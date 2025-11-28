local profile = {};
draginclude = gFunc.LoadFile('common\\draginclude.lua');

local Settings = {
    LateInitialized = {
        Initialized = false,
        TimeToUse = 0,
    },
    StatusArmorSwaps = {

    },
    CurrentLevel = 0,
    CutHP = false,
};

local sets = {
    Default_Priority = {
        Ammo = {'Hedgehog Bomb', 'Phtm. Tathlum', 'Fortune Egg'},
        Head = {'Summoner\'s Horn', 'Evoker\'s Horn', 'Shep. Bonnet', 'Dream Hat +1'},
        Neck = {'Uggalepih Pendant'},
        Ear1 = {'Novia Earring', 'Phantom Earring', 'Dodge Earring'},
        Ear2 = {'Loquac. Earring', 'Geist Earring'},
        Body = {'Yinyang Robe', 'Elder\'s Surcoat', 'Seer\'s Tunic', 'Dream Robe +1'},
        Hands = {'Zenith Mitts', 'Elder\'s Bracers', 'Carbuncle Mitts'},
        Ring1 = {'Evoker\'s Ring', 'Astral Ring'},
        Ring2 = {'Ether Ring', 'Astral Ring'},
        Back = {'Astute Cape', 'Trimmer\'s Mantle'},
        Waist = {'Hierarch Belt', 'Friar\'s Rope'},
        Legs = {'Zenith Slacks', 'Elder\'s Braguette', 'Baron\'s Slops', 'Dream Trousers +1'},
        Feet = {'Rostrum Pumps', 'Elder\'s Sandals', 'Dream Boots +1'},
    },

    AvatarEngaged_Priority = { -- Perp Down + Pet Accuracy
        Ammo = {'Hedgehog Bomb'},
        Head = {'Shep. Bonnet'}, -- Pet Acc
        Ear2 = {'Beastly Earring'}, -- Pet Acc
        Body = {'Yinyang Robe', 'Austere Robe'}, -- Perp Down
        Ring1 = {'Evoker\'s Ring'}, -- Perp Down
        Legs = {'Evoker\'s Spats'}, -- Pet Acc
        Feet = {'Evk. Pigaches +1'} -- Perp Down, Pet Eva
    },

    AvatarEngagedCarby_Priority = { -- Perp Down + Pet Accuracy
        Ammo = {'Hedgehog Bomb'},
        Head = {'Shep. Bonnet'}, -- Pet Acc
        Ear2 = {'Beastly Earring'}, -- Pet Acc
        Body = {'Yinyang Robe', 'Austere Robe'}, -- Perp Down
        Ring1 = {'Evoker\'s Ring'}, -- Perp Down
        Legs = {'Evoker\'s Spats'}, -- Pet Acc
        Feet = {'Summoner\'s Pgch.'} -- Pet Eva
    },

    MeleeEngagedAvatar_Priority = { -- 7% Haste + Support
        Ammo = {'Tiphia Sting'},
        Head = {'Nashira Turban'}, -- 2%
        Neck = {'Temp. Torque'},
        Ear1 = {'Novia Earring'},
        Ear2 = {'Beastly Earring'},
        Body = {'Nashira Manteel'}, -- 3%
        Hands = {'Summoner\'s Brcr.'},
        Ring1 = {'Evoker\'s Ring'},
        Ring2 = {'Toreador\'s Ring'},
        Waist = {'Swift Belt'}, -- +4
        Legs = {'Nashira Seraweels'}, -- 2%
        Feet = {'Summoner\'s Pgch.'},
    },

    MeleeEngaged_Priority = { -- 7% Haste + Support
        Ammo = {'Tiphia Sting'},
        Head = {'Nashira Turban'}, -- 2%
        Neck = {'Temp. Torque'},
        Ear1 = {'Novia Earring'},
        Ear2 = {'Beastly Earring'},
        Body = {'Nashira Manteel'}, -- 3%
        Ring2 = {'Toreador\'s Ring'},
        Waist = {'Swift Belt'}, -- 4%
        Legs = {'Nashira Seraweels'}, -- 2%
    },

    BPDelay_Priority = {
        Head = {'Summoner\'s Horn'}, -- -3
        Body = {'Yinyang Robe', 'Austere Robe'}, -- -5
        Hands = {'Summoner\'s Brcr.'}, -- -2
        Legs = {'Summoner\'s Spats'}, -- -2
        Feet = {'Summoner\'s Pgch.'}, -- -2
    },

    PetAccBP_Priority = { -- Summoning Skill +43, Pet Accuracy
        Head = {'Evoker\'s Horn', 'Shep. Bonnet'}, -- +5
        Neck = {'Smn. Torque'}, -- +7
        Ear2 = {'Beastly Earring'}, -- Pet Accuracy+
        Body = {'Summoner\'s Doublet'}, -- Pet Crit Rate+
        Hands = {'Summoner\'s Brcr.'}, -- +10, Pet Accuracy+
        Ring1 = {'Evoker\'s Ring'}, -- +10
        Back = {'Astute Cape'}, -- +5
        Legs = {'Austere Slops'}, -- +3
        Feet = {'Austere Sabots'} -- +3
    };

    PetMAcc_Priority = { -- Summoning Skill +43, Pet Magic Accuracy
        Head = {'Evoker\'s Horn', 'Shep. Bonnet'}, -- +5
        Neck = {'Smn. Torque'}, -- +7
        Hands = {'Summoner\'s Brcr.'}, -- +10, Pet Accuracy+
        Ring1 = {'Evoker\'s Ring'}, -- +10
        Back = {'Astute Cape'}, -- +5
        Legs = {'Austere Slops'}, -- +3
        Feet = {'Austere Sabots'} -- +3
    };

    SummonSkill_Priority = { -- Summoning Skill +43
        Head = {'Evoker\'s Horn'}, -- +5
        Neck = {'Smn. Torque'}, -- +7
        Hands = {'Summoner\'s Brcr.'}, -- +10
        Ring1 = {'Evoker\'s Ring'}, -- +10
        Back = {'Astute Cape'}, -- +5
        Legs = {'Austere Slops'}, -- +3
        Feet = {'Austere Sabots'} -- +3
    };

    PetMAB_Priority = {-- Summoning Skill +43, Pet Magic Accuracy
        Head = {'Evoker\'s Horn', 'Shep. Bonnet'}, -- +5
        Neck = {'Smn. Torque'}, -- +7
        Hands = {'Summoner\'s Brcr.'}, -- +10, Pet Accuracy+
        Ring1 = {'Evoker\'s Ring'}, -- +10
        Back = {'Astute Cape'}, -- +5
        Legs = {'Austere Slops'}, -- +3
        Feet = {'Austere Sabots'} -- +3
    },

    WeaponSkillSpiritTaker_Priority = { -- INT +42, MND +23, Acc -5
        Ammo = {'Phtm. Tathlum'}, -- INT +2
        Head = {'Summoner\'s Horn'}, -- INT +3
        Neck = {'Temp. Torque'}, -- Staff Skill +7
        Ear1 = {'Phantom Earring'}, -- INT +1
        Ear2 = {'Brutal Earring'}, -- DA +1%
        Body = {'Errant Hpl.'}, -- INT +10, MND +10, DEX -7
        Hands = {'Errant Cuffs'}, -- INT +5
        Ring1 = {'Diamond Ring'}, -- INT +4
        Ring2 = {'Diamond Ring'}, -- INT +4
        Back = {'Rainbow Cape'}, -- INT +3, MND +3
        Legs = {'Errant Slops'}, -- INT +7, MND +7, DEX -5
        Feet = {'Rostrum Pumps'}, -- INT +3, MND +3
    },

    CutHP_Priority = { -- INT +42, MND +23, Acc -5
        Ammo = {'Happy Egg'}, -- INT +2
        Head = {'Nashira Turban'}, -- INT +3
        Neck = {'Temp. Torque'}, -- Staff Skill +7
        Ear1 = {'Beastly Earring'}, -- INT +1
        Ear2 = {'Brutal Earring'}, -- DA +1%
        Body = {'Errant Hpl.'}, -- INT +10, MND +10, DEX -7
        Hands = {'Errant Cuffs'}, -- INT +5
        Ring1 = {'Diamond Ring'}, -- INT +4
        Ring2 = {'Diamond Ring'}, -- INT +4
        Back = {'Rainbow Cape'}, -- INT +3, MND +3
        Waist = {'Swift Belt'},
        Legs = {'Errant Slops'}, -- INT +7, MND +7, DEX -5
        Feet = {'Austere Sabots'}, -- INT +3, MND +3
    },

    IdleTown_Priority = {
        Head = {'Nashira Turban'},
        Ear1 = {'Novia Earring'},
        Body = {'Yinyang Robe'},
        Hands = {'Zenith Mitts'},
        Ring1 = {'Evoker\'s Ring'},
        Legs = {'Nashira Seraweels'},
        Feet = {'Rostrum Pumps'}
    },

    StyleLock = {
        Main = 'Wind Staff',
        Head = 'Zenith Crown',
        Body = 'Nashira Manteel',
        Hands = 'Zenith Mitts',
        Legs = 'Zenith Slacks',
        Feet = 'Rostrum Pumps',
    },

    StyleLock2 = {
        Head = 'Summoner\'s Horn',
        Body = 'Goblin Suit',
        --Body = 'Eerie Cloak',
        --Body = 'Errant Hpl.',
        --Hands = 'Zenith Mitts',
        --Legs = 'Austere Slops',
        --Feet = 'Austere Sabots',
    },

    StyleLock3 = {
        Main = 'Mercurial Pole',
        Head = 'Nashira Turban',
        Body = 'Yinyang Robe',
        Hands = 'Summoner\'s Brcr.',
        Legs = 'Nashira Seraweels',
        Feet = 'Rostrum Pumps',
    },

    StyleLockHydra = {
        Main = 'Fire Staff',
        Head = 'Hydra Cap',
        Body = 'Hydra Jupon',
        Hands = 'Summoner\'s Brcr.',
        Legs = 'Hydra Hose',
        Feet = 'Hydra Boots',
    },

    StyleLockSummer = {
        Head = 'Shep. Bonnet',
        Body = 'Elder Gilet +1',
        --Hands = 'Scp. Gauntlets',
        Legs = 'Elder Trunks',
        --Feet = 'Homam Gambieras',
    },

    HMP_Priority = {
        Ear1 = {'Relaxing Earring'},
        Body = {'Errant Hpl.'},
        Waist = {'Hierarch Belt'},
    },

    ConjurersRing_Priority = {
        --Ring2 = {'Conjurer\'s Ring'}
    },

    Doublet_Priority = {
        Body = {'Summoner\'s Dblt.'},
    },

    Horn_Priority = {
        Head = {'Summoner\'s Horn'},
    },

    Fire_Priority = {
        Main = {'Fire Staff'},
    },

    Ice_Priority = {
        Main = {'Ice Staff'},
    },

    Wind_Priority = {
        Main = {'Wind Staff'},
    },

    Earth_Priority = {
        Main = {'Earth Staff'},
    },

    Thunder_Priority = {
        Main = {'Thunder Staff'},
    },

    Water_Priority = {
        Main = {'Water Staff'},
    },

    Light_Priority = {
        Main = {'Light Staff'},
    },

    Dark_Priority = {
        Main = {'Dark Staff'},
    },

    EXPRing = {
        Ring1 = 'Chariot Band',
    },

    Warp = {
        Main = 'Warp Cudgel',
    },

    Sneak_Priority = {
        Feet = {'Dream Boots +1'},
    },

    Invisible_Priority = {
        Hands = {'Dream Mittens +1'},
    },

    -- MND +39 (111 Total): Enhancing Magic Skill + 3×MND - 190 --> 112 + 3*111 - 190 = 255 (350 cap) Every MND is 3 points
    Stoneskin_Priority = {
        --Main = {'Water Staff'}, -- MND +4
        Head = {'Zenith Crown'}, -- MND +3
        Neck = {'Enhancing Torque'}, -- Enhancing +7
        Ear1 = {'Novia Earring'},
        Ear2 = {'Loquac. Earring'},
        Body = {'Errant Hpl.'}, -- MND +10
        Hands = {'Devotee\'s Mitts'}, -- MND +5 
        Ring2 = {'Sapphire Ring'}, -- MND +4
        Back = {'Rainbow Cape'}, -- MND +3
        Legs = {'Errant Slops'}, -- MND +7
        Feet = {'Rostrum Pumps'}, -- MND +3
    },

    -- MND +39, Enfeebling +7
    EnfeeblingMND_Priority = {
        --Main = {'Water Staff'}, -- MND +4
        Head = {'Zenith Crown'}, -- MND +3
        Neck = {'Enfeebling Torque'}, -- Enfeebling +7
        Ear1 = {'Novia Earring'},
        Ear2 = {'Loquac. Earring'},
        Body = {'Errant Hpl.'}, -- MND +10
        Hands = {'Devotee\'s Mitts'}, -- MND +5 
        Ring2 = {'Sapphire Ring'}, -- MND +4
        Back = {'Rainbow Cape'}, -- MND +3
        Legs = {'Errant Slops'}, -- MND +7
        Feet = {'Rostrum Pumps'}, -- MND +3
    },

    -- MND +39, Enfeebling +7
    EnfeeblingINT_Priority = {
        --Main = {'Water Staff'}, -- MND +4
        Head = {'Zenith Crown'}, -- INT +3
        Neck = {'Enfeebling Torque'}, -- Enfeebling +7
        Ear1 = {'Novia Earring'},
        Ear2 = {'Phantom Earring'}, -- INT +1
        Body = {'Errant Hpl.'}, -- INT +10
        Hands = {'Errant Cuffs'}, -- INT +5 
        Ring2 = {'Diamond Ring'}, -- INT +4
        Ring2 = {'Diamond Ring'}, -- INT +4
        Back = {'Rainbow Cape'}, -- INT +3
        Legs = {'Errant Slops'}, -- INT +7
        Feet = {'Rostrum Pumps'}, -- INT +3
    },
};

profile.Sets = sets;

local SmnConfig = {
    Summons = {
        Carbuncle = { -- Free
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
        Ifrit = { --8/tick
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
        Titan = { --8/tick
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
        Leviathan = { --8/tick
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
        Garuda = { --8/tick
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
        Shiva = { --8/tick
            Name = 'Shiva',
            Rage1 = 'Axe Kick',
            Rage2 = 'Double Slap',
            Rage3 = 'Rush',
            Rage4 = '',
            AstralFlow = 'Diamond Dust',
            Ward1 = 'Frost Armor',
            Ward2 = 'Sleepga',
            Ward3 = '',
            Ward4 = '',
            Nuke = 'Blizzard IV',
        },
        Ramuh = { --8/tick
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
        Fenrir = { --7/tick
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
        Diabolos = { --8/tick
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
    },
};

local ObiTable = {
    Fire = "Karin Obi",
    Earth = "Dorin Obi",
    Water = "Suirin Obi",
    Wind = "Furin Obi",
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

local function HandleSmnCoreCommands(args)
    local pet = gData.GetPet();
    local target = gData.GetTarget();
    local targetText = ''

    if target ~= nil and target.Type == 'Monster' then
        targetText = 't' -- use <t> when we're targeting something
    else
        targetText = 'bt' -- use <bt> when we're not targeting something
    end

    if (args[1] == 'PetAtk') then
        AshitaCore:GetChatManager():QueueCommand(1, '/pet "Assault" <' .. targetText .. '>');
    elseif (args[1] == 'Rage1') then

        if pet.Name == 'Carbuncle' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Carbuncle.Rage1 .. '" <' .. targetText .. '>');
        elseif pet.Name == 'Titan' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Titan.Rage1 .. '" <' .. targetText .. '>');
        elseif pet.Name == 'Garuda' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Garuda.Rage1 .. '" <' .. targetText .. '>');
        elseif pet.Name == 'Ifrit' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Ifrit.Rage1 .. '" <' .. targetText .. '>');
        elseif pet.Name == 'Leviathan' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Leviathan.Rage1 .. '" <' .. targetText .. '>');
        elseif pet.Name == 'Shiva' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Shiva.Rage1 .. '" <' .. targetText .. '>');
        elseif pet.Name == 'Ramuh' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Ramuh.Rage1 .. '" <' .. targetText .. '>');
        elseif pet.Name == 'Fenrir' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Fenrir.Rage1 .. '" <' .. targetText .. '>');
        elseif pet.Name == 'Diabolos' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Diabolos.Rage1 .. '" <' .. targetText .. '>');
        end

    elseif (args[1] == 'Rage2') then

        if pet.Name == 'Carbuncle' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Carbuncle.Rage2 .. '" <' .. targetText .. '>');
        elseif pet.Name == 'Titan' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Titan.Rage2 .. '" <' .. targetText .. '>');
        elseif pet.Name == 'Garuda' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Garuda.Rage2 .. '" <' .. targetText .. '>');
        elseif pet.Name == 'Ifrit' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Ifrit.Rage2 .. '" <' .. targetText .. '>');
        elseif pet.Name == 'Leviathan' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Leviathan.Rage2 .. '" <' .. targetText .. '>');
        elseif pet.Name == 'Shiva' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Shiva.Rage2 .. '" <' .. targetText .. '>');
        elseif pet.Name == 'Ramuh' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Ramuh.Rage2 .. '" <' .. targetText .. '>');
        elseif pet.Name == 'Fenrir' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Fenrir.Rage2 .. '" <' .. targetText .. '>');
        elseif pet.Name == 'Diabolos' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Diabolos.Rage2 .. '" <' .. targetText .. '>');
        end

    elseif (args[1] == 'AstralFlow') then

        if pet.Name == 'Carbuncle' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Carbuncle.AstralFlow .. '" <' .. targetText .. '>');
        elseif pet.Name == 'Titan' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Titan.AstralFlow .. '" <' .. targetText .. '>');
        elseif pet.Name == 'Garuda' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Garuda.AstralFlow .. '" <' .. targetText .. '>');
        elseif pet.Name == 'Ifrit' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Ifrit.AstralFlow .. '" <' .. targetText .. '>');
        elseif pet.Name == 'Leviathan' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Leviathan.AstralFlow .. '" <' .. targetText .. '>');
        elseif pet.Name == 'Shiva' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Shiva.AstralFlow .. '" <' .. targetText .. '>');
        elseif pet.Name == 'Ramuh' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Ramuh.AstralFlow .. '" <' .. targetText .. '>');
        elseif pet.Name == 'Fenrir' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Fenrir.AstralFlow .. '" <' .. targetText .. '>');
        elseif pet.Name == 'Diabolos' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Diabolos.AstralFlow .. '" <' .. targetText .. '>');
        end

    elseif (args[1] == 'Ward1') then

        if pet.Name == 'Carbuncle' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Carbuncle.Ward1 .. '" <stpc>');
        elseif pet.Name == 'Titan' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Titan.Ward1 .. '" <stpc>');
        elseif pet.Name == 'Garuda' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Garuda.Ward1 .. '" <stpc>');
        elseif pet.Name == 'Ifrit' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Ifrit.Ward1 .. '" <stpc>');
        elseif pet.Name == 'Leviathan' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Leviathan.Ward1 .. '" <stpc>');
        elseif pet.Name == 'Shiva' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Shiva.Ward1 .. '" <stpc>');
        elseif pet.Name == 'Ramuh' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Ramuh.Ward1 .. '" <stpc>');
        elseif pet.Name == 'Fenrir' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Fenrir.Ward1 .. '" <stnpc>');
        elseif pet.Name == 'Diabolos' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Diabolos.Ward1 .. '" <stpc>');
        end

    elseif (args[1] == 'Ward2') then

        if pet.Name == 'Carbuncle' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Carbuncle.Ward2 .. '" <stpc>');
        elseif pet.Name == 'Titan' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Titan.Ward2 .. '" <stpc>');
        elseif pet.Name == 'Garuda' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Garuda.Ward2 .. '" <stpc>');
        elseif pet.Name == 'Ifrit' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Ifrit.Ward2 .. '" <stpc>');
        elseif pet.Name == 'Leviathan' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Leviathan.Ward2 .. '" <me>');
        elseif pet.Name == 'Shiva' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Shiva.Ward2 .. '" <stnpc>');
        elseif pet.Name == 'Ramuh' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Ramuh.Ward2 .. '" <stpc>');
        elseif pet.Name == 'Fenrir' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Fenrir.Ward2 .. '" <stpc>');
        elseif pet.Name == 'Diabolos' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Diabolos.Ward2 .. '" <me>');
        end

    elseif (args[1] == 'Ward3') then

        if pet.Name == 'Carbuncle' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Carbuncle.Ward3 .. '" <stpc>');
        elseif pet.Name == 'Titan' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Titan.Ward3 .. '" <me>');
        elseif pet.Name == 'Garuda' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Garuda.Ward3 .. '" <stpc>');
        elseif pet.Name == 'Ifrit' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Ifrit.Ward3 .. '" <me>');
        elseif pet.Name == 'Leviathan' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Leviathan.Ward3 .. '" <me>');
        elseif pet.Name == 'Shiva' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Shiva.Ward3 .. '" <me>');
        elseif pet.Name == 'Ramuh' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Ramuh.Ward3 .. '" <me>');
        elseif pet.Name == 'Fenrir' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Fenrir.Ward3 .. '" <me>');
        elseif pet.Name == 'Diabolos' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Diabolos.Ward3 .. '" <' .. targetText .. '>');
        end

    elseif (args[1] == 'Rage3') then

        if pet.Name == 'Carbuncle' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Carbuncle.Rage3 .. '" <' .. targetText .. '>');
        elseif pet.Name == 'Titan' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Titan.Rage3 .. '" <' .. targetText .. '>');
        elseif pet.Name == 'Garuda' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Garuda.Rage3 .. '" <' .. targetText .. '>');
        elseif pet.Name == 'Ifrit' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Ifrit.Rage3 .. '" <' .. targetText .. '>');
        elseif pet.Name == 'Leviathan' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Leviathan.Rage3 .. '" <' .. targetText .. '>');
        elseif pet.Name == 'Shiva' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Shiva.Rage3 .. '" <' .. targetText .. '>');
        elseif pet.Name == 'Ramuh' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Ramuh.Rage3 .. '" <' .. targetText .. '>');
        elseif pet.Name == 'Fenrir' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Fenrir.Rage3 .. '" <' .. targetText .. '>');
        elseif pet.Name == 'Diabolos' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Fenrir.Rage3 .. '" <' .. targetText .. '>');
        end

    elseif (args[1] == 'Rage4') then

        if pet.Name == 'Carbuncle' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Carbuncle.Rage4 .. '" <' .. targetText .. '>');
        elseif pet.Name == 'Titan' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Titan.Rage4 .. '" <' .. targetText .. '>');
        elseif pet.Name == 'Garuda' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Garuda.Rage4 .. '" <' .. targetText .. '>');
        elseif pet.Name == 'Ifrit' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Ifrit.Rage4 .. '" <' .. targetText .. '>');
        elseif pet.Name == 'Leviathan' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Leviathan.Rage4 .. '" <' .. targetText .. '>');
        elseif pet.Name == 'Shiva' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Shiva.Rage4 .. '" <' .. targetText .. '>');
        elseif pet.Name == 'Ramuh' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Ramuh.Rage4 .. '" <' .. targetText .. '>');
        elseif pet.Name == 'Fenrir' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Fenrir.Rage4 .. '" <' .. targetText .. '>');
        elseif pet.Name == 'Diabolos' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Fenrir.Rage4 .. '" <' .. targetText .. '>');
        end

    elseif (args[1] == 'Ward4') then

        if pet.Name == 'Carbuncle' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Carbuncle.Ward4 .. '" <stpc>');
        elseif pet.Name == 'Titan' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Titan.Ward4 .. '" <me>');
        elseif pet.Name == 'Garuda' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Garuda.Ward4 .. '" <stpc>');
        elseif pet.Name == 'Ifrit' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Ifrit.Ward4 .. '" <me>');
        elseif pet.Name == 'Leviathan' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Leviathan.Ward4 .. '" <me>');
        elseif pet.Name == 'Shiva' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Shiva.Ward4 .. '" <me>');
        elseif pet.Name == 'Ramuh' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Ramuh.Ward4 .. '" <me>');
        elseif pet.Name == 'Fenrir' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Fenrir.Ward4 .. '" <me>');
        elseif pet.Name == 'Diabolos' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Diabolos.Ward4 .. '" <stnpc>');
        end

    elseif (args[1] == 'Nuke') then

        if pet.Name == 'Carbuncle' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Carbuncle.Nuke .. '" <' .. targetText .. '>');
        elseif pet.Name == 'Titan' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Titan.Nuke .. '" <' .. targetText .. '>');
        elseif pet.Name == 'Garuda' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Garuda.Nuke .. '" <' .. targetText .. '>');
        elseif pet.Name == 'Ifrit' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Ifrit.Nuke .. '" <' .. targetText .. '>');
        elseif pet.Name == 'Leviathan' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Leviathan.Nuke .. '" <' .. targetText .. '>');
        elseif pet.Name == 'Shiva' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Shiva.Nuke .. '" <' .. targetText .. '>');
        elseif pet.Name == 'Ramuh' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Ramuh.Nuke .. '" <' .. targetText .. '>');
        elseif pet.Name == 'Fenrir' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Fenrir.Nuke .. '" <' .. targetText .. '>');
        elseif pet.Name == 'Diabolos' then
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "' .. SmnConfig.Summons.Diabolos.Nuke .. '" <' .. targetText .. '>');
        end

    elseif (args[1] == 'Retreat') then
        AshitaCore:GetChatManager():QueueCommand(1, '/pet "Retreat" <me>');
    end
end

--Bloodpact Lists. I have flaming crush in the PhysicalBP list which may not be optimal
local MagicBP = T{'Nether Blast', 'Meteorite','Stone II','Stone IV','Geocrush','Water II','Water IV','Grand Fall','Aero II','Aero IV','Wind Blade','Fire II','Fire IV','Meteor Strike','Burning Strike','Blizzard II','Blizzard IV','Heavenly Strike','Thunder II','Thunder IV','Thunderstorm','Thunderspark'};
local PhysBP = T{'Poison Nails','Moonlit Charge','Somnolence','Punch','Rock Throw','Barracuda Dive','Claw','Axe Kick','Shock Strike','Camisado','Regal Scratch','Crescent Fang','Rock Buster','Tail Whip','Double Punch','Megalith Throw','Double Slap','Eclipse Bite','Flaming Crush','Mountain Buster','Spinning Dive','Predator Claws','Rush','Chaotic Strike'};
local BuffBP = T{'Shining Ruby','Aerial Armor','Frost Armor','Rolling Thunder','Crimson Howl','Lightning Armor','Ecliptic Growl','Glittering Ruby','Earthen Ward','Spring Water','Hastega','Noctoshield','Ecliptic Howl','Dream Shroud'};
local DebuffBP = T{'Luncar Cry','Mewing Lullaby','Nightmare','Lunar Roar','Slowga','Ultimate Terror','Sleepga','Eerie Eye'};

local function HandlePetAction(PetAction)
    gFunc.EquipSet(sets.PetAcc);

    --There is an extra character somewhere coming through in PetAction.Name
	local BPName = PetAction.Name;
    local target = gData.GetTarget();

	if MagicBP:contains(BPName) then
		gFunc.EquipSet(profile.Sets.PetMAB);
	elseif PhysBP:contains(BPName) then
		gFunc.EquipSet(profile.Sets.PetAccBP);
	elseif BuffBP:contains(BPName) then
		gFunc.EquipSet(profile.Sets.SummonSkill);
	elseif DebuffBP:contains(BPName) then
		gFunc.EquipSet(profile.Sets.PetMacc);
	end
end

local function CheckSummonersDoublet()
    local pet = gData.GetPet();
    local dayElement = gData.GetEnvironment().DayElement;
    local petDayTable = {
            --['Carbuncle'] = 'Light',
            ['Light Spirit'] = 'Light',
            ['Titan'] = 'Earth',
            ['Earth Spirit'] = 'Earth',
            ['Garuda'] = 'Wind',
            ['Wind Spirit'] = 'Wind',
            ['Ifrit'] = 'Fire',
            ['Fire Spirit'] = 'Fire',
            ['Leviathan'] = 'Water',
            ['Water Spirit'] = 'Water',
            ['Ramuh'] = 'Thunder',
            ['Thunder Spirit'] = 'Thunder',
            ['Fenrir'] = 'Dark',
            ['Diabolos'] = 'Dark',
            ['Dark Spirit'] = 'Dark',
        };

    if pet ~= nil then
        if petDayTable[pet.Name] == dayElement then
            gFunc.EquipSet(sets.Doublet);
        end
    end
end

local function CheckSummonersHorn()
    local pet = gData.GetPet();
    local weatherElement = gData.GetEnvironment().RawWeatherElement;
    local petDayTable = {
            --['Carbuncle'] = 'Light',
            ['Light Spirit'] = 'Light',
            ['Titan'] = 'Earth',
            ['Earth Spirit'] = 'Earth',
            ['Garuda'] = 'Wind',
            ['Wind Spirit'] = 'Wind',
            ['Ifrit'] = 'Fire',
            ['Fire Spirit'] = 'Fire',
            ['Leviathan'] = 'Water',
            ['Water Spirit'] = 'Water',
            ['Ramuh'] = 'Thunder',
            ['Thunder Spirit'] = 'Thunder',
            ['Fenrir'] = 'Dark',
            ['Diabolos'] = 'Dark',
            ['Dark Spirit'] = 'Dark',
        };

    if pet ~= nil then
        if petDayTable[pet.Name] == weatherElement then
            gFunc.EquipSet(sets.Horn);
        end
    end
end

profile.OnLoad = function()
    draginclude.OnLoad(sets, {'NoStaffSwap', 'StaffSwap'}, {'None', 'Field', 'Fishing'});

    -- SMN Core Commands
    AshitaCore:GetChatManager():QueueCommand(-1,'/bind 1 /lac fwd PetAtk ');
    AshitaCore:GetChatManager():QueueCommand(-1,'/bind 3 /lac fwd Rage1 ');
    AshitaCore:GetChatManager():QueueCommand(-1,'/bind 4 /lac fwd Rage2 ');
    AshitaCore:GetChatManager():QueueCommand(-1,'/bind 5 /lac fwd Rage3 ');
    AshitaCore:GetChatManager():QueueCommand(-1,'/bind +5 /lac fwd Rage4 ');
    AshitaCore:GetChatManager():QueueCommand(-1,'/bind 6 /lac fwd AstralFlow ');
    AshitaCore:GetChatManager():QueueCommand(-1,'/bind 7 /lac fwd Ward1 ');
    AshitaCore:GetChatManager():QueueCommand(-1,'/bind +7 /lac fwd Ward3 ');
    AshitaCore:GetChatManager():QueueCommand(-1,'/bind 8 /lac fwd Ward2 ');
    AshitaCore:GetChatManager():QueueCommand(-1,'/bind +8 /lac fwd Ward4 ');
    AshitaCore:GetChatManager():QueueCommand(-1,'/bind 9 /lac fwd Retreat ');
    AshitaCore:GetChatManager():QueueCommand(-1,'/bind 0 /lac fwd Nuke ');

    
    AshitaCore:GetChatManager():QueueCommand(-1,'/alias /cuthp /lac fwd cuthp ');
end

profile.OnUnload = function()
    draginclude.OnUnload();
end

profile.HandleCommand = function(args)

    if (args[1] == 'cuthp') then
        Settings.CutHP = not Settings.CutHP;

        gFunc.Message('CutHP ' .. tostring(Settings.CutHP));
    end

    draginclude.HandleCommand(args, sets);
    HandleSmnCoreCommands(args);
end

profile.LateInitialize = function()
    local timestamp = os.time();
    local player = gData.GetPlayer();

    if timestamp >= Settings.LateInitialized.TimeToUse then
        -- Setting a Style Lock prevents the character from blinking
        gFunc.LockStyle(sets.StyleLock2);

        if player.SubJob == 'THF' then
            AshitaCore:GetChatManager():QueueCommand(1, '/macro book 20');
            AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1');
        else
            AshitaCore:GetChatManager():QueueCommand(1, '/macro book 20');
            AshitaCore:GetChatManager():QueueCommand(1, '/macro set 2');
        end
        

        Settings.LateInitialized.Initialized = true;
        gFunc.Message('LateInitialized');
    end
end

profile.HandleDefault = function()
    local timestamp = os.time();
    local zone = gData.GetEnvironment();
    local pet = gData.GetPet();
    local petAction = gData.GetPetAction();
    local player = gData.GetPlayer();
    local myLevel = AshitaCore:GetMemoryManager():GetPlayer():GetMainJobLevel();
    --local myLevel = 30;

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

    -- Forward slash toggle between NoWeaponSwap and WeaponSwap
    if draginclude.dragSettings.TpVariant == 1 then

        gFunc.EquipSet(sets.Default);

        -- Engaged Section
        if player.Status == 'Engaged' then


        -- Resting Section
        elseif (player.Status == 'Resting') then
            gFunc.EquipSet(sets.HMP);
        -- Idle Section
        else
            
        end

    elseif draginclude.dragSettings.TpVariant == 2 then --Use weapon swaps set
        gFunc.EquipSet(sets.Default);

        -- Resting Section
        if (player.Status == 'Resting') then
            gFunc.EquipSet(sets.HMP);
            gFunc.EquipSet(sets.Dark);
        -- Idle Section
        elseif (pet ~= nil) then
            if pet.Name == 'Carbuncle' or pet.Name == 'LightSpirit' then
                gFunc.EquipSet(sets.Light);
            elseif pet.Name == 'Titan' or pet.Name == 'EarthSpirit' then
                gFunc.EquipSet(sets.Earth);
            elseif pet.Name == 'Garuda' or pet.Name == 'AirSpirit' then
                gFunc.EquipSet(sets.Wind);
            elseif pet.Name == 'Ifrit' or pet.Name == 'FireSpirit' then
                gFunc.EquipSet(sets.Fire);
            elseif pet.Name == 'Leviathan'  or pet.Name == 'WaterSpirit' then
                gFunc.EquipSet(sets.Water);
            elseif pet.Name == 'Shiva'  or pet.Name == 'IceSpirit' then
                gFunc.EquipSet(sets.Ice);
            elseif pet.Name == 'Ramuh'  or pet.Name == 'ThunderSpirit' then
                gFunc.EquipSet(sets.Thunder);
            elseif pet.Name == 'Fenrir'  or pet.Name == 'DarkSpirit' then
                gFunc.EquipSet(sets.Dark);
            elseif pet.Name == 'Diabolos' then
                gFunc.EquipSet(sets.Dark);
            end
        else
            gFunc.EquipSet(sets.Earth);
        end
    end

    if (pet ~= nil) then

        -- Update these MP values when my gear updates
        if player.SubJob == 'BLM' then
            if player.MP <= 973 then
                if pet.Name == 'Carbuncle' then
                    gFunc.EquipSet(sets.AvatarEngagedCarby);
                else
                    gFunc.EquipSet(sets.AvatarEngaged);
                end
            end
        elseif player.SubJob == 'WHM' then
            if player.MP <= 954 then
                if pet.Name == 'Carbuncle' then
                    gFunc.EquipSet(sets.AvatarEngagedCarby);
                else
                    gFunc.EquipSet(sets.AvatarEngaged);
                end
            end
        elseif player.SubJob == 'RDM' then
            if player.MP <= 935 then
                if pet.Name == 'Carbuncle' then
                    gFunc.EquipSet(sets.AvatarEngagedCarby);
                else
                    gFunc.EquipSet(sets.AvatarEngaged);
                end
            end
        end

        if (petAction ~= nil) then
            HandlePetAction(petAction);
            return;
        end

        if player.Status == 'Engaged' then
            gFunc.EquipSet(sets.MeleeEngagedAvatar);
        end

        CheckSummonersDoublet();
        CheckSummonersHorn();

        if pet.Name == 'Carbuncle' then
            gFunc.Equip('Hands', 'Carbuncle Mitts');
        end
    else
        if player.Status == 'Engaged' then
            gFunc.EquipSet(sets.MeleeEngaged);
        end
    end

    if (zone.Area ~= nil) and (draginclude.Towns:contains(zone.Area)) then 
        gFunc.EquipSet(sets.IdleTown);
    end

    if Settings.CutHP then
        gFunc.EquipSet(sets.CutHP);
    end

    draginclude.HandleDefault();
    draginclude.CheckSkillingVariant();
    draginclude.CheckStatusArmorSwaps(Settings.StatusArmorSwaps, Settings.CurrentLevel);
end

profile.HandleAbility = function()
    local pet = gData.GetPet();
    local ability = gData.GetAction();

    gFunc.Message(ability.Name .. ' ' .. ability.Type);

    if string.match(ability.Name, 'Reward') then
        gFunc.EquipSet(sets.Reward);
    elseif string.match(ability.Name, 'Charm') then
        gFunc.EquipSet(sets.Charm);
    elseif string.match(ability.Type, 'Blood Pact: Rage') then
        gFunc.EquipSet(sets.BPDelay);
    elseif string.match(ability.Type, 'Blood Pact: Ward') then
        gFunc.EquipSet(sets.BPDelay);
    end
end

profile.HandleItem = function()
    local item = gData.GetAction();
end

profile.HandlePrecast = function()
    local spell = gData.GetAction();
end

profile.HandleMidcast = function()
    local spell = gData.GetAction();

    if spell.Name == 'Invisible' then
        gFunc.EquipSet(sets.Invisible);
    elseif spell.Name == 'Sneak' then
        gFunc.EquipSet(sets.Sneak);
    elseif spell.Name == 'Stoneskin' then
        if draginclude.dragSettings.TpVariant == 2 then
            gFunc.EquipSet(sets.Water); -- Water Staff MND +4
        end
        
        gFunc.EquipSet(sets.Stoneskin);
    elseif spell.Skill == 'Enfeebling Magic' and not string.contains(spell.Name, 'Dia' )then -- Dia and Dia II need zero gearswap

        if draginclude.dragSettings.TpVariant == 2 then
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

        if spell.Type == 'White Magic' then
            gFunc.EquipSet(sets.EnfeeblingMND);

            equipObiIfApplicable(spell.Element);
        elseif spell.Type == 'Black Magic' then
            gFunc.EquipSet(sets.EnfeeblingINT);

            equipObiIfApplicable(spell.Element);
        end
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

    if action.Name == 'Spirit Taker' then
        gFunc.EquipSet(sets.WeaponSkillSpiritTaker);
    end
end

return profile;