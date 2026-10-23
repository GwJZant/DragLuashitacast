local profile = {};
draginclude = gFunc.LoadFile('common\\draginclude.lua');

local BluMagPhys = T{'Foot Kick', 'Sprout Smack', 'Wild Oats', 'Power Attack', 'Queasyshroom', 'Battle Dance', 'Feather Storm', 'Helldive', 'Bludgeon', 'Claw Cyclone', 'Screwdriver', 'Grand Slam', 'Smite of Rage', 'Pinecone Bomb', 'Jet Stream', 'Uppercut', 'Terror Touch', 'Mandibular Bite', 'Sickle Slash', 'Dimensional Death', 'Spiral Spin', 'Death Scissors', 'Seedspray', 'Body Slam', 'Hydro Shot', 'Frenetic Rip', 'Spinal Cleave', 'Hysteric Barrage', 'Asuran Claws', 'Cannonball', 'Disseverment', 'Ram Charge', 'Vertical Cleave', 'Final Sting', 'Goblin Rush', 'Vanity Dive', 'Whirl of Rage', 'Benthic Typhoon', 'Quad. Continuum', 'Empty Thrash', 'Delta Thrust', 'Heavy Strike', 'Quadrastrike', 'Tourbillion', 'Amorphic Spikes', 'Barbed Crescent', 'Bilgestorm', 'Bloodrake', 'Glutinous Dart', 'Paralyzing Triad', 'Thrashing Assault', 'Sinker Drill', 'Sweeping Gouge', 'Saurian Slide'};
local BluMagDebuff = T{'Filamented Hold', 'Cimicine Discharge', 'Demoralizing Roar', 'Venom Shell', 'Light of Penance', 'Sandspray', 'Auroral Drape', 'Frightful Roar', 'Enervation', 'Infrasonics', 'Lowing', 'CMain Wave', 'Awful Eye', 'Voracious Trunk', 'Sheep Song', 'Soporific', 'Yawn', 'Dream Flower', 'Chaotic Eye', 'Sound Blast', 'Blank Gaze', 'Stinking Gas', 'Geist Wall', 'Feather Tickle', 'Reaving Wind', 'Mortal Ray', 'Absolute Terror', 'Blistering Roar', 'Cruel Joke'};
local BluMagStun = T{};
local BluPhysStun = T{'Head Butt', 'Frypan', 'Tail Slap', 'Sub-zero Smash', 'Sudden Lunge'};
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
local BluMagINT = T{'MP Drainkiss', 'Sandspin', 'Cursed Sphere', 'Bomb Toss', 'Death Ray', 'Blitzstrahl', 'Ice Break', 'Maelstrom', 'Corrosive Ooze', 'Firespit', 'Regurgitation'};

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
    MeleeAcc = true,
	ConvertMPNuke = 0,
    Learn = false,
    Verm = false,
    LockEth = false,
    BreathLock = false,
};

local sets = {
    Default_Priority = {
        Ammo = {'Hedgehog Bomb', 'Phtm. Tathlum', 'Fortune Egg'},
        Head = {'Darksteel Cap +1', 'Emperor Hairpin', 'Faceguard', 'Dream Hat +1'},
        Neck = {'Jeweled Collar', 'Ajase Beads'},
        Ear1 = {'Merman\'s Earring', 'Phantom Earring'},
        Ear2 = {'Merman\'s Earring', 'Bloodbead Earring'},
        --Body = {'Dst. Harness +1', 'Scp. Harness +1', 'Elder\'s Surcoat', 'Dream Robe +1'},
        Body = {'Mirage Jubbah', 'Scp. Harness +1', 'Elder\'s Surcoat', 'Dream Robe +1'},
        Hands = {'Dst. Mittens +1', 'Magus Bazubands', 'Elder\'s Bracers', 'Dream Mittens +1'},
        Ring1 = {'Merman\'s Ring', 'Rajas Ring'},
        Ring2 = {'Merman\'s Ring', 'Ether Ring', 'Astral Ring'},
        Back = {'Cheviot Cape', 'Trimmer\'s Mantle'},
        Waist = {'Desert Sash', 'Druid\'s Rope'},
        Legs = {'Crimson Cuisses', 'Coral Cuisses +1', 'Magus Shalwar', 'Elder\'s Braguette', 'Dream Trousers +1'},
        Feet = {'Coral Greaves +1', 'Magus Charuqs', 'Mountain Gaiters', 'Elder\'s Sandals', 'Dream Boots +1'},
    },

    MeleeEngagedAcc_Priority = {
	    Ammo = {'Tiphia Sting'},
	    Head = {'Nashira Turban', 'Optical Hat', 'Emperor Hairpin'},
	    Neck = {'Peacock Amulet'},
	    Ear1 = {'Brutal Earring', 'Merman\'s Earring'},
	    Ear2 = {'Merman\'s Earring'},
	    Body = {'Mirage Jubbah', 'Scp. Harness +1'},
	    Hands = {'Homam Manopolas', 'Dusk Gloves'},
	    Ring1 = {'Rajas Ring'},
	    Ring2 = {'Toreador\'s Ring'},
	    Back = {'Forager\'s Mantle'},
	    Waist = {'Sonic Belt', 'Swift Belt'},
	    Legs = {'Homam Cosciales'},
	    Feet = {'Homam Gambieras', 'Dusk Ledelsens'},
    },

    MeleeEngaged_Priority = {
	    Ammo = {'Tiphia Sting'},
	    Head = {'Nashira Turban', 'Optical Hat', 'Emperor Hairpin'},
	    Neck = {'Peacock Amulet'},
	    Ear1 = {'Brutal Earring', 'Merman\'s Earring'},
	    Ear2 = {'Merman\'s Earring'},
	    Body = {'Mirage Jubbah', 'Scp. Harness +1'},
	    Hands = {'Homam Manopolas', 'Dusk Gloves'},
	    Ring1 = {'Rajas Ring'},
	    Ring2 = {'Toreador\'s Ring'},
	    Back = {'Forager\'s Mantle'},
	    Waist = {'Sonic Belt', 'Swift Belt'},
	    Legs = {'Homam Cosciales'},
	    Feet = {'Homam Gambieras', 'Dusk Ledelsens'},
    },

    MDT_Priority = { -- PDT -13% or 18%, MDT -17%
        Ammo = {'Phtm. Tathlum'}, -- INT +2
        Head = {'Darksteel Cap +1'}, -- PDT -2%
        Neck = {'Jeweled Collar'}, -- Res +10
        Ear1 = {'Merman\'s Earring'}, -- MDT -2%
        Ear2 = {'Merman\'s Earring'}, -- MDT -2%
        Body = {'Dst. Harness +1'}, -- PDT -4%
        Hands = {'Dst. Mittens +1'}, -- PDT -2%
        Ring1 = {'Merman\'s Ring'}, -- MDT -4%
        Ring2 = {'Merman\'s Ring'}, -- MDT -4%
        Back = {'Cheviot Cape'}, -- PDT -5% or -10%
        Waist = {'Hierarch Belt'}, -- MP +48
        Legs = {'Coral Cuisses +1'}, -- MDT -3%
        Feet = {'Coral Greaves +1'}, -- MDT -2%
    },
	
	PDT_Priority = { -- PDT -13% or 18%, MDT -17%
        Ammo = {'Phtm. Tathlum'}, -- INT +2
        Head = {'Darksteel Cap +1'}, -- PDT -2%
        Neck = {'Jeweled Collar'}, -- Res +10
        Ear1 = {'Merman\'s Earring'}, -- MDT -2%
        Ear2 = {'Merman\'s Earring'}, -- MDT -2%
        Body = {'Dst. Harness +1'}, -- PDT -4%
        Hands = {'Dst. Mittens +1'}, -- PDT -2%
        Ring1 = {'Merman\'s Ring'}, -- MDT -4%
        Ring2 = {'Merman\'s Ring'}, -- MDT -4%
        Back = {'Cheviot Cape'}, -- PDT -5% or -10%
        Waist = {'Hierarch Belt'}, -- MP +48
        Legs = {'Coral Cuisses +1'}, -- MDT -3%
        Feet = {'Coral Greaves +1'}, -- MDT -2%
    },

    Vermillion = {
        Head = 'displaced',
        Body = 'Vermillion Cloak',
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
        Body = {'Mirage Jubbah'},
        Waist = {'Druid\'s Rope'}, -- 10%
        Legs = {'Magus Shalwar'}, -- 10%
        Feet = {'Mountain Gaiters'}, -- 5%
    },

    -- 22%
    SIRDLow_Priority = {
        Head = {'Nashira Turban'}, -- 10%
        Neck = {'Willpower Torque'}, -- 5%
        Body = {'Mirage Jubbah'},
        Waist = {'Druid\'s Rope'}, -- 10%
        Legs = {'Magus Shalwar'}, -- 10%
        Feet = {'Mountain Gaiters'}, -- 5%
    },

    Precast_Priority = {
        Ear1 = {'Loquac. Earring'}, --2
		Legs = {'Homam Cosciales'}, --2
    },

    Ethereal_Priority = {
        Ear1 = {'Ethereal Earring'},
    },
	
	BluBreath2_Priority = {
        Ammo = {''},
		Head = {'Mirage Keffiyeh'}, -- Breath + 5%
        --Head = {'Mirage Keffiyeh'}, BLU +5
        Neck = {'Uggalepih Pendant'},
        Ear1 = {''},
        Ear2 = {'Moldavite Earring'},
        Body = {'Nashira Manteel'}, -- Macc +5
        Body = {'Magus Jubbah'}, -- BLU +15
        Hands = {'Nashira Gages'}, -- Macc +3
        Ring1 = {''},
        Ring2 = {''},
        Back = {''},
        Waist = {'Desert Sash'},
        Legs = {'Nashira Seraweels'}, -- Macc +3
        Feet = {'Nashira Crackows'}, -- Macc +2, Haste +1%
    },

    BluBreath_Priority = {
        Ammo = {'Fenrir\'s Stone'}, -- Good
        Head = {'Mirage Keffiyeh'},
        Ear1 = {'Bloodbead Earring'}, -- Good
        Ear2 = {'Moldavite Earring'}, -- Good
        Neck = {'Uggalepih Pendant'}, -- Good
        Body = {'Homam Corazza'}, -- Good
        Hands = {'Alkyoneus\'s Brc.'}, -- Good
        Ring1 = {'Bloodbead Ring'}, -- Good
        Ring2 = {'Bomb Queen Ring'}, -- Good
        Back = {'Gigant Mantle'}, -- Good
        Waist = {'Desert Sash'}, -- Desert Sash
        Legs = {'Homam Cosciales'}, -- Good
        Feet = {'Homam Gambieras'}, -- Good
    },
	
	-- Acc, DEX, STR, Attack, Haste
	BluPhysicalBase_Priority = { -- Acc +25, Attack +25, STR +36, DEX +7
        Ammo = {'Tiphia Sting'}, -- Acc +2, Attack +4
        Head = {'Optical Hat'}, -- Acc +10
        Neck = {'Peacock Amulet'}, -- Acc +10
        Ear1 = {'Cassie Earring'}, -- STR +1
        Ear2 = {'Merman\'s Earring'}, -- Attack +6
        Body = {'Magus Jubbah'}, -- Skill +15, STR +3 DEX +3
        Hands = {'Alkyoneus\'s Brc.'}, -- STR +11 DEX -6
        Ring1 = {'Rajas Ring'}, -- STR +5, DEX +5
        Ring2 = {'Flame Ring'}, -- STR +5
        Back = {'Forager\'s Mantle'}, -- STR +3, Attack +15
        Waist = {'Warwolf Belt', 'Ryl.Kgt. Belt'}, -- STR+5, DEX+5, VIT+5
        Legs = {'Homam Cosciales'}, -- Acc +3
        Feet = {'Rutter Sabatons'}, -- STR +3
    },
	
	BluPhysical_STR_Priority = {
        Ammo = {''},
        Head = {''},
        Neck = {''},
        Ear1 = {'Cassie Earring'}, -- STR +1
        Ear2 = {''},
        Body = {'Alkyoneus\'s Brc.', 'Magus Jubbah'}, -- STR +11 DEX -6
        Ring1 = {'Rajas Ring'}, -- STR +5, DEX +5
        Ring2 = {'Flame Ring'}, -- STR +5
        Back = {''},
        Waist = {'Warwolf Belt'}, -- STR+5, DEX+5, VIT+5
        Legs = {''},
        Feet = {'Rutter Sabatons'}, -- STR +3, VIT +2, Attack +5
    },
	
	BluPhysical_DEX_Priority = {
        Ammo = {''},
        Head = {''},
        Neck = {'Love Torque'}, -- DEX +5
        Ear1 = {''},
        Ear2 = {''},
        Body = {'Magus Jubbah'}, -- STR +3 DEX +3
        Hands = {'Mirage Bazubands'}, -- DEX +5
        Ring1 = {'Rajas Ring'}, -- STR +5, DEX +5
        Ring2 = {''},
        Back = {''},
        Waist = {'Warwolf Belt'}, -- STR+5, DEX+5, VIT+5
        Legs = {''},
        Feet = {''},
    },
	
	BluPhysical_VIT_Priority = {
        Ammo = {''},
        Head = {''},
        Neck = {''},
        Ear1 = {'Cassie Earring'}, -- VIT +1
        Ear2 = {''},
        Body = {''},
        Hands = {''},
        Ring1 = {''},
        Ring2 = {''},
        Back = {''},
        Waist = {'Warwolf Belt'}, -- STR+5, DEX+5, VIT+5
        Legs = {'Magus Shalwar'}, -- VIT +3 AGI +3
        Feet = {'Rutter Sabatons'}, -- STR +3, VIT +2, Attack +5
    },
	
	BluPhysical_AGI_Priority = {
        Ammo = {''},
        Head = {''},
        Neck = {''},
        Ear1 = {''},
        Ear2 = {''},
        Body = {''},
        Hands = {'Homam Manopolas'},
        Ring1 = {'Snow Ring'}, -- AGI +2
        Ring2 = {'Snow Ring'}, -- AGI +2
        Back = {''},
        Waist = {'Desert Sash'}, -- AGI +4
        Legs = {'Magus Shalwar'}, -- VIT +3 AGI +3
        Feet = {'Elder\'s Sandals'}, -- AGI +3
    },
	
	BluPhysical_CHR_Priority = {
        Ammo = {''},
        Head = {''},
        Neck = {'Temp. Torque', 'Star Necklace'}, -- CHR +5
        Ear1 = {'Beastly Earring'},
        Ear2 = {''},
        Body = {'Elder\'s Surcoat'},
        Hands = {''},
        Ring1 = {''},
        Ring2 = {''},
        Back = {''},
        Waist = {'Druid\'s Rope'},
        Legs = {'Elder\'s Braguette'},
        Feet = {''},
    },
	
	-- Conserve MP
	ConserveMP_Priority = {
        Ammo = {''},
        Head = {''},
        Neck = {''},
        Ear1 = {''},
        Ear2 = {''},
        Body = {''},
        Hands = {''},
        Ring1 = {''},
        Ring2 = {''},
        Back = {''},
        Waist = {''},
        Legs = {''},
        Feet = {''},
    },
	
	-- BLU Skill
	BluSkill_Priority = {
        Ammo = {''},
        Head = {'Mirage Keffiyeh'}, --BLU +5
        Neck = {''},
        Ear1 = {''},
        Ear2 = {''},
        Body = {'Magus Jubbah'}, -- BLU +15
        Hands = {''},
        Ring1 = {''},
        Ring2 = {''},
        Back = {''},
        Waist = {''},
        Legs = {''},
        Feet = {''},
    },
	
	-- BLU Skill + Macc
	-- Not sure if INT + MND are relevant; if they are, break this out into 2 sets
	BluMagicAccuracy_Priority = {
        Ammo = {''},
        Head = {'Mirage Keffiyeh'}, --BLU +5
        Neck = {''},
        Ear1 = {''},
        Ear2 = {''},
        Body = {'Nashira Manteel'}, -- Macc +5
        Body = {'Magus Jubbah'}, -- BLU +15
        Hands = {'Nashira Gages'}, -- Macc +3
        Ring1 = {''},
        Ring2 = {''},
        Back = {''},
        Waist = {''},
        Legs = {'Nashira Seraweels'}, -- Macc +3
        Feet = {'Homam Gambieras'}, -- Macc +4, Haste +3%
    },
	
	UglyPP_Priority = {
        Neck = {'Uggalepih Pendant'},
    },
	
	-- MAB, BLU Skill, Macc
	BluMagical_Priority = {
        Ammo = {''},
        Head = {'Mirage Keffiyeh'}, --BLU +5
        Neck = {''},
        Ear1 = {'Moldavite Earring'}, -- MAB +5
        --Ear2 = {'Novio Earring'}, -- MAB +7
        Body = {'Nashira Manteel'}, -- Macc +5
        Body = {'Magus Jubbah'}, -- BLU +15
        Hands = {'Nashira Gages'}, -- Macc +3
        Ring1 = {''},
        Ring2 = {''},
        Back = {''},
        Waist = {''},
        Legs = {'Nashira Seraweels'}, -- Macc +3
        Feet = {'Nashira Crackows'}, -- Macc +3, Haste +1%
    },
	
	-- BLU Skill, Macc, Fast Cast, Haste
	BluStun_Priority = {
        Ammo = {''},
        Head = {'Mirage Keffiyeh'}, --BLU +5
        Neck = {''},
        Ear1 = {'Phantom Earring'},
        Ear2 = {'Loquac. Earring'}, -- Fast Cast
        Body = {'Nashira Manteel'}, -- Macc +5, Haste +3%
        Body = {'Magus Jubbah'}, -- BLU +15
        Hands = {'Nashira Gages'}, -- Macc +3, Haste +1%
        Ring1 = {''},
        Ring2 = {''},
        Back = {''},
        Waist = {'Sonic Belt'}, -- Haste +6%
        Legs = {'Nashira Seraweels'}, -- Macc +3, Haste +2%
        Feet = {'Nashira Crackows'}, -- Macc +3, Haste +1%
    },

    -- BLU Skill, Acc, Haste
	BluPhysStun_Priority = {
        Ammo = {'Tiphia Sting'}, -- Acc +2
		Head = {'Optical Hat'}, -- Accuracy +10
        Neck = {'Peacock Amulet'}, -- Acc +10
        Ear1 = {'Phantom Earring'},
        Ear2 = {'Loquac. Earring'}, -- Fast Cast
        --Body = {'Homam Corazza'}, -- Acc +15
        Body = {'Magus Jubbah'}, -- BLU +15
        Hands = {'Homam Manopolas'}, -- Acc +4
        Ring1 = {'Rajas Ring'}, -- DEX +5
        Ring2 = {'Toreador\'s Ring'}, -- Acc +7
        Back = {'Forager\'s Mantle'},
        Waist = {'Swift Belt'}, -- Acc +3
        Legs = {'Homam Cosciales'}, -- Acc +3
        Feet = {'Homam Gambieras'}, -- Acc +6
    },
	
	Cure_Priority = {
        Head = {'Zenith Crown', 'Magus Keffiyeh'}, -- MND +3
        Neck = {'Faith Torque'}, -- MND +5
        Ear1 = {'Loquac. Earring'}, -- FC
        Body = {'Errant Hpl.'}, -- MND +10
        Hands = {'Dvt. Mitts +1'}, -- MND +6
        Ring1 = {'Aqua Ring'}, -- MND +5
        Ring2 = {'Aqua Ring'}, -- MND +5
        Back = {'Prism Cape'}, -- MND +4
        Legs = {'Mahatma Slops'}, -- MND +8
    },
	
	Enmity_Priority = {
        Ammo = {''},
        Head = {''},
        Neck = {''},
        Ear1 = {''},
        Ear2 = {''},
        Body = {''},
        Hands = {''},
        Ring1 = {''},
        Ring2 = {''},
        Back = {''},
        Waist = {''},
        Legs = {''},
        Feet = {'Magus Charuqs'},
    },
	
	WhiteWind_Priority = {
        Ammo = {'Fenrir\'s Stone'}, -- Good
        Head = {'Mirage Keffiyeh'},
        Ear1 = {'Bloodbead Earring'}, -- Good
        Ear2 = {'Ethereal Earring'}, -- Good
        Neck = {'Ajase Beads'}, -- Good
        Body = {'Homam Corazza'}, -- Good
        Hands = {'Alkyoneus\'s Brc.'}, -- Good
        Ring1 = {'Bloodbead Ring'}, -- Good
        Ring2 = {'Bomb Queen Ring'}, -- Good
        Back = {'Gigant Mantle'}, -- Good
        Waist = {'Desert Sash'}, -- Desert Sash
        Legs = {'Homam Cosciales'}, -- Good
        Feet = {'Homam Gambieras'}, -- Good
    },
	
	BluMagical_MND_Priority = {
        Ammo = {''},
        Head = {'Mirage Keffiyeh'}, -- BLU +5
        Neck = {'Faith TorqueUggalepih'}, -- MND +5
        Ear1 = {'Moldavite Earring'}, -- MAB +5
        Ear2 = {'Cmn. Earring'}, -- MND +2
        --Ear2 = {'Novio Earring'}, -- MAB +7
        Body = {'Errant Hpl.'}, -- MND +10
        Hands = {'Dvt. Mitts +1'}, -- MND +6 
        Ring1 = {'Aqua Ring'}, -- MND +5
        Ring2 = {'Aqua Ring'}, -- MND +5
		Waist = {'Druid\'s Rope'}, -- MND +1
        Back = {'Prism Cape'}, -- MND +4
        Legs = {'Mahatma Slops'}, -- MND +8
        Feet = {''},
    },
	
	BluMagical_CHR_Priority = {
        Ammo = {''},
        Head = {'Mirage Keffiyeh'}, -- BLU +5
        Neck = {'Temp. Torque', 'Star Necklace'}, -- CHR +5
        Ear1 = {''},
        Ear2 = {''},
        Body = {'Elder\'s Surcoat'},
        Hands = {''},
        Ring1 = {''},
        Ring2 = {''},
        Back = {''},
        Waist = {'Druid\'s Rope'},
        Legs = {'Elder\'s Braguette'},
        Feet = {''},
    },
	
	BluMagical_INT_Priority = {
        Ammo = {'Phtm. Tathlum'}, -- INT+2
        Head = {'Magus Keffiyeh'},
        Neck = {''},
        Ear1 = {'Moldavite Earring'}, -- Macc +5
        Ear2 = {'Phantom Earring', 'Magus Jubbah'}, -- INT +1
        Body = {'Errant Hpl.'}, -- INT +10
        Hands = {'Errant Cuffs'}, -- INT +5 
        Ring1 = {'Snow Ring'}, -- INT +5
        Ring2 = {'Snow Ring'}, -- INT +5
        Back = {''},
        Waist = {''},
        Legs = {''},
        Feet = {''},
    },
	
	WS_Priority = {
        Ammo = {'Tiphia Sting'},
        Head = {'Optical Hat'},
        Neck = {'Peacock Amulet'},
        Ear1 = {'Brutal Earring', 'Merman\'s Earring'},
        Ear2 = {'Cassie Earring'},
        Body = {'Homam Corazza', 'Scp. Harness +1'},
        Hands = {'Alkyoneus\'s Brc.'},
        Ring1 = {'Rajas Ring'},
        Ring2 = {'Flame Ring'},
        Back = {'Forager\'s Mantle'},
        Waist = {'Warwolf Belt'},
        Legs = {'Homam Cosciales'},
        Feet = {'Rutter Sabatons'},
    },
	
	Vorpal_Priority = {
        Ammo = {'Tiphia Sting'},
        Head = {'Optical Hat'},
        Neck = {'Peacock Amulet'},
        Ear1 = {'Brutal Earring', 'Merman\'s Earring'},
        Ear2 = {'Cassie Earring'},
        Body = {'Homam Corazza', 'Scp. Harness +1'},
        Hands = {'Alkyoneus\'s Brc.'},
        Ring1 = {'Rajas Ring'},
        Ring2 = {'Flame Ring'},
        Back = {'Forager\'s Mantle'},
        Waist = {'Warwolf Belt'},
        Legs = {'Homam Cosciales'},
        Feet = {'Rutter Sabatons'},
    },
	
	SavageBlade_Priority = {
        Ammo = {'Tiphia Sting'},
        Head = {'Optical Hat'},
        Neck = {'Light Gorget'},
        Ear1 = {'Brutal Earring', 'Merman\'s Earring'},
        Ear2 = {'Cassie Earring'},
        Body = {'Homam Corazza', 'Scp. Harness +1'},
        Hands = {'Alkyoneus\'s Brc.'},
        Ring1 = {'Rajas Ring'},
        Ring2 = {'Flame Ring'},
        Back = {'Forager\'s Mantle'},
        Waist = {'Warwolf Belt'},
        Legs = {'Homam Cosciales'},
        Feet = {'Rutter Sabatons'},
    },
	
	WSAcc_Priority = {
        Ammo = {'Tiphia Sting'},
        Head = {'Optical Hat'},
        Neck = {'Peacock Amulet'},
        Ear1 = {'Brutal Earring', 'Merman\'s Earring'},
        Ear2 = {'Cassie Earring'},
        Body = {'Homam Corazza', 'Scp. Harness +1'},
        Hands = {'Alkyoneus\'s Brc.'},
        Ring1 = {'Rajas Ring'},
        Ring2 = {'Flame Ring'},
        Back = {'Forager\'s Mantle'},
        Waist = {'Warwolf Belt'},
        Legs = {'Homam Cosciales'},
        Feet = {'Rutter Sabatons'},
    },
	
	Diffusion_Priority = {
        Ammo = {''},
        Head = {''},
        Neck = {''},
        Ear1 = {''},
        Ear2 = {''},
        Body = {''},
        Hands = {''},
        Ring1 = {''},
        Ring2 = {''},
        Back = {''},
        Waist = {''},
        Legs = {''},
        Feet = {''},
    },
	
	CA_Priority = {
        Ammo = {''},
        Head = {''},
        Neck = {''},
        Ear1 = {''},
        Ear2 = {''},
        Body = {''},
        Hands = {''},
        Ring1 = {''},
        Ring2 = {''},
        Back = {''},
        Waist = {''},
        Legs = {''},
        Feet = {''},
    },
	
	BA_Priority = {
        Ammo = {''},
        Head = {''},
        Neck = {''},
        Ear1 = {''},
        Ear2 = {''},
        Body = {''},
        Hands = {''},
        Ring1 = {''},
        Ring2 = {''},
        Back = {''},
        Waist = {''},
        Legs = {''},
        Feet = {''},
    },

    Stoneskin_Priority = { -- MND +46
        Head = {'Zenith Crown', 'Magus Keffiyeh'}, -- MND +3
        Neck = {'Faith Torque'}, -- MND +5
        Ear1 = {'Loquac. Earring'}, -- FC
        Body = {'Errant Hpl.'}, -- MND +10
        Hands = {'Dvt. Mitts +1'}, -- MND +6
        Ring1 = {'Aqua Ring'}, -- MND +5
        Ring2 = {'Aqua Ring'}, -- MND +5
        Back = {'Prism Cape'}, -- MND +4
        Legs = {'Mahatma Slops'}, -- MND +8
    },

    SpellHaste_Priority = { -- 19%
        Head = {'Nashira Turban'}, -- 1%
        Body = {'Nashira Manteel'}, -- 3%
        Hands = {'Homam Manopolas'}, -- 3%
        Waist = {'Sonic Belt', 'Swift Belt'}, -- 6%
        Legs = {'Homam Cosciales'}, -- 3%
        Feet = {'Homam Gambieras'}, -- 3%
    },

    SpellHasteUtsu_Priority = { -- 17%
        Head = {'Nashira Turban'}, -- 1%
        Body = {'Nashira Manteel'}, -- 3%
        Hands = {'Homam Manopolas'}, -- 3%
        Waist = {'Sonic Belt', 'Swift Belt'}, -- 6%
        Legs = {'Homam Cosciales'}, -- 3%
        Feet = {'Homam Gambieras'}, -- 3%
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
		Waist = {'Hierarch Belt'},
		--Legs = {'Baron\'s Slops'},
    },

    StealthEarring_Priority = {
        Ear1 = {'Stealth Earring'},
    },

    Reward_Priority = { -- MND
        Ammo = {'Pet Food Zeta', 'Pet Fd. Epsilon', 'Pet Food Delta', 'Pet Fd. Gamma', 'Pet Food Beta', 'Pet Food Alpha'},
        Head = {'Magus Keffiyeh'},
        Neck = {'Faith Torque'},
        Ear2 = {'Cmn. Earring'}, -- MND +2
        Body = {'Errant Hpl.'},
        Hands = {'Dvt. Mitts +1'}, -- MND +6
        Back = {'Prism Cape'},
        Waist = {'Druid\'s Rope'},
        Ring1 = {'Aqua Ring'},
        Ring2 = {'Aqua Ring'},
        Legs = {'Mahatma Slops'},
    },

    Charm_Priority = {
        Neck = {'Temp. Torque', 'Star Necklace'},
        Ear1 = {'Beastly Earring'},
        Body = {'Errant Hpl.', 'Elder\'s Surcoat'},
        Back = {'Trimmer\'s Mantle'},
        Waist = {'Druid\'s Rope'},
        Legs = {'Mahatma Slops', 'Elder\'s Braguette'},
    },

    Learn_Priority = {
        Head = {'Mirage Keffiyeh'}, -- BLU +5
        Body = {'Magus Jubbah'}, -- BLU +15
        Hands = {'Magus Bazubands'}, -- BLU Learning+
    },

    Invisible = {
        Hands = 'Dream Mittens +1',
    },

    Sneak = {
        Feet = 'Dream Boots +1',
    },

    StyleLock = {
        --Main = 'Auster\'s Staff',
        Head = 'Darksteel Cap +1',
        Body = 'Mirage Jubbah',
        Hands = 'Mirage Bazubands',
        Legs = 'Crimson Cuisses',
        Feet = 'Coral Greaves +1',
    },

    StyleLockDT = {
        --Main = 'Auster\'s Staff',
        Head = 'Darksteel Cap +1',
        Body = 'Dst. Harness +1',
        Hands = 'Dst. Mittens +1',
        Legs = 'Coral Cuisses +1',
        Feet = 'Dst. Greaves +1',
    },

    StyleLockWinter = {
        Main = 'Vulcan\'s Staff',
        Head = 'Dream Hat +1',
        Body = 'Dream Robe +1',
        Hands = 'Dream Mittens +1',
        Legs = 'Dream Trousers +1',
        Feet = 'Dream Boots +1',
    },

    StyleLockBLU = {
        Head = 'Magus Keffiyeh',
        Body = 'Magus Jubbah',
        Hands = 'Magus Bazubands',
        Legs = 'Magus Shalwar',
        Feet = 'Magus Charuqs',
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
    AshitaCore:GetChatManager():QueueCommand(-1,'/alias /learn /lac fwd Learn ');
    AshitaCore:GetChatManager():QueueCommand(-1,'/alias /eth /lac fwd LockEth');
    AshitaCore:GetChatManager():QueueCommand(-1,'/alias /hp /lac fwd BreathLock');
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
    elseif (args[1] == 'Learn') then
        Settings.Learn = not Settings.Learn;

        if Settings.Learn then
            gFunc.Message('It\'s time to LEARN!');
        else
            gFunc.Message('I am DONE Learning!');
        end
    elseif args[1] == 'LockEth' then

        if Settings.LockEth == false then
            Settings.LockEth = true;
        else
            Settings.LockEth = false;
        end

        gFunc.Message('LockEth ' .. tostring(Settings.LockEth));
    elseif args[1] == 'BreathLock' then

        if Settings.BreathLock == false then
            Settings.BreathLock = true;
        else
            Settings.BreathLock = false;
        end

        gFunc.Message('BreathLock ' .. tostring(Settings.BreathLock));
        
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma ' .. spellName .. ' <me>');
    end

    draginclude.HandleCommand(args, sets);
    draginclude.HandleBstCoreCommands(args, nil);
    draginclude.HandleDrgCoreCommands(args);
    draginclude.HandleBluCoreCommands(args);
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

    elseif draginclude.dragSettings.TpVariant == 2 then
        gFunc.EquipSet(sets.Earth);
    end

    if player.Status == 'Engaged' then
        if Settings.Acc then
            gFunc.EquipSet(sets.MeleeEngagedAcc);
        else
            gFunc.EquipSet(sets.MeleeEngaged);
        end
    elseif player.Status == 'Resting' then
        gFunc.EquipSet(sets.Resting);

        if draginclude.dragSettings.TpVariant == 2 then
            gFunc.EquipSet(sets.Dark);
        end
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
    elseif Settings.BreathLock then
        gFunc.EquipSet(sets.BluBreath);
    end

    if Settings.Learn then
        gFunc.EquipSet(sets.Learn);
    end

    if Settings.LockEth then
        gFunc.EquipSet(sets.Ethereal);
    end
end

profile.HandleAbility = function()
    local pet = gData.GetPet();
    local ability = gData.GetAction();

    if string.match(ability.Name, 'Reward') then
        gFunc.EquipSet(sets.Reward);
    elseif string.match(ability.Name, 'Charm') then
        gFunc.LockSet(sets.Charm, 1);

        if draginclude.dragSettings.TpVariant == 2 then
            gFunc.EquipSet(sets.Light);
        end
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

    if Settings.BreathLock then
        gFunc.EquipSet(sets.BluBreath);
    elseif Settings.SIRD then
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
	local aquaveil = gData.GetBuffCount('Aquaveil');

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

    if Settings.BreathLock then
        gFunc.EquipSet(sets.BluBreath);
    else
        if draginclude.dragSettings.TpVariant == 1 then
            draginclude.SetupInterimEquipSet(sets.SIRD);
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

        gFunc.EquipSet(sets.SpellHaste);
        
        if spell.Name == 'Invisible' then
            gFunc.EquipSet(sets.Invisible);
        elseif spell.Name == 'Sneak' then
            gFunc.EquipSet(sets.Sneak);
        elseif spell.Name == 'Stoneskin' then
            gFunc.EquipSet(sets.Stoneskin);
        elseif spell.Skill == 'Ninjutsu' then
            gFunc.EquipSet(sets.SpellHasteUtsu);
        elseif (BluMagBreath:contains(spell.Name)) then
            gFunc.EquipSet(sets.BluBreath)

            equipObiIfApplicable(spell.Element);
        elseif (BluMagPhys:contains(spell.Name)) then
            gFunc.EquipSet(sets.BluPhysicalBase);
            
            if (BluPhysSTR:contains(spell.Name)) then 
                gFunc.EquipSet(sets.BluPhysical_STR);
            elseif (BluPhysDEX:contains(spell.Name)) then 
                gFunc.EquipSet(sets.BluPhysical_DEX);
            elseif (BluPhysVIT:contains(spell.Name)) then 
                gFunc.EquipSet(sets.BluPhysical_VIT);
            elseif (BluPhysAGI:contains(spell.Name)) then 
                gFunc.EquipSet(sets.BluPhysical_AGI);
            elseif (BluPhysCHR:contains(spell.Name)) then 
                gFunc.EquipSet(sets.BluPhysical_CHR);
            end
            
            if (ca >= 1) then 
                gFunc.EquipSet(sets.CA); 
            end
        elseif (spell.Skill == 'Blue Magic') then
            if (BluMagBuff:contains(spell.Name)) then
                gFunc.EquipSet(sets.ConserveMP); -- non-skill-scaling buffs (Refueling, Plasma Charge, etc.)
                
                if (diff >= 1) then 
                    gFunc.EquipSet(sets.Diffusion); 
                end
            elseif (BluMagSkill:contains(spell.Name)) then
                gFunc.EquipSet(sets.BluSkill); -- skill-scaling buffs/defenses (e.g. Zephyr Mantle)
                
                if (diff >= 1) then 
                    gFunc.EquipSet(sets.Diffusion); 
                end
            elseif (BluMagDebuff:contains(spell.Name)) then
                gFunc.EquipSet(sets.BluMagicAccuracy);
            else
                if (BluMagStun:contains(spell.Name)) then 
                    gFunc.EquipSet(sets.BluStun);
                elseif (BluPhysStun:contains(spell.Name)) then 
                    gFunc.EquipSet(sets.BluPhysStun);
                elseif (BluMagCure:contains(spell.Name)) then 
                    gFunc.EquipSet(sets.Cure);
                elseif (BluMagEnmity:contains(spell.Name)) then 
                    gFunc.EquipSet(sets.Enmity);
                elseif (spell.Name == 'White Wind') then 
                    gFunc.EquipSet(sets.WhiteWind);
                else
                    -- Generic magic-damage nuke (including Everyone's Grudge/Tenebral Crush, which used to
                    -- get a dedicated BluDark set - now just fall through to their stat-mod classification
                    -- like everything else): layer the stat-specific subset on top of BluMagical. INT is
                    -- the default for anything not explicitly MND/CHR/INT-classified above.
                    gFunc.EquipSet(sets.BluMagical);
                    
                    if (BluMagMND:contains(spell.Name)) then 
                        gFunc.EquipSet(sets.BluMagical_MND);
                    elseif (BluMagCHR:contains(spell.Name)) then 
                        gFunc.EquipSet(sets.BluMagical_CHR);
                    elseif (BluMagINT:contains(spell.Name)) then 
                        gFunc.EquipSet(sets.BluMagical_INT);
                    else 
                        gFunc.EquipSet(sets.BluMagical_INT); -- unclassified spells still default to INT
                    end
                    
                    -- If I ever put on Convert gear, I need to account for it!!!
                    if ((player.MP - spell.MpCost) / player.MaxMP) < .51 then
                        gFunc.Message('UglyPP Pendant going on.');
                        gFunc.EquipSet(sets.UglyPP);
                    end
                end
                
                if (ba >= 1) then 
                    gFunc.EquipSet(sets.BA);
                end
            end

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
    local player = gData.GetPlayer();

    gFunc.Message(action.Name);

    gFunc.EquipSet(sets.WS);

    if (action.Name == 'Vorpal Blade') then
        gFunc.EquipSet(sets.Vorpal);
    elseif (action.Name == 'Savage Blade') then
        gFunc.EquipSet(sets.SavageBlade);
    end

    if (Settings.MeleeAcc) then
        gFunc.EquipSet(sets.WSAcc);
    end

    draginclude.HandleWeaponSkill(action);
end

return profile;