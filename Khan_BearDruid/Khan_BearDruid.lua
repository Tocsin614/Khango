local function MyRoutine()
    local Author = 'Feral Bear Tank - TBC Classic 1.0'
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

    ------------------------------------------------------------
    -- Local Spell Table (Don't use global HL.Spell.Druid)
    ------------------------------------------------------------
    local S = {
        -- Shapeshift
        DireBearForm = Spell(9634),

        -- Bear Form Abilities
        Maul = MultiSpell(
            6807,   -- Maul (Rank 1)
            6808,   -- Maul (Rank 2)
            6809,   -- Maul (Rank 3)
            8972,   -- Maul (Rank 4)
            9745,   -- Maul (Rank 5)
            9880,   -- Maul (Rank 6)
            9881,   -- Maul (Rank 7)
            26996   -- Maul (Rank 8 - TBC)
        ),

        Swipe = MultiSpell(
            779,    -- Swipe (Rank 1)
            780,    -- Swipe (Rank 2)
            769,    -- Swipe (Rank 3)
            9754,   -- Swipe (Rank 4)
            9908,   -- Swipe (Rank 5)
            26997   -- Swipe (Rank 6 - TBC)
        ),

        MangleBear = MultiSpell(
            33878,  -- Mangle (Bear) (Rank 1)
            33986,  -- Mangle (Bear) (Rank 2)
            33987   -- Mangle (Bear) (Rank 3)
        ),

        FaerieFireFeral = MultiSpell(
            16857,  -- Faerie Fire (Feral) (Rank 1)
            17390,  -- Faerie Fire (Feral) (Rank 2)
            17391,  -- Faerie Fire (Feral) (Rank 3)
            17392,  -- Faerie Fire (Feral) (Rank 4)
            27011   -- Faerie Fire (Feral) (Rank 5 - TBC)
        ),

        DemoralizingRoar = MultiSpell(
            99,     -- Demoralizing Roar (Rank 1)
            1735,   -- Demoralizing Roar (Rank 2)
            9490,   -- Demoralizing Roar (Rank 3)
            9747,   -- Demoralizing Roar (Rank 4)
            9898,   -- Demoralizing Roar (Rank 5)
            26998   -- Demoralizing Roar (Rank 6 - TBC)
        ),

        Lacerate = Spell(33745),  -- TBC skill
        LacerateDebuff = Spell(33745),  -- Same ID for debuff tracking

        Enrage = Spell(5229),

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

        OmenOfClarity = Spell(16864)
    }
    
    -- Alias for easier reference
    S.Mangle = S.MangleBear

    ------------------------------------------------------------
    -- Buff/Debuff helpers (legacy for specific checks)
    ------------------------------------------------------------
    local FAERIE_FIRE_FERAL_NAME = GetSpellInfo(16857)
    local DEMORALIZING_ROAR_NAME = GetSpellInfo(99)
    local DIRE_BEAR_FORM_NAME = GetSpellInfo(9634)

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

    local function PlayerHasBearForm()
        return HasBuffByName("player", DIRE_BEAR_FORM_NAME)
    end

    local function TargetHasFaerieFireFeral()
        return HasDebuffByName("target", FAERIE_FIRE_FERAL_NAME)
    end

    local function TargetHasDemoralizingRoar()
        return HasDebuffByName("target", DEMORALIZING_ROAR_NAME)
    end

    ------------------------------------------------------------
    -- Config Menu
    ------------------------------------------------------------
    local Druid_Config = {
        key      = 'AUTHOR_FeralBearTankTBC',
        title    = 'Feral Bear Tank - TBC Classic',
        subtitle = '1.0',
        width    = 450,
        height   = 650,
        profiles = true,
        config   = {
            { type='header', text='Feral Bear Tank - TBC', size=24, align='Center', color='ffffff' },

            { type='spacer' }, { type='ruler' }, { type='spacer' },

            { type='header', text='Buffs', color='ffffff' },
            { type='checkbox', text='Auto Mark of the Wild', key='automark', icon=S.MarkOfTheWild:ID(), default=true },
            { type='checkbox', text='Use Gift of the Wild (Raid)', key='usegift', icon=S.GiftOfTheWild:ID(), default=false },
            { type='checkbox', text='Auto Thorns', key='autothorns', icon=S.Thorns:ID(), default=true },
            { type='checkbox', text='Auto Omen of Clarity', key='autoomen', icon=S.OmenOfClarity:ID(), default=true },

            { type='spacer' }, { type='ruler' }, { type='spacer' },

            { type='header', text='Debuffs', color='ffffff' },
            { type='checkbox', text='Use Faerie Fire (Feral)', key='usefaeriefire', icon=S.FaerieFireFeral:ID(), default=true },
            { type='checkbox', text='Use Demoralizing Roar', key='usedemroar', icon=S.DemoralizingRoar:ID(), default=true },

            { type='spacer' }, { type='ruler' }, { type='spacer' },

            { type='header', text='Rotation Options', color='ffffff' },
            { type='checkbox', text='Use Enrage (pre-pull)', key='useenrage', icon=S.Enrage:ID(), default=true },
            { type='checkbox', text='Use Lacerate', key='uselacerate', icon=S.Lacerate:ID(), default=true },
            {
                type          = 'checkspin',
                text          = 'Lacerate Max Stacks',
                key           = 'lacerate_stacks',
                min           = 1,
                max           = 5,
                icon          = S.Lacerate:ID(),
                default_check = true,
                default_spin  = 5,
            },
            {
                type          = 'checkspin',
                text          = 'Lacerate Refresh Threshold (seconds)',
                key           = 'lacerate_refresh',
                min           = 1,
                max           = 10,
                icon          = S.Lacerate:ID(),
                default_check = true,
                default_spin  = 5,
            },
            { type='checkbox', text='Use Mangle (Bear)', key='usemangle', icon=S.MangleBear:ID(), default=true },
            { type='checkbox', text='Use Swipe', key='useswipe', icon=S.Swipe:ID(), default=true },
            {
                type          = 'checkspin',
                text          = 'Swipe Rage Threshold',
                key           = 'swipe_rage',
                min           = 15,
                max           = 70,
                icon          = S.Swipe:ID(),
                default_check = true,
                default_spin  = 45,
            },
            { type='checkbox', text='Use Maul', key='usemaul', icon=S.Maul:ID(), default=true },
            {
                type          = 'checkspin',
                text          = 'Maul Rage Threshold',
                key           = 'maul_rage',
                min           = 15,
                max           = 70,
                icon          = S.Maul:ID(),
                default_check = true,
                default_spin  = 65,
            },
            {
                type          = 'checkspin',
                text          = 'AoE Target Count',
                key           = 'aoe_targets',
                min           = 2,
                max           = 10,
                icon          = S.Swipe:ID(),
                default_check = true,
                default_spin  = 3,
            },
        }
    }

    MainAddon.SetCustomConfig(Author, SpecID, Druid_Config)

    ------------------------------------------------------------
    -- INIT
    ------------------------------------------------------------
    local function Init()
        MainAddon:Print('Feral Bear Tank - TBC Classic 1.0 loaded.....O.K.')
    end

    ------------------------------------------------------------
    -- Combat Rotation
    -- Single Target Priority:
    -- 1. Mangle (Bear) - on cooldown (6s CD)
    -- 2. Lacerate - build to 5 stacks, then refresh at <= 5s remaining
    -- 3. Swipe - filler to fill all remaining GCDs (only if rage >= 45 to ensure Lacerate doesn't fall off)
    -- 4. Maul - ONLY if excess rage >= 65 after filling GCDs with above
    --
    -- AoE Priority:
    -- 1. Swipe - spam to fill GCDs (only if rage >= 45)
    -- 2. Maul - ONLY if excess rage >= 65
    --
    -- Rage Management:
    -- - Swipe costs 20 rage, Lacerate costs 13 rage
    -- - Default Swipe threshold: 45 rage ensures you can always cast Lacerate/Mangle
    -- - Default Maul threshold: 65 rage ensures you never rage starve
    ------------------------------------------------------------
    local function EnemyRotation()
        if not Target:Exists() or not Target:IsInRange(10) or Target:IsDeadOrGhost() then
            return
        end

        local rage = Player:Rage()
        local playerLevel = UnitLevel("player")

        -- Get config settings
        local useFaerieFire = MainAddon.Config.GetSetting('AUTHOR_FeralBearTankTBC', 'usefaeriefire')
        local useDemRoar = MainAddon.Config.GetSetting('AUTHOR_FeralBearTankTBC', 'usedemroar')
        local useEnrage = MainAddon.Config.GetSetting('AUTHOR_FeralBearTankTBC', 'useenrage')
        local useLacerate = MainAddon.Config.GetSetting('AUTHOR_FeralBearTankTBC', 'uselacerate')
        local lacerateEnabled = MainAddon.Config.GetSetting('AUTHOR_FeralBearTankTBC', 'lacerate_stacks_check')
        local lacerateMaxStacks = MainAddon.Config.GetSetting('AUTHOR_FeralBearTankTBC', 'lacerate_stacks_spin') or 5
        local lacerateRefreshEnabled = MainAddon.Config.GetSetting('AUTHOR_FeralBearTankTBC', 'lacerate_refresh_check')
        local lacerateRefreshThreshold = MainAddon.Config.GetSetting('AUTHOR_FeralBearTankTBC', 'lacerate_refresh_spin') or 5
        local useMangle = MainAddon.Config.GetSetting('AUTHOR_FeralBearTankTBC', 'usemangle')
        local useSwipe = MainAddon.Config.GetSetting('AUTHOR_FeralBearTankTBC', 'useswipe')
        local swipeRageEnabled = MainAddon.Config.GetSetting('AUTHOR_FeralBearTankTBC', 'swipe_rage_check')
        local swipeRageThreshold = MainAddon.Config.GetSetting('AUTHOR_FeralBearTankTBC', 'swipe_rage_spin') or 45
        local useMaul = MainAddon.Config.GetSetting('AUTHOR_FeralBearTankTBC', 'usemaul')
        local maulRageEnabled = MainAddon.Config.GetSetting('AUTHOR_FeralBearTankTBC', 'maul_rage_check')
        local maulRageThreshold = MainAddon.Config.GetSetting('AUTHOR_FeralBearTankTBC', 'maul_rage_spin') or 65
        local aoeTargetsEnabled = MainAddon.Config.GetSetting('AUTHOR_FeralBearTankTBC', 'aoe_targets_check')
        local aoeTargets = MainAddon.Config.GetSetting('AUTHOR_FeralBearTankTBC', 'aoe_targets_spin') or 3

        -- Check if we're in Dire Bear Form
        if not PlayerHasBearForm() then
            if S.DireBearForm:IsReady() then
                if Cast(S.DireBearForm) then
                    return "Dire Bear Form"
                end
            end
            return
        end

        --------------------------------------------------------
        -- Pre-pull: Use Enrage before pulling (must be in Bear Form)
        --------------------------------------------------------
        if useEnrage and not Player:AffectingCombat() and S.Enrage:IsReady() then
            if Cast(S.Enrage) then
                return "Enrage (pre-pull)"
            end
        end

        -- Get enemy count for AoE rotation decision
        local enemies = Player:GetEnemiesInMeleeRange(8)
        local enemyCount = #enemies
        local targetCountMet = aoeTargetsEnabled and enemyCount >= aoeTargets or not aoeTargetsEnabled
        local isAoE = targetCountMet

        --------------------------------------------------------
        -- Single Target Rotation
        --------------------------------------------------------
        if not isAoE then
            -- 1. Maintain Faerie Fire (Feral) if assigned
            if useFaerieFire and not TargetHasFaerieFireFeral() and S.FaerieFireFeral:IsReady() then
                if Cast(S.FaerieFireFeral) then
                    return "Faerie Fire (Feral)"
                end
            end

            -- 2. Maintain Demoralizing Roar if assigned
            if useDemRoar and not TargetHasDemoralizingRoar() and S.DemoralizingRoar:IsReady() then
                if Cast(S.DemoralizingRoar) then
                    return "Demoralizing Roar"
                end
            end

            -- 3. Use Mangle (Bear) on cooldown - HIGHEST PRIORITY ABILITY
            -- Mangle (Bear) is the highest threat/damage ability and should always be used on CD
            if useMangle and S.Mangle:IsReady() then
                if Cast(S.Mangle) then
                    return "Mangle (Bear)"
                end
            end

            -- 4. Maintain Lacerate stacks and refresh before falling off
            -- Cast Lacerate if: stacks < max (building) OR stacks = max and <= threshold remaining (refresh)
            if useLacerate and lacerateEnabled then
                local lacerateStacks = Target:DebuffStack(S.LacerateDebuff, true) or 0
                local lacerateRemaining = Target:DebuffRemains(S.LacerateDebuff) or 0
                
                -- Build to max stacks OR refresh when <= threshold remaining
                local needsLacerate = (lacerateStacks < lacerateMaxStacks)
                
                -- Also refresh if at max stacks and threshold checking is enabled
                if lacerateStacks >= lacerateMaxStacks and lacerateRefreshEnabled then
                    needsLacerate = needsLacerate or (lacerateRemaining > 0 and lacerateRemaining <= lacerateRefreshThreshold)
                end
                
                if needsLacerate and S.Lacerate:IsReady() then
                    if Cast(S.Lacerate) then
                        if lacerateStacks < lacerateMaxStacks then
                            return "Lacerate (stacking)"
                        else
                            return "Lacerate (refresh)"
                        end
                    end
                end
            end

            -- 5. Use Swipe as filler to fill GCDs and generate threat
            -- Only use Swipe if we have enough rage to ensure Lacerate doesn't fall off
            local swipeRageMet = swipeRageEnabled and rage >= swipeRageThreshold or not swipeRageEnabled
            if useSwipe and swipeRageMet and S.Swipe:IsReady() then
                if Cast(S.Swipe) then
                    return "Swipe (filler)"
                end
            end

            -- 6. Use Maul ONLY if you have excess rage (after all other abilities)
            if useMaul and maulRageEnabled and rage >= maulRageThreshold and S.Maul:IsReady() then
                if Cast(S.Maul) then
                    return "Maul (excess rage)"
                end
            end
        end

        --------------------------------------------------------
        -- AoE Rotation
        --------------------------------------------------------
        if isAoE then
            -- 1. Use Swipe to fill GCDs and generate AoE threat
            -- Only use if we have enough rage to not starve other abilities
            local swipeRageMet = swipeRageEnabled and rage >= swipeRageThreshold or not swipeRageEnabled
            if useSwipe and swipeRageMet and S.Swipe:IsReady() then
                if Cast(S.Swipe) then
                    return "Swipe (AoE)"
                end
            end

            -- 2. Use Maul ONLY if you have excess rage
            if useMaul and maulRageEnabled and rage >= maulRageThreshold and S.Maul:IsReady() then
                if Cast(S.Maul) then
                    return "Maul (AoE excess rage)"
                end
            end
        end

        return
    end

    ------------------------------------------------------------
    -- MAIN LOOP
    ------------------------------------------------------------
    local function MainRotation()
        local autoMark = MainAddon.Config.GetSetting('AUTHOR_FeralBearTankTBC', 'automark')
        local useGift = MainAddon.Config.GetSetting('AUTHOR_FeralBearTankTBC', 'usegift')
        local autoThorns = MainAddon.Config.GetSetting('AUTHOR_FeralBearTankTBC', 'autothorns')
        local autoOmen = MainAddon.Config.GetSetting('AUTHOR_FeralBearTankTBC', 'autoomen')

        --------------------------------------------------------
        -- Always maintain buffs (in and out of combat)
        --------------------------------------------------------
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