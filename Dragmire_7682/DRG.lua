local profile = {};
draginclude = gFunc.LoadFile('common\\draginclude.lua');

local Settings = {
    LateInitialized = {
        Initialized = false,
        TimeToUse = 0,
    },
    StatusArmorSwaps = {
        OpoopoNecklace = true,
        PresidentialHairpin = true,
    },
    CurrentLevel = 0,
    TankToggle = 0, -- 0 = DPS, 1 = Parrying/Evasion
    Acc = 0,
    LockEth = false,
    GreedyHeal = false,
    DayCap = 971,
    NightCap = 962,
    GreedyDayCap = 1007,
    GreedyNightCap = 999,
    LockHP = false,
};

local sets = {
    Default_Priority = {
        Ammo = {'Fenrir\'s Stone', 'Happy Egg'},
        Head = {'Ace\'s Helm', 'Emperor Hairpin', 'Shep. Bonnet'},
        Neck = {'Love Torque', 'Peacock Amulet',},
        Ear1 = {'Beastly Earring', 'Spike Earring'},
        Ear2 = {'Brutal Earring', 'Merman\'s Earring'},
        Body = {'Wym. Mail +1', 'Elder\'s Surcoat', 'Dream Robe +1',},
        Hands = {'Homam Manopolas',},
        Ring1 = {'Rajas Ring'},
        Ring2 = {'Blitz Ring'},
        Back = {'Forager\'s Mantle', 'Amemet Mantle', 'Nomad\'s Mantle',},
        Waist = {'Sonic Belt', 'Swift Belt'},
        Legs = {'Homam Cosciales', 'Drn. Brais +1', 'Elder\'s Braguette'},
        Feet = {'Homam Gambieras', 'Elder\'s Sandals'},
    },

    DefaultLowHp_Priority = {

    },

    StaffTorque_Priority = {
        Neck = {'Temp. Torque'},
    },

    Engaged_Priority = { --22% Haste (Missing: Dusk Gloves +1(1%))
        Ammo = {'Tiphia Sting'},
        Head = {'Ace\'s Helm'}, --4%
        Body = {'Wym. Mail +1'}, -- +2%
        Hands = {'Homam Manopolas'}, --3%
        Ring2 = {'Blitz Ring'}, --1%
        Waist = {'Sonic Belt', 'Swift Belt'}, --6%
        Legs = {'Homam Cosciales'}, --3%
        Feet = {'Homam Gambieras'}, --3%
    },

    EngagedAcc_Priority = { --20% Haste (Missing: Dusk Gloves +1(1%))
        Ammo = {'Tiphia Sting'},
        Head = {'Ace\'s Helm'}, --4%
        Body = {'Homam Corazza'}, -- +15 Accuracy, Triple Attack+
        Hands = {'Homam Manopolas'}, --3%
        Ring2 = {'Blitz Ring'}, --1%
        Waist = {'Sonic Belt', 'Swift Belt'}, --4%
        Legs = {'Homam Cosciales'}, --3%
        Feet = {'Homam Gambieras'}, --3%
    },

    Mage_Priority = {
        Ammo = {'Fenrir\'s Stone', 'Happy Egg'},
        Head = {'Ace\'s Helm', 'Shep. Bonnet'},
        Neck = {'Love Torque', 'Peacock Amulet'},
        Ear1 = {'Beastly Earring', 'Spike Earring'},
        Ear2 = {'Brutal Earring', 'Merman\'s Earring'},
        Body = {'Wym. Mail +1', 'Elder\'s Surcoat'},
        Hands = {'Homam Manopolas'},
        Ring1 = {'Rajas Ring'},
        Ring2 = {'Blitz Ring'},
        Back = {'Forager\'s Mantle'},
        Waist = {'Sonic Belt', 'Swift Belt'},
        Legs = {'Homam Cosciales', 'Elder\'s Braguette'},
        Feet = {'Homam Gambieras'},
    },

    Parry_Priority = {
        Ear2 = {'Ethereal Earring'},
        Ring1 = {'Rajas Ring'},
        Ring2 = {'Toreador\'s Ring'},
        Waist = {'Sonic Belt', 'Swift Belt'},
    },

    TankDPS_Priority = {
        Ammo = {'Tiphia Sting', 'Happy Egg'},
        Head = {'Ace\'s Helm', 'Shep. Bonnet'},
        Neck = {'Love Torque', 'Peacock Amulet'},
        Ear1 = {'Beastly Earring', 'Spike Earring'},
        Ear2 = {'Ethereal Earring', 'Merman\'s Earring'},
        Body = {'Wym. Mail +1', 'Elder\'s Surcoat'},
        Hands = {'Homam Manopolas'},
        Ring1 = {'Rajas Ring'},
        Ring2 = {'Blitz Ring'},
        Back = {'Forager\'s Mantle'},
        Waist = {'Sonic Belt', 'Swift Belt'},
        Legs = {'Homam Cosciales', 'Elder\'s Braguette'},
        Feet = {'Homam Gambieras'},
    },

    TankStats_Priority = {
        Ammo = {'Fenrir\'s Stone', 'Happy Egg'},
        Head = {'Optical Hat'}, -- Evasion +10
        Ear1 = {'Novia Earring'}, -- Evasion +7
        Ear2 = {'Ethereal Earring'}, -- Evasion +5 Converts 3% damage to MP
        Body = {'Wym. Mail +1'}, -- Parrying Skill +15
        Hands = {'Wyrm Fng.Gnt.'}, -- AGI +3
        Ring1 = {}, -- Nothing useful
        Ring2 = {'Jelly Ring'},
        Back = {'Boxer\'s Mantle'}, -- Evasion Skill +10 Parrying Skill +10
        Waist = {'Ryl.Kgt. Belt'}, -- AGI +2
        Legs = {}, -- Nothing useful
        Feet = {'Drn. Greaves +1'}, -- AGI +5
    },

    PDT_Priority = {
        Head = {'Darksteel Cap +1'}, -- PDT -2%
        Ear1 = {'Ethereal Earring'}, -- Evasion +5, Absorb Damage as MP
        Ear2 = {'Novia Earring'}, -- Evasion +7
        Body = {'Wym. Mail +1'}, -- Parrying Skill +15
        Hands = {'Dst. Mittens +1'}, -- PDT -2%
        Ring2 = {'Jelly Ring'}, -- PDT -5%
        Back = {'Boxer\'s Mantle'}, -- Evasion Skill +10, Parrying Skill +10
        Legs = {'Dst. Subligar +1'}, -- PDT -3%
        Feet = {'Dst. Leggings +1'}, -- PDT -2%
    },

    PDTNight_Priority = {
        Ammo = {'Fenrir\'s Stone'}, -- Evasion +10
        Head = {'Darksteel Cap +1'}, -- PDT -2%
        Ear1 = {'Ethereal Earring'}, -- Evasion +5, Absorb Damage as MP
        Ear2 = {'Novia Earring'}, -- Evasion +7
        Body = {'Wym. Mail +1'}, -- Parrying Skill +15
        Hands = {'Dst. Mittens +1'}, -- PDT -2%
        Ring2 = {'Jelly Ring'}, -- PDT -5%
        Back = {'Boxer\'s Mantle'}, -- Evasion Skill +10, Parrying Skill +10
        Legs = {'Dst. Subligar +1'}, -- PDT -3%
        Feet = {'Dst. Leggings +1'}, -- PDT -2%
    },

    MDT_Priority = {
        Ear1 = {'Loquac. Earring'},
        Ear2 = {'Ethereal Earring'},
    },

    MP_Priority = {
        Ammo = {'Hedgehog Bomb', 'Phtm. Tathlum'},
        Head = {},
        Neck = {'Rep.Mythril Medal'},
        Ear1 = {'Beastly Earring'},
        Ear2 = {'Phantom Earring'},
        Body = {'Elder\'s Surcoat'},
        Hands = {'Elder\'s Bracers'},
        Ring1 = {'Astral Ring'},
        Ring2 = {'Ether Ring'},
        Back = {},
        Waist = {},
        Legs = {'Elder\'s Braguette'},
        Feet = {'Elder\'s Sandals'},
    },

    Evasion_Priority = {

    },

    WeaponSkill_Priority = { -- STR +53, DEX +12, ATT +23
        Ammo = {'Tiphia Sting'}, -- ATT+2, ACC+2
        Head = {'Ace\'s Helm'}, -- STR+4, ACC+7
        Neck = {'Love Torque'}, -- SKILL+7, DEX+5
        Ear1 = {'Beastly Earring',}, -- SKILL+5
        Ear2 = {'Brutal Earring'}, -- DA+
        Body = {'Hecatomb Harness'}, -- STR+12, ACC+10
        Hands = {'Alkyoneus\'s Brc.'}, -- STR+11, DEX-6
        Ring1 = {'Rajas Ring'}, -- STR+5, DEX+5
        Ring2 = {'Flame Ring'}, -- STR+5
        Back = {'Forager\'s Mantle'}, -- STR+3, ATT+15
        Waist = {'Warwolf Belt'}, -- STR+5, DEX+5
        Legs = {'Barone Cosciales'}, -- STR+2, ATT+6
        Feet = {'Hct. Leggings'}, --STR+6, DEX+3
    },

    WeaponSkillPenta_Priority = {
        Body = {'Homam Corazza'}, -- ACC+15
        Hands = {'Wyrm Fng.Gnt.'}, -- ACC+5
        Legs = {'Drn. Brais +1'}, -- ACC+9
        Ring2 = {'Toreador\'s Ring'}, -- ACC+7
    },

    -- Wheeling Thrust: STR:80%
    -- Geirskogul: STR: 30% DEX: 30% 
    WeaponSkillLight_Priority = {
        Neck = {'Light Gorget'},
    },

    WeaponSkillGeirskogul_Priority = { -- STR +47, DEX +25, ATT +17
        Neck = {'Light Gorget'},
        Hands = {'Hecatomb Mittens'}, -- STR+7, DEX+4
        Legs = {'Wyrm Brais'}, -- DEX +5
    },

    WeaponSkillSpiritTaker_Priority = { -- ACC+20, INT+16, MND+6
        Ammo = {'Phtm. Tathlum'}, -- INT+2
        Head = {'Optical Hat'}, -- ACC+10
        Neck = {'Peacock Amulet'}, -- ACC+10
        Ear1 = {'Phantom Earring',}, -- INT+1
        Ear2 = {'Brutal Earring'}, -- DA+
        Body = {'Elder\'s Surcoat'}, -- INT+1
        Hands = {'Elder\'s Bracers'}, -- INT+2
        Ring1 = {'Diamond Ring'}, -- INT+4
        Ring2 = {'Sapphire Ring'}, -- MND+4
        Back = {},
        Waist = {'Ryl.Kgt. Belt'}, -- INT+2, MND+2
        Legs = {'Elder\'s Braguette'}, -- INT+2
        Feet = {'Elder\'s Sandals'}, -- INT+2
    },

    Precast_Priority = {
        Ear1 = {'Loquac. Earring'},
        Legs = {'Homam Cosciales'},
    },

    -- Improvements: Ajase Beads (No HP change but save 20 MP, Rare/EX -> NM), Desert Sash (10 more HP but none in stock on AH, 20k)
    -- Skips (for now): Wbody (Expensive + DKP), 
    -- Current Threshold Cap (Nighttime): 999/1960 (Carbonara: 1097/2151)
    -- Current Threshold Cap (Daytime): 1007/1976 (Carbonara: 1088/2135)
    -- Optimized Threshold Cap (Nighttime): 1004/1970 (Carbonara: 1102/2161)
    -- Optimized Threshold Cap (Daytime): 1012/1986 (Carbonara: 1093/2145)
    MidcastNightGreedy_Priority = { -- +HP
        Ammo = {'Happy Egg'}, -- Good
        Head = {'Drachen Armet'}, -- Good
        Ear1 = {'Bloodbead Earring'}, -- Good
        Ear2 = {'Cassie Earring'}, -- Good
        Neck = {'Ajase Beads'}, -- Good
        Body = {'Bloody Aketon'}, -- Good
        Hands = {'Alkyoneus\'s Brc.'}, -- Good
        Ring1 = {'Bloodbead Ring'}, -- Good
        Ring2 = {'Bomb Queen Ring'}, -- Good
        Back = {'Gigant Mantle'}, -- Good
        Waist = {'Powerful Rope'}, -- Desert Sash
        Legs = {'Homam Cosciales'}, -- Good
        Feet = {'Homam Gambieras'}, -- Good
    },

    MidcastGreedy_Priority = { -- +HP
        Ammo = {'Fenrir\'s Stone'}, -- Good
        Head = {'Drachen Armet'}, -- Good
        Ear1 = {'Bloodbead Earring'}, -- Good
        Ear2 = {'Cassie Earring'}, -- Good
        Neck = {'Ajase Beads'}, -- Good
        Body = {'Bloody Aketon'}, -- Good
        Hands = {'Alkyoneus\'s Brc.'}, -- Good
        Ring1 = {'Bloodbead Ring'}, -- Good
        Ring2 = {'Bomb Queen Ring'}, -- Good
        Back = {'Gigant Mantle'}, -- Good
        Waist = {'Powerful Rope'}, -- Desert Sash
        Legs = {'Homam Cosciales'}, -- Good
        Feet = {'Homam Gambieras'}, -- Good
    },

    -- Current Threshold Cap (Daytime): 962/1888 (Carbonara: 1052/2063)
    -- Current Threshold Cap (Nighttime): 971/1904 (Carbonara: 1060/2079)
    MidcastNight_Priority = { -- +HP
        Ammo = {'Happy Egg'}, -- Good
        Head = {'Drachen Armet'}, -- Good
        Ear1 = {'Bloodbead Earring'}, -- Good
        Ear2 = {'Ethereal Earring'}, -- Good
        Neck = {'Ajase Beads'}, -- Good
        Body = {'Wym. Mail +1'}, -- Good
        Hands = {'Alkyoneus\'s Brc.'}, -- Good
        Ring1 = {'Bloodbead Ring'}, -- Good
        Ring2 = {'Bomb Queen Ring'}, -- Good
        Back = {'Gigant Mantle'}, -- Good
        Waist = {'Powerful Rope'}, -- Desert Sash
        Legs = {'Homam Cosciales'}, -- Good
        Feet = {'Homam Gambieras'}, -- Good
    },

    Midcast_Priority = { -- +HP
        Ammo = {'Fenrir\'s Stone'}, -- Good
        Head = {'Drachen Armet'}, -- Good
        Ear1 = {'Bloodbead Earring'}, -- Good
        Ear2 = {'Ethereal Earring'}, -- Good
        Neck = {'Ajase Beads'}, -- Good
        Body = {'Wym. Mail +1'}, -- Good
        Hands = {'Alkyoneus\'s Brc.'}, -- Good
        Ring1 = {'Bloodbead Ring'}, -- Good
        Ring2 = {'Bomb Queen Ring'}, -- Good
        Back = {'Gigant Mantle'}, -- Good
        Waist = {'Powerful Rope'}, -- Desert Sash
        Legs = {'Homam Cosciales'}, -- Good
        Feet = {'Homam Gambieras'}, -- Good
    },

    MidcastJustHelm_Priority = { 
        Head = {'Drachen Armet'}, -- Good
    },

    StyleLock = {
        Main = 'Gungnir',
        Head = 'Ace\'s Helm',
        Body = 'Homam Corazza',
        Hands = 'Homam Manopolas',
        Legs = 'Homam Cosciales',
        Feet = 'Homam Gambieras',
    },

    StyleLockRelic = {
        Main = 'Love Halberd',
        Head = 'Wyrm Armet',
        Body = 'Wym. Mail +1',
        Hands = 'Wyrm Fng.Gnt.',
        Legs = 'Wyrm Brais',
        Feet = 'Wyrm Greaves',
    },

    StyleLockAF = {
        Main = 'Love Halberd',
        Head = 'Drachen Armet',
        Body = 'Drachen Mail',
        Hands = 'Drachen Fng. Gnt.',
        Legs = 'Drn. Brais +1',
        Feet = 'Drn. Greaves +1',
    },

    StyleLockRSE = {
        Main = 'Pitchfork +1',
        Head = 'Egg Helm',
        Body = 'Elder\'s Surcoat',
        Hands = 'Elder\'s Bracers',
        Legs = 'Elder\'s Braguette',
        Feet = 'Elder\'s Sandals'
    },

    StyleLockTank = {
        Main = 'Gungnir',
        Head = 'Darksteel Cap +1',
        Body = 'Dst. Harness +1',
        Hands = 'Dst. Mittens +1',
        Legs = 'Dst. Subligar +1',
        Feet = 'Dst. Leggings +1',
    },

    StyleLockUgly = {
        Main = 'Gungnir',
        Head = 'Shep. Bonnet',
        Body = 'Elder\'s Surcoat',
        Hands = 'Ostreger Mitts',
        Legs = 'Barone Cosciales',
        Feet = 'Dst. Leggings +1',
    },

    StyleLockSummer = {
        Main = 'Gungnir',
        Head = 'Ace\'s Helm',
        Body = 'Goblin Suit',
        --Hands = 'Scp. Gauntlets',
        --Legs = 'Elder Trunks',
        --Feet = 'Homam Gambieras',
    },

    StyleLockWinter = {
        Main = 'Gungnir',
        Head = 'Dream Hat +1',
        Body = 'Dream Robe +1',
        Hands = 'Dream Mittens +1',
        Legs = 'Dream Trousers +1',
        Feet = 'Dream Boots +1',
    },

    StyleLockStrange = {
        Main = 'Gungnir',
        Head = 'Darksteel Cap +1',
        Body = 'Bloody Aketon',
        Hands = 'Crimson Fng. Gnt.',
        Legs = 'Crimson Cuisses',
        Feet = 'Dst. Leggings +1',
    },

    StyleLockSummer2 = {
        Main = 'Gungnir',
        Head = 'President. Hairpin',
        Body = 'Elder Gilet +1',
        Legs = 'Elder Trunks',
    },

    BreathBonusHealing_Priority = {
        Head = {'Wyrm Armet', 'Drachen Armet', 'Shep. Bonnet'},
        Body = {'Wyvern Mail'},
		Hands = {'Ostreger Mitts'},
        Legs = {'Drn. Brais +1'},
		Feet = {'Homam Gambieras'},
    },

    BreathBonusElemental_Priority = {
        Head = {'Wyrm Armet', 'Drachen Armet', 'Shep. Bonnet'},
    },

    CallWyvern_Priority = {
        Body = {'Wym. Mail +1'},
    },

    Jump_Priority = { -- ACC
        Head = {'Ace\'s Helm'},
        Neck = {'Peacock Amulet'},
        Body = {'Homam Corazza'},
        Hands = {'Hecatomb Mittens'},
        Ring2 = {'Toreador\'s Ring'},
        Waist = {'Wyrm Belt'},
        Legs = {'Barone Cosciales'},
        Feet = {'Drn. Greaves +1'},
    },

    HighJump_Priority = { -- ACC
        Head = {'Ace\'s Helm'},
        Neck = {'Peacock Amulet'},
        Body = {'Homam Corazza'},
        Hands = {'Hecatomb Mittens'},
        Waist = {'Wyrm Belt'},
        Ring1 = {'Rajas Ring'},
        Ring2 = {'Toreador\'s Ring'},
        Legs = {'Barone Cosciales'},
        Feet = {'Drn. Greaves +1'},
    },

    AncientCircle_Priority = {
        Legs = {'Drn. Brais +1'},
    },

    Resting_Priority = {
        Body = {'Wyvern Mail'},
    },

    RestingMage_Priority = {
        Ear2 = {'Relaxing Earring'},
        Body = {'Wyvern Mail'},
    },

    PetIdle_Priority = {
        --Body = {'Drachen Mail'},
    },

    RunSpeed_Priority = {
        --Body = {'Barone Corazza'},
        Legs = {'Crimson Cuisses'},
    },

    Ethereal_Priority = {
        Ear1 = {'Ethereal Earring'},
    },

    IdleTownMage_Priority = {
        Ammo = {'Tiphia Sting'},
        Head = {'Ace\'s Helm'},
        Neck = {'Love Torque'},
        Ear1 = {'Loquac. Earring'},
        Ear2 = {'Ethereal Earring'},
        Body = {'Wym. Mail +1'},
        Hands = {'Homam Manopolas'},
        Ring1 = {'Jelly Ring'},
        Ring2 = {'Blitz Ring'},
        Back = {'Forager\'s Mantle'},
        Waist = {'Sonic Belt', 'Swift Belt'},
        Legs = {'Crimson Cuisses'},
        Feet = {'Homam Gambieras'},
    },

    IdleTown_Priority = {
        Ammo = {'Tiphia Sting'},
        Head = {'Ace\'s Helm'},
        Neck = {'Love Torque'},
        Ear1 = {'Brutal Earring'},
        Ear2 = {'Beastly Earring'},
        Body = {'Homam Corazza'},
        Hands = {'Homam Manopolas'},
        Ring1 = {'Rajas Ring'},
        Ring2 = {'Blitz Ring'},
        Back = {'Forager\'s Mantle'},
        Waist = {'Sonic Belt', 'Swift Belt'},
        Legs = {'Crimson Cuisses'},
        Feet = {'Homam Gambieras'},
    },

    Charm_Priority = { -- CHR +15 & Charm +5
        --Head = {'Panther Mask'}, -- CHR +5
        Ear1 = {'Brutal Earring'}, -- Nothing; keeps Beastly Earring off
        Ear2 = {'Ethereal Earring'}, -- Nothing; keeps Beastly Earring off
        Neck = {'Temp. Torque'}, -- CHR +5
        Body = {'Elder\'s Surcoat'}, -- CHR +1
        Waist = {'Ryl.Kgt. Belt'}, -- CHR +2
        Back = {'Trimmer\'s Mantle'}, -- Charm +5
        Legs = {'Elder\'s Braguette'}, -- CHR +2
    },

    EXPRing = {
        Ring1 = 'Emperor Band',
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
};

profile.Sets = sets;

local function HandlePetAction(PetAction)

    gFunc.Message(PetAction.Name .. ' - ' .. PetAction.Type);

    if string.contains(PetAction.Name, 'Healing Breath') then
        gFunc.EquipSet(sets.BreathBonusHealing);
        gFunc.Message("Healing Breath set");
    else
        gFunc.EquipSet(sets.BreathBonusElemental);
        gFunc.Message("Elemental Breath set");
    end
end

local function LateInitialize()
    local timestamp = os.time();
    local player = gData.GetPlayer();

    if timestamp >= Settings.LateInitialized.TimeToUse then
        -- Setting a Style Lock prevents the character from blinking
        gFunc.LockStyle(sets.StyleLock);

        --[[ Set your job macro defaults here]]
        if player.SubJob == 'RDM' then
            AshitaCore:GetChatManager():QueueCommand(1, '/macro book 15');
            AshitaCore:GetChatManager():QueueCommand(1, '/macro set 2');
        elseif player.SubJob == 'WHM' then
            AshitaCore:GetChatManager():QueueCommand(1, '/macro book 15');
            AshitaCore:GetChatManager():QueueCommand(1, '/macro set 3');
            gFunc.Message('WHM Macro Book');
        elseif player.SubJob == 'THF' then
            AshitaCore:GetChatManager():QueueCommand(1, '/macro book 15');
            AshitaCore:GetChatManager():QueueCommand(1, '/macro set 4');
            gFunc.Message('THF Macro Book');
        elseif player.SubJob == 'WAR' then
            AshitaCore:GetChatManager():QueueCommand(1, '/macro book 15');
            AshitaCore:GetChatManager():QueueCommand(1, '/macro set 5');
            gFunc.Message('WAR Macro Book');
        elseif player.SubJob == 'NIN' then
            AshitaCore:GetChatManager():QueueCommand(1, '/macro book 15');
            AshitaCore:GetChatManager():QueueCommand(1, '/macro set 6');
            gFunc.Message('NIN Macro Book');
        elseif player.SubJob == 'SAM' then
            AshitaCore:GetChatManager():QueueCommand(1, '/macro book 15');
            AshitaCore:GetChatManager():QueueCommand(1, '/macro set 7');
            gFunc.Message('SAM Macro Book');
        else
            AshitaCore:GetChatManager():QueueCommand(1, '/macro book 15');
            AshitaCore:GetChatManager():QueueCommand(1, '/macro set 8');
            gFunc.Message('DEFAULT Macro Book');
        end

        -- DRG Core Commands
        AshitaCore:GetChatManager():QueueCommand(-1,'/bind 2 /lac fwd Jump ');
        AshitaCore:GetChatManager():QueueCommand(-1,'/bind 3 /lac fwd CallWyvern ');
        AshitaCore:GetChatManager():QueueCommand(-1,'/bind 4 /lac fwd HighJump ');
        AshitaCore:GetChatManager():QueueCommand(-1,'/bind 5 /lac fwd SuperJump ');
        AshitaCore:GetChatManager():QueueCommand(-1,'/bind 9 /lac fwd SpiritLink ');
        AshitaCore:GetChatManager():QueueCommand(-1,'/bind 0 /lac fwd SteadyWing');

        AshitaCore:GetChatManager():QueueCommand(-1,'/alias /tank /lac fwd TankToggle');
        AshitaCore:GetChatManager():QueueCommand(-1,'/alias /acc /lac fwd Acc');
        AshitaCore:GetChatManager():QueueCommand(-1,'/alias /eth /lac fwd LockEth');
        AshitaCore:GetChatManager():QueueCommand(-1,'/alias /greedy /lac fwd GreedyToggle');
        AshitaCore:GetChatManager():QueueCommand(-1,'/alias /hp /lac fwd LockHP');

        Settings.LateInitialized.Initialized = true;
        gFunc.Message('LateInitialized');
    end
end

profile.OnLoad = function()
    draginclude.OnLoad(sets, {'Default', 'Tank'}, {'None', 'Field', 'Fishing'});
end

profile.OnUnload = function()
    draginclude.OnUnload();
end

profile.HandleCommand = function(args)
    draginclude.HandleCommand(args, sets);
    draginclude.HandleDrgCoreCommands(args);

    if args[1] == 'TankToggle' then

        if Settings.TankToggle == 0 then
            Settings.TankToggle = 1;
        else
            Settings.TankToggle = 0;
        end

        gFunc.Message('TankToggle ' .. Settings.TankToggle);
    elseif args[1] == 'Acc' then

        if Settings.Acc == 0 then
            Settings.Acc = 1;
        else
            Settings.Acc = 0;
        end

        gFunc.Message('Acc ' .. Settings.Acc);
    elseif args[1] == 'LockEth' then

        if Settings.LockEth == false then
            Settings.LockEth = true;
        else
            Settings.LockEth = false;
        end

        gFunc.Message('LockEth ' .. tostring(Settings.LockEth));
    elseif args[1] == 'GreedyToggle' then

        Settings.GreedyHeal = not Settings.GreedyHeal;

        gFunc.Message('GreedyHeal ' .. tostring(Settings.GreedyHeal));
    elseif args[1] == 'LockHP' then

        Settings.LockHP = not Settings.LockHP;

        gFunc.Message('LockHP ' .. tostring(Settings.LockHP));
    elseif args[1] == 'DayCheck' then
        local day = gData.GetEnvironment().Day;

        gFunc.Message(day);
    end
end

profile.HandleDefault = function()
    local timestamp = os.time();
    local petAction = gData.GetPetAction();
    local pet = gData.GetPet();
    local player = gData.GetPlayer();
    local party = AshitaCore:GetMemoryManager():GetParty();
    local zone = gData.GetEnvironment();
    local eq = gData.GetEquipment();
    local time = zone.Time;
    local myZone = party:GetMemberZone(0);
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
            LateInitialize();
        end
    end

    -- Forward slash toggle between Default and Evasion
    if draginclude.dragSettings.TpVariant == 1 then
        if Settings.TankToggle == 0 then
            gFunc.EquipSet(sets.TankDPS);
        else
            gFunc.EquipSet(sets.TankStats);
        end
        if player.SubJob == 'WHM' or player.SubJob == 'RDM' or player.SubJob == 'BLM' then
            if player.MP <= 75 then
                gFunc.EquipSet(sets.Default);
            else
                --gFunc.EquipSet(sets.Default);
                gFunc.EquipSet(sets.Mage);
            end

        else
            gFunc.EquipSet(sets.Default);
        end
    end
    
    if eq.Main then
        if eq.Main.Name == 'Mercurial Pole' then
            gFunc.Equip('Neck', 'Peacock Amulet');
        else
            draginclude.CheckTorque();
        end
    end

    -- Engaged Section
    if player.Status == 'Engaged' then

        if Settings.Acc == 0 then
            gFunc.EquipSet(sets.Engaged);
        else
            gFunc.EquipSet(sets.EngagedAcc);
        end
        
    -- Resting Section
    elseif (player.Status == 'Resting') then

        if pet ~= nil and pet.HPP < 100 then
            gFunc.EquipSet(sets.PetIdle);
        end

        -- Switch to Resting gear
        if player.SubJob == 'WHM' or player.SubJob == 'BLM' or player.SubJob == 'RDM' then
            gFunc.EquipSet(sets.RestingMage);
        else
            gFunc.EquipSet(sets.Resting);
        end

    -- Idle Section
    else
        if player.IsMoving then
            gFunc.EquipSet(sets.RunSpeed);
        end

        if pet ~= nil and pet.HPP < 100 then
            gFunc.EquipSet(sets.PetIdle);
        end
    end

    
    if draginclude.dragSettings.TpVariant == 2 then -- Use Tank set
        if time < 6 or time > 18 then
            gFunc.EquipSet(sets.PDTNight);
        else
            gFunc.EquipSet(sets.PDT);
        end

        if player.Status ~= 'Engaged' and player.IsMoving then
            gFunc.EquipSet(sets.RunSpeed);
        end
    end

    if (petAction ~= nil) then
        HandlePetAction(petAction);
        return;
    end

    if Settings.LockEth then
        gFunc.EquipSet(sets.Ethereal);
    end

    if Settings.LockHP then
        if time < 6 or time > 18 then
            gFunc.EquipSet(sets.MidcastNightGreedy);
        else
            gFunc.EquipSet(sets.MidcastGreedy);
        end
    end

    draginclude.HandleDefault(Settings);
    draginclude.CheckSkillingVariantCondition(player.IsMoving, sets.RunSpeed);
    draginclude.CheckStatusArmorSwaps(Settings.StatusArmorSwaps, Settings.CurrentLevel);
end

profile.HandleAbility = function()
    local ability = gData.GetAction();

    if string.match(ability.Name, 'Call Wyvern') then
        gFunc.EquipSet(sets.CallWyvern);
    elseif string.match(ability.Name, 'High Jump') then
        gFunc.EquipSet(sets.HighJump);
    elseif string.match(ability.Name, 'Jump') then
        gFunc.EquipSet(sets.Jump);
    elseif string.match(ability.Name, 'Ancient Circle') then
        gFunc.EquipSet(sets.AncientCircle);
    elseif string.match(ability.Name, 'Spirit Link') then
        gFunc.EquipSet(sets.Resting);
    elseif string.match(ability.Name, 'Charm') then
        gFunc.LockSet(sets.Charm, 1);
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
    local player = gData.GetPlayer();
    local spell = gData.GetAction();
    local partyPrioSpell = 'Barston';
    local time = gData.GetEnvironment().Time;
    local hasRefresh = gData.GetBuffCount('Refresh') + gData.GetBuffCount('Ballad');
    local greedyMpCap = 0;

    if player.SubJob == 'RDM' then
        greedyMpCap = 77;
    elseif player.SubJob == 'WHM' then
        greedyMpCap = 96;
    elseif player.SubJob == 'BLM' then
        greedyMpCap = 115;
    end

    gFunc.Message(spell.Name .. ' Greedy: ' .. tostring(Settings.GreedyHeal) .. ' Time: ' .. time);

    gFunc.EquipSet(sets.MidcastJustHelm);

    if string.contains(spell.Name, partyPrioSpell) then
        gFunc.Message('HP Up Set SKIPPED');
    elseif (Settings.GreedyHeal or player.MP <= greedyMpCap or hasRefresh > 0) and not (string.contains(spell.Name, 'Teleport') or string.contains(string.lower(spell.Name), 'raise')) then
        if time < 6 or time > 18 then
            gFunc.EquipSet(sets.MidcastNightGreedy);
        else
            gFunc.EquipSet(sets.MidcastGreedy);
        end
    else
        if time < 6 or time > 18 then
            gFunc.EquipSet(sets.MidcastNight);
        else
            gFunc.EquipSet(sets.Midcast);
        end
    end

    if spell.Name == 'Invisible' then
        gFunc.EquipSet(sets.Invisible);
    elseif spell.Name == 'Sneak' then
        gFunc.EquipSet(sets.Sneak);
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

    gFunc.Message(action.Name);

    gFunc.EquipSet(sets.WeaponSkill);

    if action.Name == 'Penta Thrust' then
        gFunc.EquipSet(sets.WeaponSkillPenta);
    elseif action.Name == 'Geirskogul' then
        gFunc.EquipSet(sets.WeaponSkillGeirskogul);
    elseif action.Name == 'Wheeling Thrust' or action.Name == 'Skewer' then
        gFunc.EquipSet(sets.WeaponSkillLight);
    elseif action.Name == 'Spirit Taker' then
        gFunc.EquipSet(sets.WeaponSkillSpiritTaker);
    end

    draginclude.HandleWeaponSkill(action);
end

return profile;