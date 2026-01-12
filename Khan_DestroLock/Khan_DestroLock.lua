local function MyRoutine()
    local Author = 'Destruction Warlock - TBC Classic 1.0'
    local SpecID = 9 -- Warlock

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
    -- Last Cast Tracking (prevent double-casting DoTs)
    ------------------------------------------------------------
    local lastImmolateTime = 0
    local lastCurseTime = 0
    local lastSummonTime = 0
    local MIN_RECAST_DELAY = 3  -- Don't recast DoTs within 3 seconds
    local MIN_SUMMON_DELAY = 5  -- Don't summon pets within 5 seconds

    ------------------------------------------------------------
    -- Spells (all ranks) - LOCAL TABLE
    ------------------------------------------------------------
    local S = {}

    -- Armor
    S.FelArmor = MultiSpell(
        28176,  -- R1
        28189   -- R2
    )

    S.DemonArmor = MultiSpell(
        706,    -- R1
        1086,   -- R2
        11733,  -- R3
        11734,  -- R4
        11735,  -- R5
        27260   -- R6
    )

    -- Pets
    S.SummonImp = Spell(688)
    S.SummonSuccubus = Spell(712)
    S.DemonicSacrifice = Spell(18788)

    -- Curses
    S.CurseOfDoom = MultiSpell(
        603,    -- R1
        30910   -- R2
    )

    S.CurseOfAgony = MultiSpell(
        980,    -- R1
        1014,   -- R2
        6217,   -- R3
        11711,  -- R4
        11712,  -- R5
        11713,  -- R6
        27218   -- R7
    )

    S.CurseOfTheElements = MultiSpell(
        1490,   -- R1
        11721,  -- R2
        11722,  -- R3
        27228   -- R4
    )

    S.CurseOfRecklessness = MultiSpell(
        704,    -- R1
        7658,   -- R2
        7659,   -- R3
        11717,  -- R4
        27226   -- R5
    )

    -- DoTs
    S.Immolate = MultiSpell(
        348,    -- R1
        707,    -- R2
        1094,   -- R3
        2941,   -- R4
        11665,  -- R5
        11667,  -- R6
        11668,  -- R7
        25309,  -- R8
        27215   -- R9
    )

    S.Corruption = MultiSpell(
        172,    -- R1
        6222,   -- R2
        6223,   -- R3
        7648,   -- R4
        11671,  -- R5
        11672,  -- R6
        25311,  -- R7
        27216   -- R8
    )

    -- Main Nukes
    S.ShadowBolt = MultiSpell(
        686,    -- R1
        695,    -- R2
        705,    -- R3
        1088,   -- R4
        1106,   -- R5
        7641,   -- R6
        11659,  -- R7
        11660,  -- R8
        11661,  -- R9
        25307,  -- R10
        27209   -- R11
    )

    S.Incinerate = MultiSpell(
        29722,  -- R1
        32231   -- R2
    )

    -- Instant Casts
    S.Shadowburn = MultiSpell(
        17877,  -- R1
        18867,  -- R2
        18868,  -- R3
        18869,  -- R4
        18870,  -- R5
        18871,  -- R6
        27263,  -- R7
        30546   -- R8
    )

    S.DeathCoil = MultiSpell(
        6789,   -- R1
        17925,  -- R2
        17926,  -- R3
        27223   -- R4
    )

    -- AoE
    S.SeedOfCorruption = Spell(27243)

    S.Hellfire = MultiSpell(
        1949,   -- R1
        11683,  -- R2
        11684,  -- R3
        27213   -- R4
    )

    S.RainOfFire = MultiSpell(
        5740,   -- R1
        6219,   -- R2
        11677,  -- R3
        11678,  -- R4
        27212   -- R5
    )

    -- Mana Management
    S.LifeTap = MultiSpell(
        1454,   -- R1
        1455,   -- R2
        1456,   -- R3
        11687,  -- R4
        11688,  -- R5
        11689,  -- R6
        27222   -- R7
    )

    S.DarkPact = MultiSpell(
        18220,  -- R1
        18937,  -- R2
        18938,  -- R3
        27265   -- R4
    )

    -- Utility
    S.Conflagrate = MultiSpell(
        17962,  -- R1
        18930,  -- R2
        18931,  -- R3
        18932,  -- R4
        27266   -- R5
    )

    S.Soulshatter = Spell(29858)  -- TBC threat drop

    ------------------------------------------------------------
    -- Buff/Debuff helpers
    ------------------------------------------------------------
    local FEL_ARMOR_NAME            = GetSpellInfo(28176)
    local DEMON_ARMOR_NAME          = GetSpellInfo(706)
    local TOUCH_OF_SHADOW_NAME      = GetSpellInfo(18791)  -- Succubus sacrifice buff
    local BURNING_WISH_NAME         = GetSpellInfo(18789)  -- Imp sacrifice buff
    
    local CURSE_OF_DOOM_NAME        = GetSpellInfo(603)
    local CURSE_OF_AGONY_NAME       = GetSpellInfo(980)
    local CURSE_OF_ELEMENTS_NAME    = GetSpellInfo(1490)
    local CURSE_OF_RECKLESSNESS_NAME = GetSpellInfo(704)
    
    local IMMOLATE_NAME             = GetSpellInfo(348)
    local CORRUPTION_NAME           = GetSpellInfo(172)

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

    local function PlayerHasFelArmor()
        return HasBuffByName("player", FEL_ARMOR_NAME)
    end

    local function PlayerHasDemonArmor()
        return HasBuffByName("player", DEMON_ARMOR_NAME)
    end

    local function PlayerHasSacBuff()
        return HasBuffByName("player", TOUCH_OF_SHADOW_NAME) or HasBuffByName("player", BURNING_WISH_NAME)
    end

    local function TargetHasCurse()
        return HasDebuffByName("target", CURSE_OF_DOOM_NAME) or
               HasDebuffByName("target", CURSE_OF_AGONY_NAME) or
               HasDebuffByName("target", CURSE_OF_ELEMENTS_NAME) or
               HasDebuffByName("target", CURSE_OF_RECKLESSNESS_NAME)
    end

    local function GetTargetCurseName()
        if HasDebuffByName("target", CURSE_OF_DOOM_NAME) then
            return CURSE_OF_DOOM_NAME
        elseif HasDebuffByName("target", CURSE_OF_AGONY_NAME) then
            return CURSE_OF_AGONY_NAME
        elseif HasDebuffByName("target", CURSE_OF_ELEMENTS_NAME) then
            return CURSE_OF_ELEMENTS_NAME
        elseif HasDebuffByName("target", CURSE_OF_RECKLESSNESS_NAME) then
            return CURSE_OF_RECKLESSNESS_NAME
        end
        return nil
    end

    local function TargetHasImmolate()
        return HasDebuffByName("target", IMMOLATE_NAME)
    end

    local function GetImmolateTimeRemaining()
        return GetDebuffTimeRemaining("target", IMMOLATE_NAME)
    end

    local function UnitIsPet(unit)
        return UnitIsUnit(unit, "pet")
    end

    ------------------------------------------------------------
    -- Aggro and Boss checks
    ------------------------------------------------------------
    local function TargetIsTargetingPlayer()
        return Target:Exists()
            and Target:CanAttack(Player)
            and UnitGUID("targettarget") == UnitGUID("player")
    end

    local function TargetIsBoss()
        if not Target:Exists() then return false end
        
        local classification = UnitClassification("target")
        local playerLevel = UnitLevel("player")
        local targetLevel = UnitLevel("target")
        
        -- Worldboss classification (always a boss)
        if classification == "worldboss" then
            return true
        end
        
        -- Skull level mobs (target is +3 or more levels above player)
        -- At level 70, bosses are typically level 73 (skull)
        if targetLevel == -1 then
            -- Level -1 means skull (significantly higher level)
            return true
        end
        
        if playerLevel == 70 and targetLevel >= 73 then
            -- At max level, check for +3 levels (boss level)
            return true
        end
        
        return false
    end

    local function GetTargetTimeToLive()
        -- Use the boss check function for consistency
        -- Bosses (skull level, +3) typically live > 60s, use Doom
        -- Everything else < 60s, use Agony
        if TargetIsBoss() then
            return 999  -- Boss, use Doom
        else
            return 30   -- Trash/normal, use Agony
        end
    end

    ------------------------------------------------------------
    -- Items table (kept for structure)
    ------------------------------------------------------------
    Item.Warlock = Item.Warlock or {}
    local I = Item.Warlock

    ------------------------------------------------------------
    -- Config Menu
    ------------------------------------------------------------
    local Warlock_Config = {
        key      = 'AUTHOR_DestroLockTBC',
        title    = 'Destruction Warlock - TBC Classic',
        subtitle = '1.0',
        width    = 450,
        height   = 650,
        profiles = true,
        config   = {
            { type='header', text='Destruction Warlock - TBC', size=24, align='Center', color='ffffff' },

            { type='spacer' }, { type='ruler' }, { type='spacer' },

            { type='header', text='Spec Mode', color='ffffff' },
            {
                type = 'dropdown',
                text = 'Spec Mode',
                key = 'specmode',
                list = {
                    {
                        text = "Shadow (Shadow Bolt/Succubus)",
                        key = 'shadow'
                    },
                    {
                        text = "Fire (Incinerate/Imp)",
                        key = 'fire'
                    }
                },
                default = "shadow",
                icon = S.ShadowBolt:ID()
            },

            { type='spacer' }, { type='ruler' }, { type='spacer' },

            { type='header', text='Curse Management', color='ffffff' },
            {
                type = 'dropdown',
                text = 'Assigned Curse',
                key = 'assignedcurse',
                list = {
                    {
                        text = "Curse of Doom",
                        key = 'curse_doom'
                    },
                    {
                        text = "Curse of Agony",
                        key = 'curse_agony'
                    },
                    {
                        text = "Curse of the Elements",
                        key = 'curse_elements'
                    },
                    {
                        text = "Curse of Recklessness",
                        key = 'curse_recklessness'
                    }
                },
                default = "curse_doom",
                icon = S.CurseOfDoom:ID()
            },

            { type='spacer' }, { type='ruler' }, { type='spacer' },

            { type='header', text='Mana Management', color='ffffff' },
            {
                type = 'spinner',
                text = 'Life Tap - Mana %',
                key = 'lifetap_mana',
                min = 10,
                max = 90,
                default = 30,
                icon = S.LifeTap:ID()
            },

            { type='spacer' }, { type='ruler' }, { type='spacer' },

            { type='header', text='Rotation Options', color='ffffff' },
            { type='checkbox', text='Use Immolate', key='use_immolate', icon=S.Immolate:ID(), default=true },
            { type='checkbox', text='Use Shadowburn (moving)', key='use_shadowburn', icon=S.Shadowburn:ID(), default=true },
            { type='checkbox', text='Use Death Coil (moving)', key='use_deathcoil', icon=S.DeathCoil:ID(), default=true },
            { type='checkbox', text='Use Soulshatter (threat drop on bosses)', key='use_soulshatter', icon=S.Soulshatter:ID(), default=true },

            { type='spacer' }, { type='ruler' }, { type='spacer' },

            { type='header', text='AoE Options', color='ffffff' },
            { type='checkbox', text='Use Seed of Corruption', key='use_seed', icon=S.SeedOfCorruption:ID(), default=true },
            {
                type = 'spinner',
                text = 'Seed of Corruption - Target Count',
                key = 'seed_targets',
                min = 2,
                max = 10,
                default = 3,
                icon = S.SeedOfCorruption:ID()
            },
            { type='checkbox', text='Use Hellfire', key='use_hellfire', icon=S.Hellfire:ID(), default=false },
            {
                type = 'spinner',
                text = 'Hellfire - Target Count',
                key = 'hellfire_targets',
                min = 3,
                max = 15,
                default = 5,
                icon = S.Hellfire:ID()
            },

            { type='spacer' }, { type='ruler' }, { type='spacer' },

            { type='header', text='Buffs', color='ffffff' },
            { type='checkbox', text='Auto Fel Armor', key='auto_armor', icon=S.FelArmor:ID(), default=true },
            { type='checkbox', text='Auto Demonic Sacrifice', key='auto_sacrifice', icon=S.DemonicSacrifice:ID(), default=true },
        }
    }

    MainAddon.SetCustomConfig(Author, SpecID, Warlock_Config)

    ------------------------------------------------------------
    -- INIT
    ------------------------------------------------------------
    local function Init()
        MainAddon:Print('Destruction Warlock - TBC Classic 1.0 loaded.....')
    end

    ------------------------------------------------------------
    -- ENEMY ROTATION
    ------------------------------------------------------------
    local function EnemyRotation()
        if not MainAddon.TargetIsValid() then
            return
        end

        --------------------------------------------------------
        -- ABSOLUTE PRIORITY #1: Life Tap while moving (80% threshold)
        -- Might as well tap while moving since we can't cast anyway
        --------------------------------------------------------
        local lifeTapMana = MainAddon.Config.GetSetting('AUTHOR_DestroLockTBC', 'lifetap_mana') or 30
        local mana = Player:ManaPercentage()
        local isMoving = Player:IsMoving()
        
        if isMoving and mana and mana < 80 then
            if S.LifeTap:IsReady(Player) then
                if Cast(S.LifeTap) then
                    return "Life Tap (moving)"
                end
            end
        end

        --------------------------------------------------------
        -- ABSOLUTE PRIORITY #2: Life Tap while standing (30% threshold)
        -- No health check - healers keep you topped off
        --------------------------------------------------------
        if not isMoving and mana and mana < lifeTapMana then
            if S.LifeTap:IsReady(Player) then
                if Cast(S.LifeTap) then
                    return "Life Tap"
                end
            end
        end

        --------------------------------------------------------
        -- ABSOLUTE PRIORITY #3: Soulshatter (threat emergency on bosses)
        -- 5min CD, only use on actual bosses (skull level, +3)
        -- Can save your life if you pull aggro
        --------------------------------------------------------
        local useSoulshatter = MainAddon.Config.GetSetting('AUTHOR_DestroLockTBC', 'use_soulshatter')
        
        if useSoulshatter
            and S.Soulshatter:IsReady()
            and TargetIsBoss()
            and TargetIsTargetingPlayer()
        then
            if Cast(S.Soulshatter) then
                return "Soulshatter (threat drop)"
            end
        end

        -- Get settings
        local specMode          = MainAddon.Config.GetSetting('AUTHOR_DestroLockTBC', 'specmode') or 'shadow'
        local assignedCurse     = MainAddon.Config.GetSetting('AUTHOR_DestroLockTBC', 'assignedcurse') or 'curse_doom'
        local useImmolate       = MainAddon.Config.GetSetting('AUTHOR_DestroLockTBC', 'use_immolate')
        local useShadowburn     = MainAddon.Config.GetSetting('AUTHOR_DestroLockTBC', 'use_shadowburn')
        local useDeathCoil      = MainAddon.Config.GetSetting('AUTHOR_DestroLockTBC', 'use_deathcoil')
        local useSeed           = MainAddon.Config.GetSetting('AUTHOR_DestroLockTBC', 'use_seed')
        local seedTargets       = MainAddon.Config.GetSetting('AUTHOR_DestroLockTBC', 'seed_targets') or 3
        local useHellfire       = MainAddon.Config.GetSetting('AUTHOR_DestroLockTBC', 'use_hellfire')
        local hellfireTargets   = MainAddon.Config.GetSetting('AUTHOR_DestroLockTBC', 'hellfire_targets') or 5

        --------------------------------------------------------
        -- AoE Rotation (if enabled and enough targets)
        --------------------------------------------------------
        local enemies = Player:GetEnemiesInRange(30)
        local enemyCount = #enemies

        -- Seed of Corruption spam
        if useSeed and enemyCount >= seedTargets and S.SeedOfCorruption:IsReady() then
            if Cast(S.SeedOfCorruption) then
                return "Seed of Corruption (AoE)"
            end
        end

        -- Hellfire spam
        if useHellfire and enemyCount >= hellfireTargets and S.Hellfire:IsReady() and not isMoving then
            if Cast(S.Hellfire) then
                return "Hellfire (AoE)"
            end
        end

        --------------------------------------------------------
        -- ABSOLUTE PRIORITY #1: Assigned Curse (must be on target)
        -- If resisted, immediately re-cast (no time gate on missing curse)
        --------------------------------------------------------
        local targetHasCurse = TargetHasCurse()
        local currentCurse = GetTargetCurseName()
        local targetTTL = GetTargetTimeToLive()
        
        -- Determine which curse to cast based on assignment
        local curseSpell = nil
        local curseName = nil
        
        if assignedCurse == 'curse_doom' then
            curseSpell = S.CurseOfDoom
            curseName = CURSE_OF_DOOM_NAME
            -- Curse of Doom logic: only if target will live > 60s
            -- If target is dying soon (<60s), use Curse of Agony instead
            if targetTTL < 60 then
                curseSpell = S.CurseOfAgony
                curseName = CURSE_OF_AGONY_NAME
            end
        elseif assignedCurse == 'curse_agony' then
            curseSpell = S.CurseOfAgony
            curseName = CURSE_OF_AGONY_NAME
        elseif assignedCurse == 'curse_elements' then
            curseSpell = S.CurseOfTheElements
            curseName = CURSE_OF_ELEMENTS_NAME
        elseif assignedCurse == 'curse_recklessness' then
            curseSpell = S.CurseOfRecklessness
            curseName = CURSE_OF_RECKLESSNESS_NAME
        end

        -- Cast curse with smart time-gating
        if curseSpell and curseName then
            local hasCurseName = HasDebuffByName("target", curseName)
            local curseRemaining = GetDebuffTimeRemaining("target", curseName)
            local currentTime = GetTime()
            local timeSinceLastCast = currentTime - lastCurseTime
            
            -- NO curse on target = immediate cast (no time gate, handle resists)
            if not targetHasCurse then
                if curseSpell:IsReady() then
                    if Cast(curseSpell) then
                        -- Only update lastCurseTime if debuff actually lands
                        -- Check again after a small delay to see if it landed
                        return curseSpell:Name() .. " (initial)"
                    end
                end
            -- Wrong curse active = replace it (with small time gate)
            elseif targetHasCurse and currentCurse ~= curseName and timeSinceLastCast > 1.5 then
                if curseSpell:IsReady() then
                    if Cast(curseSpell) then
                        lastCurseTime = currentTime
                        return curseSpell:Name() .. " (overwrite)"
                    end
                end
            -- Correct curse expiring soon = refresh (with time gate)
            elseif hasCurseName and curseRemaining < 1.5 and timeSinceLastCast > MIN_RECAST_DELAY then
                if curseSpell:IsReady() then
                    if Cast(curseSpell) then
                        lastCurseTime = currentTime
                        return curseSpell:Name() .. " (refresh)"
                    end
                end
            -- If we just cast and curse IS on target, update time
            elseif hasCurseName and timeSinceLastCast < 2 then
                lastCurseTime = currentTime
            end
        end

        --------------------------------------------------------
        -- APL: actions+=/immolate (maintain, let expire before reapply)
        --------------------------------------------------------
        if useImmolate then
            local hasImmolate = TargetHasImmolate()
            local immolateRemaining = GetImmolateTimeRemaining()
            local currentTime = GetTime()
            local timeSinceLastImmolate = currentTime - lastImmolateTime
            
            if not hasImmolate and timeSinceLastImmolate > MIN_RECAST_DELAY then
                if S.Immolate:IsReady() then
                    if Cast(S.Immolate) then
                        lastImmolateTime = currentTime
                        return "Immolate (initial)"
                    end
                end
            elseif hasImmolate and immolateRemaining < 1.5 and timeSinceLastImmolate > MIN_RECAST_DELAY then
                -- Let it expire before reapplying (small buffer for lag)
                if S.Immolate:IsReady() then
                    if Cast(S.Immolate) then
                        lastImmolateTime = currentTime
                        return "Immolate (refresh)"
                    end
                end
            end
        end

        --------------------------------------------------------
        -- Movement abilities (Shadowburn, Death Coil)
        --------------------------------------------------------
        if isMoving then
            -- Shadowburn while moving
            if useShadowburn and S.Shadowburn:IsReady() then
                if Cast(S.Shadowburn) then
                    return "Shadowburn (moving)"
                end
            end

            -- Death Coil while moving
            if useDeathCoil and S.DeathCoil:IsReady() then
                if Cast(S.DeathCoil) then
                    return "Death Coil (moving)"
                end
            end

            -- If moving and nothing to cast, just return
            return
        end

        --------------------------------------------------------
        -- LAST PRIORITY: Shadow Bolt or Incinerate (main filler)
        -- This should only cast if curses/immolate are up and mana is OK
        --------------------------------------------------------
        local mainNuke = nil
        if specMode == 'fire' then
            mainNuke = S.Incinerate
        else
            mainNuke = S.ShadowBolt
        end

        if mainNuke and mainNuke:IsReady() then
            if Cast(mainNuke) then
                return mainNuke:Name()
            end
        end

        return
    end

    ------------------------------------------------------------
    -- MAIN LOOP
    ------------------------------------------------------------
    local function MainRotation()
        local autoArmor     = MainAddon.Config.GetSetting('AUTHOR_DestroLockTBC', 'auto_armor')
        local autoSacrifice = MainAddon.Config.GetSetting('AUTHOR_DestroLockTBC', 'auto_sacrifice')
        local specMode      = MainAddon.Config.GetSetting('AUTHOR_DestroLockTBC', 'specmode') or 'shadow'

        --------------------------------------------------------
        -- Always maintain buffs (in and out of combat)
        --------------------------------------------------------
        
        -- Apply Fel Armor if missing
        if autoArmor and not PlayerHasFelArmor() then
            if S.FelArmor:IsReady(Player) then
                if Cast(S.FelArmor) then
                    return "Fel Armor"
                end
            end
        end

        -- Demonic Sacrifice logic
        if autoSacrifice and not PlayerHasSacBuff() then
            -- Determine which pet to summon based on spec mode
            local petSpell = nil
            if specMode == 'fire' then
                petSpell = S.SummonImp
            else
                petSpell = S.SummonSuccubus
            end

            -- If we have a pet, sacrifice it
            if UnitExists("pet") and not UnitIsDead("pet") and UnitHealth("pet") > 0 then
                if S.DemonicSacrifice:IsReady(Player) then
                    if Cast(S.DemonicSacrifice) then
                        return "Demonic Sacrifice"
                    end
                end
            else
                -- No pet, summon one to sacrifice (with time gate to prevent spam)
                local currentTime = GetTime()
                local timeSinceLastSummon = currentTime - lastSummonTime
                
                if petSpell and petSpell:IsReady(Player) and timeSinceLastSummon > MIN_SUMMON_DELAY then
                    if Cast(petSpell) then
                        lastSummonTime = currentTime
                        return petSpell:Name()
                    end
                end
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