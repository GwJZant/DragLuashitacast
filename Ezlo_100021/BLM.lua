local profile = {};
draginclude = gFunc.LoadFile('common\\draginclude.lua');

local Settings = {
    LateInitialized = {
        Initialized = false,
        TimeToUse = 0,
    },
    StatusArmorSwaps = {
        OpoopoNecklace = false,
    },
    CurrentLevel = 0,
    MagicBurst = false,
    MDT = false,
    Enmity = false,
    FastCastValueRDM = 0.21,
    FastCastValue = 0.04,
};

local sets = {
    Default_Priority = {
        Ammo = {'Hedgehog Bomb'},
        Head = {'Nashira Turban', 'Emperor Hairpin', 'Dream Hat +1'},
        Neck = {'Jeweled Collar', 'Holy Phial'},
        Ear1 = {'Merman\'s Earring', 'Geist Earring'},
        Ear2 = {'Merman\'s Earring', 'Geist Earring'},
        Body = {'Wonder Kaftan', 'Dream Robe +1'},
        Hands = {'Merman\'s Bangles', 'Wonder Mitts', 'Dream Mittens +1'},
        Ring1 = {'Merman\'s Ring', 'Tamas Ring'},
        Ring2 = {'Merman\'s Ring', 'San d\'Orian Ring'},
        Back = {'Hexerei Cape', 'Trimmer\'s Mantle'},
        Waist = {'Penitent\'s Rope', 'Druid\'s Rope'},
        Legs = {'Igqira Lappas', 'Wizard\'s Tonban', 'Wonder Braccae', 'Dream Trousers +1'},
        Feet = {'Errant Pigaches', 'Wizard\'s Sabots', 'Wonder Clomps', 'Dream Boots +1'},
    },

    RestingMP_Priority = {
        Ammo = {''},
        Head = {''},
        Neck = {'Checkered Scarf'},
        Ear1 = {''},
        Ear2 = {''},
        Body = {'Errant Hpl.'},
        Hands = {''},
        Ring1 = {''},
        Ring2 = {''},
        Back = {''},
        Waist = {'Hierarch Belt'},
        Legs = {'Baron\'s Slops'},
        Feet = {''},
    },

    SpellHaste_Priority = {
        Head = {'Nashira Turban'},
        Body = {'Igqira Weskit'}, -- Only defining this because Black Cloak makes body empty w/ Nash Turban
        Waist = {'Swift Belt'},
    },

    FastCast_Priority = {
        Ear2 = {'Loquac. Earring'},
        Feet = {'Rostrum Pumps'},
    },

    FastCastRDM_Priority = {
        Ear2 = {'Loquac. Earring'},
        Back = {'Warlock\'s Mantle'},
        Feet = {'Rostrum Pumps'},
    },

    -- Level 59
    Vermillion = {
        Head = 'displaced',
        Body = 'Vermillion Cloak',
    },

    -- Level 68
    BlackCloak = {
        Head = 'displaced',
        Body = 'Black Cloak',
    },

    MeleeEngaged_Priority = {
        Ammo = {'Phtm. Tathlum'},
        Head = {'Emperor Hairpin'},
        Neck = {'Jeweled Collar'},
        Ear1 = {'Merman\'s Earring'},
        Ear2 = {'Merman\'s Earring'},
        Body = {'Black Cotehardie'},
        Hands = {'Wonder Mitts'},
        Ring1 = {'Sniper\'s Ring'},
        Ring2 = {'Toreador\'s Ring'},
        Back = {'Hexerei Cape'},
        Waist = {'Swift Belt'},
        Legs = {'Igqira Lappas'},
        Feet = {'Wonder Clomps'},
    },

    INT_Priority = { -- INT +50
        Ammo = {'Phtm. Tathlum'}, -- INT +2
        Head = {'Demon Helm', 'Wizard\'s Petasos'}, -- INT +4
        Neck = {'Checkered Scarf'}, -- INT +2
        Ear1 = {'Morion Earring'}, -- INT +1
        Ear2 = {'Abyssal Earring'}, -- INT +2
        Body = {'Errant Hpl.', 'Shaman\'s Cloak'}, -- INT +10
        Hands = {'Errant Cuffs'}, -- INT +5
        Ring1 = {'Tamas Ring'}, -- INT +5
        Ring2 = {'Snow Ring'}, -- INT +4
        Back = {'Prism Cape'}, -- INT +3
        Waist = {'Penitent\'s Rope', 'Druid\'s Rope'}, -- INT +5
        Legs = {'Errant Slops'}, -- INT +3
        Feet = {'Rostrum Pumps', 'Wizard\'s Sabots'}, -- INT +3
    },

    INTEnfeebling_Priority = { -- INT +32, Enfeebling +30
        Ammo = {'Phtm. Tathlum'}, -- INT +2
        Head = {'Igqira Tiara', 'Elite Beret'}, -- Enfeebling +10
        Neck = {'Checkered Scarf'}, -- INT +2
        Ear1 = {'Morion Earring'}, -- INT +1
        Ear2 = {'Abyssal Earring'}, -- INT +2
        Body = {'Wizard\'s Coat', 'Shaman\'s Cloak'}, -- Enfeebling +10
        Hands = {'Errant Cuffs'}, -- INT +5
        Ring1 = {'Tamas Ring'}, -- INT +5
        Ring2 = {'Snow Ring'}, -- INT +4
        Back = {'Prism Cape'}, -- INT +3
        Waist = {'Penitent\'s Rope', 'Druid\'s Rope'}, -- INT +5
        Legs = {'Igqira Lappas'}, -- Enfeebling +10
        Feet = {'Rostrum Pumps', 'Wizard\'s Sabots'}, -- INT +3
    },

    -- 520 HP
    -- Nuke set: 520/690
    HPDown_Priority = {
        Head = {'Emperor Hairpin'}, -- -15 HP
        Neck = {'Checkered Scarf'}, -- -12 HP
        Body = {'Black Cotehardie'}, -- -25 HP
        Hands = {'Zenith Mitts'}, -- -50 HP
        Ring1 = {'Ether Ring'}, -- -30 HP
        Ring2 = {'Astral Ring'}, -- -25 HP
        Back = {'Blue Cape'}, -- -15 HP
        Waist = {'Penitent\'s Rope'}, -- -20 HP
        Legs = {'Zenith Slacks'}, -- -50 HP
        Feet = {'Rostrum Pumps'}, -- -30 HP
    },

    INTElemental_Priority = { -- INT +32, Elemental +5, MAB +33
        Ammo = {'Phtm. Tathlum'}, -- INT +2
        Head = {'Demon Helm', 'Wizard\'s Petasos'}, -- INT +5
        Neck = {'Checkered Scarf'}, -- INT +2
        Ear1 = {'Novio Earring', 'Elemental Earring'}, -- MAB +7
        Ear2 = {'Moldavite Earring'}, -- MAB +5
        Body = {'Igqira Weskit', 'Shaman\'s Cloak'}, -- MAB +6, Elemental +5
        Hands = {'Zenith Mitts', 'Errant Cuffs', 'Wizard\'s Gloves'}, -- MAB +5
        Ring1 = {'Tamas Ring'}, -- INT +5
        Ring2 = {'Sorcerer\'s Ring'}, -- MAB +10
        Back = {'Prism Cape'}, -- INT +3
        Waist = {'Penitent\'s Rope', 'Druid\'s Rope'}, -- INT +5
        Legs = {'Errant Slops'}, -- INT +7
        Feet = {'Rostrum Pumps', 'Wizard\'s Sabots'}, -- INT +3
    },

    INTElementalDot_Priority = { -- INT +40, Elemental +8, MAB +6
        Ammo = {'Phtm. Tathlum'}, -- INT +2
        Head = {'Demon Helm', 'Wizard\'s Petasos'}, -- INT +5
        Neck = {'Checkered Scarf'}, -- INT +2
        Ear1 = {'Abyssal Earring'}, -- INT +2
        Ear2 = {'Elemental Earring'}, -- Elemental +3
        Body = {'Igqira Weskit', 'Shaman\'s Cloak'}, -- MAB +6, Elemental +5
        Hands = {'Errant Cuffs', 'Wizard\'s Gloves'}, -- INT +5
        Ring1 = {'Tamas Ring'}, -- INT +5
        Ring2 = {'Snow Ring'}, -- INT +4
        Back = {'Prism Cape'}, -- INT +3
        Waist = {'Penitent\'s Rope', 'Druid\'s Rope'}, -- INT +5
        Legs = {'Errant Slops'}, -- INT +3
        Feet = {'Rostrum Pumps', 'Wizard\'s Sabots'}, -- INT +3
    },

    MagicBurst_Priority = {
        Hands = {'Sorcerer\'s Gloves'},
    },

    Enmity_Priority = { -- Enmity -35
        Ammo = {'Hedgehog Bomb'}, -- Enmity -1
        Head = {'Nashira Turban'}, -- Enmity -5
        Ear2 = {'Novia Earring'}, -- Enmity -7
        Body = {'Errant Hpl.'}, -- Enmity -3
        Hands = {'Sorcerer\'s Gloves'}, -- Enmity -2
        Ring1 = {'Tamas Ring'}, -- Enmity -5
        Back = {'Errant Cape'}, -- Enmity -5
        Waist = {'Penitent\'s Rope'}, -- Enmity -3
        Legs = {'Errant Slops'}, -- Enmity -3
        Feet = {'Errant Pigaches', 'Wizard\'s Sabots'}, -- Enmity -2
    },

    INTDark_Priority = { -- INT +34, Dark +34, Macc +5, Haste +2%
        Ammo = {'Phtm. Tathlum'}, -- INT +2
        Head = {'Nashira Turban', 'Wizard\'s Petasos'}, -- Macc +5 Haste +2%
        Neck = {'Checkered Scarf'}, -- INT +2
        Ear1 = {'Abyssal Earring'}, -- INT +2, Dark Skill +5
        Ear2 = {'Morion Earring'}, -- INT +1
        Body = {'Errant Hpl.', 'Shaman\'s Cloak'}, -- INT +10
        Hands = {'Sorcerer\'s Gloves', 'Wizard\'s Gloves'}, -- Dark Skill +10
        Ring1 = {'Tamas Ring'}, -- INT +5
        Ring2 = {'Snow Ring'}, -- INT +4
        Back = {'Prism Cape'}, -- INT +3
        Waist = {'Penitent\'s Rope', 'Druid\'s Rope'}, -- INT +5
        Legs = {'Wizard\'s Tonban'}, -- Dark Skill +15
        Feet = {'Igqira Huaraches', 'Wizard\'s Sabots'}, -- Dark +4
    },

    Stun_Priority = { -- INT +29, Dark +34, Macc +5, Haste +6%
        Ammo = {'Phtm. Tathlum'}, -- INT +2
        Head = {'Nashira Turban', 'Wizard\'s Petasos'}, -- Macc +5 Haste +2%
        Neck = {'Checkered Scarf'}, -- INT +2
        Ear1 = {'Abyssal Earring'}, -- INT +2, Dark Skill +5
        Ear2 = {'Morion Earring'}, -- INT +1
        Body = {'Errant Hpl.', 'Shaman\'s Cloak'}, -- INT +10
        Hands = {'Sorcerer\'s Gloves', 'Wizard\'s Gloves'}, -- Dark Skill +10
        Ring1 = {'Tamas Ring'}, -- INT +5
        Ring2 = {'Snow Ring'}, -- INT +4
        Back = {'Prism Cape'}, -- INT +3
        Waist = {'Swift Belt', 'Druid\'s Rope'}, -- Haste +4%
        Legs = {'Wizard\'s Tonban'}, -- Dark Skill +15
        Feet = {'Igqira Huaraches', 'Wizard\'s Sabots'}, -- Dark +4
    },

    SorcererTonban_Priority = {
        Legs = {'Sorcerer\'s Tonban'},
    },

    MND_Priority = { -- MND +45, Enfeebling +4
        Ammo = {'Hedgehog Bomb'},
        Neck = {'Holy Phial'}, -- MND +3
        Ear1 = {'Geist Earring'}, -- MND +1
        Ear2 = {'Geist Earring'}, -- MND +1
        Body = {'Errant Hpl.', 'Wonder Kaftan'}, -- MND +10
        Hands = {'Devotee\'s Mitts'}, -- MND +5
        Ring1 = {'Tamas Ring',}, -- MND +5
        Ring2 = {'Aqua Ring'}, -- MND +4
        Back = {'Prism Cape'}, -- MND +3
        Waist = {'Penitent\'s Rope', 'Druid\'s Rope'}, -- MND +1
        Legs = {'Errant Slops', 'Wonder Braccae'}, -- MND +7
        Feet = {'Errant Pigaches'}, -- MND +5
    },

    MNDStoneskin_Priority = { -- MND +54, Enfeebling +4
        Main = {'Mythic Wand +1'}, -- MND +9
        Ammo = {'Hedgehog Bomb'},
        Head = {'Nashira Turban'},
        Neck = {'Holy Phial'}, -- MND +3
        Ear1 = {'Geist Earring'}, -- MND +1
        Ear2 = {'Geist Earring'}, -- MND +1
        Body = {'Errant Hpl.', 'Wonder Kaftan'}, -- MND +10
        Hands = {'Devotee\'s Mitts'}, -- MND +5
        Ring1 = {'Tamas Ring',}, -- MND +5
        Ring2 = {'Aqua Ring'}, -- MND +4
        Back = {'Prism Cape'}, -- MND +3
        Waist = {'Penitent\'s Rope', 'Druid\'s Rope'}, -- MND +1
        Legs = {'Errant Slops', 'Wonder Braccae'}, -- MND +7
        Feet = {'Errant Pigaches'}, -- MND +5
    },

    MNDEnfeebling_Priority = { -- MND +24, Enfeebling +40
        Ammo = {'Hedgehog Bomb'},
        Head = {'Igqira Tiara'}, -- Enfeebling +10
        Neck = {'Enfeebling Torque', 'Holy Phial'}, -- Enfeebling +7
        Ear1 = {'Geist Earring'}, -- MND +1
        Ear2 = {'Geist Earring'}, -- MND +1
        Body = {'Wizard\'s Coat', 'Wonder Kaftan'}, -- Enfeebling +10
        Hands = {'Devotee\'s Mitts'}, -- MND +5
        Ring1 = {'Tamas Ring',}, -- MND +5
        Ring2 = {'Aqua Ring'}, -- MND +4
        Back = {'Prism Cape'}, -- MND +3
        Waist = {'Penitent\'s Rope', 'Druid\'s Rope'}, -- MND +1
        Legs = {'Igqira Lappas', 'Wonder Braccae'}, -- Enfeebling +10
        Feet = {'Errant Pigaches'}, -- MND +5
    },

    Diabolos_Priority = {
        Main = {'Diabolos\'s Pole', 'Pluto\'s Staff'},
    },

    Fire_Priority = {
        Main = {'Vulcan\'s Staff'},
    },

    Ice_Priority = {
        Main = {'Aquilo\'s Staff'},
    },

    Wind_Priority = {
        Main = {'Auster\'s Staff'},
    },

    Earth_Priority = {
        Main = {'Terra\'s Staff'},
    },

    Thunder_Priority = {
        Main = {'Jupiter\'s Staff'},
    },

    Water_Priority = {
        Main = {'Neptune\'s Staff'},
    },

    Light_Priority = {
        Main = {'Apollo\'s Staff'},
    },

    Dark_Priority = {
        Main = {'Pluto\'s Staff'},
    },

    StyleLock = {
        Main = 'Diabolos\'s Pole',
        Head = 'Demon Helm',
        Body = 'Igqira Weskit',
        Hands = 'Merman\'s Bangles',
        Legs = 'Igqira Lappas',
        Feet = 'Igqira Huaraches',
    },

    PetReadyDefault = {

    },

    PetAttack = {

    },

    Reward_Priority = { -- MND
        Ammo = {'Pet Fd. Epsilon', 'Pet Food Delta', 'Pet Food Beta', 'Pet Food Alpha'},
        Neck = {'Holy Phial'},
        Body = {'Wonder Kaftan'},
        Ring1 = {'San d\'Orian Ring'},
        Legs = {'Wonder Braccae'},
    },

    Charm_Priority = {
        Ammo = {''},
        Head = {''},
        Neck = {''},
        Ear1 = {''},
        Ear2 = {''},
        Body = {''},
        Hands = {'Wizard\'s Gloves'},
        Ring1 = {''},
        Ring2 = {''},
        Back = {'Trimmer\'s Mantle'},
        Waist = {''},
        Legs = {''},
        Feet = {''},
    },

    Sneak = {
        Hands = 'Dream Mittens +1',
    },

    Invisible = {
        Feet = 'Dream Boots +1',
    },
};

profile.Sets = sets;

local ObiTable = {
    --Fire = "Karin Obi",
    --Earth = "Dorin Obi",
    Water = "Suirin Obi",
    --Wind = "Furin Obi",
    Ice = "Hyorin Obi",
    Thunder = "Rairin Obi",
    Light = "Korin Obi",
    Dark = "Anrin Obi"
}

local ElementWeaknessTable = {
    Fire = "Water",
    Ice = "Fire",
    Wind = "Ice",
    Earth = "Wind",
    Thunder = "Earth",
    Water = "Thunder",
    Light = "Dark",
    Dark = "Light"
}

local hasteSpells = T{'Blink', 'Escape', 'Warp', 'Warp II', 'Silena', 'Blindna', 'Paralyna', 'Erase', 'Regen', 'Protect', 'Protectra', 'Protect II', 'Protectra II', 'Shell', 'Shellra', 'Shell II', 'Shellra II', 'Teleport-Dem', 'Teleport-Mea', 'Teleport-Holla'};
local elementalDots = T{'Burn', 'Choke', 'Shock', 'Drown', 'Rasp', 'Frost'};

local obiBonus = function(spellElement)
    local environment = gData.GetEnvironment();
    local dayElement = environment.DayElement;
    local weatherElement = environment.WeatherElement;
    local isDoubleWeather = string.find(environment.Weather, "x2");

    local bonus = 0;
    if (spellElement == dayElement) then
        bonus = bonus + 10;
    end

    if (spellElement == weatherElement) then
        if (isDoubleWeather) then
            bonus = bonus + 25;
        else
            bonus = bonus + 10;
        end
    end

    if (dayElement == ElementWeaknessTable[spellElement]) then
        bonus = bonus - 10;
    end

    if (weatherElement == ElementWeaknessTable[spellElement]) then
        if (isDoubleWeather) then
            bonus = bonus - 25;
        else
            bonus = bonus - 10;
        end
    end

    return bonus;
end

local equipObiIfApplicable = function(spellElement)
    local obiBonus = obiBonus(spellElement);
    if (obiBonus > 0) then
        print("Obi Bonus: " .. obiBonus .. "%");
        gFunc.Equip("waist", ObiTable[spellElement]);
    end
end

local function HandlePetAction(PetAction)
    gFunc.EquipSet(sets.PetReadyDefault);
end

profile.OnLoad = function()
    draginclude.OnLoad(sets, {'NoStaffSwap', 'StaffSwap'}, {'None', 'Field'});

    AshitaCore:GetChatManager():QueueCommand(-1,'/alias /mdt /lac fwd MDT ');
    AshitaCore:GetChatManager():QueueCommand(-1,'/alias /mb /lac fwd MagicBurst ');
    AshitaCore:GetChatManager():QueueCommand(-1,'/alias /enmity /lac fwd Enmity ');
end

profile.OnUnload = function()
    draginclude.OnUnload();
end

profile.HandleCommand = function(args)
    if (args[1] == 'MagicBurst') then
        Settings.MagicBurst = not Settings.MagicBurst;

        if Settings.MagicBurst then
            gFunc.Message('MagicBurst ON');
        else
            gFunc.Message('MagicBurst OFF');
        end
    elseif (args[1] == 'MDT') then
        Settings.MDT = not Settings.MDT;

        if Settings.MDT then
            gFunc.Message('MDT ON');
        else
            gFunc.Message('MDT OFF');
        end
    elseif (args[1] == 'Enmity') then
        Settings.Enmity = not Settings.Enmity;

        if Settings.Enmity then
            gFunc.Message('Enmity ON');
        else
            gFunc.Message('Enmity OFF');
        end
    elseif (args[1] == 'haste') then
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma "Haste" <stpc>');
    elseif (args[1] == 'refresh') then
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma "Refresh" <stpc>');
    elseif (args[1] == 'regen') then
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma "Regen" <stpc>');
    elseif (args[1] == 'regen2') then
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma "Regen II" <stpc>');
    elseif (args[1] == 'regen3') then
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma "Regen III" <stpc>');
    elseif (args[1] == 'cure5') then
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma "Cure V" <stpc>');
    elseif (args[1] == 'gravity') then
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma "Gravity" <stnpc>');
    elseif (args[1] == 'stoneskin') then
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma "Stoneskin" <me>');
    elseif (args[1] == 'silence') then
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma "Silence" <stnpc>');
    elseif (args[1] == 'drain') then
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma "Drain" <stnpc>');
    elseif (args[1] == 'aspir') then
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma "Aspir" <stnpc>');
    elseif (args[1] == 'bind') then
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma "Bind" <stnpc>');
    elseif (args[1] == 'sleepga') then
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma "Sleepga" <stnpc>');
    elseif (args[1] == 'sleepga2') then
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma "Sleepga II" <stnpc>');
    elseif (args[1] == 'sleep') then
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma "Sleep" <stnpc>');
    elseif (args[1] == 'sleep2') then
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma "Sleep II" <stnpc>');
    elseif (args[1] == 'paralyze') then
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma "Paralyze" <stnpc>');
    elseif (args[1] == 'slow') then
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma "Slow" <stnpc>');
    elseif (args[1] == 'icespikes') then
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma "Ice Spikes" <me>');
    elseif (args[1] == 'blazespikes') then
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma "Blaze Spikes" <me>');
    elseif (args[1] == 'shockspikes') then
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma "Shock Spikes" <me>');
    elseif (args[1] == 'phalanx') then
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma "Phalanx" <me>');
    elseif (args[1] == 'blink') then
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma "Blink" <me>');
    elseif (args[1] == 'enspell') then
        local environment = gData.GetEnvironment();
        local dayElement = environment.DayElement;
        local weatherElement = environment.WeatherElement;
        local isDoubleWeather = string.find(environment.Weather, "x2");
        local spellName = 'Enblizzard';

        if isDoubleWeather or dayElement == 'Light' or dayElement == 'Dark' then
            if weatherElement == 'Wind' then
                spellName = 'Enaero';
            elseif weatherElement == 'Ice' then
                spellName = 'Enblizzard';
            elseif weatherElement == 'Fire' then
                spellName = 'Enfire';
            elseif weatherElement == 'Earth' then
                spellName = 'Enstone';
            elseif weatherElement == 'Thunder' then
                spellName = 'Enthunder';
            elseif weatherElement == 'Water' then
                spellName = 'Enwater';
            end
        else
            if dayElement == 'Wind' then
                spellName = 'Enaero';
            elseif dayElement == 'Ice' then
                spellName = 'Enblizzard';
            elseif dayElement == 'Fire' then
                spellName = 'Enfire';
            elseif dayElement == 'Earth' then
                spellName = 'Enstone';
            elseif dayElement == 'Thunder' then
                spellName = 'Enthunder';
            elseif dayElement == 'Water' then
                spellName = 'Enwater';
            end
        end
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma ' .. spellName .. ' <me>');
    end

    draginclude.HandleCommand(args, sets);
    draginclude.HandleBstCoreCommands(args, nil);
end

profile.LateInitialize = function()
    local timestamp = os.time();
    local player = gData.GetPlayer();

    if timestamp >= Settings.LateInitialized.TimeToUse then
        -- Setting a Style Lock prevents the character from blinking
        gFunc.LockStyle(sets.StyleLock);

        --[[ Set your job macro defaults here]]
        if player.SubJob == 'BST' then
            AshitaCore:GetChatManager():QueueCommand(1, '/macro book 6');
            AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1');

            -- BST Core Commands
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 1 /lac fwd PetAtk ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 2 /lac fwd Charm ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 3 /lac fwd CallBeast ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 4 /lac fwd PetSTA ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 5 /lac fwd PetAOE ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 6 /lac fwd PetSpec ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 8 /lac fwd Stay ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 9 /lac fwd Heel ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 0 /lac fwd Reward ');
        else
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 3 /lac fwd regen ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 4 /lac fwd gravity ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind +4 /lac fwd shockspikes ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 5 /lac fwd stoneskin ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind +5 /lac fwd phalanx ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 6 /lac fwd silence ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind +6 /lac fwd blink ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 7 /lac fwd drain ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 8 /lac fwd aspir ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 9 /lac fwd sleepga ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind +9 /lac fwd sleepga2 ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 0 /lac fwd sleep ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind +0 /lac fwd sleep2 ');

            AshitaCore:GetChatManager():QueueCommand(1, '/macro book 1');
            AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1');
        end

        Settings.LateInitialized.Initialized = true;
        gFunc.Message('LateInitialized');
    end
end

profile.HandleDefault = function()
    local timestamp = os.time();
    local pet = gData.GetPet();
    local petAction = gData.GetPetAction();
    local player = gData.GetPlayer();
    local party = AshitaCore:GetMemoryManager():GetParty();
    local myLevel = AshitaCore:GetMemoryManager():GetPlayer():GetMainJobLevel();

    -- Determining current level for Priority EquipSet purposes
    if (myLevel ~= Settings.CurrentLevel) then
        gFunc.EvaluateLevels(profile.Sets, myLevel);
        Settings.CurrentLevel = myLevel;
    end

    -- Delayed Initialization for things like Style Locking
    if Settings.LateInitialized.Initialized == false then
        if Settings.LateInitialized.TimeToUse == 0 then
            Settings.LateInitialized.TimeToUse = timestamp + 11;
        else
            profile.LateInitialize();
        end
    end

    -- Forward slash toggle between Default and Evasion
    if draginclude.dragSettings.TpVariant == 1 then

        gFunc.EquipSet(sets.Default);
        
        -- Engaged Section
        if player.Status == 'Engaged' then
            gFunc.EquipSet(sets.MeleeEngaged);
        -- Resting Section
        elseif (player.Status == 'Resting') then
            gFunc.EquipSet(sets.RestingMP);
        -- Idle Section
        else
            if player.Status ~= 'Engaged' and Settings.CurrentLevel >= 68 then
                gFunc.EquipSet(sets.BlackCloak);
            end
        end

    elseif draginclude.dragSettings.TpVariant == 2 then --Use default set
        gFunc.EquipSet(sets.Default);
        
        -- Engaged Section
        if player.Status == 'Engaged' then
            gFunc.EquipSet(sets.MeleeEngaged);
        -- Resting Section
        elseif (player.Status == 'Resting') then
            gFunc.EquipSet(sets.Dark);
            gFunc.EquipSet(sets.RestingMP);
        -- Idle Section
        else
            if player.Status ~= 'Engaged' and Settings.CurrentLevel >= 68 then
                gFunc.EquipSet(sets.BlackCloak);
            end
            
            gFunc.EquipSet(sets.Earth);
        end
    end

    if (pet ~= nil) then
        if (petAction ~= nil) then
            HandlePetAction(petAction);
            return;
        end
    end

    draginclude.HandleDefault();
    draginclude.CheckSkillingVariant();
end

profile.HandleAbility = function()
    local pet = gData.GetPet();
    local ability = gData.GetAction();

    if string.match(ability.Name, 'Reward') then
        gFunc.EquipSet(sets.Reward);
    elseif string.match(ability.Name, 'Charm') then
        gFunc.EquipSet(sets.Charm);
    end
end

profile.HandleItem = function()
    local item = gData.GetAction();
end

profile.HandlePrecast = function()
    local player = gData.GetPlayer();
    local action = gData.GetAction();
    local target = gData.GetActionTarget();
    local castTime = action.CastTime;
    local minimumBuffer = 0.4; -- Can be lowered to 0.1 if you want
    local packetDelay = 0.4; -- Change this to 0.4 if you do not use PacketFlow
    local castDelay = ((castTime * (1 - Settings.FastCastValue)) / 1000) - minimumBuffer;

    gFunc.EquipSet(sets.FastCast);

    if player.SubJob == 'RDM' then
        gFunc.EquipSet(sets.FastCastRDM);

        castDelay = ((castTime * (1 - Settings.FastCastValueRDM)) / 1000) - minimumBuffer;
    end

    if action.Skill == 'Elemental Magic' and not elementalDots:contains(action.Name) and (castDelay >= packetDelay) then
        gFunc.Message('Equipping Interim ' .. castDelay);
        gFunc.SetMidDelay(castDelay);
    end
end


profile.HandleMidcast = function()
    local spell = gData.GetAction();
    local player = gData.GetPlayer();
    local target = gData.GetActionTarget();
    local environment = gData.GetEnvironment();
    local dayElement = environment.DayElement;
    local weatherElement = environment.WeatherElement;

    if spell.Skill == 'Elemental Magic' and not elementalDots:contains(spell.Name) then
        draginclude.SetupInterimEquipSet(sets.HPDown); -- HP Down
    end

    if draginclude.dragSettings.TpVariant == 1 then
        -- Don't swap weapons
    elseif draginclude.dragSettings.TpVariant == 2 then
        if spell.Element == 'Fire' then
            gFunc.EquipSet(sets.Fire);
        elseif spell.Element == 'Ice' then
            gFunc.EquipSet(sets.Ice);
        elseif spell.Element == 'Wind' then
            gFunc.EquipSet(sets.Wind);
        elseif spell.Element == 'Earth' then
            gFunc.EquipSet(sets.Earth);
        elseif spell.Element == 'Thunder' then
            gFunc.EquipSet(sets.Thunder);
        elseif spell.Element == 'Water' then
            gFunc.EquipSet(sets.Water);
        elseif spell.Element == 'Light' then
            gFunc.EquipSet(sets.Light);
        elseif spell.Element == 'Dark' then
            gFunc.EquipSet(sets.Dark);
        end
    end    

    if spell.Name == 'Invisible' then
        gFunc.EquipSet(sets.Invisible);
    elseif spell.Name == 'Sneak' then
        gFunc.EquipSet(sets.Sneak);
    elseif hasteSpells:contains(spell.Name) then
        gFunc.EquipSet(sets.SpellHaste);
    elseif elementalDots:contains(spell.Name) then
        gFunc.EquipSet(sets.INTElementalDot);
    elseif spell.Type == 'White Magic' then
        if spell.Skill == 'Enfeebling Magic' then
            gFunc.EquipSet(sets.MNDEnfeebling);
        elseif spell.Name == 'Stoneskin' then
            gFunc.EquipSet(sets.MNDStoneskin);
        else
            gFunc.EquipSet(sets.MND);  
        end
        
        equipObiIfApplicable(spell.Element);
    elseif spell.Type == 'Black Magic' then
        if spell.Skill == 'Elemental Magic' then
            gFunc.EquipSet(sets.INTElemental);

            if Settings.Enmity then
                gFunc.EquipSet(sets.Enmity);
            end

            if Settings.MagicBurst then
                gFunc.EquipSet(sets.MagicBurst);
            end

            if spell.Element == dayElement then
                gFunc.EquipSet(sets.SorcererTonban);
            end
        elseif spell.Skill == 'Enfeebling Magic' then
            gFunc.EquipSet(sets.INTEnfeebling);
        elseif spell.Skill == 'Dark Magic' then
            gFunc.EquipSet(sets.INTDark);

            if spell.Name == 'Stun' then
                gFunc.EquipSet(sets.Stun);
            end

            if draginclude.dragSettings.TpVariant == 2 and (spell.Name == 'Drain' or spell.Name == 'Aspir') and weatherElement == 'Dark' then
                gFunc.EquipSet(sets.Diabolos);
            end
        else
            gFunc.EquipSet(sets.INT);
        end
        
        equipObiIfApplicable(spell.Element);
    end
end

profile.HandlePreshot = function()
    local player = gData.GetPlayer();
end

profile.HandleMidshot = function()
    local player = gData.GetPlayer();
end

profile.HandleWeaponskill = function()
    local action = gData.GetAction();

    draginclude.HandleWeaponSkill(action);
end

return profile;