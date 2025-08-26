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
    MartialKnife = false,
    PDT = false,
    FastCastValue = 0.42 -- 20% from traits 22% from gear listed in Precast set
};

local sets = {
    Default_Priority = {
        Ammo = {{Name = 'Hedgehog Bomb', Priority = 100}, {Name = 'Phtm. Tathlum', Priority = 100}, 'Fortune Egg'},
        Head = {{Name = 'Duelist\'s Chapeau', Priority = 100}, 'Egg Helm'},
        Neck = {{Name = 'Uggalepih Pendant', Priority = 100}, {Name = 'Peacock Amulet', Priority = 0}},
        Ear1 = {{Name = 'Loquac. Earring', Priority = 100}},
        Ear2 = {{Name = 'Novia Earring', Priority = 0}, {Name = 'Phantom Earring', Priority = 100}, },
        Body = {{Name = 'Wlk. Tabard +1', Priority = 100}, {Name = 'Elder\'s Surcoat', Priority = 100}},
        Hands = {{Name = 'Zenith Mitts', Priority = 100}, {Name = 'Elder\'s Bracers', Priority = 100}},
        Ring1 = {{Name = 'Ether Ring', Priority = 100}, {Name = 'Astral Ring', Priority = 100}},
        Ring2 = {{Name = 'Jelly Ring', Priority = 0}},
        Back = {{Name = 'Rainbow Cape', Priority = 100}, 'Trimmer\'s Mantle'},
        Waist = {{Name = 'Hierarch Belt', Priority = 100}, {Name = 'Ryl. Kgt. Belt', Priority = 0}},
        Legs = {{Name = 'Crimson Cuisses', Priority = 0}, {Name = 'Elder\'s Braguette', Priority = 100}},
        Feet = {{Name = 'Dls. Boots +1', Priority = 100}, {Name = 'Elder\'s Sandals', Priority = 100}},
    },

    Engaged_Priority = {
        Head = {{Name = 'Optical Hat', Priority = 0}},
        Body = {{Name = 'Nashira Manteel', Priority = 0}, {Name = 'Scorpion Harness', Priority = 0}},
    },

    MeleeWeapons_Priority = {
        Main = {'Joyeuse'},
        Sub = {'Genbu\'s Shield'},
    },

    MeleeWeaponsDagger_Priority = {
        Main = {'Blau Dolch'},
        Sub = {'Genbu\'s Shield'},
    },

    MeleeWeaponsNIN_Priority = {
        Main = {'Joyeuse'},
        Sub = {'Justice Sword'},
    },

    MeleeWeaponsDaggerNIN_Priority = {
        Main = {'Blau Dolch'},
        Sub = {'Joyeuse'},
    },

    MeleeWeaponsDaggerNINMartial_Priority = {
        Main = {'Martial Knife'},
        Sub = {'Joyeuse'},
    },

    MeleeEngagedAcc_Priority = {
        Ammo = {{Name = 'Tiphia Sting', Priority = 0}},
        Head = {{Name = 'Optical Hat', Priority = 0}},
        Neck = {{Name = 'Peacock Amulet', Priority = 0}},
        Ear1 = {{Name = 'Ethereal Earring', Priority = 0}},
        Ear2 = {{Name = 'Brutal Earring', Priority = 0}},
        Body = {{Name = 'Scorpion Harness', Priority = 0}},
        Hands = {{Name = 'Dusk Gloves', Priority = 0}}, --3% Haste
        Ring1 = {{Name = 'Rajas Ring', Priority = 0}},
        Ring2 = {{Name = 'Toreador\'s Ring', Priority = 0}},
        Back = {{Name = 'Forager\'s Mantle', Priority = 0}},
        Waist = {{Name = 'Swift Belt', Priority = 0}}, --6% Haste
        Legs = {{Name = 'Duelist\'s Tights', Priority = 100}, {Name = 'Elder\'s Braguette', Priority = 100}},
        Feet = {{Name = 'Dusk Ledelsens', Priority = 0}}, --2% Haste
    },

    MeleeEngaged_Priority = {
        Ammo = {{Name = 'Tiphia Sting', Priority = 0}},
        Head = {{Name = 'Nashira Turban', Priority = 0}}, --2% Haste
        Neck = {{Name = 'Peacock Amulet', Priority = 0}},
        Ear1 = {{Name = 'Merman\'s Earring', Priority = 0}},
        Ear2 = {{Name = 'Brutal Earring', Priority = 0}},
        Body = {{Name = 'Nashira Manteel', Priority = 0}}, --3% Haste
        Hands = {{Name = 'Dusk Gloves', Priority = 0}}, --3% Haste
        Ring1 = {{Name = 'Rajas Ring', Priority = 0}},
        Ring2 = {{Name = 'Toreador\'s Ring', Priority = 0}},
        Back = {{Name = 'Forager\'s Mantle', Priority = 0}},
        Waist = {{Name = 'Swift Belt', Priority = 0}}, --6% Haste
        Legs = {{Name = 'Nashira Seraweels', Priority = 0}, {Name = 'Duelist\'s Tights', Priority = 100}, {Name = 'Elder\'s Braguette', Priority = 100}}, --2% Haste
        Feet = {{Name = 'Dusk Ledelsens', Priority = 0}}, --2% Haste
    },

    TankStaff_Priority = { -- PDT -43% or -48%
        Main = {'Earth Staff'}, -- PDT -20%
        Ammo = {{Name = 'Phtm. Tathlum', Priority = 100}}, -- MP +10
        Head = {{Name = 'Darksteel Cap +1', Priority = 0}}, -- PDT -2%
        Ear1 = {{Name = 'Loquac. Earring', Priority = 100}}, -- MP +30
        Ear2 = {{Name = 'Ethereal Earring', Priority = 0}}, -- Convert 3% Damage to MP
        Body = {{Name = 'Dst. Harness +1', Priority = 0}}, -- PDT -4%
        Hands = {{Name = 'Dst. Mittens +1', Priority = 0}}, -- PDT -2%
        Ring1 = {{Name = 'Ether Ring', Priority = 100}}, -- MP +30
        Ring2 = {{Name = 'Jelly Ring', Priority = 0}}, -- PDT -5%
        Back = {{Name = 'Cheviot Cape', Priority = 0}}, -- PDT -5% or -10%
        Waist = {{Name = 'Hierarch Belt', Priority = 100}}, -- MP +48
        Legs = {{Name = 'Dst. Subligar +1', Priority = 0}}, -- PDT -3%
        Feet = {{Name = 'Dst. Leggings +1', Priority = 0}}, -- PDT -2%
    },

    TankShield_Priority = { -- PDT -33% or -38%
        Main = {'Blau Dolch'},
        Sub = {'Genbu\'s Shield'}, -- PDT -10%
        Ammo = {{Name = 'Phtm. Tathlum', Priority = 100}}, -- MP +10
        Head = {{Name = 'Darksteel Cap +1', Priority = 0}}, -- PDT -2%
        Ear1 = {{Name = 'Loquac. Earring', Priority = 100}}, -- MP +30
        Ear2 = {{Name = 'Ethereal Earring', Priority = 0}}, -- Convert 3% Damage to MP
        Body = {{Name = 'Dst. Harness +1', Priority = 0}}, -- PDT -4%
        Hands = {{Name = 'Dst. Mittens +1', Priority = 0}}, -- PDT -2%
        Ring1 = {{Name = 'Ether Ring', Priority = 100}}, -- MP +30
        Ring2 = {{Name = 'Jelly Ring', Priority = 0}}, -- PDT -5%
        Back = {{Name = 'Cheviot Cape', Priority = 0}}, -- PDT -5% or -10%
        Waist = {{Name = 'Hierarch Belt', Priority = 100}}, -- MP +48
        Legs = {{Name = 'Dst. Subligar +1', Priority = 0}}, -- PDT -3%
        Feet = {{Name = 'Dst. Leggings +1', Priority = 0}}, -- PDT -2%
    },

    -- Skill SIRD: 100 - [ (40 flat - level diff to the mob) * (your skill if you had it capped on the job at lvl 75 / your actual skill) then clamped to 100 if it exceeds 100 ]
    SIRD_Priority = { -- 57% (77% w/ Aquaveil)
        Main = {'Hermit\'s Wand'}, -- 25%
        Sub = {'Genbu\'s Shield'}, -- PDT -10%
        Head = {'Nashira Turban'}, -- 10%
        Body = {'Wlk. Tabard +1'}, -- 12%
        Waist = {'Druid\'s Rope'}, -- 10%
    },

    StyleLockCool = {
        Main = 'Wind Staff',
        Head = 'Zenith Crown',
        Body = 'Nashira Manteel',
        Hands = 'Zenith Mitts',
        Legs = 'Zenith Slacks',
        Feet = 'Dream Boots +1',
    },

    StyleLockTank = {
        Main = 'Earth Staff',
        Head = 'Darksteel Cap +1',
        Body = 'Dst. Harness +1',
        Hands = 'Dst. Mittens +1',
        Legs = 'Dst. Subligar +1',
        Feet = 'Dst. Leggings +1',
    },

    Precast_Priority = {
        Head = {{Name = 'Warlock\'s Chapeau', Priority = 100}}, --10
        Ear1 = {{Name = 'Loquac. Earring', Priority = 100}}, --2
        Body = {{Name = 'Duelist\'s Tabard', Priority = 100}}, --10
    },

    INTElementalAcc_Priority = {
        Ammo = {{Name = 'Phtm. Tathlum', Priority = 100}},
        Head = {{Name = 'Warlock\'s Chapeau', Priority = 100}},
        Neck = {{Name = 'Elemental Torque', Priority = 0}},
        Ear1 = {{Name = 'Loquac. Earring', Priority = 100}},
        Ear2 = {{Name = 'Moldavite Earring', Priority = 0}},
        Body = {{Name = 'Nashira Manteel', Priority = 0}},
        Hands = {{Name = 'Errant Cuffs', Priority = 0}},
        Ring2 = {{Name = 'Diamond Ring', Priority = 0}},
        Waist = {{Name = 'Duelist\'s Belt', Priority = 0}},
        Back = {{Name = 'Rainbow Cape', Priority = 100}},
        Legs = {{Name = 'Duelist\'s Tights', Priority = 100}},
        Feet = {{Name = 'Dls. Boots +1', Priority = 100}},
    },

    INTElementalPotency_Priority = {
        Ammo = {{Name = 'Phtm. Tathlum', Priority = 100}},
        Head = {{Name = 'Warlock\'s Chapeau', Priority = 100}},
        Neck = {{Name = 'Philomath Stole', Priority = 0}},
        Ear1 = {{Name = 'Loquac. Earring', Priority = 100}},
        Ear2 = {{Name = 'Moldavite Earring', Priority = 0}},
        Body = {{Name = 'Errant Hpl.', Priority = 0}},
        Hands = {{Name = 'Zenith Mitts', Priority = 100}},
        Ring1 = {{Name = 'Diamond Ring', Priority = 0}},
        Ring2 = {{Name = 'Diamond Ring', Priority = 0}},
        Waist = {{Name = 'Duelist\'s Belt', Priority = 0}},
        Back = {{Name = 'Rainbow Cape', Priority = 100}},
        Legs = {{Name = 'Errant slops', Priority = 0}},
        Feet = {{Name = 'Dls. Boots +1', Priority = 100}},
    },

    INTDarkAcc_Priority = {
        Ammo = {{Name = 'Phtm. Tathlum', Priority = 100}},
        Head = {{Name = 'Warlock\'s Chapeau', Priority = 100}},
        Neck = {{Name = 'Philomath Stole', Priority = 0}},
        Ear1 = {{Name = 'Loquac. Earring', Priority = 100}},
        Ear2 = {{Name = 'Phantom Earring', Priority = 100}},
        Body = {{Name = 'Nashira Manteel', Priority = 0}, {Name = 'Errant Hpl.', Priority = 0}},
        Hands = {{Name = 'Crimson Fng. Gnt.', Priority = 99}, {Name = 'Errant Cuffs', Priority = 0}},
        Ring2 = {{Name = 'Diamond Ring', Priority = 0}},
        Waist = {{Name = 'Duelist\'s Belt', Priority = 0}},
        Back = {{Name = 'Rainbow Cape', Priority = 100}},
        Legs = {{Name = 'Errant slops', Priority = 0}},
        Feet = {{Name = 'Elder\'s Sandals', Priority = 100}},
    },
    INTDark_Priority = {
        Ammo = {{Name = 'Phtm. Tathlum', Priority = 100}},
        Head = {{Name = 'Nashira Turban', Priority = 0}, {Name = 'Warlock\'s Chapeau', Priority = 100}},
        Neck = {{Name = 'Philomath Stole', Priority = 0}},
        Ear1 = {{Name = 'Loquac. Earring', Priority = 100}},
        Ear2 = {{Name = 'Phantom Earring', Priority = 100}},
        Body = {{Name = 'Nashira Manteel', Priority = 0}, {Name = 'Errant Hpl.', Priority = 0}},
        Hands = {{Name = 'Crimson Fng. Gnt.', Priority = 99}, {Name = 'Errant Cuffs', Priority = 0}},
        Ring2 = {{Name = 'Diamond Ring', Priority = 0}},
        Waist = {{Name = 'Duelist\'s Belt', Priority = 0}},
        Back = {{Name = 'Rainbow Cape', Priority = 100}},
        Legs = {{Name = 'Errant slops', Priority = 0}},
        Feet = {{Name = 'Elder\'s Sandals', Priority = 100}},
    },

    DarkSkill_Priority = {
        Body = {{Name = 'Nashira Manteel', Priority = 0}}, -- +5
        Hands = {{Name = 'Crimson Fng. Gnt.', Priority = 99}}, -- +10
        Legs = {{Name = 'Zenith Slacks', Priority = 100}},
    },

    MND_Priority = { -- MND +30 (95 Total): Enhancing Magic Skill + 3×MND - 190 --> 256 + 3*95 - 190 = 351 (350 cap)
        Head = {{Name = 'Zenith Crown', Priority = 100}}, -- MND +3
        Ear1 = {{Name = 'Loquac. Earring', Priority = 100}}, -- FC
        Body = {{Name = 'Errant Hpl.', Priority = 100}}, -- MND +10
        Hands = {{Name = 'Devotee\'s Mitts', Priority = 100}}, -- MND +5
        Ring2 = {{Name = 'Sapphire Ring', Priority = 0}}, -- MND +4
        Back = {{Name = 'Rainbow Cape', Priority = 100}}, -- MND +3
        --Waist = {{Name = 'Duelist\'s Belt', Priority = 0}}, -- MND +4
        --Legs = {{Name = 'Errant slops', Priority = 0}}, -- MND +7
        Feet = {{Name = 'Dls. Boots +1', Priority = 100}}, -- MND +5
    },

    MNDEnfeeb_Priority = {
        Head = {{Name = 'Duelist\'s Chapeau', Priority = 100}},
        Ear1 = {{Name = 'Loquac. Earring', Priority = 100}},
        Neck = {{Name = 'Enfeebling Torque', Priority = 0}},
        Body = {{Name = 'Wlk. Tabard +1', Priority = 100}},
        Hands = {'Devotee\'s Mitts'}, 
        Ring2 = {'Sapphire Ring'},
        Waist = {{Name = 'Duelist\'s Belt', Priority = 0}},
        Back = {{Name = 'Rainbow Cape', Priority = 100}},
        Legs = {{Name = 'Nashira Seraweels', Priority = 0}, {Name = 'Errant slops', Priority = 0}},
        Feet = {{Name = 'Dls. Boots +1', Priority = 100}},
    },

    INTEnfeebSkill_Priority = { -- Enfeeb Skill > INT
        Ammo = {{Name = 'Phtm. Tathlum', Priority = 100}},
        Head = {{Name = 'Duelist\'s Chapeau', Priority = 100}},
        Ear1 = {{Name = 'Loquac. Earring', Priority = 100}},
        Ear2 = {{Name = 'Phantom Earring', Priority = 100}},
        Neck = {{Name = 'Enfeebling Torque', Priority = 0}},
        Body = {{Name = 'Wlk. Tabard +1', Priority = 100}},
        Hands = {{Name = 'Duelist\'s Gloves', Priority = 100}},
        Ring2 = {{Name = 'Diamond Ring', Priority = 0}},
        Waist = {{Name = 'Duelist\'s Belt', Priority = 0}},
        Back = {{Name = 'Rainbow Cape', Priority = 100}},
        Legs = {{Name = 'Nashira Seraweels', Priority = 0}, {Name = 'Errant slops', Priority = 0}},
        Feet = {{Name = 'Elder\'s Sandals', Priority = 100}},
    },

    INTEnfeeb_Priority = { -- INT
        Ammo = {{Name = 'Phtm. Tathlum', Priority = 100}},
        Head = {{Name = 'Warlock\'s Chapeau', Priority = 100}},
        Ear1 = {{Name = 'Loquac. Earring', Priority = 100}},
        Ear2 = {{Name = 'Phantom Earring', Priority = 100}},
        Neck = {{Name = 'Philomath Stole', Priority = 0}},
        Body = {{Name = 'Errant Hpl.', Priority = 0}},
        Hands = {{Name = 'Duelist\'s Gloves', Priority = 100}},
        Ring1 = {{Name = 'Diamond Ring', Priority = 0}},
        Ring2 = {{Name = 'Diamond Ring', Priority = 0}},
        Waist = {{Name = 'Duelist\'s Belt', Priority = 0}},
        Back = {{Name = 'Rainbow Cape', Priority = 100}},
        Legs = {{Name = 'Errant slops', Priority = 0}, {Name = 'Elder\'s Braguette', Priority = 100}},
        Feet = {{Name = 'Elder\'s Sandals', Priority = 100}},
    },

    MNDEnhancing_Priority = {
        Neck = {'Enhancing Torque'}, -- +7
        Hands = {{Name = 'Duelist\'s Gloves', Priority = 100}}, -- +15
        Legs = {'Warlock\'s Tights'}, -- +15
    },

    -- This set plus the Spikes set below let Blaze Spikes proc for 19 unresisted damage. Removing anything in either set now drops Blaze Spikes down to 16
    INTEnhancing_Priority = { -- INT +39 (106 total)
        --Ammo = {'Phtm. Tathlum'}, -- INT +2
        Head = {'Zenith Crown'}, -- INT +3
        Neck = {'Enhancing Torque'}, -- Enhancing +7
        Ear2 = {'Phantom Earring'}, -- INT +1
        Body = {'Errant Hpl.'}, -- INT +10
        Hands = {'Errant Cuffs'}, -- INT +5
        Ring1 = {'Diamond Ring'}, -- INT +4
        Ring2 = {'Diamond Ring'}, -- INT +4
        Back = {'Rainbow Cape'}, -- INT +3
        --Waist = {'Duelist\'s Belt'}, -- INT +4
        Legs = {'Errant Slops'}, -- INT +7
        Feet = {'Elder\'s Sandals'}, -- INT +2
    },

    Spikes_Priority = { -- Relic legs, MAB +23 (28 native, 51 total)
        Neck = {'Uggalepih Pendant'}, -- MAB +8 (conditional but im a galka so lets be real here)
        Ear2 = {'Moldavite Earring'}, -- MAB +5
        Hands = {'Zenith Mitts'}, -- MAB +5
        Legs = {'Duelist\'s Tights'}, -- Spikes+
        Feet = {'Dls. Boots +1'}, -- MAB +5
    },

    -- Before: ((256/5) + 40) == 91
    -- After: ((293/5) + 40) == 98
    EnhancingSkill_Priority = {
        Neck = {'Enhancing Torque'}, -- +7
        Hands = {{Name = 'Duelist\'s Gloves', Priority = 100}}, -- +15
        Legs = {'Warlock\'s Tights'}, -- +15
    },

    MNDHealing_Priority = {
        Ear2 = {{Name = 'Novia Earring', Priority = 0}},
        Body = {{Name = 'Nashira Manteel', Priority = 0}},
        Waist = {{Name = 'Swift Belt', Priority = 0}},
    },

    SpellHaste_Priority = {
        Body = {{Name = 'Nashira Manteel', Priority = 0}},
        Hands = {{Name = 'Dusk Gloves', Priority = 0}},
        Waist = {{Name = 'Swift Belt', Priority = 0}},
        --Feet = {{Name = 'Dusk Ledelsens', Priority = 0}},
    },

    SpellHasteUtsu_Priority = {        
        Body = {{Name = 'Nashira Manteel', Priority = 0}},
        Hands = {{Name = 'Dusk Gloves', Priority = 0}},
        Waist = {{Name = 'Swift Belt', Priority = 0}},
        Feet = {{Name = 'Dusk Ledelsens', Priority = 0}},
    },


    OverlordsRingDrainAspir_Priority = {
        Ring1 = {{Name = 'Overlord\'s Ring', Priority = 0}}
    },

    DilationRingRefreshHaste_Priority = {
        Ring1 = {{Name = 'Dilation Ring', Priority = 0}},
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

    RestingMP_Priority = {
        Main = {'Dark Staff'},
        Head = {{Name = 'Duelist\'s Chapeau', Priority = 100}},
        Ear2 = {'Relaxing Earring'},
        Body = {{Name = 'Wlk. Tabard +1', Priority = 100}, {Name = 'Errant Hpl.', Priority = 0}},
        Waist = {{Name = 'Duelist\'s Belt', Priority = 0}},
    },

    Resting_Priority = {
        Head = {{Name = 'Duelist\'s Chapeau', Priority = 100}},
        Ear2 = {'Relaxing Earring'},
        Body = {{Name = 'Wlk. Tabard +1', Priority = 100}, {Name = 'Errant Hpl.', Priority = 0}},
        Waist = {{Name = 'Duelist\'s Belt', Priority = 0}},
    },

    UglyPP_Priority = {
        Neck = {{Name = 'Uggalepih Pendant', Priority = 100}},
    },

    WeaponSkillEvis_Priority = {
        Neck = {'Light Gorget'},
        Waist = {'Warwolf Belt', {Name = 'Ryl.Kgt. Belt', Priority = 0}},
        Legs = {{Name = 'Duelist\'s Tights', Priority = 100}},
    },

    WSEnergyDrain_Priority = { -- MND
        Body = {{Name = 'Errant Hpl.', Priority = 0}},
        Hands = {'Devotee\'s Mitts'},
        Ring2 = {'Sapphire Ring'},
        Back = {{Name = 'Rainbow Cape', Priority = 100}},
        Waist = {{Name = 'Duelist\'s Belt', Priority = 0}},
        Legs = {{Name = 'Errant slops', Priority = 0}},
        Feet = {{Name = 'Dls. Boots +1', Priority = 100}},
    },

    StealthEarring_Priority = {
        Ear1 = {{Name = 'Stealth Earring', Priority = 0}},
    },

    Reward_Priority = { -- MND
        Ammo = {'Pet Food Zeta', 'Pet Fd. Epsilon', 'Pet Food Delta', 'Pet Fd. Gamma', 'Pet Food Beta', 'Pet Food Alpha'},
        Body = {{Name = 'Errant Hpl.', Priority = 0}},
        Hands = {'Ogre Gloves'},
        Back = {{Name = 'Rainbow Cape', Priority = 100}},
        Ring2 = {'Sapphire Ring'},
        Waist = {{Name = 'Duelist\'s Belt', Priority = 0}},
        Legs = {{Name = 'Errant slops', Priority = 0}},
        Feet = {{Name = 'Dls. Boots +1', Priority = 100}},
    },

    Charm_Priority = {
        --Neck = {'Flower Necklace'},
        Body = {{Name = 'Elder\'s Surcoat', Priority = 100},},
        Back = {'Trimmer\'s Mantle'},
        Legs = {{Name = 'Elder\'s Braguette', Priority = 100}},
    },

    CharmStaff_Priority = {
        Main = {'Light Staff'},
        --Neck = {'Flower Necklace'},
        Body = {{Name = 'Elder\'s Surcoat', Priority = 100},},
        Back = {'Trimmer\'s Mantle'},
        Legs = {{Name = 'Elder\'s Braguette', Priority = 100}},
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
    AshitaCore:GetChatManager():QueueCommand(-1,'/alias /martial /lac fwd Martial ');
    AshitaCore:GetChatManager():QueueCommand(-1,'/alias /pdt /lac fwd pdt ');
    AshitaCore:GetChatManager():QueueCommand(-1,'/alias /enspell /lac fwd enspell ');
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
    elseif (args[1] == 'pdt') then
        Settings.PDT = not Settings.PDT;

        if Settings.PDT then
            gFunc.Message('PDT ON');
        else
            gFunc.Message('PDT OFF');
        end
    elseif (args[1] == 'Martial') then
        Settings.MartialKnife = not Settings.MartialKnife;

        if Settings.MartialKnife then
            gFunc.Message('MartialKnife ON');
        else
            gFunc.Message('MartialKnife OFF');
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
        local spellName = 'Enthunder';

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

        AshitaCore:GetChatManager():QueueCommand(-1,'/ma ' .. spellName .. ' <me>');
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
        gFunc.LockStyle(sets.StyleLockTank);

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
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind +4 /lac fwd blazespikes ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 5 /lac fwd stoneskin ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind +5 /lac fwd phalanx ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 6 /lac fwd silence ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind +6 /lac fwd blink ');
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
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind +4 /lac fwd blazespikes ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 5 /lac fwd stoneskin ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind +5 /lac fwd phalanx ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 6 /lac fwd silence ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind +6 /lac fwd blink ');
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
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind +4 /lac fwd blazespikes ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 5 /lac fwd stoneskin ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind +5 /lac fwd phalanx ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 6 /lac fwd silence ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind +6 /lac fwd blink ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 9 /lac fwd bind ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 0 /lac fwd sleep ');
        else
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 1 /lac fwd haste ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 2 /lac fwd refresh ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 3 /lac fwd regen ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind +3 /lac fwd enspell ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 4 /lac fwd gravity ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind +4 /lac fwd shockspikes ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 5 /lac fwd stoneskin ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind +5 /lac fwd phalanx ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 6 /lac fwd silence ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind +6 /lac fwd blink ');
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
    local player = gData.GetPlayer();
    local myLevel = AshitaCore:GetMemoryManager():GetPlayer():GetMainJobLevel();
    local spikes = gData.GetBuffCount('Blaze Spikes') + gData.GetBuffCount('Shock Spikes') + gData.GetBuffCount('Ice Spikes');

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
            
        elseif player.Status == 'Resting' then
            gFunc.EquipSet(sets.Resting);
        elseif player.Status == 'Engaged' then
            --gFunc.EquipSet(sets.MeleeEngagedAcc);
            gFunc.EquipSet(sets.MeleeEngaged);
        end

        if player.SubJob == 'NIN' then
            if Settings.WeaponTypeToggle then
                gFunc.EquipSet(sets.MeleeWeaponsNIN);
            else
                if Settings.MartialKnife then
                    gFunc.EquipSet(sets.MeleeWeaponsDaggerNINMartial);
                else
                    gFunc.EquipSet(sets.MeleeWeaponsDaggerNIN);
                end
                
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

        if spikes > 0 then
            gFunc.EquipSet(sets.Spikes);
        end

    elseif draginclude.dragSettings.TpVariant == 2 then --Use default set

        gFunc.EquipSet(sets.Default);

        if player.Status == 'Resting' then
            gFunc.EquipSet(sets.RestingMP);
        elseif player.Status == 'Idle' then
            gFunc.EquipSet(sets.Earth);
        end

        if spikes > 0 then
            gFunc.EquipSet(sets.Spikes);
        end
    end

    draginclude.HandleDefault();
    draginclude.CheckSkillingVariant();
    draginclude.CheckStatusArmorSwaps(Settings.StatusArmorSwaps, Settings.CurrentLevel);

    if Settings.PDT then
        if draginclude.dragSettings.TpVariant == 1 then
            gFunc.EquipSet(sets.TankShield);
        elseif draginclude.dragSettings.TpVariant == 2 then
            gFunc.EquipSet(sets.TankStaff);
        end
    end
end

profile.HandleAbility = function()
    local pet = gData.GetPet();
    local ability = gData.GetAction();

    if string.match(ability.Name, 'Reward') then
        gFunc.EquipSet(sets.Reward);
    elseif string.match(ability.Name, 'Charm') then

        if draginclude.dragSettings.TpVariant == 1 then
            gFunc.LockSet(sets.Charm, 1);
        elseif draginclude.dragSettings.TpVariant == 2 then
            gFunc.LockSet(sets.CharmStaff, 1);
        end
    elseif string.match(ability.Name, 'Convert') then
        gFunc.LockSet(sets.Default, 15); -- Wear High MP set for 15 seconds so it doesn't get chopped down by gearswaps
    end
end

profile.HandleItem = function()
    local item = gData.GetAction();
end

profile.HandlePrecast = function()
    local player = gData.GetPlayer();
    local action = gData.GetAction();
    local castTime = action.CastTime;
    local minimumBuffer = 0.4; -- Can be lowered to 0.1 if you want
    local packetDelay = 0.4; -- Change this to 0.4 if you do not use PacketFlow
    local castDelay = ((castTime * (1 - Settings.FastCastValue)) / 1000) - minimumBuffer;
    local chainspell = gData.GetBuffCount('Chainspell');

    if chainspell == 0 then
        gFunc.EquipSet(sets.Precast);

        if Settings.PDT then
            if (castDelay >= packetDelay) then
                gFunc.Message('Equipping Interim ' .. castDelay);
                gFunc.SetMidDelay(castDelay);
            end
        end
    end
end

profile.HandleMidcast = function()
    local spell = gData.GetAction();
    local player = gData.GetPlayer();
    local chainspell = gData.GetBuffCount('Chainspell');

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

    if chainspell == 0 and Settings.PDT then
        if draginclude.dragSettings.TpVariant == 1 then
            draginclude.SetupInterimEquipSet(sets.TankShield);
        elseif draginclude.dragSettings.TpVariant == 2 then
            draginclude.SetupInterimEquipSet(sets.TankStaff);
        end
    end

    if spell.Name == 'Invisible' then
        gFunc.EquipSet(sets.Invisible);
    elseif spell.Name == 'Sneak' then
        gFunc.EquipSet(sets.Sneak);
    elseif spell.Name == 'Stoneskin' then
        gFunc.EquipSet(sets.MND);
    elseif string.contains(spell.Name, 'Spikes') then
        gFunc.EquipSet(sets.INTEnhancing);
    elseif spell.Skill == 'Ninjutsu' then
        gFunc.EquipSet(sets.SpellHasteUtsu);
    elseif spell.Skill == 'Enfeebling Magic' and not string.contains(spell.Name, 'Dia' )then -- Dia and Dia II need zero gearswap
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
        elseif string.contains(spell.Name, 'Bar') or spell.Name == 'Phalanx' then -- Barspells need raw Enhancing Skill
            gFunc.EquipSet(sets.EnhancingSkill); -- +98 Resist
        end
    elseif spell.Skill == 'Healing Magic'  then
        local mpPercent = player.MP / (player.MaxMP + Settings.ConvertMPRefresh);
        
        if spell.Name ~= 'Reraise' and spell.Name ~= 'Raise' and player.MPP < 80 then
            gFunc.EquipSet(sets.MNDHealing);
        elseif spell.Name == 'Raise' and mpPercent < .66 then
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
            gFunc.EquipSet(sets.DarkSkill);
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