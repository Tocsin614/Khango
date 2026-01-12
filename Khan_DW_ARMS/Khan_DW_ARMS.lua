local function MyRoutine()
    local Author = 'Arms Kebab Warrior - TBC Classic 1.0'
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

        ThunderClap = MultiSpell(
            6343,   -- R1
            8198,   -- R2
            8204,   -- R3
            8205,   -- R4
            11580,  -- R5
            11581,  -- R6
            25264   -- R7
        ),

        -- Attacks
        MortalStrike = MultiSpell(
            12294,  -- R1
            21551,  -- R2
            21552,  -- R3
            21553,  -- R4
            25248,  -- R5
            30330   -- R6 (TBC)
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
        key      = 'AUTHOR_ArmsKebabTBC',
        title    = 'Arms Kebab Warrior - TBC Classic',
        subtitle = '1.0 - DW Arms Bloodfrenzy',
        width    = 450,
        height   = 750,
        profiles = true,
        config   = {
            { type='header', text='Arms Kebab Warrior - TBC', size=24, align='Center', color='ffffff' },
            { type='text', text='DW Arms Build - Provides Bloodfrenzy for raid', align='Center', color='aaaaaa' },

            { type='spacer' }, { type='ruler' }, { type='spacer' },

            { type='header', text='Buffs', color='ffffff' },
            { type='checkbox', text='Auto Battle Shout', key='autobishout', icon=S.BattleShout:ID(), default=true },
            { type='checkbox', text='Auto Commanding Shout (instead of Battle)', key='autocmdshout', icon=S.CommandingShout:ID(), default=false },

            { type='spacer' }, { type='ruler' }, { type='spacer' },

            { type='header', text='Debuffs', color='ffffff' },
            { type='checkbox', text='Auto Demoralizing Shout on Target', key='autodemo', icon=S.DemoralizingShout:ID(), default=false },
            { type='checkbox', text='Auto Thunder Clap on Target', key='autotc', icon=S.ThunderClap:ID(), default=false },

            { type='spacer' }, { type='ruler' }, { type='spacer' },

            { type='header', text='Stance', color='ffffff' },
            { type='checkbox', text='Auto Berserker Stance (in combat)', key='autostance', icon=S.BerserkerStance:ID(), default=true },

            { type='spacer' }, { type='ruler' }, { type='spacer' },

            { type='header', text='Rotation Options', color='ffffff' },
            { type='checkbox', text='Use Victory Rush (free damage)', key='usevr', icon=S.VictoryRush:ID(), default=true },
            { type='checkbox', text='Use Mortal Strike', key='usems', icon=S.MortalStrike:ID(), default=true },
            { type='checkbox', text='Use Whirlwind', key='useww', icon=S.Whirlwind:ID(), default=true },
            { type='checkbox', text='Use Execute (<20% HP)', key='useexec', icon=S.Execute:ID(), default=true },

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
                default_spin  = 50,
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
                default_spin  = 50,
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
        MainAddon.Print("Arms Kebab Warrior - TBC Classic loaded! (DW Arms / Bloodfrenzy build)")
    end

    ------------------------------------------------------------
    -- COMBAT ROTATION
    ------------------------------------------------------------
    local function EnemyRotation()
        if not Player:AffectingCombat() or not Target:Exists() or not Target:IsEnemy() then
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

        -- Commanding Shout override
        local autoCmdShout = MainAddon.Config.GetSetting('AUTHOR_ArmsKebabTBC', 'autocmdshout')
        if autoCmdShout 
            and Player:BuffDown(S.CommandingShout)
            and Player:BuffDown(S.BattleShout)
            and S.CommandingShout:IsReady(Player)
        then
            if Cast(S.CommandingShout) then
                return "Commanding Shout"
            end
        end

        -- Demoralizing Shout on target (optional)
        local autoDemo = MainAddon.Config.GetSetting('AUTHOR_ArmsKebabTBC', 'autodemo')
        if autoDemo
            and Target:DebuffDown(S.DemoralizingShout)
            and S.DemoralizingShout:IsReady()
        then
            if Cast(S.DemoralizingShout) then
                return "Demoralizing Shout"
            end
        end

        -- Thunder Clap on target (optional)
        local autoTC = MainAddon.Config.GetSetting('AUTHOR_ArmsKebabTBC', 'autotc')
        if autoTC
            and Target:DebuffDown(S.ThunderClap)
            and S.ThunderClap:IsReady()
        then
            if Cast(S.ThunderClap) then
                return "Thunder Clap"
            end
        end

        local rage = UnitPower("player", 1)
        local targetHP = Target:HealthPercentage()

        -- Config settings
        local useVR              = MainAddon.Config.GetSetting('AUTHOR_ArmsKebabTBC', 'usevr')
        local useMS              = MainAddon.Config.GetSetting('AUTHOR_ArmsKebabTBC', 'usems')
        local useWW              = MainAddon.Config.GetSetting('AUTHOR_ArmsKebabTBC', 'useww')
        local useHS              = MainAddon.Config.GetSetting('AUTHOR_ArmsKebabTBC', 'usehs')
        local rageDumpEnabled    = MainAddon.Config.GetSetting('AUTHOR_ArmsKebabTBC', 'ragedump_check')
        local rageDump           = MainAddon.Config.GetSetting('AUTHOR_ArmsKebabTBC', 'ragedump_spin') or 50
        local cleaveRageEnabled  = MainAddon.Config.GetSetting('AUTHOR_ArmsKebabTBC', 'cleave_rage_check')
        local cleaveRage         = MainAddon.Config.GetSetting('AUTHOR_ArmsKebabTBC', 'cleave_rage_spin') or 50
        local useExec            = MainAddon.Config.GetSetting('AUTHOR_ArmsKebabTBC', 'useexec')
        local useSweep           = MainAddon.Config.GetSetting('AUTHOR_ArmsKebabTBC', 'usesweep')
        local useBloodrage       = MainAddon.Config.GetSetting('AUTHOR_ArmsKebabTBC', 'usebloodrage')
        local useDW              = MainAddon.Config.GetSetting('AUTHOR_ArmsKebabTBC', 'usedw')
        local useReck            = MainAddon.Config.GetSetting('AUTHOR_ArmsKebabTBC', 'usereck')

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
        -- EXECUTE PHASE: WW > Execute
        --------------------------------------------------------
        if targetHP <= 20 then
            -- Whirlwind takes priority in execute phase
            if useWW and S.Whirlwind:IsReady() then
                if Cast(S.Whirlwind) then
                    return "Whirlwind (Execute Phase)"
                end
            end
            -- Then Execute
            if useExec and S.Execute:IsReady() then
                if Cast(S.Execute) then
                    return "Execute"
                end
            end
        end

        --------------------------------------------------------
        -- NORMAL ROTATION PRIORITY: WW > MS > HS/Cleave at 50+
        --------------------------------------------------------
        
        -- Whirlwind (highest priority)
        if useWW and S.Whirlwind:IsReady() then
            if Cast(S.Whirlwind) then
                return "Whirlwind"
            end
        end

        -- Mortal Strike (second priority)
        if useMS and S.MortalStrike:IsReady() then
            if Cast(S.MortalStrike) then
                return "Mortal Strike"
            end
        end

        --------------------------------------------------------
        -- APL: actions+=/heroic_strike,if=rage>=50&nextswing<=0.2&enemies<2
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
        local autoBShout = MainAddon.Config.GetSetting('AUTHOR_ArmsKebabTBC', 'autobishout')
        local autoStance = MainAddon.Config.GetSetting('AUTHOR_ArmsKebabTBC', 'autostance')

        --------------------------------------------------------
        -- FIRST PRIORITY: Battle Shout (before anything else)
        --------------------------------------------------------
        if autoBShout 
            and Player:BuffDown(S.BattleShout)
            and Player:BuffDown(S.CommandingShout)
            and S.BattleShout:IsReady(Player)
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