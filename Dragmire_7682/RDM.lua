local profile = {};
draginclude = gFunc.LoadFile('common\\draginclude.lua');

local Settings = {
    LateInitialized = {
        Initialized = false,
        TimeToUse = 0,
    },
    StatusArmorSwaps = {
        MelodyEarring = false,
        OpoopoNecklace = false,
        FenrirsEarring = false,
        FenrirsStone = false,
        DuskGloves = false,
        ShenobiRing = false,
        GaudyHarness = false,
        PresidentialHairpin = false,
    },
    CurrentLevel = 0,
    ConvertMPNuke = 50,
    ConvertMPRefresh = 105,
    WeaponTypeToggle = false, -- true = Sword | false = dagger
};

local sets = {
    Default_Priority = {
        Ammo = {'Hedgehog Bomb', 'Phtm. Tathlum', 'Fortune Egg'},
        Head = {'Duelist\'s Chapeau', 'Egg Helm'},
        Neck = {'Uggalepih Pendant', 'Peacock Amulet'},
        Ear1 = {'Loquac. Earring', 'Dodge Earring'},
        Ear2 = {'Novia Earring', 'Phantom Earring', },
        Body = {'Wlk. Tabard +1', 'Elder\'s Surcoat'},
        Hands = {'Zenith Mitts', 'Elder\'s Bracers'},
        Ring1 = {'Ether Ring', 'Astral Ring'},
        Ring2 = {'Astral Ring'},
        Back = {'Rainbow Cape', 'Trimmer\'s Mantle'},
        Waist = {'Hierarch Belt', 'Ryl. Kgt. Belt'},
        Legs = {'Crimson Cuisses', 'Elder\'s Braguette'},
        Feet = {'Dls. Boots +1', 'Elder\'s Sandals'},
    },

    DefaultLowMP_Priority = {
        Ammo = {'Hedgehog Bomb', 'Phtm. Tathlum', 'Fortune Egg'},
        Head = {'Duelist\'s Chapeau', 'Egg Helm'},
        Neck = {'Uggalepih Pendant', 'Peacock Amulet'},
        Ear1 = {'Ethereal Earring', 'Dodge Earring'},
        Ear2 = {'Novia Earring', 'Phantom Earring'},
        Body = {'Scorpion Harness', 'Elder\'s Surcoat'},
        Hands = {'Duelist\'s Gloves', 'Elder\'s Bracers', 'Battle Gloves'},
        Ring1 = {'Diamond Ring'},
        Ring2 = {'Diamond Ring'},
        Back = {'Rainbow Cape'},
        Waist = {'Ryl.Kgt. Belt'},
        Legs = {'Crimson Cuisses', 'Elder\'s Braguette'},
        Feet = {'Dls. Boots +1', 'Elder\'s Sandals'},
    },

    Idle_Priority = {
        --Body = {'Vermillion Cloak'},
    },

    Engaged_Priority = {
        Head = {'Optical Hat'},
        Body = {'Nashira Manteel', 'Scorpion Harness'},
    },

    Evasion_Priority = { --EVA, AGI
        Head = {},
        Neck = {},
        Back = {},
    },

    MeleeWeapons_Priority = {
        Main = {'Joyeuse'},
        Sub = {'Nms. Shield +1'},
    },

    MeleeWeaponsDagger_Priority = {
        Main = {'Blau Dolch'},
        Sub = {'Nms. Shield +1'},
    },

    MeleeWeaponsNIN_Priority = {
        Main = {'Joyeuse'},
        Sub = {'Justice Sword'},
    },

    MeleeWeaponsDaggerNIN_Priority = {
        Main = {'Martial Knife'},
        Sub = {'Joyeuse'},
    },

    MeleeEngagedAcc_Priority = {
        Ammo = {'Tiphia Sting'},
        Head = {'Optical Hat'},
        Neck = {'Peacock Amulet'},
        Ear1 = {'Ethereal Earring'},
        Ear2 = {'Brutal Earring'},
        Body = {'Scorpion Harness'},
        Hands = {'Dusk Gloves'}, --3% Haste
        Ring1 = {'Rajas Ring'},
        Ring2 = {'Toreador\'s Ring'},
        Back = {'Forager\'s Mantle'},
        Waist = {'Sonic Belt'}, --6% Haste
        Legs = {'Duelist\'s Tights', 'Elder\'s Braguette'},
        Feet = {'Dusk Ledelsens'}, --2% Haste
    },

    MeleeEngaged_Priority = {
        Ammo = {'Tiphia Sting'},
        Head = {'Nashira Turban'}, --2% Haste
        Neck = {'Peacock Amulet'},
        Ear1 = {'Merman\'s Earring'},
        Ear2 = {'Brutal Earring'},
        Body = {'Nashira Manteel'}, --3% Haste
        Hands = {'Dusk Gloves'}, --3% Haste
        Ring1 = {'Rajas Ring'},
        Ring2 = {'Toreador\'s Ring'},
        Back = {'Forager\'s Mantle'},
        Waist = {'Sonic Belt'}, --6% Haste
        Legs = {'Nashira Seraweels', 'Duelist\'s Tights', 'Elder\'s Braguette'}, --2% Haste
        Feet = {'Dusk Ledelsens'}, --2% Haste
    },

    IdleTown_Priority = {
        Ammo = {'Hedgehog Bomb'},
        Head = {'Duelist\'s Chapeau'},
        Neck = {'Uggalepih Pendant'},
        Ear1 = {'Loquac. Earring'},
        Ear2 = {'Novia Earring'},
        Body = {'Nashira Manteel'},
        Hands = {'Zenith Mitts'},
        Ring1 = {'Dilation Ring'},
        Ring2 = {'Overlord\'s Ring'},
        Back = {'Empwr. Mantle'},
        Waist = {'Sonic Belt'},
        Legs = {'Crimson Cuisses'},
        Feet = {'Dls. Boots +1'},
    },

    IdleTownNIN_Priority = {
        Ammo = {'Tiphia Sting'},
        Head = {'Duelist\'s Chapeau'},
        Neck = {'Uggalepih Pendant'},
        Ear1 = {'Stealth Earring'},
        Ear2 = {'Brutal Earring'},
        Body = {'Nashira Manteel'},
        Hands = {'Zenith Mitts'},
        Ring1 = {'Dilation Ring'},
        Ring2 = {'Overlord\'s Ring'},
        Back = {'Empwr. Mantle'},
        Waist = {'Sonic Belt'},
        Legs = {'Crimson Cuisses'},
        Feet = {'Dls. Boots +1'},
    },

    StyleLock2 = {
        Head = 'Duelist\'s Chapeau',
        Body = 'Goblin Suit',
        Legs = 'Elder\'s Braguette',
    },

    StyleLockCool = {
        Main = 'Dark Staff',
        Head = 'Nashira Turban',
        Body = 'Nashira Manteel',
        Hands = 'Crimson Fng. Gnt.',
        Legs = 'Nashira Seraweels',
        Feet = 'Hydra Spats',
    },

    StyleLockHydra = {
        Main = 'Dark Staff',
        Head = 'Hydra Cap',
        Body = 'Hydra Jupon',
        Hands = 'Crimson Fng. Gnt.',
        Legs = 'Hydra Tights',
        Feet = 'Hydra Spats',
    },

    StyleLockAF = {
        Main = 'Fire Staff',
        Head = 'Warlock\'s Chapeau',
        Body = 'Wlk. Tabard +1',
        Hands = 'Warlock\'s Gloves',
        Legs = 'Warlock\'s Tights',
        Feet = 'Warlock\'s Boots',
    },

    StyleLockRelic = {
        Main = 'Dark Staff',
        Head = 'Duelist\'s Chapeau',
        Body = 'Duelist\'s Tabard',
        Hands = 'Duelist\'s Gloves',
        Legs = 'Duelist\'s Tights',
        Feet = 'Duelist\'s Boots',
    },

    StyleLockSummer = {
        Main = 'Apollo\'s Staff',
        Head = 'President. Hairpin',
        Body = 'Elder Gilet +1',
        --Hands = 'Scp. Gauntlets',
        Legs = 'Elder Trunks',
        --Feet = 'Homam Gambieras',
    },

    StyleLockSummer2 = {
        Main = 'Apollo\'s Staff',
        Head = 'Snowman Cap',
        Body = 'Elder Gilet +1',
        --Hands = 'Scp. Gauntlets',
        Legs = 'Elder Trunks',
        --Feet = 'Homam Gambieras',
    },

    StyleLockWinter = {
        Main = 'Apollo\'s Staff',
        Head = 'Dream Cap +1',
        Body = 'Dream Robe +1',
        Hands = 'Dream Mittens +1',
        Legs = 'Dream Trousers +1',
        Feet = 'Dream Boots +1',
    },

    Precast_Priority = {
        Head = {'Warlock\'s Chapeau'},
        Ear1 = {'Loquac. Earring'},
        Body = {'Duelist\'s Tabard'},
    },

    INTElementalAcc_Priority = {
        Ammo = {'Phtm. Tathlum'},
        Head = {'Warlock\'s Chapeau'},
        Neck = {'Elemental Torque'},
        Ear1 = {'Loquac. Earring'},
        Ear2 = {'Moldavite Earring'},
        Body = {'Nashira Manteel'},
        Hands = {'Errant Cuffs'},
        Ring2 = {'Diamond Ring'},
        Waist = {'Duelist\'s Belt'},
        Back = {'Rainbow Cape'},
        Legs = {'Duelist\'s Tights'},
        Feet = {'Dls. Boots +1'},
    },

    INTElementalPotency_Priority = {
        Ammo = {'Phtm. Tathlum'},
        Head = {'Warlock\'s Chapeau'},
        Neck = {'Philomath Stole'},
        Ear1 = {'Loquac. Earring'},
        Ear2 = {'Moldavite Earring'},
        Body = {'Errant Hpl.'},
        Hands = {'Zenith Mitts'},
        Ring1 = {'Diamond Ring'},
        Ring2 = {'Diamond Ring'},
        Waist = {'Duelist\'s Belt'},
        Back = {'Rainbow Cape'},
        Legs = {'Errant slops'},
        Feet = {'Dls. Boots +1'},
    },

    INTDarkAcc_Priority = {
        Ammo = {'Phtm. Tathlum'},
        Head = {'Warlock\'s Chapeau'},
        Neck = {'Philomath Stole'},
        Ear1 = {'Loquac. Earring'},
        Ear2 = {'Phantom Earring'},
        Body = {'Nashira Manteel', 'Errant Hpl.'},
        Hands = {'Crimson Fng. Gnt.', 'Errant Cuffs'},
        Ring2 = {'Diamond Ring'},
        Waist = {'Duelist\'s Belt'},
        Back = {'Rainbow Cape'},
        Legs = {'Errant slops'},
        Feet = {'Elder\'s Sandals'},
    },
    INTDark_Priority = {
        Ammo = {'Phtm. Tathlum'},
        Head = {'Nashira Turban', 'Warlock\'s Chapeau'},
        Neck = {'Philomath Stole'},
        Ear1 = {'Loquac. Earring'},
        Ear2 = {'Phantom Earring'},
        Body = {'Nashira Manteel', 'Errant Hpl.'},
        Hands = {'Crimson Fng. Gnt.', 'Errant Cuffs'},
        Ring2 = {'Diamond Ring'},
        Waist = {'Duelist\'s Belt'},
        Back = {'Rainbow Cape'},
        Legs = {'Errant slops'},
        Feet = {'Elder\'s Sandals'},
    },

    DarkSkill_Priority = {
        Body = {'Nashira Manteel'}, -- +5
        Hands = {'Crimson Fng. Gnt.'}, -- +10
    },

    MNDEnfeeb_Priority = {
        Head = {'Duelist\'s Chapeau'},
        Ear1 = {'Loquac. Earring'},
        Ear2 = {'Geist Earring'},
        Neck = {'Enfeebling Torque'},
        Body = {'Wlk. Tabard +1'},
        Hands = {'Devotee\'s Mitts'}, 
        Ring2 = {'Sapphire Ring'},
        Waist = {'Duelist\'s Belt'},
        Back = {'Rainbow Cape'},
        Legs = {'Nashira Seraweels', 'Errant slops'},
        Feet = {'Dls. Boots +1'},
    },

    INTEnfeebSkill_Priority = { -- Enfeeb Skill > INT
        Ammo = {'Phtm. Tathlum'},
        Head = {'Duelist\'s Chapeau'},
        Ear1 = {'Loquac. Earring'},
        Ear2 = {'Phantom Earring'},
        Neck = {'Enfeebling Torque'},
        Body = {'Wlk. Tabard +1'},
        Hands = {'Duelist\'s Gloves'},
        Ring2 = {'Diamond Ring'},
        Waist = {'Duelist\'s Belt'},
        Back = {'Rainbow Cape'},
        Legs = {'Nashira Seraweels', 'Errant slops'},
        Feet = {'Elder\'s Sandals'},
    },

    INTEnfeeb_Priority = { -- INT
        Ammo = {'Phtm. Tathlum'},
        Head = {'Warlock\'s Chapeau'},
        Ear1 = {'Loquac. Earring'},
        Ear2 = {'Phantom Earring'},
        Neck = {'Philomath Stole'},
        Body = {'Errant Hpl.'},
        Hands = {'Duelist\'s Gloves'},
        Ring1 = {'Diamond Ring'},
        Ring2 = {'Diamond Ring'},
        Waist = {'Duelist\'s Belt'},
        Back = {'Rainbow Cape'},
        Legs = {'Errant Slops', 'Elder\'s Braguette'},
        Feet = {'Elder\'s Sandals'},
    },

    MNDEnhancing_Priority = {
        Neck = {'Enhancing Torque'},
        Hands = {'Duelist\'s Gloves'},
        Legs = {'Warlock\'s Tights'},
    },

    INTEnhancing_Priority = {
        Neck = {'Enhancing Torque'},
        Hands = {'Duelist\'s Gloves'},
        Legs = {'Warlock\'s Tights'},
    },

    MNDHealing_Priority = {
        Ear2 = {'Novia Earring'},
        Body = {'Nashira Manteel'},
        Waist = {'Sonic Belt'},
    },

    SpellHaste_Priority = {
        Body = {'Nashira Manteel'},
        Hands = {'Dusk Gloves'},
        Waist = {'Sonic Belt'},
        --Feet = {'Dusk Ledelsens'},
    },

    SpellHasteUtsu_Priority = {        
        Body = {'Nashira Manteel'},
        Hands = {'Dusk Gloves'},
        Waist = {'Sonic Belt'},
        Feet = {'Dusk Ledelsens'},
    },


    OverlordsRingDrainAspir_Priority = {
        Ring1 = {'Overlord\'s Ring'}
    },

    DilationRingRefreshHaste_Priority = {
        Ring1 = {'Dilation Ring'},
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
        Main = {'Apollo\'s Staff'},
    },

    Dark_Priority = {
        Main = {'Dark Staff'},
    },

    RestingMP_Priority = {
        Main = {'Dark Staff'},
        Head = {'Duelist\'s Chapeau'},
        Ear2 = {'Relaxing Earring'},
        Body = {'Wlk. Tabard +1', 'Errant Hpl.'},
        Waist = {'Duelist\'s Belt'},
    },

    Resting_Priority = {
        Head = {'Duelist\'s Chapeau'},
        Ear2 = {'Relaxing Earring'},
        Body = {'Wlk. Tabard +1', 'Errant Hpl.'},
        Waist = {'Duelist\'s Belt'},
    },

    UglyPP_Priority = {
        Neck = {'Uggalepih Pendant'},
    },

    WeaponSkillEvis_Priority = {
        Neck = {'Light Gorget'},
        Waist = {'Warwolf Belt', 'Ryl.Kgt. Belt'},
        Legs = {'Duelist\'s Tights'},
    },

    WSEnergyDrain_Priority = { -- MND
        Body = {'Errant Hpl.'},
        Hands = {'Devotee\'s Mitts'},
        Ring2 = {'Sapphire Ring'},
        Back = {'Rainbow Cape'},
        Waist = {'Duelist\'s Belt'},
        Legs = {'Errant Slops'},
        Feet = {'Dls. Boots +1'},
    },

    StealthEarring_Priority = {
        Ear1 = {'Stealth Earring'},
    },

    PetReadyDefault = {

    },

    PetAttack = {

    },

    Reward_Priority = { -- MND
        Ammo = {'Pet Food Zeta', 'Pet Fd. Epsilon', 'Pet Food Delta', 'Pet Fd. Gamma', 'Pet Food Beta', 'Pet Food Alpha'},
        Body = {'Errant Hpl.'},
        Hands = {'Ogre Gloves'},
        Back = {'Rainbow Cape'},
        Ring2 = {'Sapphire Ring'},
        Waist = {'Duelist\'s Belt'},
        Legs = {'Errant Slops'},
        Feet = {'Dls. Boots +1'},
    },

    Charm_Priority = {
        --Neck = {'Flower Necklace'},
        Body = {'Elder\'s Surcoat',},
        Back = {'Trimmer\'s Mantle'},
        Legs = {'Elder\'s Braguette'},
    },

    CharmStaff_Priority = {
        Main = {'Apollo\'s Staff'},
        --Neck = {'Flower Necklace'},
        Body = {'Elder\'s Surcoat',},
        Back = {'Trimmer\'s Mantle'},
        Legs = {'Elder\'s Braguette'},
    },

    Sneak = {
        Hands = 'Dream Mittens +1',
    },

    Invisible = {
        Feet = 'Dream Boots +1',
    },
};

profile.Sets = sets;

local function HandlePetAction(PetAction)
    gFunc.EquipSet(sets.PetReadyDefault);
end

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

profile.OnLoad = function()    
    draginclude.OnLoad(sets, {'Melee', 'Staff'}, {'None', 'Field', 'Fishing'});

    AshitaCore:GetChatManager():QueueCommand(-1,'/alias /weapon /lac fwd WeaponTypeToggle ');
end

profile.OnUnload = function()
    draginclude.OnUnload();
end

profile.HandleCommand = function(args)

    if (args[1] == 'WeaponTypeToggle') then
        Settings.WeaponTypeToggle = not Settings.WeaponTypeToggle;

        if Settings.WeaponTypeToggle then
            gFunc.Message('WeaponTypeToggle SWORD');
        else
            gFunc.Message('WeaponTypeToggle DAGGER');
        end
    elseif (args[1] == 'haste') then
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma "Haste" <stpc>');
    elseif (args[1] == 'refresh') then
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma "Refresh" <stpc>');
    elseif (args[1] == 'regen') then
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma "Regen" <stpc>');
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
    elseif (args[1] == 'sleep') then
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma "Sleep" <stnpc>');
    end

    draginclude.HandleCommand(args, sets);
    draginclude.HandleBstCoreCommands(args, nil);
    draginclude.HandleDrgCoreCommands(args);
end

profile.LateInitialize = function()
    local timestamp = os.time();
    local player = gData.GetPlayer();

    if timestamp >= Settings.LateInitialized.TimeToUse then
        -- Setting a Style Lock prevents the character from blinking
        gFunc.LockStyle(sets.StyleLockSummer2);

        AshitaCore:GetChatManager():QueueCommand(1, '/macro book 4');
        AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1');

        --[[ Set your job macro defaults here]]
        if player.SubJob == 'BST' then
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
        elseif player.SubJob == 'BLM' then
            -- RDM Core Commands
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 1 /lac fwd haste ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 2 /lac fwd refresh ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 3 /lac fwd regen ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 4 /lac fwd gravity ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 5 /lac fwd stoneskin ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 6 /lac fwd silence ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 7 /lac fwd drain ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 8 /lac fwd aspir ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 9 /lac fwd sleepga ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 0 /lac fwd sleep ');
        elseif player.SubJob == 'DRK' then
            -- RDM Core Commands
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 1 /lac fwd haste ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 2 /lac fwd refresh ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 3 /lac fwd regen ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 4 /lac fwd gravity ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 5 /lac fwd stoneskin ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 6 /lac fwd silence ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 7 /lac fwd drain ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 8 /lac fwd aspir ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 9 /lac fwd bind ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 0 /lac fwd sleep ');
        elseif player.SubJob == 'WHM' then
            -- RDM Core Commands
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 1 /lac fwd haste ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 2 /lac fwd refresh ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 3 /lac fwd regen ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 4 /lac fwd gravity ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 5 /lac fwd stoneskin ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 6 /lac fwd silence ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 9 /lac fwd bind ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 0 /lac fwd sleep ');
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

    if (myLevel ~= Settings.CurrentLevel) then
        gFunc.EvaluateLevels(profile.Sets, myLevel);
        Settings.CurrentLevel = myLevel;
    end

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

        if player.Status == 'Idle' then
            gFunc.EquipSet(sets.Idle);
        elseif player.Status == 'Resting' then
            gFunc.EquipSet(sets.Idle);
            gFunc.EquipSet(sets.Resting);
        elseif player.Status == 'Engaged' then
            gFunc.EquipSet(sets.MeleeEngagedAcc);
        end

        if player.SubJob == 'NIN' then
            if Settings.WeaponTypeToggle then
                gFunc.EquipSet(sets.MeleeWeaponsNIN);
            else
                gFunc.EquipSet(sets.MeleeWeaponsDaggerNIN);
            end

            if player.Status == 'Engaged' then
                gFunc.EquipSet(sets.StealthEarring);
            end
        else
            if Settings.WeaponTypeToggle then
                gFunc.EquipSet(sets.MeleeWeapons);
            else
                gFunc.EquipSet(sets.MeleeWeaponsDagger);
            end
        end

    elseif draginclude.dragSettings.TpVariant == 2 then --Use default set

        gFunc.EquipSet(sets.Default);

        if player.Status == 'Resting' then
            gFunc.EquipSet(sets.Idle);
            gFunc.EquipSet(sets.RestingMP);
        elseif player.Status == 'Idle' then
            gFunc.EquipSet(sets.Idle);
            gFunc.EquipSet(sets.Earth);
        end
    end

    if (pet ~= nil) then
        if (petAction ~= nil) then
            HandlePetAction(petAction);
            return;
        end
    end

    if (zone.Area ~= nil) and (draginclude.Towns:contains(zone.Area)) then 
        if player.SubJob == 'NIN' then
            --gFunc.EquipSet(sets.IdleTownNIN);
        else
            --gFunc.EquipSet(sets.IdleTown);
        end
    end

    draginclude.HandleDefault();
    draginclude.CheckSkillingVariant();
    draginclude.CheckStatusArmorSwaps(Settings.StatusArmorSwaps, Settings.CurrentLevel);
end

profile.HandleAbility = function()
    local pet = gData.GetPet();
    local ability = gData.GetAction();

    if string.match(ability.Name, 'Reward') then
        gFunc.EquipSet(sets.Reward);
    elseif string.match(ability.Name, 'Charm') then

        if draginclude.dragSettings.TpVariant == 1 then
            gFunc.EquipSet(sets.Charm);
        elseif draginclude.dragSettings.TpVariant == 2 then
            gFunc.EquipSet(sets.CharmStaff);
        end
    elseif string.match(ability.Name, 'Convert') then
        gFunc.LockSet(sets.Default, 15); -- Wear High MP set for 15 seconds so it doesn't get chopped down by gearswaps
    end
end

profile.HandleItem = function()
    local item = gData.GetAction();
end

profile.HandlePrecast = function()
    local spell = gData.GetAction();

    gFunc.EquipSet(sets.Precast);
end

profile.HandleMidcast = function()
    local spell = gData.GetAction();
    local player = gData.GetPlayer();

    Settings.SpellElement = spell.Element;
    gFunc.Message(spell.Name .. ' ' .. spell.Skill .. ' ' .. spell.Type .. ' ' .. spell.Element);

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
    elseif spell.Skill == 'Ninjutsu' then
        gFunc.EquipSet(sets.SpellHasteUtsu);
    elseif spell.Skill == 'Enfeebling Magic' and spell.Name ~= 'Dia' and spell.Name ~= 'Dia II' then -- Dia and Dia II need zero gearswap
        if spell.Type == 'White Magic' then
            gFunc.EquipSet(sets.MNDEnfeeb);

            equipObiIfApplicable(spell.Element);
        elseif spell.Type == 'Black Magic' then
            gFunc.EquipSet(sets.INTEnfeebSkill);

            equipObiIfApplicable(spell.Element);
        end
    elseif spell.Skill == 'Enhancing Magic' then
        if (spell.Name == 'Refresh' or spell.Name == 'Haste') then

            local mpPercent = player.MP / (player.MaxMP + Settings.ConvertMPRefresh);
            gFunc.Message(mpPercent);
            if mpPercent < .66 then
                gFunc.EquipSet(sets.SpellHaste);
            end

            if spell.Name == 'Refresh' and player.MP >= 62 then
                gFunc.EquipSet(sets.DilationRingRefreshHaste);
            elseif spell.Name == 'Haste' and player.MP >= 50 then
                gFunc.EquipSet(sets.DilationRingRefreshHaste);
            end
        elseif string.contains(spell.Name, 'Bar') then -- Barspells need raw Enhancing Skill
            gFunc.EquipSet(sets.EnhancingSkill);
        end
    elseif spell.Skill == 'Healing Magic'  then
        local mpPercent = player.MP / (player.MaxMP + Settings.ConvertMPRefresh);
        
        if spell.Name ~= 'Reraise' and spell.Name ~= 'Raise' and player.MPP < 80 then
            gFunc.EquipSet(sets.MNDHealing);
        elseif spell.Name == 'Reraise' or spell.Name == 'Raise' and mpPercent < .66 then
            gFunc.EquipSet(sets.SpellHaste);
        end
    elseif spell.Skill == 'Elemental Magic' then
        if spell.Name == 'Drown' or spell.Name == 'Frost' or spell.Name == 'Choke' or spell.Name == 'Rasp' or spell.Name == 'Shock' or spell.Name == 'Burn' then
            gFunc.EquipSet(sets.INTElementalAcc);
        else
            gFunc.EquipSet(sets.INTElementalAcc);
        end

        -- If I ever put on Convert gear, I need to account for it!!!
        if spell.MpAftercast <= (.50 * (player.MaxMP - Settings.ConvertMPNuke + 20)) and (spell.Name ~= 'Burn' and spell.Name ~= 'Choke' and spell.Name ~= 'Shock' and spell.Name ~= 'Drown' and spell.Name ~= 'Frost' and spell.Name ~= 'Rasp') then
            gFunc.Message('UglyPP Pendant going on.');
            gFunc.EquipSet(sets.UglyPP);
        end

        equipObiIfApplicable(spell.Element);
    elseif spell.Skill == 'Dark Magic' and spell.Name ~= 'Bio' then -- Bio needs zero gearswap

        if spell.Name == 'Drain' or spell.Name == 'Aspir' then
            gFunc.EquipSet(sets.INTDark);
            gFunc.EquipSet(sets.OverlordsRingDrainAspir);
        elseif spell.Name == 'Bio II' then -- Bio needs raw Dark Skill
            gFunc.EquipSet(sets.DarkSkill);
        else
            gFunc.EquipSet(sets.INTDarkAcc);
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
    local player = gData.GetPlayer();

    gFunc.Message(action.Name);

    if action.Name == 'Evisceration' then
        gFunc.EquipSet(sets.WeaponSkillEvis);
    elseif action.Name == 'Energy Drain' then
        gFunc.EquipSet(sets.WSEnergyDrain);
    end

    draginclude.HandleWeaponSkill(action);
end

return profile;