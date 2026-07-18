local profile = {};
draginclude = gFunc.LoadFile('common\\draginclude.lua');

local BluMagPhys = T{'Foot Kick', 'Sprout Smack', 'Wild Oats', 'Power Attack', 'Queasyshroom', 'Battle Dance', 'Feather Storm', 'Helldive', 'Bludgeon', 'Claw Cyclone', 'Screwdriver', 'Grand Slam', 'Smite of Rage', 'Pinecone Bomb', 'Jet Stream', 'Uppercut', 'Terror Touch', 'Mandibular Bite', 'Sickle Slash', 'Dimensional Death', 'Spiral Spin', 'Death Scissors', 'Seedspray', 'Body Slam', 'Hydro Shot', 'Frenetic Rip', 'Spinal Cleave', 'Hysteric Barrage', 'Asuran Claws', 'Cannonball', 'Disseverment', 'Ram Charge', 'Vertical Cleave', 'Final Sting', 'Goblin Rush', 'Vanity Dive', 'Whirl of Rage', 'Benthic Typhoon', 'Quad. Continuum', 'Empty Thrash', 'Delta Thrust', 'Heavy Strike', 'Quadrastrike', 'Tourbillion', 'Amorphic Spikes', 'Barbed Crescent', 'Bilgestorm', 'Bloodrake', 'Glutinous Dart', 'Paralyzing Triad', 'Thrashing Assault', 'Sinker Drill', 'Sweeping Gouge', 'Saurian Slide'};
local BluMagDebuff = T{'Filamented Hold', 'Cimicine Discharge', 'Demoralizing Roar', 'Venom Shell', 'Light of Penance', 'Sandspray', 'Auroral Drape', 'Frightful Roar', 'Enervation', 'Infrasonics', 'Lowing', 'CMain Wave', 'Awful Eye', 'Voracious Trunk', 'Sheep Song', 'Soporific', 'Yawn', 'Dream Flower', 'Chaotic Eye', 'Sound Blast', 'Blank Gaze', 'Stinking Gas', 'Geist Wall', 'Feather Tickle', 'Reaving Wind', 'Mortal Ray', 'Absolute Terror', 'Blistering Roar', 'Cruel Joke'};
local BluMagStun = T{'Head Butt', 'Frypan', 'Tail Slap', 'Sub-zero Smash', 'Sudden Lunge'};
local BluMagBuff = T{'Cocoon', 'Refueling', 'Feather Barrier', 'Memento Mori', 'Warm-Up', 'Amplification', 'Triumphant Roar', 'Saline Coat', 'Reactor Cool', 'Plasma Charge', 'Regeneration', 'Animating Wail', 'Battery Charge', 'Winds of Promy.', 'Barrier Tusk', 'Orcish Counterstance', 'Pyric Bulwark', 'Nat. Meditation', 'Restoral', 'Erratic Flutter', 'Carcharian Verve', 'Harden Shell', 'Mighty Guard'};
local BluMagSkill = T{'Metallic Body', 'Diamondhide', 'Magic Barrier', 'Occultation', 'Atra. Libations', 'Zephyr Mantle'};
local BluMagCure = T{'Pollen', 'Healing Breeze', 'Wild Carrot', 'Magic Fruit', 'Plenilune Embrace'};
local BluMagEnmity = T{'Actinic Burst', 'Exuviation', 'Fantod', 'Jettatura', 'Temporal Shift'};

-- Physical Blue Magic stat-mod sub-classification, sourced from the bg-wiki "Calculating Blue Magic
-- Damage" Stat Mod column (cross-referenced against multiple independent, community-maintained
-- GearSwap data files for consistency). Where a spell's secondary stat isn't STR/DEX/VIT/AGI/CHR
-- (e.g. the INT-mod Mandibular Bite/Queasyshroom, or the MND-mod Ram Charge/Screwdriver/Tourbillion),
-- it falls back to STR per user direction, since there's no dedicated INT/MND physical subset.
local BluPhysSTR = T{'Battle Dance', 'Death Scissors', 'Dimensional Death', 'Empty Thrash', 'Quadrastrike', 'Sinker Drill', 'Spinal Cleave', 'Uppercut', 'Vertical Cleave', 'Saurian Slide', 'Bloodrake', 'Mandibular Bite', 'Queasyshroom', 'Ram Charge', 'Screwdriver', 'Tourbillion', 'Bilgestorm', 'Whirl of Rage', 'Sweeping Gouge', 'Final Sting'};
local BluPhysDEX = T{'Amorphic Spikes', 'Asuran Claws', 'Barbed Crescent', 'Claw Cyclone', 'Disseverment', 'Foot Kick', 'Frenetic Rip', 'Goblin Rush', 'Hysteric Barrage', 'Paralyzing Triad', 'Seedspray', 'Sickle Slash', 'Smite of Rage', 'Terror Touch', 'Thrashing Assault', 'Vanity Dive', 'Heavy Strike'};
local BluPhysVIT = T{'Body Slam', 'Cannonball', 'Delta Thrust', 'Glutinous Dart', 'Grand Slam', 'Power Attack', 'Quad. Continuum', 'Sprout Smack'};
local BluPhysAGI = T{'Benthic Typhoon', 'Feather Storm', 'Helldive', 'Hydro Shot', 'Jet Stream', 'Pinecone Bomb', 'Spiral Spin', 'Wild Oats'};
local BluPhysCHR = T{'Bludgeon'};

-- Magical Blue Magic stat-mod sub-classification, same source. Everything not listed here defaults
-- to INT (the standard magic damage stat) - only the spells with a documented MND or CHR mod get
-- their own list. Only applies to the generic magic-damage fallback in HandleMidcast (Cure/Enmity/
-- Stun/White Wind/Dark spells already have their own dedicated, more specific sets).
local BluMagMND = T{'Acrid Stream', 'Magic Hammer', 'Mind Blast'};
local BluMagCHR = T{'Eyes On Me', 'Mysterious Light'};
local BluMagINT = T{'Sandspin', 'Cursed Sphere', 'Bomb Toss', 'Death Ray', 'Blitzstrahl', 'Ice Break', 'Maelstrom', 'Corrosive Ooze', 'Firespit', 'Regurgitation'};

-- Breath spells use a distinct HP-based damage formula rather than scaling off STR/DEX/INT/etc, so
-- they get their own dedicated max-HP set rather than fitting the physical/magical split above.
local BluMagBreath = T{'Bad Breath', 'Flying Hip Press', 'Frost Breath', 'Heat Breath', 'Hecatomb Wave', 'Magnetite Cloud', 'Poison Breath', 'Radiant Breath', 'Self-Destruct', 'Thunder Breath', 'Vapor Spray', 'Wind Breath'};

local Settings = {
    LateInitialized = {
        Initialized = false,
        TimeToUse = 0,
    },
    StatusArmorSwaps = {
        OpoopoNecklace = true,
        PresidentialHairpin = false,
    },
    CurrentLevel = 0,
    WeaponTypeToggle = false, -- true = Sword | false = dagger
    PDT = false,
    MDT = false,
    SIRD = true,
    FastCastValue = 0, -- 20% from traits 22% from gear listed in Precast set
    MeleeAcc = true
};

local sets = {
    Default_Priority = {
        Ammo = {'Hedgehog Bomb', 'Phtm. Tathlum', 'Fortune Egg'},
        Head = {'Duelist\'s Chapeau', 'Egg Helm'},
        Neck = {'Uggalepih Pendant', 'Peacock Amulet'},
        Ear1 = {'Loquac. Earring'},
        Ear2 = {'Novia Earring', 'Phantom Earring', },
        Body = {'Wlk. Tabard +1', 'Elder\'s Surcoat'},
        Hands = {'Zenith Mitts', 'Elder\'s Bracers'},
        Ring1 = {'Ether Ring', 'Astral Ring'},
        Ring2 = {'Jelly Ring'},
        Back = {'Altruistic Cape', 'Trimmer\'s Mantle'},
        Waist = {'Hierarch Belt', 'Ryl. Kgt. Belt'},
        Legs = {'Crimson Cuisses', 'Elder\'s Braguette'},
        Feet = {'Dls. Boots +1', 'Elder\'s Sandals'},
    },

    Default_Priority = {
        Ammo = {'Hedgehog Bomb', 'Phtm. Tathlum', 'Fortune Egg'},
        Head = {'Nashira Turban', 'Dream Hat +1'},
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

    MeleeWeapons_Priority = {
	    Main = {'Shiva\'s Shotel'},
        Sub = {'Genbu\'s Shield'},
    },

    MeleeWeaponsNIN_Priority = {
	    Main = {'Shiva\'s Shotel'},
	    Sub = {'Ifrit\'s Blade'},
    },

    MeleeEngagedAcc_Priority = {
	    Ammo = {'Tiphia Sting'},
	    Head = {'Homam Zucchetto'},
	    Neck = {'Peacock Amulet'},
	    Ear1 = {'Brutal Earring'},
	    Ear2 = {'Stealth Earring'},
	    Body = {'Homam Corazza'},
	    Hands = {'Homam Manopolas'},
	    Ring1 = {'Rajas Ring'},
	    Ring2 = {'Toreador\'s Ring'},
	    Back = {'Forager\'s Mantle'},
	    Waist = {'Sonic Belt'},
	    Legs = {'Homam Cosciales'},
	    Feet = {'Homam Gambieras'},
    },

    MeleeEngaged_Priority = {
	    Ammo = {'Tiphia Sting'},
	    Head = {'Homam Zucchetto'},
	    Neck = {'Peacock Amulet'},
	    Ear1 = {'Brutal Earring'},
	    Ear2 = {'Stealth Earring'},
	    Body = {'Nashira Manteel'},
	    Hands = {'Homam Manopolas'},
	    Ring1 = {'Rajas Ring'},
	    Ring2 = {'Toreador\'s Ring'},
	    Back = {'Forager\'s Mantle'},
	    Waist = {'Sonic Belt'},
	    Legs = {'Homam Cosciales'},
	    Feet = {'Homam Gambieras'},
    },

    MDT_Priority = { -- PDT -13% or 18%, MDT -17%
        Ammo = {'Phtm. Tathlum'}, -- MP +10
        Head = {'Darksteel Cap +1'}, -- PDT -2%
        Neck = {'Jeweled Collar'},
        Ear1 = {'Merman\'s Earring'}, -- MP +30
        Ear2 = {'Merman\'s Earring'}, -- Convert 3% Damage to MP
        Body = {'Dst. Harness +1'}, -- PDT -4%
        Hands = {'Dst. Mittens +1'}, -- PDT -2%
        Ring1 = {'Merman\'s Ring'}, -- MP +30
        Ring2 = {'Merman\'s Ring'}, -- PDT -5%
        Back = {'Cheviot Cape'}, -- PDT -5% or -10%
        Waist = {'Hierarch Belt'}, -- MP +48
        Legs = {'Coral Cuisses +1'}, -- PDT -3%
        Feet = {'Coral Greaves +1'}, -- PDT -2%
    },

    -- 4 SIRD Merits = 8%
    -- 25% + 8% + 42% = 75% (95% w/ Aquaveil)
    SIRDWeapons_Priority = {
        Main = {'Hermit\'s Wand'}, -- 25%
        Sub = {'Genbu\'s Shield'}, -- PDT -10%
    },

    -- 50% + 8% + 42% = 100% (120% w/ Aquaveil)
    SIRDNINWeapons_Priority = {
        Main = {'Hermit\'s Wand'}, -- 25%
        Sub = {'Hermit\'s Wand'}, -- 25%
    },

    -- 42%
    SIRD_Priority = {
        Head = {'Nashira Turban'}, -- 10%
        Neck = {'Willpower Torque'}, -- 5%
        Waist = {'Druid\'s Rope'}, -- 10%
        Feet = {'Mountain Gaiters'}, -- 5%
    },

    -- 22%
    SIRDLow_Priority = {
        Head = {'Nashira Turban'}, -- 10%
        --Neck = {'Willpower Torque'}, -- 5%
        --Waist = {'Druid\'s Rope'}, -- 10%
        --Feet = {'Mountain Gaiters'}, -- 5%
    },

    StyleLock = {
        Main = 'Auster\'s Staff',
        Head = 'Nashira Turban',
        Body = 'Nashira Manteel',
        Hands = 'Nashira Gages',
        Legs = 'Nashira Seraweels',
        Feet = 'Hydra Spats',
    },

    StyleLockCool = {
        Main = 'Auster\'s Staff',
        Head = 'Zenith Crown',
        Body = 'Nashira Manteel',
        Hands = 'Zenith Mitts',
        Legs = 'Zenith Slacks',
        Feet = 'Dream Boots +1',
    },

    StyleLockTank = {
        Main = 'Terra\'s Staff',
        Head = 'Darksteel Cap +1',
        Body = 'Dst. Harness +1',
        Hands = 'Dst. Mittens +1',
        Legs = 'Dst. Subligar +1',
        Feet = 'Dst. Leggings +1',
    },

    StyleLockWinter = {
        Main = 'Vulcan\'s Staff',
        Head = 'Dream Hat +1',
        Body = 'Dream Robe +1',
        Hands = 'Dream Mittens +1',
        Legs = 'Dream Trousers +1',
        Feet = 'Dream Boots +1',
    },

    Precast_Priority = {
        Ear1 = {'Loquac. Earring'}, --2
    },

    INTElementalAcc_Priority = { -- Elemental Skill +32, Macc +5, Matk +10, INT +21
        Ammo = {'Phtm. Tathlum'}, -- INT +2
        Neck = {'Elemental Torque'}, -- Elemental Skill +7
        Ear1 = {'Loquac. Earring'}, -- Fast Cast
        Ear2 = {'Moldavite Earring'}, -- Matk +5
        Body = {'Nashira Manteel'}, -- Macc +5
        Hands = {'Errant Cuffs'}, -- INT +5
        Ring2 = {'Snow Ring'}, -- INT +5
        Ring2 = {'Snow Ring'}, -- INT +5
        Back = {'Merciful Cape'}, -- Elemental Skill +5
    },

    INTElementalPotency_Priority = { -- Elemental Skill +15, Matk +15, INT +37
        Ammo = {'Phtm. Tathlum'}, -- INT +2
        Neck = {'Philomath Stole'}, -- INT +3
        Ear1 = {'Loquac. Earring'}, -- Fast Cast
        Ear2 = {'Moldavite Earring'}, -- Matk +5
        Body = {'Errant Hpl.'}, -- INT +10
        Hands = {'Zenith Mitts'}, -- Matk +5
        Ring1 = {'Snow Ring'}, -- INT +5
        Ring2 = {'Snow Ring'}, -- INT +5
        Back = {'Merciful Cape'}, -- Elemental Skill +5
        Legs = {'Mahatma Slops'}, -- INT +8
    },

    INTDarkAcc_Priority = {
        Ammo = {'Phtm. Tathlum'},
        Neck = {'Philomath Stole'},
        Ear1 = {'Loquac. Earring'},
        Ear2 = {'Phantom Earring'},
        Body = {'Nashira Manteel', 'Errant Hpl.'},
        Hands = {'Crimson Fng. Gnt.', 'Errant Cuffs'},
        Ring1 = {'Snow Ring'},
        Ring2 = {'Snow Ring'},
        Back = {'Merciful Cape'}, -- Dark Skill +5
        Legs = {'Mahatma Slops'},
        Feet = {'Elder\'s Sandals'},
    },

    INTDark_Priority = {
        Ammo = {'Phtm. Tathlum'},
        Head = {'Nashira Turban'},
        Neck = {'Philomath Stole'},
        Ear1 = {'Loquac. Earring'},
        Ear2 = {'Phantom Earring'},
        Body = {'Nashira Manteel', 'Errant Hpl.'},
        Hands = {'Crimson Fng. Gnt.', 'Errant Cuffs'},
        Ring1 = {'Snow Ring'},
        Ring2 = {'Snow Ring'},
        Back = {'Merciful Cape'}, -- Dark Skill +5
        Legs = {'Mahatma Slops'},
        Feet = {'Elder\'s Sandals'},
    },

    DarkSkill_Priority = { -- Dark Skill +20
        Body = {'Nashira Manteel'}, -- +5
        Hands = {'Crimson Fng. Gnt.'}, -- +10
        Back = {'Merciful Cape'}, -- +5
    },

    MND_Priority = { -- MND +32 (100 Total): Enhancing Magic Skill + 3×MND - 190 --> 256 + 3*98 - 190 = 360 (350 cap)
        Head = {'Zenith Crown'}, -- MND +3
        Ear1 = {'Loquac. Earring'}, -- FC
        Body = {'Errant Hpl.'}, -- MND +10
        Hands = {'Dvt. Mitts +1'}, -- MND +6
        Ring2 = {'Aqua Ring'}, -- MND +5
        Back = {'Prism Cape'}, -- MND +4
        Legs = {'Mahatma Slops'}, -- MND +8
    },

    Stoneskin_Priority = { -- MND +33 (106 Total): Enhancing Magic Skill + 3×MND - 190 --> 256 + 3*100 - 190 = 360 (350 cap)
        Head = {'Zenith Crown'}, -- MND +3
        Ear1 = {'Loquac. Earring'}, -- FC
        Body = {'Errant Hpl.'}, -- MND +10
        Hands = {'Dvt. Mitts +1'}, -- MND +6
        Ring2 = {'Aqua Ring'}, -- MND +5
        Back = {'Prism Cape'}, -- MND +4
        Legs = {'Mahatma Slops'}, -- MND +8
    },

    MNDEnfeeb_Priority = {
        Ear1 = {'Loquac. Earring'},
        Ear2 = {'Cmn. Earring'}, -- MND +2
        Neck = {'Enfeebling Torque'},
        Hands = {'Dvt. Mitts +1'}, 
        Ring1 = {'Aqua Ring'},
        Ring2 = {'Aqua Ring'},
        Back = {'Altruistic Cape', 'Prism Cape'},
        Legs = {'Nashira Seraweels', 'Mahatma Slops'},
    },

    INTEnfeebSkill_Priority = { -- Enfeeb Skill > INT
        Ammo = {'Phtm. Tathlum'},
        Ear1 = {'Loquac. Earring'},
        Ear2 = {'Phantom Earring'},
        Neck = {'Enfeebling Torque'},
        Hands = {'Errant Cuffs'},
        Ring1 = {'Snow Ring'},
        Ring2 = {'Snow Ring'},
        Back = {'Altruistic Cape', 'Prism Cape'},
        Legs = {'Nashira Seraweels', 'Mahatma Slops'},
        Feet = {'Elder\'s Sandals'},
    },

    INTEnfeeb_Priority = { -- INT
        Ammo = {'Phtm. Tathlum'},
        Ear1 = {'Loquac. Earring'},
        Ear2 = {'Phantom Earring'},
        Neck = {'Philomath Stole'},
        Body = {'Errant Hpl.'},
        Hands = {'Errant Cuffs'},
        Ring1 = {'Snow Ring'},
        Ring2 = {'Snow Ring'},
        Back = {'Altruistic Cape', 'Prism Cape'},
        Legs = {'Mahatma Slops', 'Elder\'s Braguette'},
        Feet = {'Elder\'s Sandals'},
    },

    EnhancingSkill_Priority = {
        Neck = {'Enhancing Torque'}, -- +7
        Back = {'Merciful Cape'}, -- +5
    },

    MNDHealing_Priority = {
        Ear2 = {'Novia Earring'},
        Body = {'Nashira Manteel'},
        Waist = {'Sonic Belt', 'Swift Belt'},
    },

    SpellHaste_Priority = {
        Head = {'Nashira Turban'},
        Body = {'Nashira Manteel'},
        Hands = {'Dusk Gloves'},
        Waist = {'Sonic Belt', 'Swift Belt'},
        Legs = {'Nashira Seraweels'},
        Feet = {'Dusk Ledelsens'},
    },

    SpellHasteUtsu_Priority = {        
        Head = {'Nashira Turban'},
        Body = {'Nashira Manteel'},
        Hands = {'Dusk Gloves'},
        Waist = {'Sonic Belt', 'Swift Belt'},
        Legs = {'Nashira Seraweels'},
        Feet = {'Dusk Ledelsens'},
    },


    OverlordsRingDrainAspir_Priority = {
        Ring2 = {'Overlord\'s Ring'}
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

    Resting_Priority = {
        Ear2 = {'Relaxing Earring'},
        Body = {'Errant Hpl.'},
    },

    UglyPP_Priority = {
        Neck = {'Uggalepih Pendant'},
    },

    WeaponSkillEvis_Priority = {
        Neck = {'Love Torque'},
        Waist = {'Warwolf Belt', 'Ryl.Kgt. Belt'},
        Legs = {'Duelist\'s Tights'},
    },

    StealthEarring_Priority = {
        Ear1 = {'Stealth Earring'},
    },

    Reward_Priority = { -- MND
        Ammo = {'Pet Food Zeta', 'Pet Fd. Epsilon', 'Pet Food Delta', 'Pet Fd. Gamma', 'Pet Food Beta', 'Pet Food Alpha'},
        Head = {'Zenith Crown'},
        Neck = {'Ajari Beads'}, -- MND +6
        Ear2 = {'Cmn. Earring'}, -- MND +2
        Body = {'Errant Hpl.'},
        Hands = {'Ogre Gloves'},
        Back = {'Prism Cape'},
        Ring1 = {'Aqua Ring'},
        Ring2 = {'Aqua Ring'},
        Legs = {'Mahatma Slops'},
    },

    Charm_Priority = {
        Body = {'Elder\'s Surcoat',},
        Back = {'Trimmer\'s Mantle'},
        Legs = {'Elder\'s Braguette'},
    },

    Invisible = {
        Hands = 'Dream Mittens +1',
    },

    Sneak = {
        Feet = 'Dream Boots +1',
    },
};

profile.Sets = sets;

local ObiTable = {
    Fire = "Karin Obi",
    Earth = "Dorin Obi",
    --Water = "Suirin Obi",
    Wind = "Furin Obi",
    Ice = "Hyorin Obi",
    Thunder = "Rairin Obi",
    --Light = "Korin Obi",
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
    AshitaCore:GetChatManager():QueueCommand(-1,'/alias /pdt /lac fwd pdt ');
    AshitaCore:GetChatManager():QueueCommand(-1,'/alias /mdt /lac fwd mdt ');
    AshitaCore:GetChatManager():QueueCommand(-1,'/alias /sird /lac fwd SIRD ');
    AshitaCore:GetChatManager():QueueCommand(-1,'/alias /acc /lac fwd MeleeAcc ');
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
    elseif (args[1] == 'mdt') then
        Settings.MDT = not Settings.MDT;

        if Settings.MDT then
            gFunc.Message('MDT ON');
        else
            gFunc.Message('MDT OFF');
        end
    elseif (args[1] == 'SIRD') then
        Settings.SIRD = not Settings.SIRD;

        if Settings.SIRD then
            gFunc.Message('SIRD ON');
        else
            gFunc.Message('SIRD OFF');
        end
    elseif (args[1] == 'MeleeAcc') then
        Settings.MeleeAcc = not Settings.MeleeAcc;

        if Settings.MeleeAcc then
            gFunc.Message('MeleeAcc ON');
        else
            gFunc.Message('MeleeAcc OFF');
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
    elseif (args[1] == 'utsusemiichi') then
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma "Utsusemi: Ichi" <me>');
    elseif (args[1] == 'utsusemini') then
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma "Utsusemi: Ni" <me>');
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
    draginclude.HandleDrgCoreCommands(args);
end

profile.LateInitialize = function()
    local timestamp = os.time();
    local player = gData.GetPlayer();

    if timestamp >= Settings.LateInitialized.TimeToUse then
        -- Setting a Style Lock prevents the character from blinking
        gFunc.LockStyle(sets.StyleLock);

        AshitaCore:GetChatManager():QueueCommand(1, '/macro book 19');
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
    local shadows = gData.GetBuffCount('Copy Image') + gData.GetBuffCount('Copy Image (2)') + gData.GetBuffCount('Copy Image (3)') + gData.GetBuffCount('Copy Image (4+)');

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

    gFunc.EquipSet(sets.Default);

    if draginclude.dragSettings.TpVariant == 1 then
        if Settings.Acc then
            gFunc.EquipSet(sets.MeleeEngagedAcc);
        else
            gFunc.EquipSet(sets.MeleeEngaged);
        end
    elseif draginclude.dragSettings.TpVariant == 2 then
        gFunc.EquipSet(sets.Earth);
    end

    if player.Status == 'Engaged' then
        if player.SubJob == 'NIN' then
            gFunc.EquipSet(sets.MeleeWeaponsNIN);
        else
            gFunc.EquipSet(sets.MeleeWeapons);
        end
    elseif player.Status == 'Resting' then
        gFunc.EquipSet(sets.Resting);
    end

    if (pet ~= nil) then
        if (petAction ~= nil) then
            HandlePetAction(petAction);
            return;
        end
    end

    draginclude.HandleDefault();

    if Settings.MDT then
        gFunc.EquipSet(sets.MDT);
    elseif Settings.PDT then
        gFunc.EquipSet(sets.PDT);
    end
end

profile.HandleAbility = function()
    local pet = gData.GetPet();
    local ability = gData.GetAction();

    if string.match(ability.Name, 'Reward') then
        gFunc.EquipSet(sets.Reward);
    elseif string.match(ability.Name, 'Charm') then
        gFunc.LockSet(sets.Charm, 1);
    end
end

profile.HandleItem = function()
    local item = gData.GetAction();

	if item.Name == 'Silent Oil' then 
        gFunc.EquipSet(sets.Sneak);
    elseif item.Name == 'Prism Powder' then 
        gFunc.EquipSet(sets.Invisible);
    end
end

profile.HandlePrecast = function()
    local player = gData.GetPlayer();
    local action = gData.GetAction();
    local target = gData.GetActionTarget();
    local castTime = action.CastTime;
    local minimumBuffer = 0.4; -- Can be lowered to 0.1 if you want
    local packetDelay = 0.4; -- Change this to 0.4 if you do not use PacketFlow
    local castDelay = ((castTime * (1 - Settings.FastCastValue)) / 1000) - minimumBuffer;

    gFunc.EquipSet(sets.Precast);

    if Settings.SIRD then
        if (castDelay >= packetDelay) then
            gFunc.Message('Equipping Interim ' .. castDelay);
            gFunc.SetMidDelay(castDelay);
        end
    end
end

profile.HandleMidcast = function()
    local spell = gData.GetAction();
    local player = gData.GetPlayer();
    local target = gData.GetActionTarget();
    local diff = gData.GetBuffCount('Diffusion');
    local ca = gData.GetBuffCount('Chain Affinity');
    local ba = gData.GetBuffCount('Burst Affinity');

    Settings.SpellElement = spell.Element;
    gFunc.Message(spell.Name .. ' ' .. spell.Skill .. ' ' .. spell.Type .. ' ' .. spell.Element);

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

    if chainspell == 0 and Settings.SIRD and not Settings.ConvertToggle then
        if draginclude.dragSettings.TpVariant == 1 then
            draginclude.SetupInterimEquipSet(sets.SIRD); -- 50% SIRD (70% w/ Aquaveil)
        elseif draginclude.dragSettings.TpVariant == 2 then
            if player.SubJob == 'NIN' then
                if aquaveil > 0 then
                    draginclude.SetupInterimEquipSet(gFunc.Combine(sets.SIRDLow, sets.SIRDNINWeapons));
                else
                    draginclude.SetupInterimEquipSet(gFunc.Combine(sets.SIRD, sets.SIRDNINWeapons));
                end
            else
                draginclude.SetupInterimEquipSet(gFunc.Combine(sets.SIRD, sets.SIRDWeapons));
            end
        end
    end

    if spell.Name == 'Invisible' then
        gFunc.EquipSet(sets.Invisible);
    elseif spell.Name == 'Sneak' then
        gFunc.EquipSet(sets.Sneak);
    elseif spell.Name == 'Stoneskin' then
        gFunc.EquipSet(sets.Stoneskin);
    elseif spell.Skill == 'Ninjutsu' then
        gFunc.EquipSet(sets.SpellHasteUtsu);
    elseif (BluMagBreath:contains(action.Name)) then
        gFunc.EquipSet('BluBreath')

        equipObiIfApplicable(spell.Element);
    elseif (BluMagPhys:contains(spell.Name)) then
        gcmelee.EquipBluPhysical()
        if (BluPhysSTR:contains(spell.Name)) then 
            gFunc.EquipSet('BluPhysical_STR')
        elseif (BluPhysDEX:contains(spell.Name)) then 
            gFunc.EquipSet('BluPhysical_DEX')
        elseif (BluPhysVIT:contains(spell.Name)) then 
            gFunc.EquipSet('BluPhysical_VIT')
        elseif (BluPhysAGI:contains(spell.Name)) then 
            gFunc.EquipSet('BluPhysical_AGI')
        elseif (BluPhysCHR:contains(spell.Name)) then 
            gFunc.EquipSet('BluPhysical_CHR')
        end
    elseif (spell.Skill == 'Blue Magic') then
        if (BluMagBuff:contains(spell.Name)) then
            gFunc.EquipSet('CMP') -- non-skill-scaling buffs (Refueling, Plasma Charge, etc.)
        elseif (BluMagSkill:contains(spell.Name)) then
            gFunc.EquipSet('BluSkill') -- skill-scaling buffs/defenses (e.g. Zephyr Mantle)
        elseif (BluMagDebuff:contains(spell.Name)) then
            gFunc.EquipSet('BluMagicAccuracy')
        else
            gFunc.EquipSet('BluMagical')

            if (BluMagStun:contains(spell.Name)) then 
                gFunc.EquipSet('BluStun')
            elseif (BluMagCure:contains(spell.Name)) then 
                gFunc.EquipSet('Cure')
            elseif (BluMagEnmity:contains(spell.Name)) then 
                gFunc.EquipSet('Enmity')
            elseif (spell.Name == 'White Wind') then 
                gFunc.EquipSet('WhiteWind')
            else
                -- Generic magic-damage nuke (including Everyone's Grudge/Tenebral Crush, which used to
                -- get a dedicated BluDark set - now just fall through to their stat-mod classification
                -- like everything else): layer the stat-specific subset on top of BluMagical. INT is
                -- the default for anything not explicitly MND/CHR/INT-classified above.
                if (BluMagMND:contains(spell.Name)) then 
                    gFunc.EquipSet('BluMagical_MND')
                elseif (BluMagCHR:contains(spell.Name)) then 
                    gFunc.EquipSet('BluMagical_CHR')
                elseif (BluMagINT:contains(spell.Name)) then 
                    gFunc.EquipSet('BluMagical_INT')
                else 
                    gFunc.EquipSet('BluMagical_INT') -- unclassified spells still default to INT
                end
            end

            if (ca >= 1) then 
                gFunc.EquipSet('Ca') end
            if (ba >= 1) then 
                gFunc.EquipSet('Ba') end
            if (diff >= 1) then 
                gFunc.EquipSet('Diffusion') 
            end
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

    gFunc.EquipSet(sets.WS);

    if (ws.Name == 'Vorpal Blade') then
        gFunc.EquipSet(sets.Vorpal);
    elseif (ws.Name == 'Savage Blade') then
        gFunc.EquipSet(sets.SavageBlade);
    end

    if (gcdisplay.GetCycle('TP') == 'HighAcc') then
        gFunc.EquipSet('Ws_HighAcc')
    end

    draginclude.HandleWeaponSkill(action);
end

return profile;