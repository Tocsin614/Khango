local function MyRoutine()
    local Author = 'Fury Warrior - TBC Classic 1.0'
    local SpecID = 1 -- Warrior

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
    -- Spells (all ranks) - LOCAL SPELL TABLE
    ------------------------------------------------------------
    local S = {
        -- Auto Attack
        Attack = Spell(6603),

        -- Stances
        BerserkerStance = Spell(2458),

        -- Shouts
        BattleShout = MultiSpell(
            6673,   -- R1
            5242,   -- R2
            6192,   -- R3
            11549,  -- R4
            11550,  -- R5
            11551,  -- R6
            25289,  -- R7
            2048    -- R8 (TBC)
        ),

        CommandingShout = MultiSpell(
            469,    -- R1
            47439,  -- R2
            47440   -- R3
        ),

        DemoralizingShout = MultiSpell(
            1160,   -- R1
            6190,   -- R2
            11554,  -- R3
            11555,  -- R4
            11556,  -- R5
            25202,  -- R6
            25203   -- R7
        ),

        -- Attacks
        Bloodthirst = MultiSpell(
            23881,  -- R1
            23892,  -- R2
            23893,  -- R3
            23894,  -- R4
            25251,  -- R5
            30335   -- R6
        ),

        Whirlwind = Spell(1680),

        HeroicStrike = MultiSpell(
            78,     -- R1
            284,    -- R2
            285,    -- R3
            1608,   -- R4
            11564,  -- R5
            11565,  -- R6
            11566,  -- R7
            11567,  -- R8
            25286,  -- R9
            29707   -- R10 (TBC)
        ),

        Execute = MultiSpell(
            5308,   -- R1
            20658,  -- R2
            20660,  -- R3
            20661,  -- R4
            20662,  -- R5
            25234,  -- R6
            25236   -- R7
        ),

        VictoryRush = Spell(34428), -- TBC ability

        -- Cooldowns
        Bloodrage = Spell(2687),
        DeathWish = Spell(12292),
        Recklessness = Spell(1719),
        Rampage = MultiSpell(
            29801,  -- R1
            30030,  -- R2
            30033   -- R3
        ),

        -- AoE
        SweepingStrikes = Spell(12328),
        Cleave = MultiSpell(
            845,    -- R1
            7369,   -- R2
            11608,  -- R3
            11609,  -- R4
            20569,  -- R5
            25231,  -- R6
            30131   -- R7
        )
    }

    ------------------------------------------------------------
    -- Helper Functions
    ------------------------------------------------------------
    local function TargetIsBoss()
        local classification = UnitClassification("target")
        return classification == "worldboss" or classification == "rareelite" or classification == "elite"
    end

    local function IsInBerserkerStance()
        return GetShapeshiftForm() == 3
    end

    ------------------------------------------------------------
    -- Items table (kept for structure)
    ------------------------------------------------------------
    Item.Warrior = Item.Warrior or {}
    local I = Item.Warrior

    ------------------------------------------------------------
    -- Config Menu
    ------------------------------------------------------------
    local Warrior_Config = {
        key      = 'AUTHOR_FuryWarriorTBC',
        title    = 'Fury Warrior - TBC Classic',
        subtitle = '1.0',
        width    = 450,
        height   = 700,
        profiles = true,
        config   = {
            { type='header', text='Fury Warrior - TBC', size=24, align='Center', color='ffffff' },

            { type='spacer' }, { type='ruler' }, { type='spacer' },

            { type='header', text='Buffs', color='ffffff' },
            { type='checkbox', text='Auto Battle Shout', key='autobishout', icon=S.BattleShout:ID(), default=true },
            { type='checkbox', text='Auto Commanding Shout (instead of Battle)', key='autocmdshout', icon=S.CommandingShout:ID(), default=false },
            { type='checkbox', text='Auto Demoralizing Shout on Target', key='autodemo', icon=S.DemoralizingShout:ID(), default=true },

            { type='spacer' }, { type='ruler' }, { type='spacer' },

            { type='header', text='Stance', color='ffffff' },
            { type='checkbox', text='Auto Berserker Stance (in combat)', key='autostance', icon=S.BerserkerStance:ID(), default=true },

            { type='spacer' }, { type='ruler' }, { type='spacer' },

            { type='header', text='Rotation Options', color='ffffff' },
            { type='checkbox', text='Use Bloodthirst', key='usebt', icon=S.Bloodthirst:ID(), default=true },
            { type='checkbox', text='Use Whirlwind', key='useww', icon=S.Whirlwind:ID(), default=true },
            { type='checkbox', text='Use Rampage', key='userampage', icon=S.Rampage:ID(), default=true },
            { type='checkbox', text='Use Execute (<20% HP)', key='useexec', icon=S.Execute:ID(), default=true },
            { type='checkbox', text='Use Victory Rush (free damage)', key='usevr', icon=S.VictoryRush:ID(), default=true },

            { type='spacer' }, { type='ruler' }, { type='spacer' },

            { type='header', text='Rage Management', color='ffffff' },
            { type='checkbox', text='Use Heroic Strike (Rage Dump)', key='usehs', icon=S.HeroicStrike:ID(), default=true },
            {
                type          = 'checkspin',
                text          = 'Heroic Strike above rage',
                key           = 'ragedump',
                min           = 30,
                max           = 100,
                icon          = S.HeroicStrike:ID(),
                default_check = true,
                default_spin  = 60,
            },

            { type='spacer' }, { type='ruler' }, { type='spacer' },

            { type='header', text='AoE Options', color='ffffff' },
            { type='checkbox', text='Use Sweeping Strikes (AoE)', key='usesweep', icon=S.SweepingStrikes:ID(), default=true },
            {
                type          = 'checkspin',
                text          = 'Cleave above rage (AoE)',
                key           = 'cleave_rage',
                min           = 30,
                max           = 100,
                icon          = S.Cleave:ID(),
                default_check = true,
                default_spin  = 60,
            },

            { type='spacer' }, { type='ruler' }, { type='spacer' },

            { type='header', text='Cooldowns (Boss + Bloodlust Only)', color='ffffff' },
            { type='checkbox', text='Use Bloodrage (rage gen)', key='usebloodrage', icon=S.Bloodrage:ID(), default=true },
            { type='checkbox', text='Use Death Wish', key='usedw', icon=S.DeathWish:ID(), default=true },
            { type='checkbox', text='Use Recklessness', key='usereck', icon=S.Recklessness:ID(), default=false },
        }
    }

    MainAddon.SetCustomConfig(Author, SpecID, Warrior_Config)

    ------------------------------------------------------------
    -- INIT
    ------------------------------------------------------------
    local function Init()
        MainAddon:Print('Fury Warrior - TBC Classic 1.0 loaded........')
    end

    ------------------------------------------------------------
    -- ENEMY ROTATION
    ------------------------------------------------------------
    local function EnemyRotation()
        -- Config settings
        local autoDemo = MainAddon.Config.GetSetting('AUTHOR_FuryWarriorTBC', 'autodemo')

        -- Return early if no valid target
        if not MainAddon.TargetIsValid() then
            return
        end

        local inMelee = Target:IsInRange(5)

        --------------------------------------------------------
        -- Auto Attack - ensure attacking in melee range
        --------------------------------------------------------
        if inMelee and S.Attack:IsReady() then
            if not IsCurrentSpell(6603) then
                if Cast(S.Attack) then
                    return "Auto Attack"
                end
            end
        end

        --------------------------------------------------------
        -- Demoralizing Shout on target
        --------------------------------------------------------
        if autoDemo 
            and Target:DebuffDown(S.DemoralizingShout)
            and S.DemoralizingShout:IsReady()
        then
            if Cast(S.DemoralizingShout) then
                return "Demoralizing Shout"
            end
        end

        local rage = UnitPower("player", 1)
        local targetHP = Target:HealthPercentage()

        -- Config settings
        local useBT              = MainAddon.Config.GetSetting('AUTHOR_FuryWarriorTBC', 'usebt')
        local useWW              = MainAddon.Config.GetSetting('AUTHOR_FuryWarriorTBC', 'useww')
        local useHS              = MainAddon.Config.GetSetting('AUTHOR_FuryWarriorTBC', 'usehs')
        local rageDumpEnabled    = MainAddon.Config.GetSetting('AUTHOR_FuryWarriorTBC', 'ragedump_check')
        local rageDump           = MainAddon.Config.GetSetting('AUTHOR_FuryWarriorTBC', 'ragedump_spin') or 60
        local cleaveRageEnabled  = MainAddon.Config.GetSetting('AUTHOR_FuryWarriorTBC', 'cleave_rage_check')
        local cleaveRage         = MainAddon.Config.GetSetting('AUTHOR_FuryWarriorTBC', 'cleave_rage_spin') or 60
        local useExec            = MainAddon.Config.GetSetting('AUTHOR_FuryWarriorTBC', 'useexec')
        local useRampage         = MainAddon.Config.GetSetting('AUTHOR_FuryWarriorTBC', 'userampage')
        local useSweep           = MainAddon.Config.GetSetting('AUTHOR_FuryWarriorTBC', 'usesweep')
        local useVR              = MainAddon.Config.GetSetting('AUTHOR_FuryWarriorTBC', 'usevr')
        local useBloodrage       = MainAddon.Config.GetSetting('AUTHOR_FuryWarriorTBC', 'usebloodrage')
        local useDW              = MainAddon.Config.GetSetting('AUTHOR_FuryWarriorTBC', 'usedw')
        local useReck            = MainAddon.Config.GetSetting('AUTHOR_FuryWarriorTBC', 'usereck')

        local isBoss = TargetIsBoss()
        local hasBloodlust = (Player:BuffDown(Spell(2825)) == false or Player:BuffDown(Spell(32182)) == false)

        --------------------------------------------------------
        -- APL: actions+=/bloodrage (rage generation)
        --------------------------------------------------------
        if useBloodrage and S.Bloodrage:IsReady() then
            if Cast(S.Bloodrage) then
                return "Bloodrage"
            end
        end

        --------------------------------------------------------
        -- APL: actions+=/death_wish,if=target.is_boss&buff.bloodlust.up
        --------------------------------------------------------
        if useDW and isBoss and hasBloodlust and S.DeathWish:IsReady() then
            if Cast(S.DeathWish) then
                return "Death Wish"
            end
        end

        --------------------------------------------------------
        -- APL: actions+=/recklessness,if=target.is_boss&buff.bloodlust.up
        --------------------------------------------------------
        if useReck and isBoss and hasBloodlust and S.Recklessness:IsReady() then
            if Cast(S.Recklessness) then
                return "Recklessness"
            end
        end

        --------------------------------------------------------
        -- APL: actions+=/sweeping_strikes (AoE)
        --------------------------------------------------------
        if useSweep and S.SweepingStrikes:IsReady() then
            local enemies = Player:GetEnemiesInMeleeRange(8)
            local enemyCount = #enemies
            if enemyCount >= 2 then
                if Cast(S.SweepingStrikes) then
                    return "Sweeping Strikes"
                end
            end
        end

        --------------------------------------------------------
        -- APL: actions+=/victory_rush (free damage when buff is up)
        --------------------------------------------------------
        if useVR and S.VictoryRush:IsReady() then
            if Cast(S.VictoryRush) then
                return "Victory Rush"
            end
        end

        --------------------------------------------------------
        -- APL: actions+=/rampage (maintain buff)
        --------------------------------------------------------
        if useRampage 
            and Player:BuffDown(S.Rampage)
            and S.Rampage:IsReady()
        then
            if Cast(S.Rampage) then
                return "Rampage"
            end
        end

        --------------------------------------------------------
        -- APL: AoE Priority - Whirlwind before Bloodthirst when 2+ enemies
        --------------------------------------------------------
        local enemies = Player:GetEnemiesInMeleeRange(8)
        local enemyCount = #enemies

        if enemyCount >= 2 then
            -- Whirlwind first in AoE
            if useWW and S.Whirlwind:IsReady() then
                if Cast(S.Whirlwind) then
                    return "Whirlwind (AoE)"
                end
            end
            -- Then Bloodthirst
            if useBT and S.Bloodthirst:IsReady() then
                if Cast(S.Bloodthirst) then
                    return "Bloodthirst (AoE)"
                end
            end
        else
            -- Single target: Bloodthirst before Whirlwind
            if useBT and S.Bloodthirst:IsReady() then
                if Cast(S.Bloodthirst) then
                    return "Bloodthirst"
                end
            end
            if useWW and S.Whirlwind:IsReady() then
                if Cast(S.Whirlwind) then
                    return "Whirlwind"
                end
            end
        end

        --------------------------------------------------------
        -- APL: actions+=/heroic_strike,if=rage>60&nextswing<=0.2&enemies<2
        -- Only queue Heroic Strike right before melee swing on SINGLE TARGET
        -- Use Cleave instead when there are 2+ enemies
        --------------------------------------------------------
        if useHS and rageDumpEnabled and rage >= rageDump then
            local enemies = Player:GetEnemiesInMeleeRange(8)
            local enemyCount = #enemies
            local nextSwing = Player:NextSwing()
            if enemyCount < 2 and nextSwing <= 0.2 and S.HeroicStrike:IsReady() then
                if Cast(S.HeroicStrike) then
                    return "Heroic Strike"
                end
            end
        end

        --------------------------------------------------------
        -- APL: actions+=/execute,if=target.health<20%
        --------------------------------------------------------
        if useExec and targetHP <= 20 and S.Execute:IsReady() then
            if Cast(S.Execute) then
                return "Execute"
            end
        end

        --------------------------------------------------------
        -- APL: actions+=/cleave (AoE) - queue right before swing when 2+ enemies and rage threshold met
        --------------------------------------------------------
        if cleaveRageEnabled and rage >= cleaveRage then
            local enemies = Player:GetEnemiesInMeleeRange(8)
            local enemyCount = #enemies
            local nextSwing = Player:NextSwing()
            if enemyCount >= 2 and nextSwing <= 0.2 and S.Cleave:IsReady() then
                if Cast(S.Cleave) then
                    return "Cleave"
                end
            end
        end

        return
    end

    ------------------------------------------------------------
    -- MAIN LOOP
    ------------------------------------------------------------
    local function MainRotation()
        local autoBShout = MainAddon.Config.GetSetting('AUTHOR_FuryWarriorTBC', 'autobishout')
        local autoStance = MainAddon.Config.GetSetting('AUTHOR_FuryWarriorTBC', 'autostance')

        --------------------------------------------------------
        -- FIRST PRIORITY: Battle Shout (before anything else)
        --------------------------------------------------------
        if autoBShout 
            and Player:BuffDown(S.BattleShout)
            and Player:BuffDown(S.CommandingShout)
            and S.BattleShout:IsReady()
        then
            if Cast(S.BattleShout) then
                return "Battle Shout"
            end
        end

        -- Swap to Berserker Stance if in combat and not already in it
        if autoStance and Player:AffectingCombat() and not IsInBerserkerStance() then
            if S.BerserkerStance:IsReady(Player) then
                if Cast(S.BerserkerStance) then
                    return "Berserker Stance"
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