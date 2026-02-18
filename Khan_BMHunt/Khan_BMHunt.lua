local function MyRoutine()
    local Author = 'Hunter - BM (TBC) 3.2'
    local SpecID = 3 -- Hunter

--[[

                                                         .....'''..'''''''''''''''..........................                                                   
                                                   ..'',;;;::;;,,,,,,,,,,,,,,,,,,,,,,,,,'''''''''''''................                                           
                                               .';ccccc::;;;;;;;;::::::::::ccccc::;;;,,,,''''.................... ..........                                    
                                          ..,:odxdocc::::::::::::ccccccccllcc:;;;;,''.......                          ..........                                
                                       .,:odxxxxdolccccloolcccccccclllollc:;,'......        .........................................                           
                                    .;oxOOkkkxxxxdollodxdlllllooddxddoc:,'...          .................................................                        
                                 .;ok000000OOOkkkxxxxxxdddxxkkOOkxdc;'...         ..............                ..........................                      
                              .:dOKK0000000000OOOkkkkxkkOO00Okxoc,...       ............                           ........................                     
                            'lk0K0K000000000000OOOOOOO0000Okoc,...     ...........                                  .........................                   
                          ,oO000000O000000000000OOO0000Okdl;..     ..........                                        ........    ..............                 
                        .lO00000OkkkOO000000000OOOO00Oxo:'. .............                                              ......    ................               
                      .ck0OOOOkkxxxxkkOOOOOOOOOOOOOOko;.     .......                                                     ......  .................              
                     'dOOOOOkxddddxxxkkOOOOOOOOOOOkdc'.    .......                                                        ..........................            
                    ,xOOOOkxdoodddxxxxkkOOOOOOOOOkd:.  ........                                                            ..........................           
                   ,xOOOkxocccodddxxxxxkkkOOOOOOkd:.   ......                                                               ...........................         
                  ,xOOOkdollc:::lddxxxxxkkOOO0Oxo;.........                                                                  ........................... .'..   
                 ,kOOOkoloooll:;,;coddxxkkOOOkxo;. ......                                                                    ..''''................. ...'';c;'..
                'xOkxdolcllllolc;,';ldxkOOOOkdo;.   ....                                                                      .;;;,'................    ..',,...
               .o0kxxolc::codxxdl;'';okkOOOOxd:.  .....                                                                        ':::;'...............       .....
               :Okxxxolc:::clllc:,'';okkOOOxdl'.  ....                                                                         .;c:;'''''''''........        .  
              .dkdxxdlc::::;,,'',,:codxkOOkdo,.  ...                                                                            .:::,''''''''''......           
              ;xddddlc::::::;;;cloddddxkkkxd:. ....                                                                              ,::,''..'''''''.....           
             .cxooool:::;;;:::clooooddxkkxdl'......                                                                               ';'.......'''''...            
             .ldoloolc;,',,,,,;:ccclodxxxdd:.......                                                                                ............'''.....         
             .odollol:',:lol;..,:ccldxxxddl'.......                                                                                    ..........''.....        
             'odolll:,;lddddc...;ccodxxxdd:.......                                                                                   .',:llc,......''....       
             ;ddolc:;:oddddd:..';ccoxxxddl,.......                                                                                   ';;;codo,.............     
            .cdool::lolloddo,...;cclxxdddc........                                                                               .';::;,'',;;'..............    
            .cdooc:lolc:lodl'...':cldxddo,........                                                                              .coodddl:'....''........        
            .cdooc:ll::;:lol'....,:lddddl.........                                                                           .'',:cloooloc.....';,''......      
            .cdolc;::::::col;....':lddddc. .......                                                                         .ckOOOxl:,,,,:;'.    .',,,'........  
             ;olcc;;;,,,;:c:;'...';lodddc. .......                                                                         .okOO0K0d:'..'..        ......       
             ,olc::;,'...',,''...':lodddc.  ......                                                                      .';ldxdocllc:'...                       
             'ol:::::;;,''......';ccodooc'. .......                                                                    ,k0K0Okxdl,......                        
             'll:::::::;;;,,,,;;::::llloc'.........                                                                    'k0000Okddc'....                         
             .ll::::;,,,,,;;::::;;;:clllc,.........                                                                    'lxxxxdoll:.                             
             .cl:::,'',,,'',;:;;;;;:clllc,..  .....                                                                   ;oddl;,,,,'.                              
             .:l::;,',col;'',;::;;;:clllc;..   .....                                                                .o0Oko,.....                                
              ;o:;;''cdddl,'',::;;;:ccclc;'.   .....                                                               ;kK0Ol.                                      
              ,oc:;',ldoll:,'';c:;;;:ccc:;'.   .....                                                             'd0K0d'                                        
              'ol:,''cdlccc;..,:c:;,,:ccc;'..   ....                                                            :OK0x;                                          
              'ol:,''cdlccc,..':c:;,,,;cc;,..    ....                                                         .lO0Oc.                                           
              .lo:,'':olccc,...;:::,,,;cc:,'.    ....                                                        .oOOx,                                             
              .cl:,'.;olccc,...':::;,,;:c:,'.    ....                                                       ,dkkl.                                              
              .:c;,..;lcclc,....,:::;,,:c:,,.     ...                                                     .:dxo,                                                
              .,;,'..;ccllc;.....,;:;,,:c:,,'.    .. .                                                   .cdd:.                                                 
              .......;ccllc;,.....,;;,,:c:,,'.       .                                                  'ldo,                                                   
              ......'ccclc;,'.....',,,;:c:;,'.       ..                                                ,odc.                                                    
              .... .;c:cc:;''......',,;:::;,'.       ..                                              .:dd;.                                                     
             .... .,::cc:;;;,'......',;:::;,,.       ...                                            .cxl'                                                       
            ....  ':::::;,;;;,'.....'';:;:;,,..      ...                                           'oxc.                                                        
            .... .;:::;,,,,,;,'......',;;;;,,..      ...                                          ;xx:.                                                         
      ..    .    .,::;,'''',,,'.......,;;;;,'..     ....                                        .ckx,                                                           
     ,kOo;..     ..';;.....'','.......',,;;,,..    .....                                       'oko.                                                            
    .dNWWKko;.    .....................'',,,,.     .....                                     .:dxc.                                                             
    ,oOKNWNXKko:'........................',''.     .....                                   .,oxo,                                                               
  .,:lldk0XNNNXKOxl,.....................',''.     .....                                  'lddc.                                                                
 .;coddodxO0KNNNXXX0xl,...................'''.     .....                                .cxxd;                                                                  
.,ldkOOOkkk00KXNWWWNNX0xl;................'''.     .....                               ,okkd'                                                                   
  .:dOO00KKXXKKXXNNWWWNNX0xl,..... ......''''.     ....                              .cxkxl.                                                                    
    .;dO0KNWWNXKKKKKKKXNNNX0ko;...........''.    ....'.                             ,dkkx:.                                                                     
l:.   .,oOKXNWWNXK0OOkkO00OOkkko:........''.     ...'.                            .cxxko'                                                                       
kkxl'    'lkKXNWNX0kxdxxxddddooddoc;'.......    ...''.                          .,dkkxc.                                                                        
dkkOko,. ..'cd0KXNX0xxkkkkxoccllllcllc;'...    ...,;'                         .lxkkko'                                                                          
:dkOOOOxc,.. .;oOKXNX0OkOkkdolccc:;;;:lc:'..  ...,:;.                       .:xkkkx:.                                                                           
,;okOOOOOko:.  .'lkKNNNKOkxdollc:;;;;;;;:::,....,::.                       .okkkxl.                                                                             
,,:okOO00OOOxl,.  .:xKNWNKkollc::;;;;;;;;;;::,,,;:'                       'dkkx;.                                                                               
,,:oxOOOO000OOkd:.  .;xKXNX0xoc::;;;;;;;;;;;;:c:;'                       ;dxxo'                                                                                 
,,:oxkOOOOOOOOkkko,.  .,oOKK0kdlc;,,,,,,,,,,;;cc:.                     .cdddl.                                                                                  
llldkkOOOOkkkxxkkkxl,.   .:oxkkdoc;,''''',,,,;:c;.                   .;oood:.                                                                                   
.cdkkOOOOkkxxxxxxxdddl;.   .';lodlcc;,,,;;;;;;,..                   'coool,                                                                                     
  .:dOOOOkkkxdollllllol,..    ..''';:c:::::::,.                   .;lollc.                                                                                      
'.  .:dOOOOkxoccccccc:,......      .,ccccll:'                    .coolc,.                                                                                       
,,,....:dkOOkxolccc:,'..............,cclll;.                   .;odoc;.                                                                                         
'',,,''..;okOkxxdlc,'..............';:clc'                    'colc:'.                                                                                          
..',,;,,'..;ldkkxdoc;'.............';::;.                   .,:cc:,.                                                                                            
  ...',;;,'...;codxoc;'............,;:,.                   .;;;;,'.                                                                                             
      .',,;'...  .,::;............';:'                   .,;;,'..                                                                                               
        ..'...       .............;:.                   ...'....                                                                                                
..       .....              .....,c'                    .......                                                                                                 


]]


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

    -- Auto Shot state tracking
    local AutoShot_ACTIVE = false
    local LastTarget_GUID = nil

    ------------------------------------------------------------
    -- Ranged Swing Timer Tracking (for Steady Shot timing)
    ------------------------------------------------------------
    local lastAutoShotTime = 0
    
    -- Create frame to track Auto Shot from combat log
    local SwingTimerFrame = CreateFrame("Frame")
    SwingTimerFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    SwingTimerFrame:SetScript("OnEvent", function()
        local _, subEvent, _, sourceGUID, _, _, _, _, _, _, _, spellID =
            CombatLogGetCurrentEventInfo()
        -- Track when Auto Shot (spell ID 75) FIRES (not when it hits)
        if subEvent == "SPELL_CAST_SUCCESS"
            and sourceGUID == UnitGUID("player")
            and spellID == 75 then
            lastAutoShotTime = GetTime()
        end
    end)
    
    -- Calculate time remaining until next Auto Shot
    local function GetRangedSwingRemaining()
        if lastAutoShotTime == 0 then
            return 0  -- Haven't fired an auto shot yet
        end
        local speed = select(1, UnitRangedDamage("player")) or 0
        if speed == 0 then
            return 0  -- No ranged weapon equipped
        end
        local remaining = (lastAutoShotTime + speed) - GetTime()
        return math.max(0, remaining)  -- Never return negative
    end

    ------------------------------------------------------------
    -- Time Gate Tracking (prevent ability spam)
    ------------------------------------------------------------
    local lastRaptorStrikeTime = 0
    local lastDisengageTime = 0
    local MIN_RECAST_DELAY = 1.5  -- Minimum 1.5s between casts

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
    S.Disengage      = MultiSpell(
        781,    -- R1
        14272,  -- R2
        14273   -- R3
    )

    -- Pet Management
    S.MendPet = MultiSpell(
        136,    -- R1
        3111,   -- R2
        3661,   -- R3
        3662,   -- R4
        13542,  -- R5
        13543,  -- R6
        13544,  -- R7
        27046   -- R8 (TBC)
    )

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
    local RAPID_FIRE_NAME     = GetSpellInfo(3045)   -- Rapid Fire buff
    local QUICK_SHOTS_NAME    = GetSpellInfo(6150)   -- Quick Shots proc (15% haste)
    local HASTE_POTION_NAME   = GetSpellInfo(28507)  -- Haste Potion buff (30% haste)
    local ABACUS_NAME         = GetSpellInfo(45040)  -- Abacus of Violent Odds (260 haste rating = ~16.5% haste)
    local MEND_PET_NAME       = GetSpellInfo(136)    -- Mend Pet buff

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

    local function HasRapidFire()
        return HasBuffByName("player", RAPID_FIRE_NAME)
    end

    local function HasQuickShots()
        return HasBuffByName("player", QUICK_SHOTS_NAME)
    end

    local function HasHastePotion()
        return HasBuffByName("player", HASTE_POTION_NAME)
    end

    local function HasAbacus()
        return HasBuffByName("player", ABACUS_NAME)
    end

    -- Calculate Steady Shot cast time based on active haste buffs
    -- All haste effects are multiplicative with each other
    local function GetSteadyShotCastTime(hasSerpentsSwiftness)
        local baseCastTime = 1.5
        local hasteMultiplier = 1.0
        
        -- Serpent's Swiftness (BM talent): 20% haste (passive)
        if hasSerpentsSwiftness then
            hasteMultiplier = hasteMultiplier * 1.20
        end
        
        -- Quick Shots (talent proc): 15% haste
        if HasQuickShots() then
            hasteMultiplier = hasteMultiplier * 1.15
        end
        
        -- Abacus of Violent Odds (trinket): ~16.5% haste (260 haste rating)
        if HasAbacus() then
            hasteMultiplier = hasteMultiplier * 1.165
        end
        
        -- Rapid Fire: 40% haste
        if HasRapidFire() then
            hasteMultiplier = hasteMultiplier * 1.40
        end
        
        -- Haste Potion: 30% haste (400 haste rating)
        if HasHastePotion() then
            hasteMultiplier = hasteMultiplier * 1.30
        end
        
        -- Bloodlust/Heroism: 30% haste
        if HasBloodlust() then
            hasteMultiplier = hasteMultiplier * 1.30
        end
        
        -- Formula: new_cast_time = base_cast_time / haste_multiplier
        return baseCastTime / hasteMultiplier
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
        subtitle = '3.2',
        width    = 450,
        height   = 600,
        profiles = true,
        config   = {
            { type='header', text='BM Hunter (TBC)', size=24, align='Center', color='ffffff' },

            { type='spacer' }, { type='ruler' }, { type='spacer' },

            { type='header', text='Melee Abilities', color='ffffff' },
            {
                type    = 'checkbox',
                text    = 'Use Melee Spells (Raptor/Mongoose/Wing Clip)',
                key     = 'usemelee',
                default = false,
            },

            { type='spacer' }, { type='ruler' }, { type='spacer' },

            { type='header', text='Talents', color='ffffff' },
            {
                type    = 'checkbox',
                text    = "Serpent's Swiftness (20% passive haste)",
                key     = 'serpentswiftness',
                default = true,
            },

            { type='spacer' }, { type='ruler' }, { type='spacer' },

            { type='header', text='Pet Management', color='ffffff' },
            {
                type          = 'checkspin',
                text          = 'Mend Pet when below health %',
                key           = 'mendpet',
                min           = 1,
                max           = 100,
                icon          = S.MendPet:ID(),
                default_check = true,
                default_spin  = 75,
            },

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
            { type='checkbox', text='Use Disengage if target is in melee and on me', key='usedisengage', icon=S.Disengage:ID(), default=true },

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
        MainAddon:Print('Hunter - BM (TBC) 3.2 loaded....')
    end

    ------------------------------------------------------------
    -- ENEMY ROTATION
    ------------------------------------------------------------
    local function EnemyRotation()
        if not MainAddon.TargetIsValid() then
            AutoShot_ACTIVE = false
            LastTarget_GUID = nil
            return
        end

        local mana    = Player:ManaPercentage()
        -- Dead zone: melee range is < 5 yards, ranged is 5+ yards
        local inMelee = Target:IsInRange(5)

        -- Config settings
        local useHM         = MainAddon.Config.GetSetting('AUTHOR_HunterTBC', 'usehm')
        local useKC         = MainAddon.Config.GetSetting('AUTHOR_HunterTBC', 'usekc')
        local useMS         = MainAddon.Config.GetSetting('AUTHOR_HunterTBC', 'usems')
        local useSteady     = MainAddon.Config.GetSetting('AUTHOR_HunterTBC', 'usessteady')
        local useArc        = MainAddon.Config.GetSetting('AUTHOR_HunterTBC', 'usearc')
        local useConcussive = MainAddon.Config.GetSetting('AUTHOR_HunterTBC', 'useconcussive')
        local useDisengage  = MainAddon.Config.GetSetting('AUTHOR_HunterTBC', 'usedisengage')

        -- Talent settings
        local hasSerpentsSwiftness = MainAddon.Config.GetSetting('AUTHOR_HunterTBC', 'serpentswiftness')

        local explosiveEnabled = MainAddon.Config.GetSetting('AUTHOR_HunterTBC', 'explosivetrap_check')
        local explosiveTargets = MainAddon.Config.GetSetting('AUTHOR_HunterTBC', 'explosivetrap_spin') or 7

        -- Cooldown settings
        local useRapidFire  = MainAddon.Config.GetSetting('AUTHOR_HunterTBC', 'userapidfire')
        local useBW         = MainAddon.Config.GetSetting('AUTHOR_HunterTBC', 'usebw')
        local useRacial     = MainAddon.Config.GetSetting('AUTHOR_HunterTBC', 'useracial')
        local useTrinkets   = MainAddon.Config.GetSetting('AUTHOR_HunterTBC', 'usetrinkets')

        -- Melee settings
        local useMelee      = MainAddon.Config.GetSetting('AUTHOR_HunterTBC', 'usemelee')

        --------------------------------------------------------
        -- Auto Shot toggle (ranged only)
        --------------------------------------------------------
        if inMelee then
            AutoShot_ACTIVE = false
        else
            -- Check if target changed - reset Auto Shot if new target
            local currentTargetGUID = UnitGUID("target")
            if currentTargetGUID ~= LastTarget_GUID then
                AutoShot_ACTIVE = false
                LastTarget_GUID = currentTargetGUID
            end

            if S.AutoShot:IsReady() and not AutoShot_ACTIVE then
                if Cast(S.AutoShot) then
                    AutoShot_ACTIVE = true
                    return "Auto Shot (ON)"
                end
            end
        end

        --------------------------------------------------------
        -- Disengage (escape from melee when being targeted)
        -- Time gate prevents spam
        --------------------------------------------------------
        if useDisengage
            and S.Disengage:IsReady()
            and inMelee
            and TargetIsTargetingPlayer()
        then
            local currentTime = GetTime()
            local timeSinceLastDisengage = currentTime - lastDisengageTime
            
            if timeSinceLastDisengage > MIN_RECAST_DELAY then
                if Cast(S.Disengage) then
                    lastDisengageTime = currentTime
                    return "Disengage"
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
            if useRapidFire and S.RapidFire:IsReady() then
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
                if S.BloodFury and S.BloodFury:IsReady() then
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
            -- Cast time varies with haste buffs (Rapid Fire 40%, Bloodlust 30%)
            --------------------------------------------------------
            if useSteady
                and S.SteadyShot:IsReady()
            then
                local nextShot = GetRangedSwingRemaining()
                local steadyCastTime = GetSteadyShotCastTime(hasSerpentsSwiftness)
                local safetyBuffer = 0.2  -- 200ms buffer for latency
                
                -- Cast if we have enough time to finish before next auto
                if nextShot > (steadyCastTime + safetyBuffer) or nextShot == 0 then
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
        -- Raptor Strike is "next melee swing" (needs queue timing)
        -- Mongoose/Wing Clip are instant (use on cooldown)
        --------------------------------------------------------
        if inMelee then
            -- Mongoose Bite (instant ability - use on cooldown)
            if useMelee and S.MongooseBite:IsReady() then
                if Cast(S.MongooseBite) then
                    return "Mongoose Bite"
                end
            end

            -- Raptor Strike (next melee swing - only queue near swing)
            -- Time gate prevents spam even on edge cases
            local nextSwing = Player:NextSwing()
            if useMelee and S.RaptorStrike:IsReady() and nextSwing <= 0.2 then
                local currentTime = GetTime()
                local timeSinceLastRaptor = currentTime - lastRaptorStrikeTime
                
                if timeSinceLastRaptor > MIN_RECAST_DELAY then
                    if Cast(S.RaptorStrike) then
                        lastRaptorStrikeTime = currentTime
                        return "Raptor Strike"
                    end
                end
            end

            -- Wing Clip (instant ability - use on cooldown for kiting)
            if useMelee and S.WingClip:IsReady() and not TargetHasWingClip() then
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

        local mendPetEnabled   = MainAddon.Config.GetSetting('AUTHOR_HunterTBC', 'mendpet_check')
        local mendPetThreshold = MainAddon.Config.GetSetting('AUTHOR_HunterTBC', 'mendpet_spin') or 75

        local mana = Player:ManaPercentage()

        --------------------------------------------------------
        -- Pet Management (ALWAYS - in and out of combat)
        --------------------------------------------------------
        if mendPetEnabled and UnitExists("pet") and not UnitIsDead("pet") then
            local petHealth = (UnitHealth("pet") / UnitHealthMax("pet")) * 100
            if petHealth < mendPetThreshold and S.MendPet:IsReady() and not HasBuffByName("pet", MEND_PET_NAME) then
                if Cast(S.MendPet) then
                    return "Mend Pet"
                end
            end
        end

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