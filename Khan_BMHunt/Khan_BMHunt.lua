local function MyRoutine()
    local Author = 'Hunter - BM (TBC) 2.0'
    local SpecID = 3 -- Hunter

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

    -- Auto Shot state
    local AutoShot_ACTIVE = false

    ------------------------------------------------------------
    -- Spells (TBC) - LOCAL table
    ------------------------------------------------------------
    local S = {}

    -- Hunter's Mark
    S.HuntersMark = MultiSpell(
        1130,   -- R1
        14323,  -- R2
        14324,  -- R3
        14325   -- R4
    )

    -- Arcane Shot
    S.ArcaneShot = MultiSpell(
        3044,   -- R1
        14281,  -- R2
        14282,  -- R3
        14283,  -- R4
        14284,  -- R5
        14285,  -- R6
        14286,  -- R7
        14287,  -- R8
        27019   -- R9 (TBC)
    )

    -- Steady Shot (TBC main filler - only 1 rank)
    S.SteadyShot = Spell(34120)

    -- Kill Command (BM signature - only 1 rank in TBC)
    S.KillCommand = Spell(34026)

    -- Multi-Shot (highest DPS even on single target in TBC)
    S.MultiShot = MultiSpell(
        2643,   -- R1
        14288,  -- R2
        14289,  -- R3
        14290,  -- R4
        25294,  -- R5
        27021   -- R6 (TBC)
    )

    -- Raptor Strike (melee)
    S.RaptorStrike = MultiSpell(
        2973,   -- R1
        14260,  -- R2
        14261,  -- R3
        14262,  -- R4
        14263,  -- R5
        14264,  -- R6
        14265,  -- R7
        14266,  -- R8
        27014   -- R9 (TBC)
    )

    -- Mongoose Bite
    S.MongooseBite = MultiSpell(
        1495,   -- R1
        14269,  -- R2
        14270,  -- R3
        14271,  -- R4
        36916   -- R5 (TBC)
    )

    -- Wing Clip
    S.WingClip = MultiSpell(
        2974,   -- R1
        14267,  -- R2
        14268   -- R3
    )

    -- Aspects
    S.AspectOfTheHawk = MultiSpell(
        13165,  -- R1
        14318,  -- R2
        14319,  -- R3
        14320,  -- R4
        14321,  -- R5
        14322,  -- R6
        25296,  -- R7
        27044   -- R8 (TBC)
    )

    S.AspectOfTheViper = S.AspectOfTheViper or Spell(34074) -- TBC only

    -- Utility
    S.ConcussiveShot = S.ConcussiveShot or Spell(5116)
    S.AutoShot       = S.AutoShot       or Spell(75)

    -- Traps
    S.ExplosiveTrap = MultiSpell(
        13813,  -- R1
        14316,  -- R2
        14317,  -- R3
        27025   -- R4 (TBC)
    )

    -- Cooldowns
    S.RapidFire = Spell(3045)  -- TBC - only 1 rank

    S.BestialWrath = Spell(19574) -- BM signature CD (TBC - only 1 rank)

    -- Racials
    S.BloodFury    = Spell(20572)  -- Orc
    S.Berserking   = Spell(26297)  -- Troll

    ------------------------------------------------------------
    -- Buff/Debuff helpers
    ------------------------------------------------------------
    local HUNTERS_MARK_NAME   = GetSpellInfo(1130)
    local WING_CLIP_NAME      = GetSpellInfo(2974)
    local ASPECT_HAWK_NAME    = GetSpellInfo(13165)
    local ASPECT_VIPER_NAME   = GetSpellInfo(34074)
    local BLOODLUST_NAME      = GetSpellInfo(2825)   -- Horde: Bloodlust
    local HEROISM_NAME        = GetSpellInfo(32182)  -- Alliance: Heroism

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

    local function TargetHasHuntersMark()
        return HasDebuffByName("target", HUNTERS_MARK_NAME)
    end

    local function TargetHasWingClip()
        return HasDebuffByName("target", WING_CLIP_NAME)
    end

    local function HasAspectOfHawk()
        return HasBuffByName("player", ASPECT_HAWK_NAME)
    end

    local function HasAspectOfViper()
        return HasBuffByName("player", ASPECT_VIPER_NAME)
    end

    local function HasBloodlust()
        return HasBuffByName("player", BLOODLUST_NAME) or HasBuffByName("player", HEROISM_NAME)
    end

    ------------------------------------------------------------
    -- Items table (kept for structure)
    ------------------------------------------------------------
    Item.Hunter = Item.Hunter or {}
    local I = Item.Hunter

    ------------------------------------------------------------
    -- Aggro check
    ------------------------------------------------------------
    local function TargetIsTargetingPlayer()
        return Target:Exists()
            and Target:CanAttack(Player)
            and UnitGUID("targettarget") == UnitGUID("player")
    end

    ------------------------------------------------------------
    -- Config Menu
    ------------------------------------------------------------
    local Hunter_Config = {
        key      = 'AUTHOR_HunterTBC',
        title    = 'Hunter - BM (TBC)',
        subtitle = '2.0',
        width    = 450,
        height   = 600,
        profiles = true,
        config   = {
            { type='header', text='BM Hunter (TBC)', size=24, align='Center', color='ffffff' },

            { type='spacer' }, { type='ruler' }, { type='spacer' },

            { type='header', text='Aspect Management', color='ffffff' },
            {
                type          = 'checkspin',
                text          = 'Aspect of Viper ON below mana %',
                key           = 'viperon',
                min           = 1,
                max           = 100,
                icon          = S.AspectOfTheViper:ID(),
                default_check = true,
                default_spin  = 20,
            },
            {
                type          = 'checkspin',
                text          = 'Aspect of Hawk when above mana %',
                key           = 'viperoff',
                min           = 1,
                max           = 100,
                icon          = S.AspectOfTheHawk:ID(),
                default_check = true,
                default_spin  = 60,
            },

            { type='spacer' }, { type='ruler' }, { type='spacer' },

            { type='header', text='Rotation Options', color='ffffff' },
            { type='checkbox', text='Use Hunter\'s Mark', key='usehm', icon=S.HuntersMark:ID(), default=true },
            { type='checkbox', text='Use Kill Command', key='usekc', icon=S.KillCommand:ID(), default=true },
            { type='checkbox', text='Use Multi-Shot', key='usems', icon=S.MultiShot:ID(), default=true },
            { type='checkbox', text='Use Steady Shot', key='usessteady', icon=S.SteadyShot:ID(), default=true },
            { type='checkbox', text='Use Arcane Shot', key='usearc', icon=S.ArcaneShot:ID(), default=true },
            { type='checkbox', text='Use Concussive Shot if target is on me', key='useconcussive', icon=S.ConcussiveShot:ID(), default=true },

            { type='spacer' }, { type='ruler' }, { type='spacer' },

            { type='header', text='AoE Options', color='ffffff' },
            {
                type          = 'checkspin',
                text          = 'Use Explosive Trap on X+ targets',
                key           = 'explosivetrap',
                min           = 2,
                max           = 20,
                icon          = S.ExplosiveTrap:ID(),
                default_check = false,
                default_spin  = 7,
            },

            { type='spacer' }, { type='ruler' }, { type='spacer' },

            { type='header', text='Cooldowns (on Bloodlust/Heroism)', color='ffff00' },
            { type='checkbox', text='Rapid Fire', key='userapidfire', icon=S.RapidFire:ID(), default=true },
            { type='checkbox', text='Bestial Wrath', key='usebw', icon=S.BestialWrath:ID(), default=true },
            { type='checkbox', text='Racial (Blood Fury / Berserking)', key='useracial', icon=S.BloodFury:ID(), default=true },
            { type='checkbox', text='On-use Trinkets', key='usetrinkets', icon=S.RapidFire:ID(), default=true },
        }
    }

    MainAddon.SetCustomConfig(Author, SpecID, Hunter_Config)

    ------------------------------------------------------------
    -- INIT
    ------------------------------------------------------------
    local function Init()
        MainAddon:Print('Hunter - BM (TBC) 2.0 loaded....')
    end

    ------------------------------------------------------------
    -- ENEMY ROTATION
    ------------------------------------------------------------
    local function EnemyRotation()
        if not MainAddon.TargetIsValid() then
            AutoShot_ACTIVE = false
            return
        end

        local mana    = Player:ManaPercentage()
        local inMelee = Target:IsInRange(5)

        -- Config settings
        local useHM         = MainAddon.Config.GetSetting('AUTHOR_HunterTBC', 'usehm')
        local useKC         = MainAddon.Config.GetSetting('AUTHOR_HunterTBC', 'usekc')
        local useMS         = MainAddon.Config.GetSetting('AUTHOR_HunterTBC', 'usems')
        local useSteady     = MainAddon.Config.GetSetting('AUTHOR_HunterTBC', 'usessteady')
        local useArc        = MainAddon.Config.GetSetting('AUTHOR_HunterTBC', 'usearc')
        local useConcussive = MainAddon.Config.GetSetting('AUTHOR_HunterTBC', 'useconcussive')

        local explosiveEnabled = MainAddon.Config.GetSetting('AUTHOR_HunterTBC', 'explosivetrap_check')
        local explosiveTargets = MainAddon.Config.GetSetting('AUTHOR_HunterTBC', 'explosivetrap_spin') or 7

        -- Cooldown settings
        local useRapidFire  = MainAddon.Config.GetSetting('AUTHOR_HunterTBC', 'userapidfire')
        local useBW         = MainAddon.Config.GetSetting('AUTHOR_HunterTBC', 'usebw')
        local useRacial     = MainAddon.Config.GetSetting('AUTHOR_HunterTBC', 'useracial')
        local useTrinkets   = MainAddon.Config.GetSetting('AUTHOR_HunterTBC', 'usetrinkets')

        --------------------------------------------------------
        -- Auto Shot toggle (ranged only)
        --------------------------------------------------------
        if inMelee then
            AutoShot_ACTIVE = false
        else
            if S.AutoShot:IsReady() and not AutoShot_ACTIVE then
                if Cast(S.AutoShot) then
                    AutoShot_ACTIVE = true
                    return "Auto Shot (ON)"
                end
            end
        end

        --------------------------------------------------------
        -- Cooldowns (on Bloodlust/Heroism)
        --------------------------------------------------------
        if HasBloodlust() then

                        -- On-use Trinkets
            if useTrinkets and Player.GetUseableTrinkets then
                local trinkets = Player:GetUseableTrinkets({})
                if trinkets then
                    if Cast(trinkets, true) then
                        return "Use Trinkets"
                    end
                end
            end
            -- Rapid Fire
            if useRapidFire and S.RapidFire:IsReady(player) then
                if Cast(S.RapidFire) then
                    return "Rapid Fire"
                end
            end

            -- Bestial Wrath
            if useBW and S.BestialWrath:IsReady() then
                if Cast(S.BestialWrath) then
                    return "Bestial Wrath"
                end
            end

            -- Racial Cooldowns
            if useRacial then
                -- Orc: Blood Fury
                if S.BloodFury and S.BloodFury:IsReady(player) then
                    if Cast(S.BloodFury) then
                        return "Blood Fury"
                    end
                end

                -- Troll: Berserking
                if S.Berserking and S.Berserking:IsReady() then
                    if Cast(S.Berserking) then
                        return "Berserking"
                    end
                end
            end


        end

        --------------------------------------------------------
        -- Ranged Rotation (1:1.5 - Steady/Instant/Steady pattern)
        --------------------------------------------------------
        if not inMelee then

            --------------------------------------------------------
            -- Concussive Shot (when target is on you)
            --------------------------------------------------------
            if useConcussive
                and S.ConcussiveShot:IsReady()
                and TargetIsTargetingPlayer()
            then
                if Cast(S.ConcussiveShot) then
                    return "Concussive Shot"
                end
            end

            --------------------------------------------------------
            -- Hunter's Mark
            --------------------------------------------------------
            if useHM
                and S.HuntersMark:IsReady()
                and not TargetHasHuntersMark()
            then
                if Cast(S.HuntersMark) then
                    return "Hunter's Mark"
                end
            end

            --------------------------------------------------------
            -- Kill Command (highest priority, use on cooldown)
            --------------------------------------------------------
            if useKC
                and S.KillCommand:IsReady()
            then
                if Cast(S.KillCommand) then
                    return "Kill Command"
                end
            end

            --------------------------------------------------------
            -- Multi-Shot (highest DPS, use on CD - instant cast)
            --------------------------------------------------------
            if useMS
                and S.MultiShot:IsReady()
            then
                if Cast(S.MultiShot) then
                    return "Multi-Shot"
                end
            end

            --------------------------------------------------------
            -- Arcane Shot (filler instant cast)
            --------------------------------------------------------
            if useArc
                and S.ArcaneShot:IsReady()
            then
                if Cast(S.ArcaneShot) then
                    return "Arcane Shot"
                end
            end

            --------------------------------------------------------
            -- Steady Shot (main filler - ONLY cast if enough time before auto)
            -- Need enough time to finish 1.5s cast before next auto
            -- Check if we have at least 1.5s before next swing
            --------------------------------------------------------
            if useSteady
                and S.SteadyShot:IsReady()
            then
                local nextSwing = Player:NextSwing()
                -- Cast if we have more than 1.5s until next auto
                -- This ensures we finish the cast before clipping
                if nextSwing > 1.6 or nextSwing == 0 then   --changed to 1.6 to allow for a lil lag
                    if Cast(S.SteadyShot) then
                        return "Steady Shot"
                    end
                end
            end

            --------------------------------------------------------
            -- Explosive Trap (AoE on many targets)
            --------------------------------------------------------
            if explosiveEnabled
                and S.ExplosiveTrap:IsReady()
            then
                -- Placeholder for proper target counting
                if Cast(S.ExplosiveTrap) then
                    return "Explosive Trap"
                end
            end
        end

        --------------------------------------------------------
        -- Melee priority: Mongoose Bite > Raptor Strike > Wing Clip
        --------------------------------------------------------
        if inMelee then
            -- Mongoose Bite
            if S.MongooseBite:IsReady() then
                if Cast(S.MongooseBite) then
                    return "Mongoose Bite"
                end
            end

            -- Raptor Strike
            if S.RaptorStrike:IsReady() then
                if Cast(S.RaptorStrike) then
                    return "Raptor Strike"
                end
            end

            -- Wing Clip (for kiting)
            if S.WingClip:IsReady() and not TargetHasWingClip() then
                if Cast(S.WingClip) then
                    return "Wing Clip"
                end
            end
        end

        return
    end

    ------------------------------------------------------------
    -- MAIN LOOP
    ------------------------------------------------------------
    local function MainRotation()
        local viperEnabled    = MainAddon.Config.GetSetting('AUTHOR_HunterTBC', 'viperon_check')
        local viperOnThreshold  = MainAddon.Config.GetSetting('AUTHOR_HunterTBC', 'viperon_spin') or 20
        local hawkEnabled     = MainAddon.Config.GetSetting('AUTHOR_HunterTBC', 'viperoff_check')
        local viperOffThreshold = MainAddon.Config.GetSetting('AUTHOR_HunterTBC', 'viperoff_spin') or 60

        local mana = Player:ManaPercentage()

        --------------------------------------------------------
        -- Aspect Management (ALWAYS - in and out of combat)
        --------------------------------------------------------
        -- Switch TO Viper when mana drops below ON threshold
        if viperEnabled and mana < viperOnThreshold and not HasAspectOfViper() then
            if S.AspectOfTheViper:IsReady(Player) then
                if Cast(S.AspectOfTheViper) then
                    return "Aspect of the Viper"
                end
            end
        end

        -- Switch TO Hawk when mana is above OFF threshold (or Viper disabled)
        if hawkEnabled and ((not viperEnabled) or (HasAspectOfViper() and mana >= viperOffThreshold)) and not HasAspectOfHawk() then
            if S.AspectOfTheHawk:IsReady(Player) then
                if Cast(S.AspectOfTheHawk) then
                    return "Aspect of the Hawk"
                end
            end
        end

        -- Apply Hawk if no aspect active at all (and hawk is enabled)
        if hawkEnabled and not HasAspectOfHawk() and not HasAspectOfViper() then
            if S.AspectOfTheHawk:IsReady(Player) then
                if Cast(S.AspectOfTheHawk) then
                    return "Aspect of the Hawk (initial)"
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