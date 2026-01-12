local function MyRoutine()
	local Author = 'Shaman - Enhancement (TBC) 1.9'
	local SpecID = 7 -- Shaman

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
	-- Local Spell Table (Dont use global HL.Spell.Shaman makes Rubim angry lol)
	------------------------------------------------------------
	local S = {
		-- Auto Attack
		Attack = Spell(6603),
		
		-- Weapon imbues
		RockbiterWeapon = MultiSpell(
			8017,	-- Rockbiter Weapon (Rank 1)
			8018,	-- Rockbiter Weapon (Rank 2)
			8019,	-- Rockbiter Weapon (Rank 3)
			10399,	-- Rockbiter Weapon (Rank 4)
			16314,	-- Rockbiter Weapon (Rank 5)
			16315,	-- Rockbiter Weapon (Rank 6)
			16316,	-- Rockbiter Weapon (Rank 7)
			25479	-- Rockbiter Weapon (Rank 8 - TBC)
		),
		
		WindfuryWeapon = MultiSpell(
			8232,	-- Windfury Weapon (Rank 1)
			8235,	-- Windfury Weapon (Rank 2)
			10486,	-- Windfury Weapon (Rank 3)
			16362,	-- Windfury Weapon (Rank 4)
			25505	-- Windfury Weapon (Rank 5 - TBC)
		),
		
		-- Shields
		WaterShield = MultiSpell(
			24398,	-- Water Shield (Rank 1)
			33736	-- Water Shield (Rank 2 - TBC)
		),
		
		LightningShield = MultiSpell(
			324,	-- Lightning Shield (Rank 1)
			325,	-- Lightning Shield (Rank 2)
			905,	-- Lightning Shield (Rank 3)
			945,	-- Lightning Shield (Rank 4)
			8134,	-- Lightning Shield (Rank 5)
			10431,	-- Lightning Shield (Rank 6)
			10432,	-- Lightning Shield (Rank 7)
			25469,	-- Lightning Shield (Rank 8 - TBC)
			25472	-- Lightning Shield (Rank 9 - TBC)
		),
		
		-- Pull spell
		LightningBolt = MultiSpell(
			403,	-- Lightning Bolt (Rank 1)
			529,	-- Lightning Bolt (Rank 2)
			548,	-- Lightning Bolt (Rank 3)
			915,	-- Lightning Bolt (Rank 4)
			943,	-- Lightning Bolt (Rank 5)
			6041,	-- Lightning Bolt (Rank 6)
			10391,	-- Lightning Bolt (Rank 7)
			10392,	-- Lightning Bolt (Rank 8)
			15207,	-- Lightning Bolt (Rank 9)
			15208,	-- Lightning Bolt (Rank 10)
			25448,	-- Lightning Bolt (Rank 11 - TBC)
			25449	-- Lightning Bolt (Rank 12 - TBC)
		),
		
		-- Shocks / Damage
		EarthShock = MultiSpell(
			8042,	-- Earth Shock (Rank 1)
			8044,	-- Earth Shock (Rank 2)
			8045,	-- Earth Shock (Rank 3)
			8046,	-- Earth Shock (Rank 4)
			10412,	-- Earth Shock (Rank 5)
			10413,	-- Earth Shock (Rank 6)
			10414,	-- Earth Shock (Rank 7)
			25454	-- Earth Shock (Rank 8 - TBC)
		),
		
		FlameShock = MultiSpell(
			8050,	-- Flame Shock (Rank 1)
			8052,	-- Flame Shock (Rank 2)
			8053,	-- Flame Shock (Rank 3)
			10447,	-- Flame Shock (Rank 4)
			10448,	-- Flame Shock (Rank 5)
			29228,	-- Flame Shock (Rank 6)
			25457	-- Flame Shock (Rank 7 - TBC)
		),
		
		Stormstrike = Spell(17364),        -- Stormstrike
		ShamanisticRage = Spell(30823),    -- Shamanistic Rage
		FireElementalTotem = Spell(2894),  -- Fire Elemental Totem
		
		-- Totems (Earth / Air / Water / Fire)
		-- Earth: Strength of Earth Totem
		StrengthOfEarthTotem = MultiSpell(
			8075,	-- Strength of Earth Totem (Rank 1)
			8160,	-- Strength of Earth Totem (Rank 2)
			8161,	-- Strength of Earth Totem (Rank 3)
			10442,	-- Strength of Earth Totem (Rank 4)
			25361	-- Strength of Earth Totem (Rank 5 - TBC)
		),
		
		-- Earth: Stoneclaw Totem (leveling defense)
		StoneclawTotem = MultiSpell(
			5730,	-- Stoneclaw Totem (Rank 1)
			6390,	-- Stoneclaw Totem (Rank 2)
			6391,	-- Stoneclaw Totem (Rank 3)
			10427,	-- Stoneclaw Totem (Rank 4)
			10428,	-- Stoneclaw Totem (Rank 5)
			25525	-- Stoneclaw Totem (Rank 6 - TBC)
		),
		
		-- Air: Grace of Air Totem
		GraceOfAirTotem = MultiSpell(
			8835,	-- Grace of Air Totem (Rank 1)
			10627,	-- Grace of Air Totem (Rank 2)
			25359	-- Grace of Air Totem (Rank 3 - TBC)
		),
		
		-- Air: Windfury Totem
		WindfuryTotem = MultiSpell(
			8512,	-- Windfury Totem (Rank 1)
			10613,	-- Windfury Totem (Rank 2)
			10614,	-- Windfury Totem (Rank 3)
			25585	-- Windfury Totem (Rank 4 - TBC)
		),
		
		-- Water: Mana Spring Totem
		ManaSpringTotem = MultiSpell(
			5675,	-- Mana Spring Totem (Rank 1)
			10495,	-- Mana Spring Totem (Rank 2)
			10496,	-- Mana Spring Totem (Rank 3)
			10497,	-- Mana Spring Totem (Rank 4)
			25570	-- Mana Spring Totem (Rank 5 - TBC)
		),
		
		-- Fire: Searing Totem
		SearingTotem = MultiSpell(
			3599,	-- Searing Totem (Rank 1)
			6363,	-- Searing Totem (Rank 2)
			6364,	-- Searing Totem (Rank 3)
			6365,	-- Searing Totem (Rank 4)
			10437,	-- Searing Totem (Rank 5)
			10438,	-- Searing Totem (Rank 6)
			25533	-- Searing Totem (Rank 7 - TBC)
		),
		
		-- Fire: Magma Totem
		MagmaTotem = MultiSpell(
			8190,	-- Magma Totem (Rank 1)
			10585,	-- Magma Totem (Rank 2)
			10586,	-- Magma Totem (Rank 3)
			10587,	-- Magma Totem (Rank 4)
			25552	-- Magma Totem (Rank 5 - TBC)
		),
		
		-- Fire: Fire Nova Totem
		FireNovaTotem = MultiSpell(
			1535,	-- Fire Nova Totem (Rank 1)
			8498,	-- Fire Nova Totem (Rank 2)
			8499,	-- Fire Nova Totem (Rank 3)
			11314,	-- Fire Nova Totem (Rank 4)
			11315,	-- Fire Nova Totem (Rank 5)
			25546	-- Fire Nova Totem (Rank 6 - TBC)
		)
	}

	------------------------------------------------------------
	-- Helper spell names for buff/debuff checks (legacy)
	------------------------------------------------------------
	local FLAME_SHOCK_NAME      = GetSpellInfo(8050)

	-- Shamanistic Focus proc detection (best-effort)
	local PROC_NAME_1 = "Clearcasting"
	local PROC_NAME_2 = "Shamanistic Focus"

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

	local function TargetHasFlameShock()
		return HasDebuffByName("target", FLAME_SHOCK_NAME)
	end

	local function HasProcForCheapShock()
		return HasBuffByName("player", PROC_NAME_1) or HasBuffByName("player", PROC_NAME_2)
	end

	------------------------------------------------------------
	-- Weapon enchant helper (fixes imbue spam)
	------------------------------------------------------------
	local function HasMainHandEnchant()
		local hasMain, _, _, _ = GetWeaponEnchantInfo()
		return hasMain == true
	end

	local function HasOffHandEnchant()
		local _, _, _, _, hasOffhand = GetWeaponEnchantInfo()
		return hasOffhand == true
	end

	------------------------------------------------------------
	-- Totem helpers
	------------------------------------------------------------
	local function HasTotem(slot)
		if not GetTotemInfo then
			return false
		end
		local haveTotem, totemName = GetTotemInfo(slot)
		return haveTotem and totemName and totemName ~= ""
	end

	local function EarthTotemIsStoneclaw()
		if not GetTotemInfo then return false end
		local haveTotem, totemName = GetTotemInfo(2) -- Earth slot
		if not haveTotem or not totemName or totemName == "" then
			return false
		end
		local stoneclawName = GetSpellInfo(5730) -- Stoneclaw Totem name (Rank 1)
		return stoneclawName and totemName == stoneclawName
	end

	------------------------------------------------------------
	-- Enemy count helper: Player:GetEnemiesInRange(range) then #table
	------------------------------------------------------------
	local function GetEnemiesCount(range)
		if Player and Player.GetEnemiesInRange then
			local enemies = Player:GetEnemiesInRange(range)
			if type(enemies) == "table" then
				return #enemies
			end
		end
		return 1
	end

	local function PlayerIsCasting()
		return UnitCastingInfo("player") ~= nil or UnitChannelInfo("player") ~= nil
	end

	------------------------------------------------------------
	-- Items table (kept for structure)
	------------------------------------------------------------
	Item.Shaman = Item.Shaman or {}
	local I = Item.Shaman

	------------------------------------------------------------
	-- Totem twisting state
	------------------------------------------------------------
	local TotemTwistTimer = 0
	local TotemTwistState = 0 -- 0 = idle, 1 = waiting to drop GoA after WF

	------------------------------------------------------------
	-- Config Menu
	------------------------------------------------------------
	local Shaman_Config = {
		key      = 'AUTHOR_ShamanEnhTBC',
		title    = 'Shaman - Enhancement (TBC)',
		subtitle = '1.9',
		width    = 450,
		height   = 800,
		profiles = true,
		config   = {
			{ type='header', text='Enhancement Shaman - TBC', size=24, align='Center', color='ffffff' },

			{ type='spacer' }, { type='ruler' }, { type='spacer' },

			{ type='header', text='LEVELING (1-40)', color='66ff66' },
			{
				type    = 'checkbox',
				text    = 'Enable Leveling Rotation (Level 1-40)',
				key     = 'useleveling',
				icon    = S.LightningBolt:ID(),
				default = true
			},
			{
				type    = 'checkbox',
				text    = 'Maintain Rockbiter Weapon (Leveling, before Windfury)',
				key     = 'lvl_rockbiter',
				icon    = S.RockbiterWeapon:ID(),
				default = true
			},
			{
				type    = 'checkbox',
				text    = 'Maintain Lightning Shield (Leveling)',
				key     = 'lvl_lshield',
				icon    = S.LightningShield:ID(),
				default = true
			},
			{
				type    = 'checkbox',
				text    = 'Use Lightning Bolt to pull (Leveling)',
				key     = 'lvl_pull_lb',
				icon    = S.LightningBolt:ID(),
				default = true
			},
			{
				type    = 'checkbox',
				text    = 'Earth Shock only with Shamanistic Focus proc (Leveling)',
				key     = 'lvl_shock_proc',
				icon    = S.EarthShock:ID(),
				default = true
			},
			{
				type    = 'checkbox',
				text    = 'Drop Stoneclaw Totem when enemy count threshold met (Leveling)',
				key     = 'lvl_stoneclaw',
				icon    = S.StoneclawTotem:ID(),
				default = true
			},
			{
				type    = 'spinner',
				text    = 'Stoneclaw - Enemy Count (Leveling)',
				key     = 'lvl_stoneclaw_count',
				min     = 2,
				max     = 8,
				default = 3,
				icon    = S.StoneclawTotem:ID()
			},

			{ type='spacer' }, { type='ruler' }, { type='spacer' },

			{ type='header', text='Buffs & Imbues', color='ffffff' },
			{
				type    = 'checkbox',
				text    = 'Maintain Windfury Weapon (APL 1)',
				key     = 'usewfweapon',
				icon    = S.WindfuryWeapon:ID(),
				default = true
			},
			{
				type    = 'checkbox',
				text    = 'Maintain Water Shield (APL 2)',
				key     = 'usewatershield',
				icon    = S.WaterShield:ID(),
				default = true
			},

			{ type='spacer' }, { type='ruler' }, { type='spacer' },

			{ type='header', text='Defensives / Mana (APL 5-6)', color='ffffff' },
			{
				type          = 'checkspin',
				text          = 'Use Shamanistic Rage below % mana (APL 6)',
				key           = 'srage',
				min           = 0,
				max           = 100,
				icon          = S.ShamanisticRage:ID(),
				default_check = true,
				default_spin  = 35,
			},
			{
				type    = 'checkbox',
				text    = 'Use Fire Elemental Totem on bosses (APL 5)',
				key     = 'usefireele',
				icon    = S.FireElementalTotem:ID(),
				default = true
			},

			{ type='spacer' }, { type='ruler' }, { type='spacer' },

			{ type='header', text='Core Rotation (APL 7-10)', color='ffffff' },
			{
				type    = 'checkbox',
				text    = 'Use Stormstrike on cooldown (APL 8)',
				key     = 'usestormstrike',
				icon    = S.Stormstrike:ID(),
				default = true
			},
			{
				type    = 'checkbox',
				text    = 'Use Earth Shock as filler shock (APL 10)',
				key     = 'useearthshock',
				icon    = S.EarthShock:ID(),
				default = true
			},
			{
				type    = 'checkbox',
				text    = 'Use Flame Shock DoT (APL 9)',
				key     = 'useflameshock',
				icon    = S.FlameShock:ID(),
				default = true
			},

			{ type='spacer' }, { type='ruler' }, { type='spacer' },

			{ type='header', text='Totems (APL 3-4, 11-12)', color='ffffff' },
			{
				type    = 'checkbox',
				text    = 'Keep Strength of Earth Totem active (Earth, APL 3)',
				key     = 'usesoe',
				icon    = S.StrengthOfEarthTotem:ID(),
				default = true
			},
			{
				type    = 'checkbox',
				text    = 'Keep Mana Spring Totem active (Water, APL 3)',
				key     = 'usemanaspring',
				icon    = S.ManaSpringTotem:ID(),
				default = true
			},
			{
				type    = 'checkbox',
				text    = 'Use Windfury Totem (Air, APL 4)',
				key     = 'usewftotem',
				icon    = S.WindfuryTotem:ID(),
				default = true
			},
			{
				type    = 'checkbox',
				text    = 'Use Grace of Air Totem instead of Windfury (Air, APL 4)',
				key     = 'usegoa',
				icon    = S.GraceOfAirTotem:ID(),
				default = false
			},
			{
				type    = 'checkbox',
				text    = 'Use Searing Totem (single target Fire, APL 12)',
				key     = 'usesearing',
				icon    = S.SearingTotem:ID(),
				default = true
			},
			{
				type    = 'checkbox',
				text    = 'Use Magma Totem (AoE Fire, APL 12)',
				key     = 'usemagma',
				icon    = S.MagmaTotem:ID(),
				default = false
			},
			{
				type    = 'checkbox',
				text    = 'Use Fire Nova Totem in AoE (APL 11)',
				key     = 'usefirenova',
				icon    = S.FireNovaTotem:ID(),
				default = false
			},

			{ type='spacer' }, { type='ruler' }, { type='spacer' },

			{ type='header', text='ADVANCED Logic', color='ff9900' },
			{
				type    = 'checkbox',
				text    = 'Totem Twisting: WF Totem + GoA every 9s in combat (APL 4, high prio)',
				key     = 'usetwist',
				icon    = S.WindfuryTotem:ID(),
				default = false
			},

			{ type='ruler' }, { type='spacer' },
		}
	}

	MainAddon.SetCustomConfig(Author, SpecID, Shaman_Config)

	------------------------------------------------------------
	-- INIT
	------------------------------------------------------------
	local function Init()
		TotemTwistTimer = 0
		TotemTwistState = 0
		MainAddon:Print('Shaman - Enhancement (TBC) 1.9 loading.......loaded')
	end

	------------------------------------------------------------
	-- LEVELING ROTATION (1–40)
	------------------------------------------------------------
	local function LevelingRotation()
		local useLS        = MainAddon.Config.GetSetting('AUTHOR_ShamanEnhTBC', 'lvl_lshield')
		local useRockbiter = MainAddon.Config.GetSetting('AUTHOR_ShamanEnhTBC', 'lvl_rockbiter')

		-- LVL: Rockbiter Weapon (pre-WF only) - self check uses IsReady(Player)
		if useRockbiter
			and not S.WindfuryWeapon:IsKnown()
			and S.RockbiterWeapon:IsReady(Player)
			and not HasMainHandEnchant()
		then
			if Cast(S.RockbiterWeapon) then -- LVL: Rockbiter Weapon (pre-WF)
				return "Rockbiter Weapon (Leveling)"
			end
		end

		-- LVL: Maintain Lightning Shield even with no target - self check uses IsReady(Player)
		if not MainAddon.TargetIsValid() then
			if useLS
				and S.LightningShield:IsReady(Player)
				and Player:BuffDown(S.LightningShield)
			then
				if Cast(S.LightningShield) then -- LVL: maintain Lightning Shield
					return "Lightning Shield (Leveling)"
				end
			end
			return
		end

		local inMelee  = Target:IsInRange(5)
		local enemies  = GetEnemiesCount(8)

		local usePullLB        = MainAddon.Config.GetSetting('AUTHOR_ShamanEnhTBC', 'lvl_pull_lb')
		local shockOnProc      = MainAddon.Config.GetSetting('AUTHOR_ShamanEnhTBC', 'lvl_shock_proc')
		local useStoneclaw     = MainAddon.Config.GetSetting('AUTHOR_ShamanEnhTBC', 'lvl_stoneclaw')
		local stoneclawCount   = MainAddon.Config.GetSetting('AUTHOR_ShamanEnhTBC', 'lvl_stoneclaw_count') or 3
		if stoneclawCount < 2 then stoneclawCount = 2 end
		if stoneclawCount > 8 then stoneclawCount = 8 end

		-- LVL: Maintain Lightning Shield - self check uses IsReady(Player)
		if useLS
			and S.LightningShield:IsReady(Player)
			and Player:BuffDown(S.LightningShield)
		then
			if Cast(S.LightningShield) then -- LVL: Lightning Shield maintain
				return "Lightning Shield (Leveling)"
			end
		end

		-- LVL: Multi-target melee safety: Stoneclaw replaces SoE if needed
		if useStoneclaw
			and inMelee
			and enemies >= stoneclawCount
			and S.StoneclawTotem:IsReady()
			and not EarthTotemIsStoneclaw()
		then
			if Cast(S.StoneclawTotem) then -- LVL: Stoneclaw for multi-target safety
				return "Stoneclaw Totem (Leveling)"
			end
		end

		-- LVL: Pull with Lightning Bolt if not in melee
		if usePullLB
			and not inMelee
			and S.LightningBolt:IsReady()
			and not PlayerIsCasting()
		then
			if Cast(S.LightningBolt) then -- LVL: Lightning Bolt pull
				return "Lightning Bolt (Leveling Pull)"
			end
		end

		-- LVL: Ensure auto attack once in melee
		if inMelee and S.Attack:IsReady() then
			if not IsCurrentSpell(6603) then
				if Cast(S.Attack) then -- LVL: Auto Attack on
					return "Auto Attack (Leveling)"
				end
			end
		end

		-- LVL: Earth Shock only with proc (or if proc restriction disabled)
		if inMelee
			and S.EarthShock:IsReady()
			and (not shockOnProc or HasProcForCheapShock())
		then
			if Cast(S.EarthShock) then -- LVL: Earth Shock w/ proc
				return "Earth Shock (Leveling Proc)"
			end
		end

		return
	end

	------------------------------------------------------------
	-- NORMAL / RAID ROTATION
	------------------------------------------------------------
	local function EnemyRotation()
		-- Leveling mode switch (1–40)
		local useLeveling = MainAddon.Config.GetSetting('AUTHOR_ShamanEnhTBC', 'useleveling')
		local playerLevel = UnitLevel("player") or 70

		if useLeveling and playerLevel <= 40 then
			local r = LevelingRotation()
			if r then return r end
		end

		if not MainAddon.TargetIsValid() then
			local useWFWeapon    = MainAddon.Config.GetSetting('AUTHOR_ShamanEnhTBC', 'usewfweapon')
			local useWaterShield = MainAddon.Config.GetSetting('AUTHOR_ShamanEnhTBC', 'usewatershield')

			-- APL 1: Windfury Weapon (Main Hand) - self check uses IsReady(Player)
			if useWFWeapon
				and S.WindfuryWeapon:IsReady(Player)
				and not HasMainHandEnchant()
			then
				if Cast(S.WindfuryWeapon) then -- APL 1
					return "Windfury Weapon Main Hand (APL 1, OOC)"
				end
			end

			-- APL 1b: Windfury Weapon (Off Hand) - for dual-wield
			if useWFWeapon
				and S.WindfuryWeapon:IsReady(Player)
				and HasMainHandEnchant()
				and not HasOffHandEnchant()
			then
				if Cast(S.WindfuryWeapon) then -- APL 1b
					return "Windfury Weapon Off Hand (APL 1b, OOC)"
				end
			end

			-- APL 2: Water Shield - checking buff ID with Player:BuffDown
			if useWaterShield
				and S.WaterShield:IsReady(Player)
				and Player:BuffDown(S.WaterShield)
			then
				if Cast(S.WaterShield) then -- APL 2
					return "Water Shield (APL 2, OOC)"
				end
			end

			return
		end

		local mana     = Player:ManaPercentage()
		local inMelee  = Target:IsInRange(5)
		local inCombat = UnitAffectingCombat("player") == true

		local useWFWeapon    = MainAddon.Config.GetSetting('AUTHOR_ShamanEnhTBC', 'usewfweapon')
		local useWaterShield = MainAddon.Config.GetSetting('AUTHOR_ShamanEnhTBC', 'usewatershield')

		local srageEnabled   = MainAddon.Config.GetSetting('AUTHOR_ShamanEnhTBC', 'srage_check')
		local srageThreshold = MainAddon.Config.GetSetting('AUTHOR_ShamanEnhTBC', 'srage_spin') or 35

		local useFireEle     = MainAddon.Config.GetSetting('AUTHOR_ShamanEnhTBC', 'usefireele')

		local useStormstrike = MainAddon.Config.GetSetting('AUTHOR_ShamanEnhTBC', 'usestormstrike')
		local useEarthShock  = MainAddon.Config.GetSetting('AUTHOR_ShamanEnhTBC', 'useearthshock')
		local useFlameShock  = MainAddon.Config.GetSetting('AUTHOR_ShamanEnhTBC', 'useflameshock')

		local useSoE         = MainAddon.Config.GetSetting('AUTHOR_ShamanEnhTBC', 'usesoe')
		local useManaSpring  = MainAddon.Config.GetSetting('AUTHOR_ShamanEnhTBC', 'usemanaspring')
		local useWFTotem     = MainAddon.Config.GetSetting('AUTHOR_ShamanEnhTBC', 'usewftotem')
		local useGoA         = MainAddon.Config.GetSetting('AUTHOR_ShamanEnhTBC', 'usegoa')
		local useSearing     = MainAddon.Config.GetSetting('AUTHOR_ShamanEnhTBC', 'usesearing')
		local useMagma       = MainAddon.Config.GetSetting('AUTHOR_ShamanEnhTBC', 'usemagma')
		local useFireNova    = MainAddon.Config.GetSetting('AUTHOR_ShamanEnhTBC', 'usefirenova')
		local useTwist       = MainAddon.Config.GetSetting('AUTHOR_ShamanEnhTBC', 'usetwist')

		-- APL 1: Windfury Weapon (Main Hand) - self check uses IsReady(Player)
		if useWFWeapon
			and S.WindfuryWeapon:IsReady(Player)
			and not HasMainHandEnchant()
		then
			if Cast(S.WindfuryWeapon) then -- APL 1
				return "Windfury Weapon Main Hand (APL 1)"
			end
		end

		-- APL 1b: Windfury Weapon (Off Hand) - for dual-wield
		if useWFWeapon
			and S.WindfuryWeapon:IsReady(Player)
			and HasMainHandEnchant()
			and not HasOffHandEnchant()
		then
			if Cast(S.WindfuryWeapon) then -- APL 1b
				return "Windfury Weapon Off Hand (APL 1b)"
			end
		end

		-- APL 2: Water Shield - checking buff ID with Player:BuffDown
		if useWaterShield
			and S.WaterShield:IsReady(Player)
			and Player:BuffDown(S.WaterShield)
		then
			if Cast(S.WaterShield) then -- APL 2
				return "Water Shield (APL 2)"
			end
		end

		-- APL 4 (high prio): Totem twisting
		if useTwist
			and inCombat
			and inMelee
		then
			local now = GetTime and GetTime() or 0

			if TotemTwistState == 0
				and ((TotemTwistTimer == 0) or (now - TotemTwistTimer) >= 9)
				and S.WindfuryTotem:IsReady()
			then
				if Cast(S.WindfuryTotem) then -- APL 4 (twist WF)
					TotemTwistTimer = now
					TotemTwistState = 1
					return "Windfury Totem (Totem Twist - APL 4)"
				end
			end

			if TotemTwistState == 1
				and S.GraceOfAirTotem:IsReady()
			then
				if Cast(S.GraceOfAirTotem) then -- APL 4 (twist GoA)
					TotemTwistState = 0
					return "Grace of Air Totem (Totem Twist - APL 4)"
				end
			end
		end

		-- APL 3: SoE + Mana Spring
		if inMelee and useSoE
			and S.StrengthOfEarthTotem:IsReady()
			and not HasTotem(2)
		then
			if Cast(S.StrengthOfEarthTotem) then -- APL 3
				return "Strength of Earth Totem (APL 3)"
			end
		end

		if inMelee and useManaSpring
			and S.ManaSpringTotem:IsReady()
			and not HasTotem(3)
		then
			if Cast(S.ManaSpringTotem) then -- APL 3
				return "Mana Spring Totem (APL 3)"
			end
		end

		-- APL 4: Air totem when not twisting
		if not useTwist then
			if inMelee and useGoA
				and S.GraceOfAirTotem:IsReady()
				and not HasTotem(4)
			then
				if Cast(S.GraceOfAirTotem) then -- APL 4
					return "Grace of Air Totem (APL 4)"
				end
			elseif inMelee and useWFTotem
				and S.WindfuryTotem:IsReady()
				and not HasTotem(4)
			then
				if Cast(S.WindfuryTotem) then -- APL 4
					return "Windfury Totem (APL 4)"
				end
			end
		end

		-- APL 5: Fire Elemental
		if useFireEle
			and inMelee
			and S.FireElementalTotem:IsReady()
		then
			if Cast(S.FireElementalTotem) then -- APL 5
				return "Fire Elemental Totem (APL 5)"
			end
		end

		-- APL 6: Shamanistic Rage - self check uses IsReady(Player)
		if srageEnabled
			and S.ShamanisticRage:IsReady(Player)
			and mana <= srageThreshold
		then
			if Cast(S.ShamanisticRage) then -- APL 6
				return "Shamanistic Rage (APL 6)"
			end
		end

		-- APL 8: Stormstrike
		if useStormstrike
			and inMelee
			and S.Stormstrike:IsReady()
		then
			if Cast(S.Stormstrike) then -- APL 8
				return "Stormstrike (APL 8)"
			end
		end

		-- APL 9: Flame Shock
		if useFlameShock
			and inMelee
			and S.FlameShock:IsReady()
			and not TargetHasFlameShock()
		then
			if Cast(S.FlameShock) then -- APL 9
				return "Flame Shock (APL 9)"
			end
		end

		-- APL 10: Earth Shock
		if useEarthShock
			and inMelee
			and S.EarthShock:IsReady()
		then
			if Cast(S.EarthShock) then -- APL 10
				return "Earth Shock (APL 10)"
			end
		end

		-- APL 11: Fire Nova
		if useFireNova
			and inMelee
			and S.FireNovaTotem:IsReady()
		then
			if Cast(S.FireNovaTotem) then -- APL 11
				return "Fire Nova Totem (APL 11)"
			end
		end

		-- APL 12: Fire Totem (Searing/Magma)
		if inMelee and useMagma
			and S.MagmaTotem:IsReady()
			and not HasTotem(1)
		then
			if Cast(S.MagmaTotem) then -- APL 12
				return "Magma Totem (APL 12)"
			end
		elseif inMelee and useSearing
			and S.SearingTotem:IsReady()
			and not HasTotem(1)
		then
			if Cast(S.SearingTotem) then -- APL 12
				return "Searing Totem (APL 12)"
			end
		end

		return
	end

	------------------------------------------------------------
	-- MAIN ROTATION WRAPPER
	------------------------------------------------------------
	local function MainRotation()
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