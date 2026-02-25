local function MyRoutine()
    local Author = 'Feral DPS - TBC Classic 1.0'
    local SpecID = 11 -- Druid

    ------------------------------------------------------------
    -- Framework
    ------------------------------------------------------------
    local MainAddon = MainAddon
    local HL        = HeroLibEx
    local Unit      = HL.Unit
    local Player    = Unit.Player
    local Target    = HL.Unit.Target

    ---@type Spell
    local Spell      = HL.Spell
    local MultiSpell = HL.MultiSpell
    local Item       = HL.Item

    local Cast       = MainAddon.Cast

    -- Target tracking for auto-attack restart
    local LastTarget_GUID = nil

    ------------------------------------------------------------
    -- Local Spell Table (Don't use global HL.Spell.Druid)
    ------------------------------------------------------------
    local S = {
        -- Auto Attack
        Attack = Spell(6603),

        -- Shapeshift
        CatForm = Spell(768),
        Prowl = MultiSpell(
            5215,   -- Prowl (Rank 1)
            6783,   -- Prowl (Rank 2)
            9913    -- Prowl (Rank 3)
        ),

        -- Cat Form Abilities
        MangleCat = MultiSpell(
            33876,  -- Mangle (Cat) (Rank 1)
            33982,  -- Mangle (Cat) (Rank 2)
            33983   -- Mangle (Cat) (Rank 3)
        ),

        Shred = MultiSpell(
            5221,   -- Shred (Rank 1)
            6800,   -- Shred (Rank 2)
            8992,   -- Shred (Rank 3)
            9829,   -- Shred (Rank 4)
            9830,   -- Shred (Rank 5)
            27001,  -- Shred (Rank 6 - TBC)
            27002   -- Shred (Rank 7 - TBC)
        ),

        Ravage = MultiSpell(
            6785,   -- Ravage (Rank 1)
            6787,   -- Ravage (Rank 2)
            9866,   -- Ravage (Rank 3)
            9867,   -- Ravage (Rank 4)
            27005   -- Ravage (Rank 5 - TBC)
        ),

        Rake = MultiSpell(
            1822,   -- Rake (Rank 1)
            1823,   -- Rake (Rank 2)
            1824,   -- Rake (Rank 3)
            9904,   -- Rake (Rank 4)
            27003   -- Rake (Rank 5 - TBC)
        ),

        Rip = MultiSpell(
            1079,   -- Rip (Rank 1)
            9492,   -- Rip (Rank 2)
            9493,   -- Rip (Rank 3)
            9752,   -- Rip (Rank 4)
            9894,   -- Rip (Rank 5)
            9896,   -- Rip (Rank 6)
            27008   -- Rip (Rank 7 - TBC)
        ),

        FerociousBite = MultiSpell(
            22568,  -- Ferocious Bite (Rank 1)
            22827,  -- Ferocious Bite (Rank 2)
            22828,  -- Ferocious Bite (Rank 3)
            22829,  -- Ferocious Bite (Rank 4)
            31018,  -- Ferocious Bite (Rank 5)
            27009   -- Ferocious Bite (Rank 6 - TBC)
        ),

        FaerieFireFeral = MultiSpell(
            16857,  -- Faerie Fire (Feral) (Rank 1)
            17390,  -- Faerie Fire (Feral) (Rank 2)
            17391,  -- Faerie Fire (Feral) (Rank 3)
            17392,  -- Faerie Fire (Feral) (Rank 4)
            27011   -- Faerie Fire (Feral) (Rank 5 - TBC)
        ),

        -- Debuff tracking
        RipDebuff = Spell(1079),
        RakeDebuff = Spell(1822),
        MangleDebuff = Spell(33876),
        FaerieFireDebuff = Spell(16857),

        -- Buffs
        MarkOfTheWild = MultiSpell(
            1126,   -- Mark of the Wild (Rank 1)
            5232,   -- Mark of the Wild (Rank 2)
            6756,   -- Mark of the Wild (Rank 3)
            5234,   -- Mark of the Wild (Rank 4)
            8907,   -- Mark of the Wild (Rank 5)
            9884,   -- Mark of the Wild (Rank 6)
            9885,   -- Mark of the Wild (Rank 7)
            26990   -- Mark of the Wild (Rank 8 - TBC)
        ),

        GiftOfTheWild = MultiSpell(
            21849,  -- Gift of the Wild (Rank 1)
            21850,  -- Gift of the Wild (Rank 2)
            26991   -- Gift of the Wild (Rank 3 - TBC)
        ),

        Thorns = MultiSpell(
            467,    -- Thorns (Rank 1)
            782,    -- Thorns (Rank 2)
            1075,   -- Thorns (Rank 3)
            8914,   -- Thorns (Rank 4)
            9756,   -- Thorns (Rank 5)
            9910,   -- Thorns (Rank 6)
            26992   -- Thorns (Rank 7 - TBC)
        ),

        OmenOfClarity = Spell(16864),
        ClearcastingBuff = Spell(16870)
    }
    
    -- Alias for easier reference
    S.Mangle = S.MangleCat

    ------------------------------------------------------------
    -- Buff/Debuff helpers (legacy for specific checks)
    ------------------------------------------------------------
    local FAERIE_FIRE_FERAL_NAME = GetSpellInfo(16857)
    local CAT_FORM_NAME = GetSpellInfo(768)
    local CLEARCASTING_NAME = GetSpellInfo(16870)
    local PROWL_NAME = GetSpellInfo(5215)
    local RIP_NAME = GetSpellInfo(1079)
    local MANGLE_CAT_NAME = GetSpellInfo(33876)
    local RAKE_NAME = GetSpellInfo(1822)

    local function HasBuffByName(unit, name)
        if not name then return false end
        local i = 1
        while true do
            local buffName = UnitBuff(unit, i)
            if not buffName then
                return false
            end
            if buffName == name then
                return true
            end
            i = i + 1
        end
    end

    local function HasDebuffByName(unit, name)
        if not name then return false end
        local i = 1
        while true do
            local debuffName = UnitDebuff(unit, i)
            if not debuffName then
                return false
            end
            if debuffName == name then
                return true
            end
            i = i + 1
        end
    end

    local function GetDebuffTimeRemaining(unit, name)
        if not name then return 0 end
        local i = 1
        while true do
            local debuffName, _, _, _, _, expirationTime = UnitDebuff(unit, i)
            if not debuffName then
                return 0
            end
            if debuffName == name then
                if expirationTime then
                    return expirationTime - GetTime()
                end
                return 0
            end
            i = i + 1
        end
    end

    local function PlayerHasCatForm()
        return HasBuffByName("player", CAT_FORM_NAME)
    end

    local function TargetHasFaerieFireFeral()
        return HasDebuffByName("target", FAERIE_FIRE_FERAL_NAME)
    end

    local function PlayerHasClearcasting()
        return HasBuffByName("player", CLEARCASTING_NAME)
    end

    local function PlayerHasProwl()
        return HasBuffByName("player", PROWL_NAME)
    end

    local function TargetHasRip()
        return HasDebuffByName("target", RIP_NAME)
    end

    local function TargetHasMangle()
        return HasDebuffByName("target", MANGLE_CAT_NAME)
    end

    local function TargetHasRake()
        return HasDebuffByName("target", RAKE_NAME)
    end

    local function TargetTimeToDie()
        if MainAddon.TargetTimeToDie then return MainAddon:TargetTimeToDie() or nil end
    end

    ------------------------------------------------------------
    -- Ferocious Bite top-end damage table [spellID][comboPoints]
    -- Values are top-end tooltip damage including AP contribution.
    -- Used to check if target HP <= what a Bite would deal - no
    -- point putting a Rip on a target that will die to a Bite.
    -- Rank 6 (27009) values need in-game verification.
    ------------------------------------------------------------
    local FerociousBiteTopEnd = {
        [22568] = {  66, 102, 138, 174, 210 },  -- Rank 1 (lvl 32)
        [22827] = { 103, 162, 221, 280, 339 },  -- Rank 2 (lvl 40)
        [22828] = { 162, 254, 346, 438, 530 },  -- Rank 3 (lvl 48)
        [22829] = { 223, 351, 479, 607, 735 },  -- Rank 4 (lvl 56)
        [31018] = { 259, 406, 553, 700, 847 },  -- Rank 5 (lvl 60)
        [27009] = { 292, 461, 630, 799, 968 },  -- Rank 6 (lvl 63)
    }

    local function TargetDiesFromBite(comboPoints)
        local spellID = S.FerociousBite:ID()
        local dmgTable = FerociousBiteTopEnd[spellID]
        if not dmgTable then return false end
        local cp = math.min(comboPoints, 5)
        local topEnd = dmgTable[cp]
        if not topEnd then return false end
        return UnitHealth("target") <= topEnd
    end

    local function TargetIsTargetingPlayer()
        return Target:Exists()
            and Target:CanAttack(Player)
            and UnitGUID("targettarget") == UnitGUID("player")
    end

    ------------------------------------------------------------
    -- Config Menu
    ------------------------------------------------------------
    local Druid_Config = {
        key      = 'AUTHOR_FeralDpsTBC',
        title    = 'Feral DPS - TBC Classic',
        subtitle = '1.0',
        width    = 450,
        height   = 650,
        profiles = true,
        config   = {
            { type='header', text='Feral DPS - TBC', size=24, align='Center', color='ffffff' },

            { type='spacer' }, { type='ruler' }, { type='spacer' },

            { type='header', text='Buffs', color='ffffff' },
            { type='checkbox', text='Auto Mark of the Wild', key='automark', icon=S.MarkOfTheWild:ID(), default=true },
            { type='checkbox', text='Use Gift of the Wild (Raid)', key='usegift', icon=S.GiftOfTheWild:ID(), default=false },
            { type='checkbox', text='Auto Thorns', key='autothorns', icon=S.Thorns:ID(), default=true },
            { type='checkbox', text='Auto Omen of Clarity', key='autoomen', icon=S.OmenOfClarity:ID(), default=true },

            { type='spacer' }, { type='ruler' }, { type='spacer' },

            { type='header', text='Debuffs', color='ffffff' },
            { type='checkbox', text='Use Faerie Fire (Feral)', key='usefaeriefire', icon=S.FaerieFireFeral:ID(), default=false },
            { type='text', text='Usually assigned to Balance Druid', size=11, color='aaaaaa' },

            { type='spacer' }, { type='ruler' }, { type='spacer' },

            { type='header', text='Rotation Options', color='ffffff' },
            { type='checkbox', text='Use Mangle (Cat)', key='usemangle', icon=S.MangleCat:ID(), default=false },
            { type='text', text='Enable if assigned to apply Mangle debuff', size=11, color='aaaaaa' },
            
            { type='spacer' },

            {
                type          = 'checkspin',
                text          = 'Rip Combo Points',
                key           = 'rip_combo',
                min           = 1,
                max           = 5,
                icon          = S.Rip:ID(),
                default_check = true,
                default_spin  = 4,
            },
            { type='text', text='Minimum combo points before using Rip', size=11, color='aaaaaa' },

            { type='spacer' },

            {
                type          = 'checkspin',
                text          = 'Rip Refresh Time',
                key           = 'rip_refresh',
                min           = 0,
                max           = 10,
                icon          = S.Rip:ID(),
                default_check = false,
                default_spin  = 2,
            },
            { type='text', text='Reapply Rip when <= X seconds remaining (disabled by default - let Rip expire for last tick)', size=11, color='aaaaaa' },

            { type='spacer' },

            {
                type          = 'checkspin',
                text          = 'Rip min TTD',
                key           = 'rip_ttd',
                min           = 2,
                max           = 30,
                icon          = S.FerociousBite:ID(),
                default_check = true,
                default_spin  = 8,
            },
            { type='text', text='Use Ferocious Bite instead of Rip if TTD < X sec', size=11, color='aaaaaa' },

            { type='spacer' }, { type='ruler' }, { type='spacer' },

            { type='header', text='Power Shifting', color='ffffff' },
            { type='checkbox', text='Enable Power Shifting', key='powershift', icon=S.CatForm:ID(), default=true },
            { type='text', text='Cast Cat Form to restore energy when needed', size=11, color='aaaaaa' },

            { type='spacer' },

            {
                type          = 'checkspin',
                text          = 'Power Shift Energy Threshold',
                key           = 'powershift_energy',
                min           = 15,
                max           = 40,
                icon          = S.CatForm:ID(),
                default_check = true,
                default_spin  = 21,
            },
            { type='text', text='Power shift if energy X below next ability cost', size=11, color='aaaaaa' },
        }
    }

    MainAddon.SetCustomConfig(Author, SpecID, Druid_Config)

    ------------------------------------------------------------
    -- INIT
    ------------------------------------------------------------
    local function Init()
        MainAddon:Print('Feral DPS - TBC Classic 1.0 loaded (SpecID 11).')
    end

    ------------------------------------------------------------
    -- ENEMY ROTATION
    ------------------------------------------------------------
    local function EnemyRotation()
        if not Target:Exists() or not Target:IsEnemy() or not Target:IsInRange(10) or Target:IsDeadOrGhost() then
            return
        end

        -- Get current resources
        local energy = Player:Energy()
        local comboPoints = Player:ComboPoints()
        local inMelee = Target:IsInRange(5)
        local inCombat = Player:AffectingCombat()

        -- Get config settings
        local useFaerieFire = MainAddon.Config.GetSetting('AUTHOR_FeralDpsTBC', 'usefaeriefire')
        local useMangle = MainAddon.Config.GetSetting('AUTHOR_FeralDpsTBC', 'usemangle')
        local ripComboEnabled = MainAddon.Config.GetSetting('AUTHOR_FeralDpsTBC', 'rip_combo_check')
        local ripComboPoints = MainAddon.Config.GetSetting('AUTHOR_FeralDpsTBC', 'rip_combo_spin') or 4
        local ripRefreshEnabled = MainAddon.Config.GetSetting('AUTHOR_FeralDpsTBC', 'rip_refresh_check')
        local ripRefreshTime = MainAddon.Config.GetSetting('AUTHOR_FeralDpsTBC', 'rip_refresh_spin') or 2
        local ripTtdEnabled = MainAddon.Config.GetSetting('AUTHOR_FeralDpsTBC', 'rip_ttd_check')
        local ripTtdThreshold = MainAddon.Config.GetSetting('AUTHOR_FeralDpsTBC', 'rip_ttd_spin') or 8
        local powerShift = MainAddon.Config.GetSetting('AUTHOR_FeralDpsTBC', 'powershift')
        local powerShiftEnergyEnabled = MainAddon.Config.GetSetting('AUTHOR_FeralDpsTBC', 'powershift_energy_check')
        local powerShiftThreshold = MainAddon.Config.GetSetting('AUTHOR_FeralDpsTBC', 'powershift_energy_spin') or 21

        -- Check if we're in Cat Form
        if not PlayerHasCatForm() then
            if S.CatForm:IsReady() then
                if Cast(S.CatForm) then
                    return "Cat Form"
                end
            end
            return
        end

        --------------------------------------------------------
        -- Auto-attack management (skip if in Prowl/stealth)
        --------------------------------------------------------
        local currentGUID = UnitGUID("target")
        local nextSwing = Player:NextSwing()
        
        -- Check if player is stealthed (using framework BuffUp)
        local isStealthed = Player:BuffUp(S.Prowl)
        
        if inMelee and not isStealthed and S.Attack:IsReady() then
            if nextSwing == 0 or currentGUID ~= LastTarget_GUID then
                if Cast(S.Attack) then
                    LastTarget_GUID = currentGUID
                    return "Auto Attack"
                end
            end
        end

        --------------------------------------------------------
        -- Single Target Rotation Priority
        --------------------------------------------------------
        
        -- 0. Use Ravage if in Prowl (stealth) - HIGHEST PRIORITY
        if isStealthed and S.Ravage:IsReady() then
            if Cast(S.Ravage) then
                return "Ravage (Prowl)"
            end
        end
        
        -- 1. Maintain Faerie Fire (Feral) if assigned and IN COMBAT (don't break stealth)
        if inCombat and useFaerieFire and not TargetHasFaerieFireFeral() and S.FaerieFireFeral:IsReady() then
            if Cast(S.FaerieFireFeral) then
                return "Faerie Fire (Feral)"
            end
        end

        -- 2. Maintain Mangle (Cat) debuff if assigned to it
        if useMangle and not TargetHasMangle() and S.Mangle:IsReady() then
            if Cast(S.Mangle) then
                return "Mangle (Cat) - debuff"
            end
        end

        -- 3. Use Shred with Omen of Clarity proc (free energy)
        if PlayerHasClearcasting() and S.Shred:IsReady() and not TargetIsTargetingPlayer() then
            if Cast(S.Shred) then
                return "Shred (Omen of Clarity)"
            end
        end

        -- 4. Rip or Ferocious Bite at combo point threshold
        if ripComboEnabled and comboPoints >= ripComboPoints then
            local ttd = TargetTimeToDie()

            -- TTD is unreliable on fast trash kills - Bite damage table is the reliable fallback.
            -- Bite if TTD says dying soon OR target HP <= what a Bite at current CP would deal.
            local dyingSoon = ripTtdEnabled and (
                (ttd and ttd > 0 and ttd < ripTtdThreshold) or
                TargetDiesFromBite(comboPoints)
            )

            if dyingSoon then
                -- Target dying too fast for Rip to get full value - Ferocious Bite instead.
                -- Per Bite mechanics: cast at low energy (~35), never with Clearcasting active.
                -- If energy >= 60 or Clearcasting is up, Shred first to burn energy/proc.
                if not PlayerHasClearcasting() and energy <= 60 and S.FerociousBite:IsReady() then
                    if Cast(S.FerociousBite) then
                        return "Ferocious Bite (TTD)"
                    end
                end
            else
                local ripRemaining = GetDebuffTimeRemaining("target", RIP_NAME)

                -- Apply Rip if not on target OR about to expire.
                -- Guard against re-casting immediately after application (frame timing).
                local needsRip = (ripRemaining == 0 or ripRemaining > 13)
                if ripRefreshEnabled and ripRemaining > 0 and ripRemaining <= ripRefreshTime then
                    needsRip = true
                end

                if needsRip and S.Rip:IsReady() then
                    if Cast(S.Rip) then
                        return "Rip"
                    end
                end
            end
        end

        -- 5. Use Mangle (Cat) if target is facing you (can't Shred from front)
        if TargetIsTargetingPlayer() and S.Mangle:IsReady() then
            if Cast(S.Mangle) then
                return "Mangle (Cat) - target facing"
            end
        end

        -- 6. Use Shred to build combo points (behind target)
        if S.Shred:IsReady() then
            if Cast(S.Shred) then
                return "Shred"
            end
        end

        -- 7. Use Rake as filler if Shred not available (not behind target)
        if S.Rake:IsReady() and not TargetHasRake() then
            if Cast(S.Rake) then
                return "Rake"
            end
        end

        -- 8. Power Shift if energy is too low
        if powerShift and powerShiftEnergyEnabled then
            -- Shred base cost is ~42 energy with talents
            local nextAbilityCost = 42
            
            -- Power shift if energy < (cost - threshold)
            if energy < (nextAbilityCost - powerShiftThreshold) then
                if S.CatForm:IsReady() then
                    if Cast(S.CatForm) then
                        return "Power Shift"
                    end
                end
            end
        end

        return
    end

    ------------------------------------------------------------
    -- MAIN LOOP
    ------------------------------------------------------------
    local function MainRotation()
        local autoMark = MainAddon.Config.GetSetting('AUTHOR_FeralDpsTBC', 'automark')
        local useGift = MainAddon.Config.GetSetting('AUTHOR_FeralDpsTBC', 'usegift')
        local autoThorns = MainAddon.Config.GetSetting('AUTHOR_FeralDpsTBC', 'autothorns')
        local autoOmen = MainAddon.Config.GetSetting('AUTHOR_FeralDpsTBC', 'autoomen')

        --------------------------------------------------------
        -- Always maintain buffs (in and out of combat)
        -- Skip if in Prowl - casting breaks stealth
        --------------------------------------------------------
        if not PlayerHasProwl() and not Player:AffectingCombat() then

        -- Mark of the Wild / Gift of the Wild - checking buff ID with Player:BuffDown
        if autoMark then
            if useGift 
                and S.GiftOfTheWild:IsReady(Player)
                and Player:BuffDown(S.GiftOfTheWild)
            then
                if Cast(S.GiftOfTheWild) then
                    return "Gift of the Wild"
                end
            elseif S.MarkOfTheWild:IsReady(Player)
                and Player:BuffDown(S.MarkOfTheWild)
                and Player:BuffDown(S.GiftOfTheWild)
            then
                if Cast(S.MarkOfTheWild) then
                    return "Mark of the Wild"
                end
            end
        end

        -- Thorns - checking buff ID with Player:BuffDown
        if autoThorns
            and S.Thorns:IsReady(Player)
            and Player:BuffDown(S.Thorns)
        then
            if Cast(S.Thorns) then
                return "Thorns"
            end
        end

        -- Omen of Clarity - checking buff ID with Player:BuffDown
        if autoOmen
            and S.OmenOfClarity:IsReady(Player)
            and Player:BuffDown(S.OmenOfClarity)
        then
            if Cast(S.OmenOfClarity) then
                return "Omen of Clarity"
            end
        end

        end -- not PlayerHasProwl()

        --------------------------------------------------------
        -- Enemy rotation
        --------------------------------------------------------
        local r = EnemyRotation()
        if r then return r end
    end

    MainAddon.SetCustomAPL(Author, SpecID, MainRotation, Init)
end -- CLOSES MyRoutine()


------------------------------------------------------------
-- Loader loop
------------------------------------------------------------
local function TryLoading()
    C_Timer.After(1, function()
        if MainAddon then
            MyRoutine()
        else
            TryLoading()
        end
    end)
end

TryLoading()