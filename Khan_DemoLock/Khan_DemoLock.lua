local function MyRoutine()
    local Author = 'Demonology Felguard Warlock - TBC Leveling 50-70'
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
    local lastCorruptionTime = 0
    local lastImmolateTime = 0
    local lastCurseTime = 0
    local lastSummonTime = 0
    local MIN_RECAST_DELAY = 3  -- Don't recast DoTs within 3 seconds
    local MIN_SUMMON_DELAY = 5  -- Don't summon pets within 5 seconds

    ------------------------------------------------------------
    -- LOCAL Spell Table (all ranks)
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
    S.SummonFelguard = Spell(30146)  -- Demonology 41-point talent
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

    S.CurseOfWeakness = MultiSpell(
        702,    -- R1
        1108,   -- R2
        6205,   -- R3
        7646,   -- R4
        11707,  -- R5
        11708,  -- R6
        27224   -- R7
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

    -- Drain/Channel Spells
    S.DrainLife = MultiSpell(
        689,    -- R1
        699,    -- R2
        709,    -- R3
        7651,   -- R4
        11699,  -- R5
        11700,  -- R6
        27219,  -- R7
        27220   -- R8
    )

    S.DrainSoul = MultiSpell(
        1120,   -- R1
        8288,   -- R2
        8289,   -- R3
        11675,  -- R4
        27217   -- R5
    )

    -- Fear Spells
    S.Fear = MultiSpell(
        5782,   -- R1
        6213,   -- R2
        6215    -- R3
    )

    S.HowlOfTerror = MultiSpell(
        5484,   -- R1
        17928   -- R2
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

    S.Shoot = Spell(5019)  -- Wand attack

    S.SoulLink = Spell(19028)  -- Demonology 31-point talent

    ------------------------------------------------------------
    -- Buff/Debuff helpers
    ------------------------------------------------------------
    local FEL_ARMOR_NAME            = GetSpellInfo(28176)
    local DEMON_ARMOR_NAME          = GetSpellInfo(706)
    local SOUL_LINK_NAME            = GetSpellInfo(19028)
    
    local CURSE_OF_DOOM_NAME        = GetSpellInfo(603)
    local CURSE_OF_AGONY_NAME       = GetSpellInfo(980)
    local CURSE_OF_ELEMENTS_NAME    = GetSpellInfo(1490)
    local CURSE_OF_RECKLESSNESS_NAME = GetSpellInfo(704)
    local CURSE_OF_WEAKNESS_NAME    = GetSpellInfo(702)
    
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

    local function PlayerHasSoulLink()
        return HasBuffByName("player", SOUL_LINK_NAME)
    end

    local function TargetHasCurse()
        return HasDebuffByName("target", CURSE_OF_DOOM_NAME) or
               HasDebuffByName("target", CURSE_OF_AGONY_NAME) or
               HasDebuffByName("target", CURSE_OF_ELEMENTS_NAME) or
               HasDebuffByName("target", CURSE_OF_RECKLESSNESS_NAME) or
               HasDebuffByName("target", CURSE_OF_WEAKNESS_NAME)
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
        elseif HasDebuffByName("target", CURSE_OF_WEAKNESS_NAME) then
            return CURSE_OF_WEAKNESS_NAME
        end
        return nil
    end

    local function TargetHasImmolate()
        return HasDebuffByName("target", IMMOLATE_NAME)
    end

    local function GetImmolateTimeRemaining()
        return GetDebuffTimeRemaining("target", IMMOLATE_NAME)
    end

    local function TargetHasCorruption()
        return HasDebuffByName("target", CORRUPTION_NAME)
    end

    local function GetCorruptionTimeRemaining()
        return GetDebuffTimeRemaining("target", CORRUPTION_NAME)
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
        key      = 'AUTHOR_DemoLockLeveling',
        title    = 'Demonology Felguard - TBC Leveling',
        subtitle = '50-70 Leveling and Raid',
        width    = 450,
        height   = 700,
        profiles = true,
        config   = {
            { type='header', text='Demonology Felguard Leveling (50-70)', size=24, align='Center', color='ffffff' },

            { type='spacer' }, { type='ruler' }, { type='spacer' },

            { type='header', text='DoT Management', color='ffffff' },
            { type='checkbox', text='Use Corruption', key='use_corruption', icon=S.Corruption:ID(), default=true },
            { type='checkbox', text='Use Immolate', key='use_immolate', icon=S.Immolate:ID(), default=true },
            {
                type = 'spinner',
                text = 'Immolate - Min Mana %',
                key = 'immolate_mana',
                min = 10,
                max = 100,
                default = 40,
                icon = S.Immolate:ID()
            },

            { type='spacer' }, { type='ruler' }, { type='spacer' },

            { type='header', text='Curse Management', color='ffffff' },
            {
                type = 'dropdown',
                text = 'Default Curse',
                key = 'defaultcurse',
                list = {
                    {
                        text = "Curse of Agony (Damage)",
                        key = 'curse_agony'
                    },
                    {
                        text = "Curse of Doom (Boss/Raid - 60s duration)",
                        key = 'curse_doom'
                    },
                    {
                        text = "Curse of Elements (Raid - Magic Vuln)",
                        key = 'curse_elements'
                    },
                    {
                        text = "Curse of Recklessness (Raid - AP/Armor Debuff)",
                        key = 'curse_recklessness'
                    },
                    {
                        text = "Curse of Weakness (Defense)",
                        key = 'curse_weakness'
                    },
                    {
                        text = "None (Manual)",
                        key = 'curse_none'
                    }
                },
                default = "curse_agony",
                icon = S.CurseOfAgony:ID()
            },

            { type='spacer' }, { type='ruler' }, { type='spacer' },

            { type='header', text='Survival / Fear', color='ffffff' },
            { type='checkbox', text='Use Death Coil (emergency melee escape)', key='use_deathcoil', icon=S.DeathCoil:ID(), default=true },
            {
                type = 'spinner',
                text = 'Death Coil - Health %',
                key = 'deathcoil_health',
                min = 10,
                max = 90,
                default = 35,
                icon = S.DeathCoil:ID()
            },
            { type='checkbox', text='Use Fear when in danger', key='use_fear', icon=S.Fear:ID(), default=true },
            {
                type = 'spinner',
                text = 'Fear - Health %',
                key = 'fear_health',
                min = 10,
                max = 90,
                default = 30,
                icon = S.Fear:ID()
            },

            { type='spacer' }, { type='ruler' }, { type='spacer' },

            { type='header', text='Sustain / Execute', color='ffffff' },
            { type='checkbox', text='Use Drain Life for healing', key='use_drainlife', icon=S.DrainLife:ID(), default=true },
            {
                type = 'spinner',
                text = 'Drain Life - Health %',
                key = 'drainlife_health',
                min = 10,
                max = 90,
                default = 60,
                icon = S.DrainLife:ID()
            },
            { type='checkbox', text='Use Drain Soul for shards/mana', key='use_drainsoul', icon=S.DrainSoul:ID(), default=true },
            {
                type = 'spinner',
                text = 'Drain Soul - Target Health %',
                key = 'drainsoul_execute',
                min = 5,
                max = 50,
                default = 25,
                icon = S.DrainSoul:ID()
            },

            { type='spacer' }, { type='ruler' }, { type='spacer' },

            { type='header', text='Filler', color='ffffff' },
            { type='checkbox', text='Use Wand (Shoot)', key='use_wand', icon=S.Shoot:ID(), default=true },
            {
                type = 'spinner',
                text = 'Wand - Max Mana % (only wand below this)',
                key = 'wand_mana',
                min = 10,
                max = 100,
                default = 70,
                icon = S.Shoot:ID()
            },

            { type='spacer' }, { type='ruler' }, { type='spacer' },

            { type='header', text='Buffs', color='ffffff' },
            { type='checkbox', text='Auto Armor (Fel if trained, else Demon)', key='auto_armor', icon=S.FelArmor:ID(), default=true },
            { type='checkbox', text='Auto Soul Link (damage reduction + 5% dmg)', key='auto_soullink', icon=S.SoulLink:ID(), default=true },
            { type='checkbox', text='Auto Summon Felguard', key='auto_felguard', icon=S.SummonFelguard:ID(), default=true },
        }
    }

    MainAddon.SetCustomConfig(Author, SpecID, Warlock_Config)

    ------------------------------------------------------------
    -- INIT
    ------------------------------------------------------------
    local function Init()
        MainAddon:Print('Demonology Felguard Warlock - TBC 50-70 loaded.....')
    end

    ------------------------------------------------------------
    -- ENEMY ROTATION
    ------------------------------------------------------------
    ------------------------------------------------------------
    -- ENEMY ROTATION (Leveling 50-70)
    ------------------------------------------------------------
    local function EnemyRotation()
        if not MainAddon.TargetIsValid() then
            return
        end

        -- Get settings
        local useCorruption     = MainAddon.Config.GetSetting('AUTHOR_DemoLockLeveling', 'use_corruption')
        local useImmolate       = MainAddon.Config.GetSetting('AUTHOR_DemoLockLeveling', 'use_immolate')
        local immolateMana      = MainAddon.Config.GetSetting('AUTHOR_DemoLockLeveling', 'immolate_mana') or 40
        local defaultCurse      = MainAddon.Config.GetSetting('AUTHOR_DemoLockLeveling', 'defaultcurse') or 'curse_agony'
        local useDeathCoil      = MainAddon.Config.GetSetting('AUTHOR_DemoLockLeveling', 'use_deathcoil')
        local deathCoilHealth   = MainAddon.Config.GetSetting('AUTHOR_DemoLockLeveling', 'deathcoil_health') or 35
        local useFear           = MainAddon.Config.GetSetting('AUTHOR_DemoLockLeveling', 'use_fear')
        local fearHealth        = MainAddon.Config.GetSetting('AUTHOR_DemoLockLeveling', 'fear_health') or 30
        local useDrainLife      = MainAddon.Config.GetSetting('AUTHOR_DemoLockLeveling', 'use_drainlife')
        local drainLifeHealth   = MainAddon.Config.GetSetting('AUTHOR_DemoLockLeveling', 'drainlife_health') or 60
        local useDrainSoul      = MainAddon.Config.GetSetting('AUTHOR_DemoLockLeveling', 'use_drainsoul')
        local drainSoulExecute  = MainAddon.Config.GetSetting('AUTHOR_DemoLockLeveling', 'drainsoul_execute') or 25
        local useWand           = MainAddon.Config.GetSetting('AUTHOR_DemoLockLeveling', 'use_wand')

        local mana = Player:ManaPercentage()
        local health = Player:HealthPercentage()
        local targetHP = Target:HealthPercentage()
        local isMoving = Player:IsMoving()

        --------------------------------------------------------
        -- PRIORITY #0: Death Coil (emergency - target in melee, low health)
        --------------------------------------------------------
        if useDeathCoil and health and health < deathCoilHealth then
            -- Check if target is in melee range (8 yards for safety)
            if Target:IsInRange(8) then
                if S.DeathCoil:IsReady() then
                    if Cast(S.DeathCoil) then
                        return "Death Coil (emergency)"
                    end
                end
            end
        end

        --------------------------------------------------------
        -- PRIORITY #1: Corruption (main DoT)
        --------------------------------------------------------
        if useCorruption then
            local hasCorruption = TargetHasCorruption()
            local corruptionRemaining = GetCorruptionTimeRemaining()
            local currentTime = GetTime()
            local timeSinceLastCorruption = currentTime - lastCorruptionTime
            
            if not hasCorruption and timeSinceLastCorruption > MIN_RECAST_DELAY then
                if S.Corruption:IsReady() then
                    if Cast(S.Corruption) then
                        lastCorruptionTime = currentTime
                        return "Corruption (initial)"
                    end
                end
            elseif hasCorruption and corruptionRemaining < 1.5 and timeSinceLastCorruption > MIN_RECAST_DELAY then
                if S.Corruption:IsReady() then
                    if Cast(S.Corruption) then
                        lastCorruptionTime = currentTime
                        return "Corruption (refresh)"
                    end
                end
            end
        end

        --------------------------------------------------------
        -- PRIORITY #2: Curse (default Curse of Agony)
        --------------------------------------------------------
        if defaultCurse ~= 'curse_none' then
            local targetHasCurse = TargetHasCurse()
            local currentCurse = GetTargetCurseName()
            local curseSpell = nil
            local curseName = nil
            
            if defaultCurse == 'curse_agony' then
                curseSpell = S.CurseOfAgony
                curseName = CURSE_OF_AGONY_NAME
            elseif defaultCurse == 'curse_doom' then
                curseSpell = S.CurseOfDoom
                curseName = CURSE_OF_DOOM_NAME
            elseif defaultCurse == 'curse_elements' then
                curseSpell = S.CurseOfTheElements
                curseName = CURSE_OF_ELEMENTS_NAME
            elseif defaultCurse == 'curse_recklessness' then
                curseSpell = S.CurseOfRecklessness
                curseName = CURSE_OF_RECKLESSNESS_NAME
            elseif defaultCurse == 'curse_weakness' then
                curseSpell = S.CurseOfWeakness
                curseName = CURSE_OF_WEAKNESS_NAME
            end

            if curseSpell and curseName then
                local hasCurseName = HasDebuffByName("target", curseName)
                local curseRemaining = GetDebuffTimeRemaining("target", curseName)
                local currentTime = GetTime()
                local timeSinceLastCast = currentTime - lastCurseTime
                
                -- No curse on target = immediate cast
                if not targetHasCurse then
                    if curseSpell:IsReady() then
                        if Cast(curseSpell) then
                            return curseSpell:Name() .. " (initial)"
                        end
                    end
                -- Wrong curse = replace
                elseif targetHasCurse and currentCurse ~= curseName and timeSinceLastCast > 1.5 then
                    if curseSpell:IsReady() then
                        if Cast(curseSpell) then
                            lastCurseTime = currentTime
                            return curseSpell:Name() .. " (overwrite)"
                        end
                    end
                -- Curse expiring = refresh
                elseif hasCurseName and curseRemaining < 1.5 and timeSinceLastCast > MIN_RECAST_DELAY then
                    if curseSpell:IsReady() then
                        if Cast(curseSpell) then
                            lastCurseTime = currentTime
                            return curseSpell:Name() .. " (refresh)"
                        end
                    end
                -- Update time if curse landed
                elseif hasCurseName and timeSinceLastCast < 2 then
                    lastCurseTime = currentTime
                end
            end
        end

        --------------------------------------------------------
        -- PRIORITY #3: Immolate (if mana allows)
        --------------------------------------------------------
        if useImmolate and mana and mana >= immolateMana then
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
                if S.Immolate:IsReady() then
                    if Cast(S.Immolate) then
                        lastImmolateTime = currentTime
                        return "Immolate (refresh)"
                    end
                end
            end
        end

        --------------------------------------------------------
        -- PRIORITY #5: Fear if in danger (low health)
        --------------------------------------------------------
        if useFear and health and health < fearHealth then
            if S.Fear:IsReady() then
                if Cast(S.Fear) then
                    return "Fear (danger)"
                end
            end
        end

        --------------------------------------------------------
        -- PRIORITY #6: Drain Life (if need health)
        --------------------------------------------------------
        if useDrainLife and health and health < drainLifeHealth and not isMoving then
            if S.DrainLife:IsReady() then
                if Cast(S.DrainLife) then
                    return "Drain Life"
                end
            end
        end

        --------------------------------------------------------
        -- PRIORITY #7: Drain Soul (execute, shards/mana)
        --------------------------------------------------------
        if useDrainSoul and targetHP and targetHP < drainSoulExecute and not isMoving then
            if S.DrainSoul:IsReady() then
                if Cast(S.DrainSoul) then
                    return "Drain Soul (execute)"
                end
            end
        end

        --------------------------------------------------------
        -- PRIORITY #8: Wand (filler when mana is low AND DoTs are up)
        -- Don't spam wand between casts - only use as true filler
        --------------------------------------------------------
        if useWand and not isMoving then
            local wandMana = MainAddon.Config.GetSetting('AUTHOR_DemoLockLeveling', 'wand_mana') or 70
            local hasCorruption = TargetHasCorruption()
            local hasCurse = TargetHasCurse()
            
            -- Only wand if:
            -- 1. Mana is below threshold (conserve mana!), AND
            -- 2. Both Corruption AND Curse are on target (DoTs up first!)
            if mana and mana < wandMana and hasCorruption and hasCurse then
                if S.Shoot:IsReady() then
                    if Cast(S.Shoot) then
                        return "Shoot (wand)"
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
        local autoArmor     = MainAddon.Config.GetSetting('AUTHOR_DemoLockLeveling', 'auto_armor')
        local autoSoulLink  = MainAddon.Config.GetSetting('AUTHOR_DemoLockLeveling', 'auto_soullink')
        local autoFelguard  = MainAddon.Config.GetSetting('AUTHOR_DemoLockLeveling', 'auto_felguard')

        --------------------------------------------------------
        -- Always maintain buffs (in and out of combat)
        --------------------------------------------------------
        
        -- Apply armor based on what's available
        -- Try Fel Armor first (level 62+, if trained)
        -- Fall back to Demon Armor if Fel not learned yet
        if autoArmor then
            -- Try Fel Armor first (if learned/ready)
            if not PlayerHasFelArmor() and S.FelArmor:IsReady(Player) then
                if Cast(S.FelArmor) then
                    return "Fel Armor"
                end
            -- Fall back to Demon Armor (if Fel not available or not trained)
            elseif not PlayerHasDemonArmor() and S.DemonArmor:IsReady(Player) then
                if Cast(S.DemonArmor) then
                    return "Demon Armor"
                end
            end
        end

        -- Apply Soul Link if missing (requires pet to be alive)
        -- Soul Link: 5% damage increase + damage sharing with pet
        if autoSoulLink and not PlayerHasSoulLink() then
            if UnitExists("pet") and not UnitIsDead("pet") and UnitHealth("pet") > 0 then
                if S.SoulLink:IsReady(Player) then
                    if Cast(S.SoulLink) then
                        return "Soul Link"
                    end
                end
            end
        end

        -- Summon Felguard if missing (Demonology Badass pet)
        if autoFelguard and not UnitExists("pet") then
            local currentTime = GetTime()
            local timeSinceLastSummon = currentTime - lastSummonTime
            
            if S.SummonFelguard:IsReady(Player) and timeSinceLastSummon > MIN_SUMMON_DELAY then
                if Cast(S.SummonFelguard) then
                    lastSummonTime = currentTime
                    return "Summon Felguard"
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