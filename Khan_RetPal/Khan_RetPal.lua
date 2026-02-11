local function MyRoutine()
    local Author = 'Retribution Paladin - TBC Classic 2.0'
    local SpecID = 2 -- Paladin

    --[[
    
                             .......  ...................,;:;;,,;;;;;:clokOOKKKKKKKKKXXNNNNKkxdddddoooooooooodddxxxkkkkdlclllooooddddxxkk0XXK0kdoc;''
                             ......  ........'........'':lc:,,,;;;;:::lxO0XXXKkoc;;;:codkO0KOdddooooooloollllcclooooooooc;:ccccccccc::;;,,:xKXKK0kdc,'
                             ..............,'.......',codoc:;;;;;;;:cox0XNNXXd'  .lk0KXXXNNX0KXNWWWWWWWWWWWNWWNWWWWWWWNNK0XXXXXXXXXXXKKOxl;:kXXKK0xc;'
                             .... .......',''......':oxxdlc:;;;;;::ldkKNWWWW0,   ,ONMMMMMMMNXNWWWWWWWNNWWWWNNNWWWMMMMMWWWNNNNNNNNWWWWWWWW0l:o0XXK0xc,'
                            ..   .......,,'... ..',lxkxdolc::;;::clx0XNWWW0d,    .l0WWWWWWWWWWMMNXXKKKKKKXNNK00XWWNXXXXKXNXK0000XNWMMMMMMNxccxKXXOo:,'
                                ......',''... ..':xO0Oxollcc::cccokKNWWWNk;.......:OWMMWWWNNXXNWNXKKKKKKKKXX000KXKKKK000000OO000KXNWMMMMMMKo:o0XKkc,,.
                               ......','.... ..,l0KK0kdlllllllccoOXNWWWXd'..','...;0MMMMWWNK0O0XXKKKKKKKKXXXXXXKKKKKKK00K0OkxO0KKKXNWMMMMMNx:lOXOo;'''
                              ... ..''....  ..,dKXKOdoollllllclx0XNWWWKl.',;,,,'..'xWMMMWWX0kkxkkOOOOOO00KKKKKKKKKKKKKKK00OkddxOXXXNWWWWMMWOcoO0d:''''
                             ..  ..''....  ..:kXXKkollllllllcokKXNWWW0c.'cc::;:,...cXMMMWX0Okkkkkxxxddddddddk00KKXXXKK000OOOxdolxOO0KXWWMMW0ooxdl;''''
                            ..  ..'...   ..'cOXXKOxllllloooox0XNWWWWO:'',coooll;...;kNWWN0OkkO0000000OOOkxxdxkOKXXK0OOOO00OOkdddxkO0KKXNNNNXkdddoc;,''
                           ..  ......   ..,lOK00kxolllllodk0XNWWWWNk;;:;;;:cccc:,..,xNNNNKOkkOO0XXXXXXKKKK0OkxxO00OO000000OkxxkO00KKKXNNNNWNOxxxdll:,,
                             .......   ..;d00Okxxdolcc::lkKNWWWWWXd'':clol::::::;'.'oXNXXXK0OOOO0KKXXXXXXXXXKOxddkO00KKK0xodkO0KKKK00KNWMMMWKxkkkdllc;
                            ......    .':x00Oxddxdoc;,;cd0XWWWWWKl..';cdkxdllccc:,''c0XXXXXXKOOOOOOOOO0KKXXXXX0kooddxxdol:lk0XXKKK000KKNMMMMXxdkOkxol:
                           ......    .'lk0Okolodddl:;;ldOXNWWWN0:...';coxkxxdoooc,,';kNXXXXNX0OKX0OOOkxddxOKK0kooxxdddollllxKXXKK0000KXNWMMMNkox0Okxdl
                          ......    .,oOOkdl::clooolcokKXNNXXN0:.',;cl:cldxxdddo:;;,,dXNNNNNKOO0KK0O00KOxdoddl:lkOxxkkkkk0Oxox0KKK000KKXWMMMWOoxKK0kxd
                         .....     .;dOOkdlc::clllodx0XNNX000Kd'.;oddlc::codddolc:;;,:ONWWWX0OOOOOOOO00OOOkkOOkkxxxxkkkO0KXXx;lxxO0KKXXNNWMMWKodKNK0Ox
                        .....    ..:dOOkkdolcclllodkKNNXOxk000k;'cddoolccclloooolc:;,:OWWWNK0OOkkk0Oxkkkkkkkkkxo:,'....';cdxl:dOkkkO0XNNNWMMMXdlONXK0o
                      .....     ..:xOOkxxdlccllllokXNNKxox0K00Ol,;ldolllollcodooooc:;c0WWNX0OO00OO0doOOkkkxxdc'.   .....   ..:xOO0K0OkO0KNWMMNxlkXXKkc
                     ...       .'cxOOkxxoc::ccc:lOXNKkoloxKK000d;;:ododol:ldxdooodc:;;cdkOOOOO0Okxdc:oxxxdl;.   ..;lddxdl:'  .:xkOOKKkkxxO0KXWOlxKX0d;
                    ...       .,lxOkkxoc:;;;;;;o0NXOolloox0K000kc;cdkkxo::lxxdooooc:::::lOKKKK0000Odlc:ll:..   ...'cdkkkkkxl'  ;dkkOkO0kxOXXNWKooOKkc,
                  ...        .;okkkxdl:;;;;,,:d0NKdccodddxOK00K0ook0Oxxdl:coddoolccccccl0NXKKKKKK000xl::;..   ...',codxkOOkkx:  ;dxkkOkx0XWMWWXxlx0x:'
                 ...        'cdkkkxoc;;;;,',:xKXOdllloooook0KKXK00Oddxxdolccloolc:clcccoKWXKKKKKKKKOo:::,....,coOxlllc:codxddd; .cxxxxkKXNWMWWWkldkd:'
               ...        .,lxkkkxoc;;,,'',cdKKxooollllcclkKXXNNXx:coxxddolclllol::cccclkNNXKKKKKK0o::col'...:0NWW0d:,'',;;:coc. .;::o0XXNWWWMW0ooxo:,
              ...        .,okkkkdl:;,,'.';cx0kc:clolcc:::oOXNNNNO:,:ldddddolllooc:;:::cco0XXK00K0kl;cxOOk:. .,OWMMWXxc;,,,,;cdc.  ';:okKXXWWWWWKdodoc,
             ..         .,okkkxo:,,,,'.,:lxkc,,',:cccc:cdOKNNNK0O:';cloodddoool:::::;::;cxO00OO0kl::dXKOOk,  .;xXWMMWXOdoodxkx;  ;xkkOOKXXNWWWWXxoxxl;
            .          .;oxxkd:,',,,'';cdxo,.'''',;::lox0XXXK0000o'';clodkkxxl::coolc:::lxkkO0KK0xc;ck000Kd.  .'lx0NMWWNXKK0d,  'dkkkOKNWWWWWWMNkokOxc
                      .;oxxxl;'',,,,,;ldo;.......',:lxO0XKOxxkO00k;';:ldkkxdoc:cloollcc:cdkOO0KKXXkc;;:dkdlc,.  ':oOXNNXX0x:.  .cxkkOKNWNXKKXNWWOoOX0x
                    ..:dxxdc,'''',,;:ol;.........,:oxOKK0xoldkO00kc',cxkkdoolc:clollllc::ok00KKKXNN0l'.',oKNXkc.  .',;:c:'   .';ldk0KXK0OO0KXNWW0okNN0
                   .'cdxxo:'.''''';co:'........',:oxO00kdolldO000Oo;cxkxxxxxoc;:clllllc::lk00KKKNNWWKl...:ONWWN0d;.       .':ox0Kxoxxoox0XXKXWWWKoxXNX
                  .'cdxxl,..''''';c:'........'',:lxOOxdocccldOKKK0kdxddxxkxxo:;;:cllooc:;:xKKKKKXWWWWXo.. .:kNWWWNKxoccclodk0KNWWKoccokKKKK0KNWWKoxXNX
                 .,cdxdc'...'..';:,.........'',:lxkdooollcldkOKXXXKxc;ldxxxdl:;;:clodl:;,cONKK00KNNWWWN0c.  .,okKNWWNXXKKKXXNWWWKdccd0K000000XWMXodKNK
               ..,cdxo;........;,......''',,,;clddllllollodkO0KNNN0c..:odddoc:;::loooc;;;ckNXKK0O00KXWWWNO;    .,coOXNNXXNNWNNKkl:co0K00000O0XWMNxo0Kk
              .',codl,........,'......'',,;:clddollllllcclok0KNNNNx.  ,looocc::cloolc;;;;:kNNXKK0OOO0KNWWWXx,. .''';colloxkxdolldxddO0kOOO0O0NMMWklxxo
             .';coo:'..... .''.......',,,;cldddolllllccccloOXNNNXx'   .clolccclllllc:;;;;:kNWNXKKKKK0000KKK0d;',;;:cc::;;;:::cx0XX0xooxxkO00KWMMM0llol
           ..,;coo;.....  .'.......'',,;:loddollcclllccclx0XNNXk:.... .,lllllllloolc;;;;;:ok0XXXXK000KK0OOdc::dOKKKXXKOkxolcclkKKKK0Ol:ldk0XNWMMMKlclc
          .',:loc,....   ....  ....'',;clllllc::::::cccdOXXNXk:..';,.  .:ldddlloollcc:;;;:ckNNXNXK00KKKKKkc;:o0NWWWWWWWWWNKkdoodxOOkxolodk0KXXNWWXo:c:
         .,;:ll:'...    ...    ..''',:cc:;;:;;,;;;;;;lkKXXXOc'';c:;,....:odddlcoolccccc:;;:dXNXNNK0KKK0ko::cldxO0KKKKKXNNWNXKkxdooooxO00KKKKKXNWMXo;:;
        ',;clc,...     ..     ...'';::;'''''''',,,;:d0XXX0l'':cc;,'''...:ddooc:lc:cllllc;;;ckXXNNX00Oxo:,:lxO0KKKKKKKKKKKXNXXK0OOkxddk0K0000OXWMMNo,;,
      .';:cc;...      ..     ....,;;,'....''''',,;lOXXXKd,':cc;,,,'.....;ooooc;:::lollol;;;:xNNNWXOxolc::oO0000000000KKKKKKKXXXXXK0Okdx0KK0KKNWMMWx,,,
      ';:l:'..      ..     .....,,,'......'',,,,cxKXXKx:,:cc;;,,''.......cllcc:;,;:clol:;;;;l0XXWXkdodxxxkOKKKKKKKXXXXXKKKKK00000KKKKOOXNXXNWWWMMMO;''
     .;cc,...     ..      ....',,'.......'',,,cx0XXKkl;:c:;,,,''.........':cc::::;:cllc;;;;;:xKNNKkk0XXKKOxoxO0KKKK00OOXNX0OOOO00KKKK00XWWWWWWWMMMK:''
    .,::'..      ..     ....',,'...... ..'',:d0XXKkl:cc:;,'''.............,:::clloddolc::;;,;dKNNXNWWNXXXKKkooxxxxxxxxxOKK0OkkxkkkkkxxkOXWWWWWWMMMXl',
   .',,..      ..     ....'','.....  ...'':d0XNKkl::c:;,''.................,;codxxxolcll:;,',oXWWMMWXXXXXXXKkdkkkkkkkkxkOOOOOOkkkkkkkkxk0NWWWWWMMMXl;:
  ......     ..     .....'''...... ...',:dKNNXkl::c;,'''....................;oxxxdolcloo:,'..lNMMMMWNXXXNXXNX0KX000000KXNNNXXXXXXXXXXK0OKWWWWMMMMMXl:o
 .....      .     .................',;lkXWWXkc;::;,'......................,cokdlccc::loo:,...cXMMMMMMWWWWWWWWWWWWNNNNNWWWWWWWWWWWWMMMWWNWWWWMMMMMMXoox
.....           ............   .',,:oOXWWXkc;;:;,'.................... .,oxxoc:::;;;clool;...'xNMMMMMMMMMMMMMMMWWWMMMMMMMMMMMMMMWNWMMMMMMMMMMMMMMWKxO0
...            ..........    .',;:d0NWN0dc;;:;,'.............''''..  .;dKXd;,,:c;;;;:looo:.. ..cx0XXXXXXXXXXXXKkxKXXXXKK0000000kdx0KXXKKK00KXXXK0kkKXK
.            .........     .';;:d0NNKko;,;:;,'.............',,'..  .;kNWWNkc,,c:;;;::codl;.. .....',,,,,,;,,,;;,,::::;;;;;;;;,,,,;;:::::;,,,,,,''c0XX0
            ........     .';;:dOOkOkdl;,;;,'.............',,'..  .;kXWWWWWKxc';;,;::codl:'..............','.'''',,,,,,,;;;;,''''',,,.....     .;xXNXKO
          .......     ..';;cxOd;.cOkd:,,;'.............',,'.   .;kNWWWWWWWNXx,,;;:clodl:'''',,,,,,,,,,,,,,,,,,,,;;;,,,,;,,,,,,,,;:;.       .,lONNXK00x
         ......      .',;lkK0:. .d0xl:'','...........',,..   .:kXWWWWWWWWWWW0:,;cloddc;,,,;;;;;;;;,,,,;;;:::::cll:;;;;;;;;;::;;;;,..    .,oONWNNK0O0Od
       .....       ..,;lOXXx'':.'x0dc:'..''''.....',,'..   .lONNNWNXXNNWWWWWNd;coxxl;,,,,;;;;;::::;;;;;;;::clxxo:;;;;;;;;;;;:;,'...  .,oONWWNNX0OOOOxl
      ....      ...';oONNN0c.o0;.dkdc;;'...''''',,,'..  .,dKNNNNKOdloxKNWWWWW0dxxo;'''',;;:::::::;;;,,,;;;lxko:,,,'''',,;;;,'.... .,oOXWWWWNXKOOOOkdl;
     ..       ...,:oONN0dxXKxOKl.cxo:,,,'.....'''..  .'lOXNNNX0dc:;,;:xXWWWWWNOl'....''..'''''''........:dko,...............  ..,lONWWWWNNXKOkkkOkoc,'
   ..       ...,:d0NNKl..,dXXKKx,'loc,',''......   .,dKNWNNXOdc;,,,'.'l0NWWWWW0:...,,'''..........'',:lk0kl:::::cc:;;;;;:::::coONWWWWWNNXKOxxxOkdc;;'.
...       ..',cd0NN0d,    .oXXXO;.':c:;,'''''... .;xXWWNNX0oc;,,''.  .lKNWWWWWWX0O0KKK00000000OO000KXNWWNNNNNNNNNNNNXXXNNNWWWWWWWWWNNXX0Oxxxkkdl;,;,..
.       ..':okKX0d:,'c:.   .cxO0kl;',;;;,,''''..:OXNNNNXOo:;,''..   'dXWWWWWNNNNWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWNXK00OkkO0Oxoc:;,,'..
     ....;oOXN0l'..'oOk;    ..,:lddc;;;;,;;:,. .kWNNN0xc;,''...   .c0NWWWWXK0KXNWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWNNNXK0kxxkO00Oxdddo:;,'...
   ....,lkXNKd'.:c.,dkko. ..  ...'',;,;:cc;'. .lXNXKxc,''....   .'dXWWWNXOdolok0XK000KK00000KNWWWWNXKKKKXNWWWWWWWWWWWWWWWNNNXK0OxoodxkOkdloxkxo:,'....
.....':xKNX0c. .cOo:looo;..'.   ....',;;,'..'ckXX0xl;'...... ...:ONWWNXOdc;,,;cllccllllccldOKXXXK0OkkkkO0XNWWWWWWWWWWNNXXXKKK0kdodddlccccdkkkxo;'.....
....;lOXXKkc..  .lxdoc;;;,'';,..........,lkOKXX0xl;,'........'ckXNNX0kdl:;;;;;,,,;;::::clxO000OkxxkkkkOKXXNNWWWWWWNXXK0OOOOOOOOkxdl:;;;:okkkxl;'..''..
..':ox0Oxdoc;'.  .,:ll:,''''',,,,'...'cxKNNXKkdc;''........,ckKXK0kxoc:;;,,''',;;;:ccccloxxxxdddxkkkOO0KXNWWWWWWNXKOxoodxxkOOOxol:;;;;;:cloo:,'..''...
',:looc',xOkxdc'. ...',,'.........'okKNNXKOdc;,'.........,lkKX0Okdl:;;,''.'',;:;:ccc:ccccc::codxkOOkkO0XNWWWWNXKOxoc:::ldkkxolc::;;:::::::;,'..''''...
',loo,. .;dkkkxo:'........''','..:ONNNX0xc;'...........,lOKK0Okoc;,'''...,;;;;;:::;:::;,'',;:loxkkkkOKXXNWWNXOxoc:;;:coddlc::;;;:codolll:'....''''....
;codo:ll...;cc::c:'..  ........;xXNX0ko:,'..........';oOKKOkdc;...    .',;;;;:;;;::;'...',;;:clodkOKKKXXNN0xl:;;;;:cool:;;;;;;:ldxxxxoc;'...'',,'.....
clooocoOd;..........      .,:okKK0Oxl;'...........':d0K0kdc;...      ..',;;,,,;;;,'...',,;;:cldk0KKKXXNKkl;'.',,;clc:,,,,,,;codxxddoc;'...'',,,'......
loddo;';lllc,,,,,''..,clodOKK0Okdol:,'..........,cx00kdl;'..       ......'',,;;,....',,;::loxO0KKKKK0xl,....',:c::;,,,,,,:ldxxddoc:,'...',;;;;'.......
oodddc'..',;;;,,;,',l0XXXX0kdl:::;,'..........;okOOdc;'..       .................'',,;:cldk0K000Oxo:'.  ..',:::;,''''';codxddol:;,....';;;;;,'........
cloxxxdc;,'.....';oOKXK0kdl;'''''..........':okOxl:'..      ............     ..',,,;;coxO0K0Oxl:'.     .',;;,'''...';codddolc:;'....';;;;;;,'.........
;cloxkOkxdl:'',lx0KK0kdl;'...............,coxdl:,..       ..........        ..',,;:coxO00Od:'.      ..'''........';coollc:;,,''...';;;;;;,'...........
';cloxkkkkxdodxkOkxoc;'........... ....;looc;'..       ..........        ....',;:ldkOOxl;.       ...''..     ..,:cc:;,,;,,''....',,;;;,,'.............
,;:clloddxxxxxdoc;,............ ....',clc,...        .........         ...''',:ldkkxc,.       .......      .':cc:,............'',,,,,'............... 
;:ccc::::::::;,'...........    ....',,,..          ........         .....';:coddl:..       .......       .;cc:,..................'''..............    
;;;,'..'''''.............    .........          ........          .....';;;;;,..        ......        .,:c:,.......................   .........       
,'..  .................    .........          .......           .....',;,..           ....          .,ll;........................     .......         

    
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

    ------------------------------------------------------------
    -- Local Spell Table
    ------------------------------------------------------------
    local S = {}

    -- Seals
    S.SealOfTheCrusader = MultiSpell(
        21082,  -- R1
        20162,  -- R2
        20305,  -- R3
        20306,  -- R4
        20307,  -- R5
        20308,  -- R6
        27158   -- R7
    )

    S.SealOfCommand = MultiSpell(
        20375,  -- R1
        20915,  -- R2
        20918,  -- R3
        20919,  -- R4
        20920,  -- R5
        27170   -- R6
    )

    S.SealOfBlood = Spell(31892)  -- R1 (Horde only)

    S.SealOfTheMartyr = Spell(348700)  -- R1 (Alliance version of Seal of Blood)

    S.SealOfRighteousness = MultiSpell(
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
    )

    -- Judgements
    S.Judgement = Spell(20271)

    -- Blessings
    S.BlessingOfMight = MultiSpell(
        19740,  -- R1
        19834,  -- R2
        19835,  -- R3
        19836,  -- R4
        19837,  -- R5
        19838,  -- R6
        25291,  -- R7
        27140   -- R8
    )

    S.BlessingOfWisdom = MultiSpell(
        19742,  -- R1
        19850,  -- R2
        19852,  -- R3
        19853,  -- R4
        19854,  -- R5
        25290,  -- R6
        27142   -- R7
    )

    S.BlessingOfKings = Spell(20217)

    S.BlessingOfSalvation = Spell(1038)

    -- Greater Blessings
    S.GreaterBlessingOfMight = MultiSpell(
        25782,  -- R1
        25916   -- R2
    )

    S.GreaterBlessingOfWisdom = MultiSpell(
        25894,  -- R1
        25918   -- R2
    )

    S.GreaterBlessingOfKings = Spell(25898)

    S.GreaterBlessingOfSalvation = Spell(25895)

    -- Auras
    S.RetributionAura = MultiSpell(
        7294,   -- R1
        10298,  -- R2
        10299,  -- R3
        10300,  -- R4
        10301,  -- R5
        27150   -- R6
    )

    S.SanctityAura = Spell(20218)  -- TBC aura

    S.DevotionAura = MultiSpell(
        465,    -- R1
        10290,  -- R2
        643,    -- R3
        10291,  -- R4
        1032,   -- R5
        10292,  -- R6
        10293,  -- R7
        27149   -- R8
    )

    -- Attacks
    S.CrusaderStrike = Spell(35395)  -- TBC skill

    S.Consecration = MultiSpell(
        26573,  -- R1
        20116,  -- R2
        20922,  -- R3
        20923,  -- R4
        20924,  -- R5
        27173   -- R6
    )

    S.Exorcism = MultiSpell(
        879,    -- R1
        5614,   -- R2
        5615,   -- R3
        10312,  -- R4
        10313,  -- R5
        10314,  -- R6
        27138   -- R7
    )

    S.HolyWrath = MultiSpell(
        2812,   -- R1
        10318,  -- R2
        27139   -- R3
    )

    S.HammerOfWrath = MultiSpell(
        24275,  -- R1
        24274,  -- R2
        24239,  -- R3
        27180   -- R4
    )

    -- Utility
    S.AvengingWrath = Spell(31884)  -- TBC cooldown
    S.DivineShield = MultiSpell(642, 1020)
    S.HammerOfJustice = MultiSpell(853, 5588, 5589, 10308)

    ------------------------------------------------------------
    -- Buff/Debuff helpers
    ------------------------------------------------------------
    local SEAL_OF_CRUSADER_NAME     = GetSpellInfo(21082)
    local SEAL_OF_COMMAND_NAME      = GetSpellInfo(20375)
    local SEAL_OF_BLOOD_NAME        = GetSpellInfo(31892)
    local SEAL_OF_MARTYR_NAME       = GetSpellInfo(348700)
    local SEAL_OF_RIGHTEOUSNESS_NAME = GetSpellInfo(21084)
    
    local BLESSING_OF_MIGHT_NAME    = GetSpellInfo(19740)
    local BLESSING_OF_WISDOM_NAME   = GetSpellInfo(19742)
    local BLESSING_OF_KINGS_NAME    = GetSpellInfo(20217)
    local BLESSING_OF_SALVATION_NAME = GetSpellInfo(1038)
    local GREATER_BLESSING_OF_MIGHT_NAME = GetSpellInfo(25782)
    local GREATER_BLESSING_OF_WISDOM_NAME = GetSpellInfo(25894)
    local GREATER_BLESSING_OF_KINGS_NAME = GetSpellInfo(25898)
    local GREATER_BLESSING_OF_SALVATION_NAME = GetSpellInfo(25895)
    
    local RETRIBUTION_AURA_NAME     = GetSpellInfo(7294)
    local SANCTITY_AURA_NAME        = GetSpellInfo(20218)
    local DEVOTION_AURA_NAME        = GetSpellInfo(465)
    
    local JUDGEMENT_OF_CRUSADER_NAME = GetSpellInfo(21183)  -- Debuff from judging SotC

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
        return HasBuffByName("player", BLESSING_OF_MIGHT_NAME)
            or HasBuffByName("player", BLESSING_OF_WISDOM_NAME)
            or HasBuffByName("player", BLESSING_OF_KINGS_NAME)
            or HasBuffByName("player", BLESSING_OF_SALVATION_NAME)
            or HasBuffByName("player", GREATER_BLESSING_OF_MIGHT_NAME)
            or HasBuffByName("player", GREATER_BLESSING_OF_WISDOM_NAME)
            or HasBuffByName("player", GREATER_BLESSING_OF_KINGS_NAME)
            or HasBuffByName("player", GREATER_BLESSING_OF_SALVATION_NAME)
    end

    local function PlayerHasAura()
        return HasBuffByName("player", RETRIBUTION_AURA_NAME)
            or HasBuffByName("player", SANCTITY_AURA_NAME)
            or HasBuffByName("player", DEVOTION_AURA_NAME)
    end

    local function TargetHasJudgementOfCrusader()
        return HasDebuffByName("target", JUDGEMENT_OF_CRUSADER_NAME)
    end

    ------------------------------------------------------------
    -- Items table (kept for structure)
    ------------------------------------------------------------
    Item.Paladin = Item.Paladin or {}
    local I = Item.Paladin

    ------------------------------------------------------------
    -- Helper functions
    ------------------------------------------------------------
    local function TargetIsUndeadOrDemon()
        if not Target:Exists() then return false end
        local creatureType = UnitCreatureType("target")
        return creatureType == "Undead" or creatureType == "Demon"
    end

    ------------------------------------------------------------
    -- Config Menu
    ------------------------------------------------------------
    local Paladin_Config = {
        key      = 'RetPaladinTBC',
        title    = 'Retribution Paladin - TBC Classic',
        subtitle = '2.0',
        width    = 450,
        height   = 650,
        profiles = true,
        config   = {
            { type='header', text='Retribution Paladin - TBC', size=24, align='Center', color='ffffff' },

            { type='spacer' }, { type='ruler' }, { type='spacer' },

            { type='header', text='Seal Management', color='ffffff' },
            {
                type          = 'checkspin',
                text          = 'Use Judgement above mana % (pre-70)',
                key           = 'judgement',
                min           = 1,
                max           = 100,
                icon          = S.Judgement:ID(),
                default_check = true,
                default_spin  = 30,
            },
            { type='checkbox', text='Auto Seal of Crusader (Level 6-69)', key='autocrusader', icon=S.SealOfTheCrusader:ID(), default=true },
            {
                type = 'dropdown',
                text = 'Primary Seal (Level 6-69)',
                key = 'primaryseal_leveling',
                list = {
                    {
                        text = "Seal of Command (Slow Weapons)",
                        key = 'seal_command'
                    },
                    {
                        text = "Seal of Righteousness (Fast Weapons)",
                        key = 'seal_righteousness'
                    }
                },
                default = "seal_command"
            },
            { type='checkbox', text='Auto Seal of Blood/Martyr (Level 70)', key='autoblood', icon=S.SealOfBlood:ID(), default=true },
            { type='checkbox', text='Enable Seal Twisting (Level 70 - Command/Blood)', key='enabletwist', icon=S.SealOfCommand:ID(), default=false },
            { type='checkbox', text='Enable Seal Twisting (Level 60 - Command/Righteousness)', key='enabletwist60', icon=S.SealOfRighteousness:ID(), default=false },

            { type='spacer' }, { type='ruler' }, { type='spacer' },

            { type='header', text='Buffs', color='ffffff' },
            {
                type = 'dropdown',
                text = 'Auto Blessing',
                key = 'autoblessing',
                list = {
                    {
                        text = "Blessing of Might",
                        key = 'blessing_might'
                    },
                    {
                        text = "Blessing of Wisdom",
                        key = 'blessing_wisdom'
                    },
                    {
                        text = "Blessing of Kings",
                        key = 'blessing_kings'
                    },
                    {
                        text = "Blessing of Salvation",
                        key = 'blessing_salvation'
                    }
                },
                default = "blessing_might",
                icon = S.BlessingOfMight:ID()
            },
            { type='checkbox', text='Use Greater Blessings (Raid)', key='usegreater', icon=S.GreaterBlessingOfMight:ID(), default=false },
            { type='checkbox', text='Auto Retribution Aura', key='autoretaura', icon=S.RetributionAura:ID(), default=true },
            { type='checkbox', text='Use Sanctity Aura (if talented)', key='usesanctity', icon=S.SanctityAura:ID(), default=false },

            { type='spacer' }, { type='ruler' }, { type='spacer' },

            { type='header', text='Rotation Options', color='ffffff' },
            { type='checkbox', text='Use Crusader Strike', key='usecstrike', icon=S.CrusaderStrike:ID(), default=true },
            { type='checkbox', text='Use Consecration (AoE only)', key='useconsecration', icon=S.Consecration:ID(), default=true },
            {
                type          = 'checkspin',
                text          = 'Consecration AoE target count',
                key           = 'consecration_targets',
                min           = 1,
                max           = 10,
                icon          = S.Consecration:ID(),
                default_check = true,
                default_spin  = 4,
            },
            {
                type          = 'checkspin',
                text          = 'Use Consecration above mana %',
                key           = 'consecration_mana',
                min           = 1,
                max           = 100,
                icon          = S.Consecration:ID(),
                default_check = true,
                default_spin  = 40,
            },
            { type='checkbox', text='Use Exorcism on Undead/Demons', key='useexorcism', icon=S.Exorcism:ID(), default=true },
            { type='checkbox', text='Use Holy Wrath on Undead/Demons', key='useholywrath', icon=S.HolyWrath:ID(), default=false },
            { type='checkbox', text='Use Hammer of Wrath as execute', key='usehow', icon=S.HammerOfWrath:ID(), default=true },

            { type='spacer' }, { type='ruler' }, { type='spacer' },

            { type='header', text='Cooldowns', color='ffffff' },
            { type='checkbox', text='Use Avenging Wrath', key='useaw', icon=S.AvengingWrath:ID(), default=true },
        }
    }

    MainAddon.SetCustomConfig(Author, SpecID, Paladin_Config)

    ------------------------------------------------------------
    -- INIT
    ------------------------------------------------------------
    local function Init()
        MainAddon:Print('Retribution Paladin - TBC Classic 2.0 loaded......Ret Baby!')
    end

    ------------------------------------------------------------
    -- ENEMY ROTATION
    ------------------------------------------------------------
    local function EnemyRotation()
        if not MainAddon.TargetIsValid() then
            return
        end

        local mana        = Player:ManaPercentage()
        local targetHP    = Target:HealthPercentage()
        local playerLevel = UnitLevel("player")

        -- Config settings
        local judgementEnabled     = MainAddon.Config.GetSetting('RetPaladinTBC', 'judgement_check')
        local judgementThreshold   = MainAddon.Config.GetSetting('RetPaladinTBC', 'judgement_spin') or 30

        local autoCrusader         = MainAddon.Config.GetSetting('RetPaladinTBC', 'autocrusader')
        local primarySeal          = MainAddon.Config.GetSetting('RetPaladinTBC', 'primaryseal_leveling') or 'seal_command'
        local autoBlood            = MainAddon.Config.GetSetting('RetPaladinTBC', 'autoblood')
        local enableTwist          = MainAddon.Config.GetSetting('RetPaladinTBC', 'enabletwist')
        local enableTwist60        = MainAddon.Config.GetSetting('RetPaladinTBC', 'enabletwist60')

        local useCStrike           = MainAddon.Config.GetSetting('RetPaladinTBC', 'usecstrike')
        local useConsecration      = MainAddon.Config.GetSetting('RetPaladinTBC', 'useconsecration')
        local consecrationEnabled  = MainAddon.Config.GetSetting('RetPaladinTBC', 'consecration_mana_check')
        local consecrationThreshold = MainAddon.Config.GetSetting('RetPaladinTBC', 'consecration_mana_spin') or 40
        local consecrationTargetsEnabled = MainAddon.Config.GetSetting('RetPaladinTBC', 'consecration_targets_check')
        local consecrationTargets = MainAddon.Config.GetSetting('RetPaladinTBC', 'consecration_targets_spin') or 4

        local useExorcism          = MainAddon.Config.GetSetting('RetPaladinTBC', 'useexorcism')
        local useHolyWrath         = MainAddon.Config.GetSetting('RetPaladinTBC', 'useholywrath')
        local useHoW               = MainAddon.Config.GetSetting('RetPaladinTBC', 'usehow')
        local useAW                = MainAddon.Config.GetSetting('RetPaladinTBC', 'useaw')

        --------------------------------------------------------
        -- ABSOLUTE PRIORITY #1: Crusader Strike outside twist window (Level 70 Twisting)
        -- Fire CS at opener (nextSwing == 0) or when nextSwing > 2.1s with Command active
        -- CS is NOT part of the twist - it's just regular damage between twists
        --------------------------------------------------------
        if playerLevel >= 70 and enableTwist and useCStrike then
            local nextSwing = Player:NextSwing()
            local hasCommandSeal = PlayerHasSeal(SEAL_OF_COMMAND_NAME)
            
            -- Fire CS if: opener (nextSwing == 0) OR (nextSwing > 2.1s AND Command active)
            if S.CrusaderStrike:IsReady() and (nextSwing == 0 or (nextSwing > 2.1)) then
                if Cast(S.CrusaderStrike) then
                    if nextSwing == 0 then
                        return "Crusader Strike (opener)"
                    else
                        return "Crusader Strike (with Command)"
                    end
                end
            end
        end

        --------------------------------------------------------
        -- ABSOLUTE PRIORITY #2: Apply Command at 1.7s+ window (Level 70 Twisting)
        -- ONLY if Crusader debuff is already on target (don't interfere with opener)
        --------------------------------------------------------
        if playerLevel >= 70 and enableTwist then
            local hasCrusaderDebuff = TargetHasJudgementOfCrusader()
            local hasBloodSeal = PlayerHasSeal(SEAL_OF_BLOOD_NAME) or PlayerHasSeal(SEAL_OF_MARTYR_NAME)
            local hasCommandSeal = PlayerHasSeal(SEAL_OF_COMMAND_NAME)
            local nextSwing = Player:NextSwing()
            
            -- Only apply Command if Crusader debuff is confirmed on target
            if hasCrusaderDebuff and not hasBloodSeal and not hasCommandSeal and nextSwing > 2.0 then
                if S.SealOfCommand:IsReady(Player) then
                    if Cast(S.SealOfCommand) then
                        return "Seal of Command"
                    end
                end
            end
        end

        --------------------------------------------------------
        -- ABSOLUTE PRIORITY #3: Seal Twisting at 0.4s (Level 70)
        --------------------------------------------------------
        if playerLevel >= 70 and enableTwist then
            local hasCommandSeal = PlayerHasSeal(SEAL_OF_COMMAND_NAME)
            local nextSwing = Player:NextSwing()
            
            -- Twist to Blood at exactly <= 0.4s before auto attack
            if hasCommandSeal and nextSwing <= 0.4 then
                -- Try Seal of Blood (Horde)
                if S.SealOfBlood:IsReady(Player) then
                    if Cast(S.SealOfBlood) then
                        return "Seal of Blood (twist)"
                    end
                end
                -- Try Seal of the Martyr (Alliance)
                if S.SealOfTheMartyr:IsReady(Player) then
                    if Cast(S.SealOfTheMartyr) then
                        return "Seal of the Martyr (twist)"
                    end
                end
            end
        end

        --------------------------------------------------------
        -- ABSOLUTE PRIORITY #4: Judgement with Blood active (Level 70 Twisting)
        --------------------------------------------------------
        if playerLevel >= 70 and enableTwist then
            local hasBloodSeal = PlayerHasSeal(SEAL_OF_BLOOD_NAME) or PlayerHasSeal(SEAL_OF_MARTYR_NAME)
            
            if hasBloodSeal and S.Judgement:IsReady() then
                if Cast(S.Judgement) then
                    return "Judge Blood"
                end
            end
        end

        --------------------------------------------------------
        -- ABSOLUTE PRIORITY #5: Crusader Strike outside twist window (Level 60 Twisting)
        -- Fire CS at opener (nextSwing == 0) or when nextSwing > 2.1s with Command active
        -- CS is NOT part of the twist - it's just regular damage between twists
        --------------------------------------------------------
        if playerLevel < 70 and enableTwist60 and useCStrike then
            local nextSwing = Player:NextSwing()
            local hasCommandSeal = PlayerHasSeal(SEAL_OF_COMMAND_NAME)

            -- Fire CS if: opener (nextSwing == 0) OR (nextSwing > 2.1s AND Command active)
            if S.CrusaderStrike:IsReady() and (nextSwing == 0 or (nextSwing > 2.1 and hasCommandSeal)) then
                if Cast(S.CrusaderStrike) then
                    if nextSwing == 0 then
                        return "Crusader Strike (opener)"
                    else
                        return "Crusader Strike (with Command)"
                    end
                end
            end
        end

        --------------------------------------------------------
        -- ABSOLUTE PRIORITY #6: Crusader Strike with Righteousness (Level 60 Twisting)
        -- After the twist completes, fire CS with Righteousness for extra damage
        --------------------------------------------------------
        if playerLevel < 70 and enableTwist60 and useCStrike then
            local hasRighteousnessSeal = PlayerHasSeal(SEAL_OF_RIGHTEOUSNESS_NAME)

            if hasRighteousnessSeal and S.CrusaderStrike:IsReady() then
                if Cast(S.CrusaderStrike) then
                    return "Crusader Strike (with Righteousness)"
                end
            end
        end

        --------------------------------------------------------
        -- ABSOLUTE PRIORITY #7: Apply Command at 2.0s+ window (Level 60 Twisting)
        -- No seal active and swing is far enough away — put Command up so
        -- it rides the auto before the twist window opens.
        --------------------------------------------------------
        if playerLevel < 70 and enableTwist60 then
            local hasRighteousnessSeal = PlayerHasSeal(SEAL_OF_RIGHTEOUSNESS_NAME)
            local hasCommandSeal       = PlayerHasSeal(SEAL_OF_COMMAND_NAME)
            local nextSwing            = Player:NextSwing()

            if not hasRighteousnessSeal and not hasCommandSeal and nextSwing > 2.0 then
                if S.SealOfCommand:IsReady(Player) then
                    if Cast(S.SealOfCommand) then
                        return "Seal of Command (twist)"
                    end
                end
            end
        end

        --------------------------------------------------------
        -- ABSOLUTE PRIORITY #8: Twist Command → Righteousness at 0.4s (Level 60)
        -- Same window as the level 70 Blood twist.  Command is up, swing is
        -- imminent — swap to Righteousness so the auto procs it.
        --------------------------------------------------------
        if playerLevel < 70 and enableTwist60 then
            local hasCommandSeal = PlayerHasSeal(SEAL_OF_COMMAND_NAME)
            local nextSwing      = Player:NextSwing()

            if hasCommandSeal and nextSwing <= 0.4 then
                if S.SealOfRighteousness:IsReady(Player) then
                    if Cast(S.SealOfRighteousness) then
                        return "Seal of Righteousness (twist)"
                    end
                end
            end
        end

        --------------------------------------------------------
        -- ABSOLUTE PRIORITY #9: Judgement with Righteousness active (Level 60 Twisting)
        -- Judge while Righteousness is up to get Judgement of Righteousness damage.
        --------------------------------------------------------
        if playerLevel < 70 and enableTwist60 then
            local hasRighteousnessSeal = PlayerHasSeal(SEAL_OF_RIGHTEOUSNESS_NAME)

            if hasRighteousnessSeal and S.Judgement:IsReady() then
                if Cast(S.Judgement) then
                    return "Judge Righteousness (twist)"
                end
            end
        end

        --------------------------------------------------------
        -- APL: actions+=/avenging_wrath
        --------------------------------------------------------
        if useAW and S.AvengingWrath:IsReady() then
            if Cast(S.AvengingWrath) then
                return "Avenging Wrath"
            end
        end

        --------------------------------------------------------
        -- APL: actions+=/hammer_of_wrath (execute range < 20%)
        -- For level 70 twisting: only cast if nextSwing > 2.1s to avoid clipping twist
        --------------------------------------------------------
        if useHoW and S.HammerOfWrath:IsReady() and targetHP <= 20 then
            local canCast = true
            
            -- Level 70 twist check: don't cast in twist window
            if playerLevel >= 70 and enableTwist then
                local nextSwing = Player:NextSwing()
                canCast = nextSwing > 2.1 or nextSwing == 0
            end
            
            if canCast then
                if Cast(S.HammerOfWrath) then
                    return "Hammer of Wrath"
                end
            end
        end

        --------------------------------------------------------
        -- APL: actions+=/crusader_strike (for levels 1-69 and non-twisting)
        --------------------------------------------------------
        if useCStrike and S.CrusaderStrike:IsReady() then
            -- Only use here if NOT twisting (both 70 and 60 twist blocks own CS at absolute priority)
            if not (playerLevel >= 70 and enableTwist) and not (playerLevel < 70 and enableTwist60) then
                if Cast(S.CrusaderStrike) then
                    return "Crusader Strike"
                end
            end
        end

        --------------------------------------------------------
        -- Level 1-69: Seal Twist Logic with Crusader
        -- 1. If no Judgement of Crusader debuff on target, apply Seal of Crusader and Judge it
        -- 2. Once Crusader debuff is on target, maintain primary seal (Command or Righteousness)
        -- 3. Judge primary seal when mana allows (for burst damage)
        -- 
        -- Seal of Command: Best with slow, hard-hitting weapons (2.5+ speed)
        -- Seal of Righteousness: Best with fast weapons or low weapon damage
        --------------------------------------------------------
        if playerLevel < 70 then
            local hasCrusaderDebuff = TargetHasJudgementOfCrusader()
            local primarySealSpell = (primarySeal == 'seal_righteousness') and S.SealOfRighteousness or S.SealOfCommand
            local primarySealName = (primarySeal == 'seal_righteousness') and SEAL_OF_RIGHTEOUSNESS_NAME or SEAL_OF_COMMAND_NAME
            local hasPrimarySeal = PlayerHasSeal(primarySealName)

            -- Step 1: Apply Crusader debuff if missing
            if autoCrusader and not hasCrusaderDebuff then
                -- Put up Seal of Crusader
                if not PlayerHasSeal(SEAL_OF_CRUSADER_NAME) then
                    if S.SealOfTheCrusader:IsReady(Player) then
                        if Cast(S.SealOfTheCrusader) then
                            return "Seal of the Crusader (apply for judge)"
                        end
                    end
                end

                -- Judge Seal of Crusader to apply debuff
                if PlayerHasSeal(SEAL_OF_CRUSADER_NAME) and judgementEnabled and mana >= judgementThreshold then
                    if S.Judgement:IsReady() then
                        if Cast(S.Judgement) then
                            return "Judgement of the Crusader (apply debuff)"
                        end
                    end
                end
            end

            -- Step 2: Maintain primary seal once Crusader debuff is active
            -- Skip entirely when twist60 is enabled — the absolute priority blocks handle all seal logic.
            if hasCrusaderDebuff and not enableTwist60 then
                if not hasPrimarySeal then
                    if primarySealSpell:IsReady(Player) then
                        if Cast(primarySealSpell) then
                            if primarySeal == 'seal_righteousness' then
                                return "Seal of Righteousness (maintain)"
                            else
                                return "Seal of Command (maintain)"
                            end
                        end
                    end
                end

                -- Judge primary seal for burst damage (when mana allows)
                if hasPrimarySeal and judgementEnabled and mana >= judgementThreshold then
                    if S.Judgement:IsReady() then
                        if Cast(S.Judgement) then
                            if primarySeal == 'seal_righteousness' then
                                return "Judgement of Righteousness (damage)"
                            else
                                return "Judgement of Command (damage)"
                            end
                        end
                    end
                end
            end
        end

        --------------------------------------------------------
        -- Level 70: Maintain Judgement of Crusader, then Seal Twist
        -- Priority:
        -- 1. Keep Judgement of Crusader debuff on target (judge SotC, autos refresh)
        -- 2. Twist Command → Blood for damage optimization
        -- 3. Crusader Strike maintains judgements
        --------------------------------------------------------
        if playerLevel >= 70 then
            local hasCrusaderDebuff = TargetHasJudgementOfCrusader()
            local hasBloodSeal = PlayerHasSeal(SEAL_OF_BLOOD_NAME) or PlayerHasSeal(SEAL_OF_MARTYR_NAME)
            local hasCommandSeal = PlayerHasSeal(SEAL_OF_COMMAND_NAME)
            local hasCrusaderSeal = PlayerHasSeal(SEAL_OF_CRUSADER_NAME)
            local nextSwing = Player:NextSwing()
            
            -- Track what seal was active before judging (for post-judge seal application)
            local lastActiveSeal = "none"
            if hasBloodSeal then
                lastActiveSeal = "blood"
            elseif hasCommandSeal then
                lastActiveSeal = "command"
            end

            -- Step 1: Apply and maintain Judgement of Crusader debuff on target
            if not hasCrusaderDebuff then
                -- Put up Seal of Crusader if we don't have it
                if not hasCrusaderSeal then
                    if S.SealOfTheCrusader:IsReady(Player) then
                        if Cast(S.SealOfTheCrusader) then
                            return "Seal of the Crusader (apply debuff)"
                        end
                    end
                end

                -- Judge Seal of Crusader to apply debuff (autos will refresh it)
                if hasCrusaderSeal and S.Judgement:IsReady() then
                    if Cast(S.Judgement) then
                        return "Judge Crusader (apply debuff)"
                    end
                end
            end

            -- Step 2: Once Crusader debuff is up, handle seal management
            if hasCrusaderDebuff and autoBlood then
                -- Advanced twisting (if enabled)
                if enableTwist then
                    -- Twisting logic is handled at absolute priority (top of EnemyRotation):
                    -- 1. Crusader Strike with Blood
                    -- 2. Command at nextSwing > 1.7
                    -- 3. Twist at nextSwing <= 0.4
                    -- 4. Judge with Blood
                    -- Nothing needed here for twisting
                else
                    -- Simple rotation: Just maintain Seal of Blood and judge on cooldown
                    if not hasBloodSeal then
                        -- Try Seal of Blood (Horde)
                        if S.SealOfBlood:IsReady(Player) then
                            if Cast(S.SealOfBlood) then
                                return "Seal of Blood (maintain)"
                            end
                        end
                        -- Try Seal of the Martyr (Alliance)
                        if S.SealOfTheMartyr:IsReady(Player) then
                            if Cast(S.SealOfTheMartyr) then
                                return "Seal of the Martyr (maintain)"
                            end
                        end
                    end

                    -- Judge Blood on cooldown when not twisting
                    if hasBloodSeal and S.Judgement:IsReady() 
                       and (nextSwing > 0.6 or not Target:IsInRange(10)) then
                        if Cast(S.Judgement) then
                            return "Judge Blood/Martyr"
                        end
                    end
                end
            end
        end

        --------------------------------------------------------
        -- APL: actions+=/consecration (if mana allows, AoE targets met, and not moving)
        -- For level 70 twisting: only cast if nextSwing > 2.1s to avoid clipping twist
        --------------------------------------------------------
        if useConsecration and consecrationEnabled and S.Consecration:IsReady() and mana >= consecrationThreshold and not Player:IsMoving() then
            local canCast = true
            
            -- Level 70 twist check: don't cast in twist window
            if playerLevel >= 70 and enableTwist then
                local nextSwing = Player:NextSwing()
                canCast = nextSwing > 2.1 or nextSwing == 0
            end
            
            if canCast then
                local enemies = Player:GetEnemiesInMeleeRange(8)
                local enemyCount = #enemies
                local targetCountMet = consecrationTargetsEnabled and enemyCount >= consecrationTargets or not consecrationTargetsEnabled
                
                if targetCountMet then
                    if Cast(S.Consecration) then
                        return "Consecration"
                    end
                end
            end
        end

        --------------------------------------------------------
        -- APL: actions+=/exorcism (if target is undead/demon)
        -- For level 70 twisting: only cast if nextSwing > 2.1s to avoid clipping twist
        --------------------------------------------------------
        if useExorcism and S.Exorcism:IsReady() and TargetIsUndeadOrDemon() and not S.CrusaderStrike:IsReady() then
            local canCast = true
            
            -- Level 70 twist check: don't cast in twist window
            if playerLevel >= 70 and enableTwist then
                local nextSwing = Player:NextSwing()
                canCast = nextSwing > 2.1 or nextSwing == 0
            end
            
            if canCast then
                if Cast(S.Exorcism) then
                    return "Exorcism"
                end
            end
        end

        --------------------------------------------------------
        -- APL: actions+=/holy_wrath (if target is undead/demon)
        -- For level 70 twisting: only cast if nextSwing > 2.1s to avoid clipping twist
        --------------------------------------------------------
        if useHolyWrath and S.HolyWrath:IsReady() and TargetIsUndeadOrDemon() then
            local canCast = true
            
            -- Level 70 twist check: don't cast in twist window
            if playerLevel >= 70 and enableTwist then
                local nextSwing = Player:NextSwing()
                canCast = nextSwing > 2.1 or nextSwing == 0
            end
            
            if canCast then
                if Cast(S.HolyWrath) then
                    return "Holy Wrath"
                end
            end
        end

        return
    end

    ------------------------------------------------------------
    -- MAIN LOOP
    ------------------------------------------------------------
    local function MainRotation()
        local autoRetAura   = MainAddon.Config.GetSetting('RetPaladinTBC', 'autoretaura')
        local useSanctity   = MainAddon.Config.GetSetting('RetPaladinTBC', 'usesanctity')
        local blessingChoice = MainAddon.Config.GetSetting('RetPaladinTBC', 'autoblessing') or 'blessing_might'

        local playerLevel = UnitLevel("player")

        --------------------------------------------------------
        -- Always maintain buffs (in and out of combat)
        --------------------------------------------------------
        -- Apply selected blessing if missing
        local useGreater = MainAddon.Config.GetSetting('RetPaladinTBC', 'usegreater')
        
        -- Determine which blessing name to check for based on selection
        local blessingName = nil
        local greaterBlessingName = nil
        
        if blessingChoice == 'blessing_might' then
            blessingName = BLESSING_OF_MIGHT_NAME
            greaterBlessingName = GREATER_BLESSING_OF_MIGHT_NAME
        elseif blessingChoice == 'blessing_wisdom' then
            blessingName = BLESSING_OF_WISDOM_NAME
            greaterBlessingName = GREATER_BLESSING_OF_WISDOM_NAME
        elseif blessingChoice == 'blessing_kings' then
            blessingName = BLESSING_OF_KINGS_NAME
            greaterBlessingName = GREATER_BLESSING_OF_KINGS_NAME
        elseif blessingChoice == 'blessing_salvation' then
            blessingName = BLESSING_OF_SALVATION_NAME
            greaterBlessingName = GREATER_BLESSING_OF_SALVATION_NAME
        end
        
        -- Check if player has the SPECIFIC blessing they selected (normal OR greater version)
        local hasSelectedBlessing = HasBuffByName("player", blessingName) or HasBuffByName("player", greaterBlessingName)
        
        if not hasSelectedBlessing then
            local blessingSpell = nil
            
            if useGreater then
                -- Use Greater Blessings
                if blessingChoice == 'blessing_might' then
                    blessingSpell = S.GreaterBlessingOfMight
                elseif blessingChoice == 'blessing_wisdom' then
                    blessingSpell = S.GreaterBlessingOfWisdom
                elseif blessingChoice == 'blessing_kings' then
                    blessingSpell = S.GreaterBlessingOfKings
                elseif blessingChoice == 'blessing_salvation' then
                    blessingSpell = S.GreaterBlessingOfSalvation
                end
            else
                -- Use Regular Blessings
                if blessingChoice == 'blessing_might' then
                    blessingSpell = S.BlessingOfMight
                elseif blessingChoice == 'blessing_wisdom' then
                    blessingSpell = S.BlessingOfWisdom
                elseif blessingChoice == 'blessing_kings' then
                    blessingSpell = S.BlessingOfKings
                elseif blessingChoice == 'blessing_salvation' then
                    blessingSpell = S.BlessingOfSalvation
                end
            end

            if blessingSpell and blessingSpell:IsReady(Player) then
                if Cast(blessingSpell) then
                    return blessingSpell:Name()
                end
            end
        end

        -- Apply Aura if missing
        if not PlayerHasAura() then
            -- Sanctity Aura (if enabled and available)
            if useSanctity then
                if S.SanctityAura:IsReady(Player) then
                    if Cast(S.SanctityAura) then
                        return "Sanctity Aura"
                    end
                end
            end
            -- Retribution Aura (default)
            if autoRetAura then
                if S.RetributionAura:IsReady(Player) then
                    if Cast(S.RetributionAura) then
                        return "Retribution Aura"
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