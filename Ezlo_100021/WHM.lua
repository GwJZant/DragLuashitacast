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
    HPUp = false,
    MDT = true,
};

local sets = {
    Default_Priority = {
        Ammo = {'Hedgehog Bomb', 'Holy Ampulla', 'Morion Tathlum'},
        Head = {'Cleric\'s Cap', 'Emperor Hairpin', 'Dream Hat +1'},
        Neck = {'Ajari Necklace', 'Holy Phial', 'Black Neckerchief'},
        Ear1 = {'Novia Earring', 'Geist Earring', 'Reraise Earring'},
        Ear2 = {'Loquac. Earring', 'Geist Earring', 'Morion Earring'},
        Body = {'Noble\'s Tunic', 'Wonder Kaftan', 'Seer\'s Tunic', 'Dream Robe +1'},
        Hands = {'Blessed Mitts', 'Wonder Mitts', 'Dream Mittens +1'},
        Ring1 = {'Tamas Ring'},
        Ring2 = {'Sapphire Ring', 'Aquamarine Ring', 'Turquoise Ring', 'San d\'Orian Ring'},
        Back = {'Errant Cape', 'Red Cape +1', 'Trimmer\'s Mantle'},
        Waist = {'Swift Belt', 'Druid\'s Rope'},
        Legs = {'Healer\'s Pantaln.', 'Wonder Braccae', 'Seer\'s Slacks', 'Dream Trousers +1'},
        Feet = {'Rostrum Pumps', 'Healer\'s Duckbills', 'Wonder Clomps', 'Dream Boots +1'},
    },

    DefaultMDT_Priority = {
        Ammo = {'Hedgehog Bomb', 'Holy Ampulla', 'Morion Tathlum'},
        Head = {'Cleric\'s Cap', 'Emperor Hairpin', 'Dream Hat +1'},
        Neck = {'Jeweled Collar', 'Ajari Necklace', 'Holy Phial', 'Black Neckerchief'},
        Ear1 = {'Merman\'s Earring', 'Geist Earring'},
        Ear2 = {'Merman\'s Earring', 'Geist Earring'},
        Body = {'Noble\'s Tunic', 'Wonder Kaftan', 'Seer\'s Tunic', 'Dream Robe +1'},
        Hands = {'Coral Bangles', 'Dream Mittens +1'},
        Ring1 = {'Merman\'s Ring', 'Tamas Ring', 'San d\'Orian Ring'},
        Ring2 = {'Merman\'s Ring', 'Aquamarine Ring', 'Turquoise Ring'},
        Back = {'Hexerei Cape', 'Red Cape +1', 'Trimmer\'s Mantle'},
        Waist = {'Penitent\'s Rope', 'Swift Belt', 'Life Belt'},
        Legs = {'Blessed Trousers', 'Healer\'s Pantaln.', 'Wonder Braccae', 'Seer\'s Slacks', 'Dream Trousers +1'},
        Feet = {'Rostrum Pumps', 'Healer\'s Duckbills', 'Wonder Clomps', 'Dream Boots +1'},
    },

    RestingMP_Priority = {
        Ammo = {''},
        Head = {''},
        Neck = {'Checkered Scarf'}, -- HMP +1
        Ear1 = {''},
        Ear2 = {''},
        Body = {'Errant Hpl.', 'Seer\'s Tunic'}, -- HMP +5
        Hands = {''},
        Ring1 = {''},
        Ring2 = {''}, -- Enmity -5
        Back = {''},
        Waist = {'Hierarch Belt'}, -- HMP +2
        Legs = {''},
        Feet = {''},
    },

    RestingMPBLM_Priority = {
        Ammo = {''},
        Head = {''},
        Neck = {'Checkered Scarf'}, -- HMP +1
        Ear1 = {''},
        Ear2 = {''},
        Body = {'Errant Hpl.', 'Seer\'s Tunic'}, -- HMP +5
        Hands = {''},
        Ring1 = {''}, -- Enmity -5
        Ring2 = {''},
        Back = {'Wizard\'s Mantle'}, -- HMP +1 when /BLM
        Waist = {'Hierarch Belt'}, -- HMP +2
        Legs = {''},
        Feet = {''},
    },

    VermillionCloak = {
        Head = 'displaced',
        Body = 'Vermillion Cloak',
    },

    MeleeEngaged_Priority = { -- Haste +14%
        Ammo = {'Holy Ampulla', 'Morion Tathlum'},
        Head = {'Optical Hat', 'Emperor Hairpin'},
        --Neck = {'Ajari Necklace', 'Holy Phial'},
        Ear1 = {'Merman\'s Earring', 'Spike Earring', 'Beetle Earring +1'},
        Ear2 = {'Brutal Earring', 'Merman\'s Earring', 'Spike Earring', 'Beetle Earring +1'},
        Body = {'Reverend Mail', 'Black Cotehardie', 'Wonder Kaftan', 'Seer\'s Tunic', 'Tarutaru Kaftan'},
        Hands = {'Blessed Mitts', 'Battle Gloves'}, -- Haste +5%
        Ring1 = {'Toreador\'s Ring', 'San d\'Orian Ring'},
        Ring2 = {'Sniper\'s Ring'},
        Back = {'Hexerei Cape', 'Rearguard Mantle', 'Trimmer\'s Mantle'},
        Waist = {'Swift Belt', 'Life Belt'}, -- Haste +4%
        Legs = {'Blessed Trousers', 'Wonder Braccae', 'Seer\'s Slacks', 'Tarutaru Braccae'}, -- Haste +3%
        Feet = {'Blessed Pumps', 'Wonder Clomps', 'Tarutaru Clomps'}, -- Haste +2%
    },

    MND_Priority = { -- MND +59
        Ammo = {'Holy Ampulla'}, -- MND +1
        Head = {'Healer\'s Cap'}, -- MND +4, Enmity -1
        Neck = {'Ajari Necklace', 'Holy Phial'}, -- MND +6
        Ear1 = {'Geist Earring'}, -- MND +1
        Ear2 = {'Geist Earring'}, -- MND +1
        Body = {'Errant Hpl.', 'Blessed Bliaut', 'Wonder Kaftan'}, -- MND +10
        Hands = {'Blessed Mitts', }, -- MND +7
        Ring1 = {'Tamas Ring', 'Turquoise Ring'}, -- MND +5
        Ring2 = {'Sapphire Ring', 'Aquamarine Ring', 'Turquoise Ring'}, -- MND +4
        Back = {'Red Cape +1'}, -- MND +3
        Waist = {'Penitent\'s Rope', 'Swift Belt'}, -- MND +5
        Legs = {'Errant Slops', 'Blessed Trousers', 'Wonder Braccae'}, -- MND +7
        Feet = {'Cleric\'s Duckbills', 'Blessed Pumps', 'Healer\'s Duckbills'}, -- MND +5
    },

    MNDEnfeeb_Priority = { -- MND +49 Enfeebling Skill +10
        Ammo = {'Holy Ampulla'}, -- MND +1
        Head = {'Healer\'s Cap'}, -- MND +4, Enmity -1
        Neck = {'Ajari Necklace', 'Holy Phial'}, -- MND +6
        Ear1 = {'Geist Earring'}, -- MND +1
        Ear2 = {'Geist Earring'}, -- MND +1
        Body = {'Healer\'s Bliaut', 'Shaman\'s Cloak', 'Wonder Kaftan'}, -- Enfeebling Skill +10
        Hands = {'Blessed Mitts', }, -- MND +7
        Ring1 = {'Tamas Ring', 'Turquoise Ring'}, -- MND +5
        Ring2 = {'Sapphire Ring', 'Aquamarine Ring', 'Turquoise Ring'}, -- MND +4
        Back = {'Red Cape +1'}, -- MND +3
        Waist = {'Penitent\'s Rope', 'Swift Belt'}, -- MND +5
        Legs = {'Errant Slops', 'Blessed Trousers', 'Wonder Braccae'}, -- MND +7
        Feet = {'Cleric\'s Duckbills', 'Blessed Pumps', 'Healer\'s Duckbills'}, -- MND +5
    },

    INT_Priority = { -- INT +44
        Neck = {'Checkered Scarf'}, -- INT +2
        Ear1 = {'Abyssal Earring', 'Morion Earring'}, -- INT +2
        Ear2 = {'Morion Earring'}, -- INT +1
        Body = {'Errant Hpl.', 'Shaman\'s Cloak'}, -- INT +10
        Hands = {'Errant Cuffs'}, -- INT +5
        Ring1 = {'Tamas Ring', 'Eremite\'s Ring'}, -- INT +5
        Ring2 = {'Diamond Ring', 'Zircon Ring', 'Eremite\'s Ring'}, -- INT +4
        Waist = {'Penitent\'s Rope', 'Swift Belt'}, -- INT +5
        Legs = {'Errant Slops'}, -- INT +7
        Feet = {'Rostrum Pumps', 'Healer\'s Duckbills'}, -- INT +3 SIRD 20%
    },

    INTEnfeeb_Priority = { -- INT +34 Enfeebling Skill +14
        Head = {'Elite Beret'}, -- Enfeebling Skill +4
        Neck = {'Checkered Scarf'}, -- INT +2
        Ear1 = {'Abyssal Earring', 'Morion Earring'}, -- INT +2
        Ear2 = {'Morion Earring'}, -- INT +1
        Body = {'Healer\'s Bliaut', 'Shaman\'s Cloak'}, -- Enfeebling Skill +10
        Hands = {'Errant Cuffs'}, -- INT +5
        Ring1 = {'Tamas Ring', 'Eremite\'s Ring'}, -- INT +5
        Ring2 = {'Diamond Ring', 'Zircon Ring', 'Eremite\'s Ring'}, -- INT +4
        Waist = {'Penitent\'s Rope', 'Swift Belt'}, -- INT +5
        Legs = {'Errant Slops'}, -- INT +7
        Feet = {'Rostrum Pumps', 'Healer\'s Duckbills'}, -- INT +3 SIRD 20%
    },

    INTElemental_Priority = { -- INT +32 Elemental Skill +12 MAB +5
        Head = {'Elite Beret'}, -- Enfeebling Skill +4
        Neck = {'Checkered Scarf'}, -- INT +2
        Ear1 = {'Abyssal Earring', 'Morion Earring'}, -- INT +2
        Ear2 = {'Elemental Earring', 'Morion Earring'}, -- Elemental Skill +3
        Body = {'Shaman\'s Cloak'}, -- INT +4 Elemental Skill +5
        Hands = {'Zenith Mitts', 'Errant Cuffs'}, -- MAB +5
        Ring1 = {'Tamas Ring', 'Eremite\'s Ring'}, -- INT +5
        Ring2 = {'Diamond Ring', 'Zircon Ring', 'Eremite\'s Ring'}, -- INT +4
        Waist = {'Penitent\'s Rope', 'Swift Belt'}, -- INT +5
        Legs = {'Errant Slops'}, -- INT +7
        Feet = {'Rostrum Pumps', 'Healer\'s Duckbills'}, -- INT +3 Fast Cast+ / INT +3 SIRD 20%
    },

    MedicineRing_Priority = {
        Ring2 = {'Medicine Ring'}, -- Cure Potency +10% while HP <= 75% and TP <= 1000
    },

    MedicineEarring_Priority = {
        Ear2 = {'Medicine Earring'}, -- Damage Taken -30% while HP <= 25% and TP <= 1000
    },

    HPDown_Priority = {
        Ring1 = {'Ether Ring'},
        Ring2 = {'Astral Ring'},
    },

    -- Default: 766 -> 191 MP
    -- HPUp: 915 -> 228 MP
    HPUp_Priority = {
        Body = {'Wonder Kaftan'}, -- HP +36
        Hands = {'Wonder Mitts'}, -- HP +12
        Ring1 = {'Bomb Queen Ring'}, -- HP +75
        Ring2 = {'Toreador\'s Ring'}, -- HP +10
        Waist = {'Hierarch Belt'}, -- HP +20 (I idle in Penitent's Rope)
        Legs = {'Wonder Braccae'}, -- HP +21
        Feet = {'Wonder Clomps'}, -- HP +50 (I idle in Rostrum Pumps which has -30)
    },

    Precast_Priority = { -- Haste +12%, Fast Cast +3%
        Ear2 = {'Loquac. Earring'}, -- Fast Cast +1%
        Hands = {'Blessed Mitts'}, -- Haste +5%
        Waist = {'Swift Belt'}, -- Haste +4%
        Legs = {'Blessed Trousers', 'Wonder Braccae', 'Seer\'s Slacks', 'Tarutaru Braccae'}, -- Haste +3%
        Feet = {'Rostrum Pumps', 'Blessed Pumps', 'Wonder Clomps', 'Tarutaru Clomps'}, -- Fast Cast +2%
    },

    SpellHaste_Priority = { -- Haste +14%
        Ear2 = {'Loquac. Earring'},
        Hands = {'Blessed Mitts'}, -- Haste +5%
        Waist = {'Swift Belt', 'Life Belt'}, -- Haste +4%
        Legs = {'Blessed Trousers', 'Wonder Braccae', 'Seer\'s Slacks', 'Tarutaru Braccae'}, -- Haste +3%
        Feet = {'Blessed Pumps', 'Wonder Clomps', 'Tarutaru Clomps'}, -- Haste +2%
    },

    DarkSkill_Priority = { -- INT +44 Dark Skill +5
        Neck = {'Checkered Scarf'}, -- INT +2
        Ear1 = {'Abyssal Earring', 'Morion Earring'}, -- INT +2, Dark Skill +5
        Ear2 = {'Morion Earring'}, -- INT +1
        Body = {'Errant Hpl.', 'Shaman\'s Cloak'}, -- INT +10
        Hands = {'Errant Cuffs'}, -- INT +5
        Ring1 = {'Tamas Ring', 'Eremite\'s Ring'}, -- INT +5
        Ring2 = {'Diamond Ring', 'Zircon Ring', 'Eremite\'s Ring'}, -- INT +4
        Waist = {'Penitent\'s Rope', 'Swift Belt'}, -- INT +5
        Legs = {'Errant Slops'}, -- INT +7
        Feet = {'Rostrum Pumps', 'Healer\'s Duckbills'}, -- INT +3 SIRD 20%
    },

    DivineSkill_Priority = { -- MND +46, MAB +10
        Ammo = {'Holy Ampulla'}, -- MND +1
        Head = {'Healer\'s Cap'}, -- MND +4, Enmity -1
        Neck = {'Ajari Necklace', 'Holy Phial'}, -- MND +6
        Ear1 = {'Geist Earring'}, -- MND +1
        Ear2 = {'Moldavite Earring', 'Geist Earring'}, -- Matk +5
        Body = {'Errant Hpl.', 'Blessed Bliaut', 'Wonder Kaftan'}, -- MND +10
        Hands = {'Zenith Mitts'}, -- MND +7
        Ring1 = {'Tamas Ring', 'Turquoise Ring'}, -- MND +5
        Ring2 = {'Sapphire Ring', 'Aquamarine Ring', 'Turquoise Ring'}, -- MND +4
        Back = {'Red Cape +1'}, -- MND +3
        Waist = {'Penitent\'s Rope', 'Swift Belt'}, -- MND +5
        Legs = {'Healer\'s Pantaln.', 'Wonder Braccae'}, -- Divine Skill +15
        Feet = {'Cleric\'s Duckbills', 'Blessed Pumps', 'Healer\'s Duckbills'}, -- MND +5
    },

    Cure_Priority = { -- Enmity -50, MND +31 (Capped Enmity-)
        Ammo = {'Hedgehog Bomb', 'Holy Ampulla'}, -- Enmity -1
        Head = {'Raven Beret'}, -- Enmity -8
        Neck = {'Ajari Necklace', 'Holy Phial'}, -- MND +6
        Ear1 = {'Geist Earring'}, -- MND +1
        Ear2 = {'Novia Earring', 'Geist Earring'}, -- Enmity -7
        Body = {'Crow Jupon', 'Wonder Kaftan'}, -- Enmity -8
        Hands = {'Healer\'s Mitts'}, -- Healing skill +15, Enmity -4
        Ring1 = {'Tamas Ring', 'Turquoise Ring'}, -- MND +5, Enmity -5
        Ring2 = {'Sapphire Ring', 'Aquamarine Ring', 'Turquoise Ring'}, -- MND +4
        Back = {'Errant Cape', 'Red Cape +1'}, -- Enmity -5
        Waist = {'Penitent\'s Rope', 'Swift Belt'}, -- MND +5, Enmity -3
        Legs = {'Blessed Trousers', 'Healer\'s Pantaln.', 'Wonder Braccae'}, -- MND +6, Enmity -5
        Feet = {'Blessed Pumps', 'Healer\'s Duckbills'}, -- MND +3, Enmity -4
    },

    Cure5_Priority = { -- MND +49, Enmity -15, Cure Potency +10%
        Ammo = {'Holy Ampulla'}, -- MND +1
        Head = {'Healer\'s Cap'}, -- MND +4
        Neck = {'Ajari Necklace', 'Holy Phial'}, -- MND +6
        Ear1 = {'Geist Earring'}, -- MND +1
        Ear2 = {'Geist Earring'}, -- MND +1
        Body = {'Noble\'s Tunic', 'Healer\'s Bliaut', 'Wonder Kaftan'}, -- Cure Potency +10%
        Hands = {'Blessed Mitts', 'Healer\'s Mitts'}, -- MND +7, Enmity -3
        Ring1 = {'Tamas Ring', 'Turquoise Ring'}, -- MND +5, Enmity -5
        Ring2 = {'Sapphire Ring', 'Aquamarine Ring', 'Turquoise Ring'}, -- MND +4
        Back = {'Red Cape +1'}, -- MND +3
        Waist = {'Penitent\'s Rope', 'Swift Belt'}, -- MND +5, Enmity -3
        Legs = {'Errant Slops', 'Healer\'s Pantaln.', 'Wonder Braccae'}, -- MND +7, Enmity -3
        Feet = {'Cleric\'s Duckbills', 'Healer\'s Duckbills'}, -- MND +5, Enmity -1
    },

    Cursna_Priority = { -- Healing Skill only
        Hands = {'Healer\'s Mitts'}, -- Healing skill +15, Enmity -4
    },

    -- Stoneskin = Enhancing Magic Skill + 3×MND - 190
    -- 240 + 3*(65+58=123) - 190 = 419/350
    -- Target MND: 100 => MND +35 from gear
    MNDEnhancingSkill_Priority = { -- MND +40, Enhancing Skill +10
        Neck = {'Ajari Necklace', 'Holy Phial'}, -- MND +6
        Hands = {'Blessed Mitts', }, -- MND +7
        Ring1 = {'Tamas Ring', 'Turquoise Ring'}, -- MND +5
        Ring2 = {'Sapphire Ring', 'Aquamarine Ring', 'Turquoise Ring'}, -- MND +4
        Waist = {'Penitent\'s Rope', 'Swift Belt'}, -- MND +5
        Legs = {'Errant Slops', 'Blessed Trousers', 'Wonder Braccae'}, -- MND +7
        Feet = {'Cleric\'s Duckbills', 'Blessed Pumps', 'Healer\'s Duckbills'}, -- MND +5, Enhancing Skill +10
    },

    Barspell_Priority = {
        Ammo = {'Holy Ampulla'}, -- MND +1
        Head = {'Healer\'s Cap'}, -- MND +4, Enmity -1
        Neck = {'Ajari Necklace', 'Holy Phial'}, -- MND +6
        Ear1 = {'Geist Earring'}, -- MND +1
        Ear2 = {'Geist Earring'}, -- MND +1
        Body = {'Blessed Bliaut', 'Wonder Kaftan'}, -- MND +5, Barspell+
        Hands = {'Blessed Mitts', }, -- MND +7
        Ring1 = {'Tamas Ring', 'Turquoise Ring'}, -- MND +5
        Ring2 = {'Sapphire Ring', 'Aquamarine Ring', 'Turquoise Ring'}, -- MND +4
        Back = {'Red Cape +1'}, -- MND +3
        Waist = {'Penitent\'s Rope', 'Swift Belt'}, -- MND +5
        Legs = {'Errant Slops', 'Blessed Trousers', 'Wonder Braccae'}, -- MND +7
        Feet = {'Cleric\'s Duckbills', 'Blessed Pumps', 'Healer\'s Duckbills'}, -- MND +5, Enhancing Skill +10
    },

    CurePrecast_Priority = {
        Feet = {'Cure Clogs'}, -- Cure Cast -15%
    },

    RuckesRung_Priority = {
        Main = {'Rucke\'s Rung'},
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

    Weaponskill_Priority = { -- Acc +32, Attack + 10, STR +7, DEX +2
        Ammo = {},
        Head = {'Optical Hat'}, -- Acc +10
        Neck = {},
        Ear1 = {'Spike Earring'}, -- Attack +5
        Ear2 = {'Spike Earring'}, -- Attack +5
        Body = {'Black Cotehardie'}, -- STR +3, DEX +2
        Hands = {'Healer\'s Mitts', }, -- STR +5
        Ring1 = {'Toreador\'s Ring'}, -- Acc +7
        Ring2 = {'Sniper\'s Ring'}, -- Acc +5
        Back = {'Rearguard Mantle'}, -- STR +1
        Waist = {'Life Belt'}, -- Acc +10
        Legs = {'Wonder Braccae'}, -- STR +1
        Feet = {'Wonder Clomps'}, -- STR +2
    },

    WeaponskillHexa_Priority = { -- STR, MND
        Ammo = {'Holy Ampulla'}, -- MND +1
        Head = {'Optical Hat'}, -- Acc +10
        Neck = {'Ajari Necklace', 'Holy Phial'}, -- MND +6
        Ear1 = {'Minuet Earring', 'Geist Earring'}, -- STR +1
        Ear2 = {'Geist Earring'}, -- MND +1
        Body = {'Reverend Mail', 'Blessed Bliaut', 'Wonder Kaftan'}, -- Acc +10
        Hands = {'Healer\'s Mitts', }, -- MND +7
        Ring1 = {'Tamas Ring', 'Turquoise Ring'}, -- MND +5
        Ring2 = {'Sapphire Ring', 'Aquamarine Ring', 'Turquoise Ring'}, -- MND +3
        Back = {'Red Cape +1'}, -- MND +3
        Waist = {'Life Belt'}, -- Acc +10
        Legs = {'Blessed Trouers'}, -- MND +6
        Feet = {'Cleric\'s Duckbills', 'Blessed Pumps', 'Healer\'s Duckbills'}, -- MND +5
    },

    StyleLockSummer = {
        Main = 'Apollo\'s Staff',
        Head = 'Emperor Hairpin',
        Body = 'Wonder Maillot +1',
        Legs = 'Taru. Trunks +1',
    },

    StyleLockGeneric = {
        Main = 'Apollo\'s Staff',
        Head = 'Emperor Hairpin',
        Body = 'Noble\'s Tunic',
        Hands = 'Blessed Mitts',
        Legs = 'Blessed Trousers',
        Feet = 'Blessed Pumps',
    },

    StyleLockNIN = {
        Main = 'Apollo\'s Staff',
        Head = 'Optical Hat',
        Body = 'Reverend Mail',
        Hands = 'Coral Bangles',
        Legs = 'Healer\'s Pantaln.',
        Feet = 'Rostrum Pumps',
    },

    StyleLockAF = {
        Main = 'Apollo\'s Staff',
        Head = 'Healer\'s Cap',
        Body = 'Healer\'s Bliaut',
        Hands = 'Healer\'s Mitts',
        Legs = 'Healer\'s Pantaln.',
        Feet = 'Healer\'s Duckbills',
    },
    
    StyleLockWinter = {
        Main = 'Apollo\'s Staff',
        Head = 'Dream Hat +1',
        Body = 'Dream Robe',
        Hands = 'Dream Mittens +1',
        Legs = 'Dream Trousers +1',
        Feet = 'Dream Boots +1',
    },

    PetReadyDefault = {

    },

    PetAttack = {

    },

    Reward_Priority = { -- MND +50
        Ammo = {'Pet Food Zeta', 'Pet Fd. Epsilon', 'Pet Food Delta', 'Pet Fd. Gamma', 'Pet Food Beta', 'Pet Food Alpha'},
        Head = {'Healer\'s Cap'}, -- MND +4, Enmity -1
        Neck = {'Ajari Necklace', 'Holy Phial'}, -- MND +6
        Ear1 = {'Geist Earring'}, -- MND +1
        Ear2 = {'Geist Earring'}, -- MND +1
        Body = {'Blessed Bliaut', 'Wonder Kaftan'}, -- MND +5
        Hands = {'Blessed Mitts', }, -- MND +7
        Ring1 = {'Tamas Ring', 'Turquoise Ring'}, -- MND +5
        Ring2 = {'Sapphire Ring', 'Aquamarine Ring', 'Turquoise Ring'}, -- MND +4
        Back = {'Red Cape +1'}, -- MND +3
        Waist = {'Penitent\'s Rope', 'Swift Belt'}, -- MND +5
        Legs = {'Blessed Trousers', 'Wonder Braccae'}, -- MND +6
        Feet = {'Rostrum Pumps', 'Blessed Pumps', 'Healer\'s Duckbills'}, -- MND +3
    },

    Charm_Priority = {
        Ammo = {''},
        Head = {''},
        Neck = {'Flower Necklace'}, -- CHR +3
        Ear1 = {''},
        Ear2 = {''},
        Body = {'Errant Hpl.'}, -- CHR +10
        Hands = {''},
        Ring1 = {''},
        Ring2 = {''},
        Back = {'Trimmer\'s Mantle'},
        Waist = {''},
        Legs = {'Errant Slops'}, -- CHR +7
        Feet = {''},
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

    AshitaCore:GetChatManager():QueueCommand(-1,'/alias /hpup /lac fwd hpup ');
    AshitaCore:GetChatManager():QueueCommand(-1,'/alias /mdt /lac fwd mdt ');
end

profile.OnUnload = function()
    draginclude.OnUnload();
end

profile.HandleCommand = function(args)
    if (args[1] == 'hpup') then
        Settings.HPUp = not Settings.HPUp;

        if Settings.HPUp then
            gFunc.Message('HPUp ON');
        else
            gFunc.Message('HPUp OFF');
        end
    elseif (args[1] == 'mdt') then
        Settings.MDT = not Settings.MDT;

        if Settings.MDT then
            gFunc.Message('MDT ON');
        else
            gFunc.Message('MDT OFF');
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
    elseif (args[1] == 'sleep') then
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma "Sleep" <stnpc>');
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

        if player.SubJob == 'NIN' then
            gFunc.LockStyle(sets.StyleLockNIN);
        else
            gFunc.LockStyle(sets.StyleLockNIN);
        end
        
        AshitaCore:GetChatManager():QueueCommand(1, '/macro book 6');
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
            -- BLM Core Commands
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 1 /lac fwd haste ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 2 /lac fwd regen ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 3 /lac fwd regen3 ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 4 /lac fwd cure5 ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 5 /lac fwd stoneskin ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 6 /lac fwd blink ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 7 /lac fwd drain ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 8 /lac fwd aspir ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 9 /lac fwd sleepga ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 0 /lac fwd sleep ');
        else
            -- Generic Core Commands
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 1 /lac fwd haste ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 2 /lac fwd regen ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 3 /lac fwd regen3 ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 4 /lac fwd cure5 ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 5 /lac fwd stoneskin ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 6 /lac fwd silence ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind +6 /lac fwd blink ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 7 /lac fwd paralyze ');
            AshitaCore:GetChatManager():QueueCommand(-1,'/bind 8 /lac fwd slow ');
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

    -- Forward slash toggle between NoStaffSwap and StaffSwap
    if draginclude.dragSettings.TpVariant == 1 then

        if Settings.MDT then
            gFunc.EquipSet(sets.DefaultMDT);
        else
            gFunc.EquipSet(sets.Default);
        end
        
        -- Engaged Section
        if player.Status == 'Engaged' then
            gFunc.EquipSet(sets.MeleeEngaged);
        
        -- Resting Section
        elseif (player.Status == 'Resting') then
            if player.SubJob == 'BLM' then
                gFunc.EquipSet(sets.RestingMPBLM);
            else
                gFunc.EquipSet(sets.RestingMP);
            end
            
            if Settings.CurrentLevel >= 59 and Settings.CurrentLevel < 70 then
                gFunc.EquipSet(sets.VermillionCloak);
            end
        -- Idle Section
        else
            if Settings.CurrentLevel >= 59 and Settings.CurrentLevel < 70 then
                gFunc.EquipSet(sets.VermillionCloak);
            end
        end
    elseif draginclude.dragSettings.TpVariant == 2 then --StaffSwap
        if Settings.MDT then
            gFunc.EquipSet(sets.DefaultMDT);
        else
            gFunc.EquipSet(sets.Default);
        end

        -- Resting Section
        if (player.Status == 'Resting') then
            gFunc.EquipSet(sets.Dark);

            if player.SubJob == 'BLM' then
                gFunc.EquipSet(sets.RestingMPBLM);
            else
                gFunc.EquipSet(sets.RestingMP);
            end

            if Settings.CurrentLevel >= 59 and Settings.CurrentLevel < 70 then
                gFunc.EquipSet(sets.VermillionCloak);
            end
        -- Idle Section
        else
            gFunc.EquipSet(sets.Earth);

            if Settings.CurrentLevel >= 59 and Settings.CurrentLevel < 70 then
                gFunc.EquipSet(sets.VermillionCloak);
            end
        end
    end

    if player.HPP <= 25 then
        gFunc.EquipSet(sets.MedicineEarring);
    end

    if Settings.HPUp then
        gFunc.EquipSet(sets.HPUp);
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
    local target = gData.GetActionTarget();

    if string.match(ability.Name, 'Reward') then
        gFunc.EquipSet(sets.Reward);
    elseif string.match(ability.Name, 'Charm') then
        gFunc.LockSet(sets.Charm, 1);

        -- Light Staff when in StaffMode
        if draginclude.dragSettings.TpVariant == 2 then
            gFunc.EquipSet(sets.Light);
        end
    elseif string.match(ability.Name, 'Fight') then
        -- Fight set
    elseif string.match(ability.Name, 'Sic') then
        -- Sic set
    elseif string.match(ability.Name, 'Devotion') then
        gFunc.Message(target.Name);
        
        AshitaCore:GetChatManager():QueueCommand(-1,'/p Using Devotion -> ' .. target.Name);
    end
end

profile.HandleItem = function()
    local item = gData.GetAction();
end

profile.HandlePrecast = function()
    local spell = gData.GetAction();
    local target = gData.GetActionTarget();
    local divineSeal = gData.GetBuffCount('Divine Seal');

    if draginclude.dragSettings.TpVariant == 1 then
        -- Don't swap weapons
    elseif draginclude.dragSettings.TpVariant == 2 then
        if string.contains(spell.Name, 'Cure') or string.contains(spell.Name, 'Curaga') then
            gFunc.EquipSet(sets.RuckesRung);
        end
    end

    gFunc.EquipSet(sets.Precast);

    if string.contains(spell.Name, 'Cure') or string.contains(spell.Name, 'Curaga') then
        gFunc.EquipSet(sets.CurePrecast);
    end

    if divineSeal > 0 then
        AshitaCore:GetChatManager():QueueCommand(-1,'/p Using Divine Seal -> ' .. spell.Name .. ' on ' .. target.Name);
    end
end

profile.HandleMidcast = function()
    local spell = gData.GetAction();
    local player = gData.GetPlayer();
    local target = gData.GetActionTarget();

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
            if string.contains(spell.Name, 'Regen') then
                gFunc.EquipSet(sets.RuckesRung);
            else
                gFunc.EquipSet(sets.Light);
            end
        elseif spell.Element == 'Dark' then
            gFunc.EquipSet(sets.Dark);
        end
    end

    if spell.Name == 'Invisible' then
        gFunc.EquipSet(sets.Invisible);
    elseif spell.Name == 'Sneak' then
        gFunc.EquipSet(sets.Sneak);
    elseif spell.Name == 'Stoneskin' then
        gFunc.EquipSet(sets.MNDEnhancingSkill);
    elseif spell.Name == 'Cursna' then
        gFunc.EquipSet(sets.Cursna);
    elseif string.contains(spell.Name, 'Spikes') then
        gFunc.EquipSet(sets.INT);
    elseif spell.Skill == 'Ninjutsu' then
        gFunc.EquipSet(sets.SpellHaste);
    elseif spell.Skill == 'Enfeebling Magic' and not string.contains(spell.Name, 'Dia' )then -- Dia and Dia II need zero gearswap
        if spell.Type == 'White Magic' then
            gFunc.EquipSet(sets.MNDEnfeeb);

            equipObiIfApplicable(spell.Element);
        elseif spell.Type == 'Black Magic' then
            gFunc.EquipSet(sets.INTEnfeeb);

            equipObiIfApplicable(spell.Element);
        end
    elseif spell.Skill == 'Enhancing Magic' then
        if spell.Name == 'Haste' then
            gFunc.EquipSet(sets.SpellHaste);
        elseif string.contains(spell.Name, 'Bar') or spell.Name == 'Phalanx' then -- Barspells need raw Enhancing Skill
            gFunc.EquipSet(sets.Barspell);

        elseif string.contains(spell.Name, 'Regen') then -- Rucke's Rung
            gFunc.EquipSet(sets.Regen);
        else
            gFunc.EquipSet(sets.MNDEnhancingSkill);
        end
    elseif spell.Skill == 'Healing Magic' then
    
        if string.contains(spell.Name, 'Cur') then
            if spell.Name == 'Cure V' then
                gFunc.EquipSet(sets.Cure5);
            else
                gFunc.EquipSet(sets.Cure);

                if player.HPP <= 75 then
                    gFunc.EquipSet(sets.MedicineRing);
                end
            end
        else
            gFunc.EquipSet(sets.SpellHaste);
        end
    elseif spell.Skill == 'Elemental Magic' then
        if spell.Name == 'Drown' or spell.Name == 'Frost' or spell.Name == 'Choke' or spell.Name == 'Rasp' or spell.Name == 'Shock' or spell.Name == 'Burn' then
            gFunc.EquipSet(sets.INTElemental);
        else
            gFunc.EquipSet(sets.INTElemental);
        end

        equipObiIfApplicable(spell.Element);
    elseif spell.Skill == 'Dark Magic' and spell.Name ~= 'Bio' then -- Bio needs zero gearswap

        if spell.Name == 'Drain' or spell.Name == 'Aspir' then
            gFunc.EquipSet(sets.DarkSkill);
        elseif spell.Name == 'Bio II' then -- Bio needs raw Dark Skill
            gFunc.EquipSet(sets.DarkSkill);
        else
            gFunc.EquipSet(sets.INT);
        end

        equipObiIfApplicable(spell.Element);

    elseif spell.Skill == 'Divine Magic' then

        gFunc.EquipSet(sets.DivineSkill);

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

    gFunc.EquipSet(sets.Weaponskill);

    if action.Name == 'Hexa Strike' then
        gFunc.EquipSet(sets.WeaponskillHexa);
    end

    draginclude.HandleWeaponSkill(action);
end

return profile;