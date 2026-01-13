local fonts = require('fonts');

local dragdisplay = {
	Toggles = {},
	Values = {},
};

local fontSettings = T{
	visible = true,
	font_family = 'Arial',
	font_height = 12,
	color = 0xFFFFFFFF,
	position_x = 300,
	position_y = 0,
	background = T{
		visible = true,
		color = 0xFF000000,
	}
};

local Utils = {
    Jugs = {
        LullabyMelodia = {
            Name = 'LullabyMelodia',
            DefaultJug = 'S. Herbal Broth',
            DefaultSTA = 'Lamb Chop',
            DefaultAOE = 'Sheep Song',
            DefaultSpecial = 'Rage',
            DurationMinutes = 60,
        },
        CourierCarrie = {
            Name = 'CourierCarrie',
            DefaultJug = 'Fish Oil Broth',
            DefaultSTA = 'Big Scissors',
            DefaultAOE = 'Bubble Shower',
            DefaultSpecial = 'Scissor Guard',
            --DefaultSpecial = 'Bubble Curtain',
            DurationMinutes = 30,
        },
        SaberSiravarde = {
            Name = 'SaberSiravarde',
            DefaultJug = 'W. Meat Broth',
            DefaultSTA = 'Razor Fang',
            DefaultAOE = 'Claw Cyclone',
            DefaultSpecial = 'Roar',
            DurationMinutes = 60,
        },
        SaberFamiliar = { --NQ Saber lv. 28
            Name = 'SaberFamiliar',
            DefaultJug = 'Meat Broth',
            DefaultSTA = 'Razor Fang',
            DefaultAOE = 'Claw Cyclone',
            DefaultSpecial = 'Roar',
            DurationMinutes = 60,
        },
        MiteFamiliar = { --NQ Diremite lv. 55
            Name = 'MiteFamiliar',
            DefaultJug = 'Blood Broth',
            DefaultSTA = 'Double Claw',
            DefaultAOE = 'Spinning Top',
            DefaultSpecial = 'Filamented Hold',
            DurationMinutes = 60,
        },
        KeenearedSteffi = {
            Name = 'KeenearedSteffi',
            DefaultJug = 'F. Carrot Broth',
            DefaultSTA = 'Foot Kick',
            DefaultAOE = 'Whirl Claws',
            DefaultSpecial = 'Dust Cloud',
            DurationMinutes = 90,
        },
        FunguarFamiliar = {
            Name = 'FunguarFamiliar',
            DefaultJug = 'Seedbed Soil',
            DefaultSTA = 'Frogkick',
            DefaultAOE = 'Silence Gas',
            DefaultSpecial = 'Dark Spore',
            DurationMinutes = 60,
        },
        FlowerpotBill = {
            Name = 'FlowerpotBill',
            DefaultJug = 'C. Carrion Broth',
            DefaultSTA = 'Head Butt',
            DefaultAOE = '',
            DefaultSpecial = 'Dream Flower',
            DurationMinutes = 60,
        },
        FlowerpotBen = {
            Name = 'FlowerpotBen',
            DefaultJug = 'C. Carrion Broth',
            DefaultSTA = 'Head Butt',
            DefaultAOE = '',
            DefaultSpecial = 'Dream Flower',
            DurationMinutes = 60,
        },
        ShellbusterOrob = {
            Name = 'ShellbusterOrob',
            DefaultJug = 'Q. Bug Broth',
            DefaultSTA = 'Venom',
            DefaultAOE = 'Cursed Sphere',
            DefaultSpecial = 'Venom',
            DurationMinutes = 60,
        },
        ColdbloodComo = {
            Name = 'ColdbloodComo',
            DefaultJug = 'C. Carrion Broth',
            DefaultSTA = 'Blockhead',
            DefaultAOE = 'Fireball',
            DefaultSpecial = 'Secretion',
            DurationMinutes = 60,
        },
        Homunculus = {
            Name = 'Homunculus',
            DefaultJug = 'C. Carrion Broth',
            DefaultSTA = 'Head Butt',
            DefaultAOE = '',
            DefaultSpecial = 'Dream Flower',
            DurationMinutes = 60,
        },
        VoraciousAudrey = {
            Name = 'VoraciousAudrey',
            DefaultJug = 'N. Grasshopper Broth',
            DefaultSTA = '',
            DefaultAOE = 'Soporific',
            DefaultSpecial = 'Gloeosuccus',
            DurationMinutes = 60,
        },
        FlytrapFamiliar = {
            Name = 'FlytrapFamiliar',
            DefaultJug = 'Grass Broth',
            DefaultSTA = '',
            DefaultAOE = 'Soporific',
            DefaultSpecial = 'Gloeosuccus',
            DurationMinutes = 60,
        },
        AmbusherAllie = {
            Name = 'AmbusherAllie',
            DefaultJug = 'L. Mole Broth',
            DefaultSTA = 'Nimble Snap',
            DefaultAOE = 'Cyclotail',
            DefaultSpecial = 'Toxic Spit',
            DurationMinutes = 60,
        },
        PanzerGalahad = {
            Name = 'PanzerGalahad',
            DefaultJug = 'Scarlet Sap',
            DefaultSTA = 'Rhino Attack',
            DefaultAOE = 'Hi-Freq Field',
            DefaultSpecial = 'Rhino Guard',
            DurationMinutes = 60,
        },
        LifedrinkerLars = {
            Name = 'LifedrinkerLars',
            DefaultJug = 'C. Blood Broth',
            DefaultSTA = 'Double Claw',
            DefaultAOE = 'Spinning Top',
            DefaultSpecial = 'Filamented Hold',
            DurationMinutes = 60,
        },
        ChopsueyChucky = {
            Name = 'ChopsueyChucky',
            DefaultJug = 'F. Antica Broth',
            DefaultSTA = 'Mandibular Bite',
            DefaultAOE = 'Venom Spray',
            DefaultSpecial = 'Sandblast',
            DurationMinutes = 60,
        },
        AmigoSabotender = {
            Name = 'AmigoSabotender',
            DefaultJug = 'Sun Water',
            DefaultSTA = 'Needleshot',
            DefaultAOE = '',
            DefaultSpecial = '1000 Needles',
            DurationMinutes = 30,
        },
        CharmedPet = {
            Name = '',
            DefaultJug = '',
            DefaultSTA = 'Sic',
            DefaultAOE = '',
            DefaultSpecial = '',
            DurationMinutes = 0,
        },
        Empty = {
            Name = '',
            DefaultJug = '',
            DefaultSTA = '',
            DefaultAOE = '',
            DefaultSpecial = '',
            DurationMinutes = 0,
        },
    },
    Summons = {
        Carbuncle = {
            Name = 'Carbuncle',
            Rage1 = 'Poison Nails',
            Rage2 = 'Meteorite',
            Rage3 = '',
            Rage4 = '',
            AstralFlow = 'Searing Light',
            Ward1 = 'Healing Ruby',
            Ward2 = 'Shining Ruby',
            Ward3 = 'Healing Ruby II',
            Ward4 = '',
            Nuke = '',
        },
        Ifrit = {
            Name = 'Ifrit',
            Rage1 = 'Punch',
            Rage2 = 'Burning Strike',
            Rage3 = 'Double Punch',
            Rage4 = 'Flaming Crush',
            AstralFlow = 'Inferno',
            Ward1 = 'Crimson Howl',
            Ward2 = '',
            Ward3 = '',
            Ward4 = '',
            Nuke = 'Fire IV',
        },
        Titan = {
            Name = 'Titan',
            Rage1 = 'Rock Throw',
            Rage2 = 'Rock Buster',
            Rage3 = 'Megalith Throw',
            Rage4 = 'Mountain Buster',
            AstralFlow = 'Earthen Fury',
            Ward1 = 'Earthen Ward',
            Ward2 = '',
            Ward3 = '',
            Ward4 = '',
            Nuke = '',
        },
        Leviathan = {
            Name = 'Leviathan',
            Rage1 = 'Barracuda Dive',
            Rage2 = 'Tail Whip',
            Rage3 = 'Spinning Dive',
            Rage4 = '',
            AstralFlow = 'Tidal Wave',
            Ward1 = 'Slowga',
            Ward2 = 'Spring Water',
            Ward3 = '',
            Ward4 = '',
            Nuke = 'Water IV',
        },
        Garuda = {
            Name = 'Garuda',
            Rage1 = 'Claw',
            Rage2 = 'Predator Claws',
            Rage3 = '',
            Rage4 = '',
            AstralFlow = 'Aerial Blast',
            Ward1 = 'Aerial Armor',
            Ward2 = 'Whispering Wind',
            Ward3 = 'Hastega',
            Ward4 = '',
            Nuke = 'Aero IV',
        },
        Shiva = {
            Name = 'Shiva',
            Rage1 = 'Axe Kick',
            Rage2 = 'Double Slap',
            Rage3 = '',
            Rage4 = '',
            AstralFlow = 'Diamond Dust',
            Ward1 = 'Frost Armor',
            Ward2 = 'Sleepga',
            Ward3 = '',
            Ward4 = '',
            Nuke = 'Blizzard IV',
        },
        Ramuh = {
            Name = 'Ramuh',
            Rage1 = 'Shock Strike',
            Rage2 = 'Thunderspark',
            Rage3 = 'Chaotic Strike',
            Rage4 = '',
            AstralFlow = 'Judgment Bolt',
            Ward1 = 'Rolling Thunder',
            Ward2 = 'Lightning Armor',
            Ward3 = '',
            Ward4 = '',
            Nuke = 'Thunder IV',
        },
        Fenrir = {
            Name = 'Fenrir',
            Rage1 = 'Moonlit Charge',
            Rage2 = 'Crescent Fang',
            Rage3 = 'Eclipse Bite',
            Rage4 = '',
            AstralFlow = 'Howling Moon',
            Ward1 = 'Lunar Cry',
            Ward2 = 'Lunar Roar',
            Ward3 = 'Ecliptic Howl',
            Ward4 = 'Ecliptic Growl',
            Nuke = '',
        },
        Diabolos = {
            Name = 'Diabolos',
            Rage1 = 'Camisado',
            Rage2 = 'Nether Blast',
            Rage3 = '',
            Rage4 = '',
            AstralFlow = 'Ruinous Omen',
            Ward1 = 'Noctoshield',
            Ward2 = 'Dream Shroud',
            Ward3 = 'Somnolence',
            Ward4 = 'Nightmare',
            Nuke = '',
        },
        Empty = {
            Name = '',
            Rage1 = '',
            Rage2 = '',
            Rage3 = '',
            Rage4 = '',
            AstralFlow = '',
            Ward1 = '',
            Ward2 = '',
            Ward3 = '',
            Nuke = '',
        },
    },
};

function dragdisplay.Update(settings)
	local player = AshitaCore:GetMemoryManager():GetPlayer();
    --local modifiers = player:GetStatsModifiers():GetStrength();
	local pet = gData.GetPet();

    --gFunc.Message(modifiers);

	local MID = player:GetMainJob();
	local SID = player:GetSubJob();
	Def = player:GetDefense();
	Attk = player:GetAttack();
	MainLV = player:GetMainJobLevel();
	SubLV = player:GetSubJobLevel();
	Main = AshitaCore:GetResourceManager():GetString("jobs.names_abbr", MID);
	Sub = AshitaCore:GetResourceManager():GetString("jobs.names_abbr", SID);
    DarkResistance = player:GetResist(7);
    EarthResistance = player:GetResist(3);
    FireResistance = player:GetResist(0);
    IceResistance = player:GetResist(1);
    LightningResistance = player:GetResist(4);
    LightResistance = player:GetResist(6);
    WaterResistance = player:GetResist(5);
    WindResistance = player:GetResist(2);
    local environment = gData.GetEnvironment();
    weather = environment.Weather;
    day = environment.Day;
    --PlayerStrength = player:GetStat(0);
    --PlayerDexterity = player:GetStat(1);
    --PlayerVitality = player:GetStat(2);
    --PlayerAgility = player:GetStat(3);
    --PlayerIntelligence = player:GetStat(4);
    --PlayerMind = player:GetStat(5);
    --PlayerCharisma = player:GetStat(6);
    --PlayerStrengthMod = player:GetStatModifier(0);
    --PlayerDexterityMod = player:GetStatModifier(1);
    --PlayerVitalityMod = player:GetStatModifier(2);
    --PlayerAgilityMod = player:GetStatModifier(3);
    --PlayerIntelligenceMod = player:GetStatModifier(4);
    --PlayerMindMod = player:GetStatModifier(5);
    --PlayerCharismaMod = player:GetStatModifier(6);

    if pet ~= nil then
        if pet.Name == 'Carbuncle' then
            SmnPet = Utils.Summons.Carbuncle;
        elseif pet.Name == 'Ifrit' then
            SmnPet = Utils.Summons.Ifrit;
        elseif pet.Name == 'Titan' then
            SmnPet = Utils.Summons.Titan;
        elseif pet.Name == 'Leviathan' then
            SmnPet = Utils.Summons.Leviathan;
        elseif pet.Name == 'Garuda' then
            SmnPet = Utils.Summons.Garuda;
        elseif pet.Name == 'Shiva' then
            SmnPet = Utils.Summons.Shiva;
        elseif pet.Name == 'Ramuh' then
            SmnPet = Utils.Summons.Ramuh;
        elseif pet.Name == 'Fenrir' then
            SmnPet = Utils.Summons.Fenrir;
        elseif pet.Name == 'Diabolos' then
            SmnPet = Utils.Summons.Diabolos;
        elseif pet.Name == 'LullabyMelodia' then
            BstPet = Utils.Jugs.LullabyMelodia;
        elseif pet.Name == 'CourierCarrie' then
            BstPet = Utils.Jugs.CourierCarrie;
        elseif pet.Name == 'SaberFamiliar' then
            BstPet = Utils.Jugs.SaberFamiliar;
        elseif pet.Name == 'MiteFamiliar' then
            BstPet = Utils.Jugs.MiteFamiliar;
        elseif pet.Name == 'KeenearedSteffi' then
            BstPet = Utils.Jugs.KeenearedSteffi;
        elseif pet.Name == 'FunguarFamiliar' then
            BstPet = Utils.Jugs.FunguarFamiliar;
        elseif pet.Name == 'FlowerpotBill' then
            BstPet = Utils.Jugs.FlowerpotBill;
        elseif pet.Name == 'FlowerpotBen' then
            BstPet = Utils.Jugs.FlowerpotBen;
        elseif pet.Name == 'ShellbusterOrob' then
            BstPet = Utils.Jugs.ShellbusterOrob;
        elseif pet.Name == 'ColdbloodComo' then
            BstPet = Utils.Jugs.ColdbloodComo;
        elseif pet.Name == 'Homunculus' then
            BstPet = Utils.Jugs.Homunculus;
        elseif pet.Name == 'VoraciousAudrey' then
            BstPet = Utils.Jugs.VoraciousAudrey;
        elseif pet.Name == 'FlytrapFamiliar' then
            BstPet = Utils.Jugs.FlytrapFamiliar;
        elseif pet.Name == 'AmbusherAllie' then
            BstPet = Utils.Jugs.AmbusherAllie;
        elseif pet.Name == 'PanzerGalahad' then
            BstPet = Utils.Jugs.PanzerGalahad;
        elseif pet.Name == 'LifedrinkerLars' then
            BstPet = Utils.Jugs.LifedrinkerLars;
        elseif pet.Name == 'ChopsueyChucky' then
            BstPet = Utils.Jugs.ChopsueyChucky;
        elseif pet.Name == 'AmigoSabotender' then
            BstPet = Utils.Jugs.AmigoSabotender;
        else
            SmnPet = Utils.Summons.Empty;
            BstPet = Utils.Jugs.CharmedPet;
            BstPet.Name = pet.Name;
        end
    else
        SmnPet = Utils.Summons.Empty;
        BstPet = Utils.Jugs.Empty;
    end
	
end

function dragdisplay.Unload()
	if (dragdisplay.FontObject ~= nil) then
		dragdisplay.FontObject:destroy();
	end
	ashita.events.unregister('d3d_present', 'dragdisplay_present_cb');
end

function dragdisplay.Initialize()
	dragdisplay.Update();
	dragdisplay.FontObject = fonts.new(fontSettings);	
	ashita.events.register('d3d_present', 'dragdisplay_present_cb', function ()
		local display = MainLV .. Main .. '/' .. SubLV .. Sub ..'   Attk:' .. Attk .. '   Def:' .. Def;

        display = display .. '    Res -> ' .. 'Dark: ' .. DarkResistance .. ' | Earth: ' .. EarthResistance .. ' | Fire: ' .. FireResistance .. ' | Ice: ' .. IceResistance .. ' | Lightning: ' .. LightningResistance .. ' | Light: ' .. LightResistance .. ' | Water: ' .. WaterResistance .. ' | Wind: ' .. WindResistance;
        display = display .. ' || Day: ' .. day .. ' | Weather: ' .. weather;

        if Main == 'BST' and BstPet ~= Utils.Jugs.Empty then
            display = display .. '\n' .. BstPet.Name .. ':   1: Fight   2: Charm   3: Call Beast   4: ' .. BstPet.DefaultSTA .. '   5: ' .. BstPet.DefaultAOE .. '   6: ' .. BstPet.DefaultSpecial .. '   8: Stay   9: Heel   0: RewardHP sh0: RewardSTATUS';
        --elseif Main == 'DRG' then
        --    display = display .. '\n2: Jump   3: Call Wyvern   4: High Jump   5. Super Jump   9: Spirit Link   0: Steady Wing';
        elseif Main == 'SMN' and SmnPet ~= Utils.Summons.Empty then
            display = display .. '\n' .. SmnPet.Name .. ':   1: Assault   3: ' .. SmnPet.Rage1 .. '   4: ' .. SmnPet.Rage2 .. '   5: ' .. SmnPet.Rage3 .. '   sh5: ' .. SmnPet.Rage4 .. '   6: ' .. SmnPet.AstralFlow .. '   7: ' .. SmnPet.Ward1 .. '   Sh7: ' .. SmnPet.Ward3 .. '   8: ' .. SmnPet.Ward2 .. '   Sh8: ' .. SmnPet.Ward4 .. '   9: Retreat';
        elseif Sub == 'BST' and BstPet ~= Utils.Jugs.Empty then
            display = display .. '\n' .. BstPet.Name .. ':   1: Fight   2: Charm   4: Sic   8: Stay   9: Heel   0: RewardHP sh0: RewardSTATUS';
        elseif Main == 'RDM' and Sub == 'BLM' then
            display = display .. '\n1. Haste 2. Refresh 3. Regen 4. Gravity sh4. Blaze Spikes 5. Stoneskin sh5. Phalanx 6. Silence sh6. Blink 7. Drain 8. Aspir 9. Sleepga 0. Sleep';
        elseif Main == 'RDM' and Sub == 'DRK' then
            display = display .. '\n1. Haste 2. Refresh 3. Regen 4. Gravity sh4. Blaze Spikes 5. Stoneskin sh5. Phalanx 6. Silence sh6. Blink 7. Drain 8. Aspir 9. Bind 0. Sleep';
        elseif Main == 'RDM' and Sub == 'NIN' then
            display = display .. '\n1. Haste 2. Refresh 3. Regen sh3. Enspell 4. Gravity sh4. Shock Spikes 5. Stoneskin sh5. Phalanx 6. Silence sh6. Blink 7. Utsu1 8. Utsu2 9. Bind 0. Sleep';
        elseif Main == 'RDM' then
            display = display .. '\n1. Haste 2. Refresh 3. Regen sh3. Enspell 4. Gravity sh4. Shock Spikes 5. Stoneskin sh5. Phalanx 6. Silence sh6. Blink 7. N/A 8. N/A 9. Bind 0. Sleep';
        end

        dragdisplay.FontObject.text = display;
	end);
end

return dragdisplay;