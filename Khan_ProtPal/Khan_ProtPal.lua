local function MyRoutine()
    local Author = 'Protection Paladin - TBC Classic 1.1'
    local SpecID = 2 -- Paladin

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
    -- Local Spell Table (Don't use global HL.Spell.Paladin)
    ------------------------------------------------------------
    local S = {
        -- Seals
        SealOfWisdom = MultiSpell(
            20166,  -- R1
            20356,  -- R2
            20357,  -- R3
            27164   -- R4
        ),

        SealOfRighteousness = MultiSpell(
            21084,  -- R1
            20287,  -- R2
            20288,  -- R3
            20289,  -- R4
            20290,  -- R5
            20291,  -- R6
            20292,  -- R7
            20293,  -- R8
            27155,  -- R9
            27156   -- R10
        ),

        -- Judgements
        Judgement = Spell(20271),

        -- Blessings
        BlessingOfKings = Spell(20217),

        BlessingOfWisdom = MultiSpell(
            19742,  -- R1
            19850,  -- R2
            19852,  -- R3
            19853,  -- R4
            19854,  -- R5
            25290,  -- R6
            27142   -- R7
        ),

        BlessingOfSanctuary = MultiSpell(
            20911,  -- R1
            20912,  -- R2
            20913,  -- R3
            20914,  -- R4
            27168   -- R5
        ),

        GreaterBlessingOfKings = Spell(25898),

        GreaterBlessingOfWisdom = MultiSpell(
            25894,  -- R1
            25918   -- R2
        ),

        GreaterBlessingOfSanctuary = MultiSpell(
            25899,  -- R1
            27169   -- R2
        ),

        -- Auras
        RighteousFury = Spell(25780),
        SanctityAura = Spell(20218),

        DevotionAura = MultiSpell(
            465,    -- R1
            10290,  -- R2
            643,    -- R3
            10291,  -- R4
            1032,   -- R5
            10292,  -- R6
            10293,  -- R7
            27149   -- R8
        ),

        ConcentrationAura = Spell(19746),

        RetributionAura = MultiSpell(
            7294,   -- R1
            10298,  -- R2
            10299,  -- R3
            10300,  -- R4
            10301,  -- R5
            27150   -- R6
        ),

        -- Attacks
        HolyShield = MultiSpell(
            20925,  -- R1
            20927,  -- R2
            20928,  -- R3
            27179   -- R4
        ),

        Consecration = MultiSpell(
            26573,  -- R1
            20116,  -- R2
            20922,  -- R3
            20923,  -- R4
            20924,  -- R5
            27173   -- R6
        ),

        AvengersShield = MultiSpell(
            31935,  -- R1
            32699,  -- R2
            32700   -- R3
        ),

        Exorcism = MultiSpell(
            879,    -- R1
            5614,   -- R2
            5615,   -- R3
            10312,  -- R4
            10313,  -- R5
            10314,  -- R6
            27138   -- R7
        ),

        HammerOfWrath = MultiSpell(
            24275,  -- R1
            24274,  -- R2
            24239,  -- R3
            27180   -- R4
        ),

        -- Utility
        AvengingWrath = Spell(31884),
        DivineShield = MultiSpell(642, 1020),
        HammerOfJustice = MultiSpell(853, 5588, 5589, 10308)
    }

    ------------------------------------------------------------
    -- Buff/Debuff helpers
    ------------------------------------------------------------
    local SEAL_OF_WISDOM_NAME           = GetSpellInfo(20166)
    local SEAL_OF_RIGHTEOUSNESS_NAME    = GetSpellInfo(21084)
    
    local BLESSING_OF_KINGS_NAME        = GetSpellInfo(20217)
    local BLESSING_OF_WISDOM_NAME       = GetSpellInfo(19742)
    local BLESSING_OF_SANCTUARY_NAME    = GetSpellInfo(20911)
    
    local GREATER_BLESSING_OF_KINGS_NAME     = GetSpellInfo(25898)
    local GREATER_BLESSING_OF_WISDOM_NAME    = GetSpellInfo(25894)
    local GREATER_BLESSING_OF_SANCTUARY_NAME = GetSpellInfo(25899)
    
    local RIGHTEOUS_FURY_NAME           = GetSpellInfo(25780)
    local SANCTITY_AURA_NAME            = GetSpellInfo(20218)
    local DEVOTION_AURA_NAME            = GetSpellInfo(465)
    local CONCENTRATION_AURA_NAME       = GetSpellInfo(19746)
    local RETRIBUTION_AURA_NAME         = GetSpellInfo(7294)
    
    local HOLY_SHIELD_NAME              = GetSpellInfo(20925)
    local JUDGEMENT_OF_WISDOM_NAME      = GetSpellInfo(20355)  -- Debuff from judging Seal of Wisdom

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

    local function PlayerHasSeal(sealName)
        return HasBuffByName("player", sealName)
    end

    local function PlayerHasBlessing()
        return HasBuffByName("player", BLESSING_OF_KINGS_NAME)
            or HasBuffByName("player", BLESSING_OF_WISDOM_NAME)
            or HasBuffByName("player", BLESSING_OF_SANCTUARY_NAME)
            or HasBuffByName("player", GREATER_BLESSING_OF_KINGS_NAME)
            or HasBuffByName("player", GREATER_BLESSING_OF_WISDOM_NAME)
            or HasBuffByName("player", GREATER_BLESSING_OF_SANCTUARY_NAME)
    end

    local function PlayerHasAura()
        return HasBuffByName("player", SANCTITY_AURA_NAME)
            or HasBuffByName("player", DEVOTION_AURA_NAME)
            or HasBuffByName("player", CONCENTRATION_AURA_NAME)
            or HasBuffByName("player", RETRIBUTION_AURA_NAME)
    end

    local function PlayerHasRighteousFury()
        return HasBuffByName("player", RIGHTEOUS_FURY_NAME)
    end

    local function PlayerHasHolyShield()
        return HasBuffByName("player", HOLY_SHIELD_NAME)
    end

    local function TargetHasJudgementOfWisdom()
        return HasDebuffByName("target", JUDGEMENT_OF_WISDOM_NAME)
    end

    local function TargetIsUndeadOrDemon()
        if not UnitExists("target") then return false end
        local creatureType = UnitCreatureType("target")
        return creatureType == "Undead" or creatureType == "Demon"
    end

    ------------------------------------------------------------
    -- Items table (kept for structure)
    ------------------------------------------------------------
    Item.Paladin = Item.Paladin or {}
    local I = Item.Paladin

    ------------------------------------------------------------
    -- Config Menu
    ------------------------------------------------------------
    local Paladin_Config = {
        key      = 'AUTHOR_ProtPaladinTBC',
        title    = 'Protection Paladin - TBC Classic',
        subtitle = '1.1',
        width    = 500,
        height   = 800,
        profiles = true,
        config   = {
            { type='header', text='Protection Paladin - TBC Classic', size=24, align='Center', color='ffffff' },

            { type='spacer' }, { type='ruler' }, { type='spacer' },

            { type='header', text='Seals & Judgement', color='ffffff' },
            { type='checkbox', text='Maintain Judgement of Wisdom on target (mana return)', key='autojudgewisdom', icon=S.SealOfWisdom:ID(), default=false },
            { type='checkbox', text='Use Seal of Righteousness (primary seal)', key='autosealrighteous', icon=S.SealOfRighteousness:ID(), default=true },
            {
                type          = 'checkspin',
                text          = 'Judge Seal of Righteousness above mana %',
                key           = 'judgement',
                min           = 1,
                max           = 100,
                icon          = S.Judgement:ID(),
                default_check = true,
                default_spin  = 40,
            },

            { type='spacer' }, { type='ruler' }, { type='spacer' },

            { type='header', text='Core Rotation', color='66ff66' },
            { type='header', text='Buffs & Auras', color='ffcc00', size=12 },
            { type='checkbox', text='Use Greater Blessings (requires reagents)', key='usegreater', icon=S.GreaterBlessingOfSanctuary:ID(), default=false },
            { type='header', text='Select ONE Blessing (priority order)', color='ffcc00', size=12 },
            { type='checkbox', text='Use Blessing of Sanctuary (tanking)', key='autosanctuary', icon=S.BlessingOfSanctuary:ID(), default=true },
            { type='checkbox', text='Use Blessing of Kings (stats)', key='autokings', icon=S.BlessingOfKings:ID(), default=false },
            { type='checkbox', text='Use Blessing of Wisdom (mana)', key='autowisdom', icon=S.BlessingOfWisdom:ID(), default=false },
            { type='checkbox', text='Auto Righteous Fury', key='autorighteous', icon=S.RighteousFury:ID(), default=true },
            { type='header', text='Select ONE Aura (priority order)', color='ffcc00', size=12 },
            { type='checkbox', text='Use Sanctity Aura (best DPS)', key='usesanctity', icon=S.SanctityAura:ID(), default=false },
            { type='checkbox', text='Use Retribution Aura (threat)', key='useretribution', icon=S.RetributionAura:ID(), default=false },
            { type='checkbox', text='Use Devotion Aura (default)', key='autodevotion', icon=S.DevotionAura:ID(), default=true },
            { type='checkbox', text='Use Concentration Aura (caster)', key='useconcentration', icon=S.ConcentrationAura:ID(), default=false },

            { type='spacer' }, { type='ruler' }, { type='spacer' },

            { type='header', text='Abilities & Cooldowns', color='ffffff' },
            { type='checkbox', text='Use Holy Shield', key='useholyshield', icon=S.HolyShield:ID(), default=true },
            { type='checkbox', text='Use Avenger\'s Shield', key='useavshield', icon=S.AvengersShield:ID(), default=true },
            { type='checkbox', text='Use Hammer of Wrath (<20% HP)', key='usehammer', icon=S.HammerOfWrath:ID(), default=true },
            { type='checkbox', text='Use Exorcism (Undead/Demon)', key='useexorcism', icon=S.Exorcism:ID(), default=true },

            { type='spacer' }, { type='ruler' }, { type='spacer' },

            { type='header', text='Consecration Settings', color='ffffff' },
            { type='checkbox', text='Use Consecration', key='useconsecration', icon=S.Consecration:ID(), default=true },
            {
                type          = 'checkspin',
                text          = 'Use Consecration above mana %',
                key           = 'consecration_mana',
                min           = 1,
                max           = 100,
                icon          = S.Consecration:ID(),
                default_check = false,
                default_spin  = 40,
            },
            {
                type          = 'checkspin',
                text          = 'Consecration min target count',
                key           = 'consecration_targets',
                min           = 1,
                max           = 10,
                icon          = S.Consecration:ID(),
                default_check = false,
                default_spin  = 2,
            },
        }
    }

    MainAddon.SetCustomConfig(Author, SpecID, Paladin_Config)

    ------------------------------------------------------------
    -- INIT
    ------------------------------------------------------------
    local function Init()
        MainAddon:Print('Protection Paladin - TBC Classic 1.1 loaded........')
    end

    ------------------------------------------------------------
    -- Avenger's Shield tracking
    ------------------------------------------------------------
    local AvengersShieldUsed = false

    ------------------------------------------------------------
    -- ENEMY ROTATION
    ------------------------------------------------------------
    local function EnemyRotation()
        if not MainAddon.TargetIsValid() then
            -- Reset Avenger's Shield tracking when no valid target
            AvengersShieldUsed = false
            return
        end

        -- Read config
        local autoJudgeWisdom       = MainAddon.Config.GetSetting('AUTHOR_ProtPaladinTBC', 'autojudgewisdom')
        local autoSealRighteous     = MainAddon.Config.GetSetting('AUTHOR_ProtPaladinTBC', 'autosealrighteous')
        local useHolyShield         = MainAddon.Config.GetSetting('AUTHOR_ProtPaladinTBC', 'useholyshield')
        local useConsecration       = MainAddon.Config.GetSetting('AUTHOR_ProtPaladinTBC', 'useconsecration')
        local useAvShield           = MainAddon.Config.GetSetting('AUTHOR_ProtPaladinTBC', 'useavshield')
        local useHammer             = MainAddon.Config.GetSetting('AUTHOR_ProtPaladinTBC', 'usehammer')
        local useExorcism           = MainAddon.Config.GetSetting('AUTHOR_ProtPaladinTBC', 'useexorcism')
        
        local judgementEnabled      = MainAddon.Config.GetSetting('AUTHOR_ProtPaladinTBC', 'judgement_check')
        local judgementThreshold    = MainAddon.Config.GetSetting('AUTHOR_ProtPaladinTBC', 'judgement_spin') or 40
        local consecrationEnabled   = MainAddon.Config.GetSetting('AUTHOR_ProtPaladinTBC', 'consecration_mana_check')
        local consecrationThreshold = MainAddon.Config.GetSetting('AUTHOR_ProtPaladinTBC', 'consecration_mana_spin') or 40
        local consecrationTargetsEnabled = MainAddon.Config.GetSetting('AUTHOR_ProtPaladinTBC', 'consecration_targets_check')
        local consecrationTargets   = MainAddon.Config.GetSetting('AUTHOR_ProtPaladinTBC', 'consecration_targets_spin') or 2

        local mana     = Player:ManaPercentage()
        local targetHP = Target:HealthPercentage()
        
        -- Range checks
        local inMelee = Target:IsInRange(5)
        local inAvengersRange = Target:IsInRange(30)

        --------------------------------------------------------
        -- OPENER: Avenger's Shield at range (30yd)
        --------------------------------------------------------
        -- Use Avenger's Shield as opener if:
        -- 1. Not yet used this combat
        -- 2. Target is NOT in melee range (>5 yards)
        -- 3. Target is within 30 yards
        if useAvShield and not AvengersShieldUsed and not inMelee and inAvengersRange then
            if S.AvengersShield:IsReady() then
                if Cast(S.AvengersShield) then
                    AvengersShieldUsed = true
                    return "Avenger's Shield (Opener)"
                end
            end
        end

        --------------------------------------------------------
        -- SEAL MANAGEMENT (Matches Ret Paladin pattern)
        -- Rotation:
        -- 1. If assigned to maintain Judgement of Wisdom debuff (autojudgewisdom=true):
        --    - Apply Seal of Wisdom and judge it once to apply the debuff
        --    - Switch to Seal of Righteousness
        --    - Auto-attacks will keep refreshing the Judgement of Wisdom debuff
        --    - Judge Seal of Righteousness on CD for threat (when mana allows)
        -- 2. If not assigned (autojudgewisdom=false):
        --    - Use Seal of Righteousness all the time
        --    - Judge on CD for threat (when mana allows)
        --------------------------------------------------------
        
        -- Step 1: Apply Judgement of Wisdom debuff if missing (and enabled)
        if autoJudgeWisdom and not TargetHasJudgementOfWisdom() then
            -- Put up Seal of Wisdom
            if not PlayerHasSeal(SEAL_OF_WISDOM_NAME) then
                if S.SealOfWisdom:IsReady(Player) then
                    if Cast(S.SealOfWisdom) then
                        return "Seal of Wisdom (apply for judge)"
                    end
                end
            end

            -- Judge Seal of Wisdom to apply debuff (ALWAYS judge, regardless of mana)
            if PlayerHasSeal(SEAL_OF_WISDOM_NAME) then
                if S.Judgement:IsReady() then
                    if Cast(S.Judgement) then
                        return "Judgement of Wisdom (apply debuff)"
                    end
                end
            end
        end

        -- Step 2: Maintain Seal of Righteousness (once Wisdom debuff is active or disabled)
        if autoSealRighteous then
            local hasWisdomDebuff = TargetHasJudgementOfWisdom()
            local canUsePrimarySeal = not autoJudgeWisdom or (autoJudgeWisdom and hasWisdomDebuff)
            
            if canUsePrimarySeal then
                -- Maintain Seal of Righteousness
                if not PlayerHasSeal(SEAL_OF_RIGHTEOUSNESS_NAME) then
                    if S.SealOfRighteousness:IsReady(Player) then
                        if Cast(S.SealOfRighteousness) then
                            return "Seal of Righteousness (maintain)"
                        end
                    end
                end

                -- Judge Seal of Righteousness for threat (when mana allows)
                if PlayerHasSeal(SEAL_OF_RIGHTEOUSNESS_NAME) and judgementEnabled and mana >= judgementThreshold then
                    if S.Judgement:IsReady() then
                        if Cast(S.Judgement) then
                            return "Judgement of Righteousness (threat)"
                        end
                    end
                end
            end
        end

        --------------------------------------------------------
        -- APL: actions+=/holy_shield (maintain)
        --------------------------------------------------------
        if useHolyShield and not PlayerHasHolyShield() and S.HolyShield:IsReady() then
            if Cast(S.HolyShield) then
                return "Holy Shield (maintain)"
            end
        end

        --------------------------------------------------------
        -- APL: actions+=/consecration (maintain, mana check)
        --------------------------------------------------------
        if useConsecration and S.Consecration:IsReady() and not Player:IsMoving() then
            local canUse = true
            
            -- Check mana threshold
            if consecrationEnabled and mana < consecrationThreshold then
                canUse = false
            end
            
            -- Check target count if multi-target option enabled
            if consecrationTargetsEnabled then
                local enemies = Player:GetEnemiesInMeleeRange(8)
                local enemyCount = #enemies
                if enemyCount < consecrationTargets then
                    canUse = false
                end
            end
            
            if canUse then
                if Cast(S.Consecration) then
                    return "Consecration (maintain)"
                end
            end
        end

        --------------------------------------------------------
        -- APL: actions+=/hammer_of_wrath,if=target.health.pct<20
        --------------------------------------------------------
        if useHammer and S.HammerOfWrath:IsReady() and targetHP <= 20 then
            if Cast(S.HammerOfWrath) then
                return "Hammer of Wrath (<20% HP)"
            end
        end

        --------------------------------------------------------
        -- APL: actions+=/exorcism,if=target.is_undead_or_demon
        --------------------------------------------------------
        if useExorcism and S.Exorcism:IsReady() and TargetIsUndeadOrDemon() then
            if Cast(S.Exorcism) then
                return "Exorcism (Undead/Demon)"
            end
        end

        -- Note: Avenger's Shield is now ONLY used as opener at range
        -- Once we're in melee, we don't cast it again to avoid damage

        return
    end

    ------------------------------------------------------------
    -- MAIN LOOP
    ------------------------------------------------------------
    local function MainRotation()
        local useGreater        = MainAddon.Config.GetSetting('AUTHOR_ProtPaladinTBC', 'usegreater')
        local autoSanctuary     = MainAddon.Config.GetSetting('AUTHOR_ProtPaladinTBC', 'autosanctuary')
        local autoKings         = MainAddon.Config.GetSetting('AUTHOR_ProtPaladinTBC', 'autokings')
        local autoWisdom        = MainAddon.Config.GetSetting('AUTHOR_ProtPaladinTBC', 'autowisdom')
        local autoRighteous     = MainAddon.Config.GetSetting('AUTHOR_ProtPaladinTBC', 'autorighteous')
        local useSanctity       = MainAddon.Config.GetSetting('AUTHOR_ProtPaladinTBC', 'usesanctity')
        local useRetribution    = MainAddon.Config.GetSetting('AUTHOR_ProtPaladinTBC', 'useretribution')
        local useDevotion       = MainAddon.Config.GetSetting('AUTHOR_ProtPaladinTBC', 'autodevotion')
        local useConcentration  = MainAddon.Config.GetSetting('AUTHOR_ProtPaladinTBC', 'useconcentration')

        --------------------------------------------------------
        -- Reset Avenger's Shield tracking out of combat
        --------------------------------------------------------
        if not Player:AffectingCombat() then
            AvengersShieldUsed = false
        end

        --------------------------------------------------------
        -- Always maintain buffs (in and out of combat)
        --------------------------------------------------------
        -- APL: actions+=/blessing_selection (out of combat, priority order)
        if not PlayerHasBlessing() then
            -- Priority 1: Blessing of Sanctuary (best for tanking)
            if autoSanctuary then
                if useGreater then
                    -- Use Greater Blessing of Sanctuary if enabled
                    if S.GreaterBlessingOfSanctuary:IsReady(Player) then
                        if Cast(S.GreaterBlessingOfSanctuary) then
                            return "Greater Blessing of Sanctuary"
                        end
                    end
                else
                    -- Use regular Blessing of Sanctuary
                    if S.BlessingOfSanctuary:IsReady(Player) then
                        if Cast(S.BlessingOfSanctuary) then
                            return "Blessing of Sanctuary"
                        end
                    end
                end
            end
            -- Priority 2: Blessing of Kings (stats boost)
            if autoKings then
                if useGreater then
                    -- Use Greater Blessing of Kings if enabled
                    if S.GreaterBlessingOfKings:IsReady(Player) then
                        if Cast(S.GreaterBlessingOfKings) then
                            return "Greater Blessing of Kings"
                        end
                    end
                else
                    -- Use regular Blessing of Kings
                    if S.BlessingOfKings:IsReady(Player) then
                        if Cast(S.BlessingOfKings) then
                            return "Blessing of Kings"
                        end
                    end
                end
            end
            -- Priority 3: Blessing of Wisdom (mana regen)
            if autoWisdom then
                if useGreater then
                    -- Use Greater Blessing of Wisdom if enabled
                    if S.GreaterBlessingOfWisdom:IsReady(Player) then
                        if Cast(S.GreaterBlessingOfWisdom) then
                            return "Greater Blessing of Wisdom"
                        end
                    end
                else
                    -- Use regular Blessing of Wisdom
                    if S.BlessingOfWisdom:IsReady(Player) then
                        if Cast(S.BlessingOfWisdom) then
                            return "Blessing of Wisdom"
                        end
                    end
                end
            end
        end

        -- APL: actions+=/righteous_fury (out of combat)
        if autoRighteous and not PlayerHasRighteousFury() then
            if S.RighteousFury:IsReady(Player) then
                if Cast(S.RighteousFury) then
                    return "Righteous Fury"
                end
            end
        end

        -- APL: actions+=/aura_selection (out of combat, priority order)
        if not PlayerHasAura() then
            -- Priority 1: Sanctity Aura (best DPS if talented)
            if useSanctity then
                if S.SanctityAura:IsReady(Player) then
                    if Cast(S.SanctityAura) then
                        return "Sanctity Aura"
                    end
                end
            end
            -- Priority 2: Retribution Aura (threat generation)
            if useRetribution then
                if S.RetributionAura:IsReady(Player) then
                    if Cast(S.RetributionAura) then
                        return "Retribution Aura"
                    end
                end
            end
            -- Priority 3: Devotion Aura (default tanking)
            if useDevotion then
                if S.DevotionAura:IsReady(Player) then
                    if Cast(S.DevotionAura) then
                        return "Devotion Aura"
                    end
                end
            end
            -- Priority 4: Concentration Aura (caster heavy groups)
            if useConcentration then
                if S.ConcentrationAura:IsReady(Player) then
                    if Cast(S.ConcentrationAura) then
                        return "Concentration Aura"
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