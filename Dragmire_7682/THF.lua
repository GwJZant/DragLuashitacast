local profile = {};
draginclude = gFunc.LoadFile('common\\draginclude.lua');
local isTargetTagged = gFunc.LoadFile('common\\tag.lua');

local Settings = {
    -- Default settings for jug/food preferences
    JugPetSettings = {
        DefaultFood = 'Pet Fd. Gamma',
    },
    LateInitialized = {
        Initialized = false,
        TimeToUse = 0,
    },
    StatusArmorSwaps = {
        OpoopoNecklace = true,
        PresidentialHairpin = true,
    },
    CurrentLevel = 0,
    CurrentBolt = 'Crossbow Bolt',
    CurrentRanged = 'Crossbow',
    LockTH = false,
    LockTH2 = false,
    LockGilfinder = false,
};

local sets = {
    Default_Priority = {
        --Main = {'Earth Staff'},
        Head = {'Optical Hat', 'Rogue\'s Bonnet'},
        Neck = {'Love Torque', 'Peacock Amulet'},
        Ear1 = {'Novia Earring', 'Merman\'s Earring', 'Reraise Earring'}, --EVA +3
        Ear2 = {'Ethereal Earring', 'Dodge Earring'}, --AGI +3
        Body = {'Scorpion Harness', 'Elder\'s Surcoat'},
        Hands = {'Homam Manopolas', 'Rogue\'s Armlets', 'Elder\'s Bracers'},
        Ring1 = {'Rajas Ring'},
        Ring2 = {'Toreador\'s Ring', 'Woodsman Ring'},
        Back = {'Boxer\'s Mantle', 'Trimmer\'s Mantle'},
        Waist = {'Swift Belt', 'Swift Belt'},
        Legs = {'Homam Cosciales', 'Raven Hose', 'Elder\'s Braguette'},
        Feet = {'Trotter Boots'},
    },

    RangedAcc_Priority = {
        Head = {'Optical Hat'},
        Neck = {'Peacock Amulet'},
        Body = {'Rapparee Harness'},
        Waist = {'Ryl.Kgt. Belt'},
    },

    RangedINT_Priority = {
        Head = {'Rogue\'s Bonnet'},
        Neck = {'Peacock Amulet'},
        Ear2 = {'Phantom Earring'},
        Body = {'Elder\'s Surcoat'},
        Hands = {'Elder\'s Bracers'},
        Ring1 = {'Diamond Ring'},
        Ring2 = {'Diamond Ring'},
        Waist = {'Ryl.Kgt. Belt'},
        Legs = {'Elder\'s Braguette'},
        Feet = {'Elder\'s Sandals'},
    },

    RangedUngur_Priority = {
        Range = {'Ungur Boomerang'},
    },

    RangedCrossbow_Priority = {
        Range = {'Velocity Bow'},
    },

    DefaultNIN_Priority = {
        Ear2 = {'Stealth Earring'},
    },

    FastCast_Priority = {
        Ear2 = {'Loquac. Earring'},
        Legs = {'Homam Cosciales'},
    },

    Evasion_Priority = {
        Head = {'Optical Hat'},
        Ear1 = {'Novia Earring'},
        Ear2 = {'Ethereal Earring'},
        Body = {'Scorpion Harness'},
        Ring2 = {'Jelly Ring'},
        Waist = {'Ryl.Kgt. Belt'},
    },

    Engaged_Priority = {
        Head = {'Panther Mask'}, --2%
        Ear1 = {'Merman\'s Earring'},
        Ear2 = {'Brutal Earring'},
        Hands = {'Homam Manopolas', 'Dusk Gloves'}, --3%
        Body = {'Rapparee Harness'}, --4%
        Back = {'Forager\'s Mantle'},
        Waist = {'Swift Belt'}, --6%
        Legs = {'Homam Cosciales'}, --3%
        Feet = {'Homam Gambieras', 'Dusk Ledelsens'}, --3%
    },

    EngagedNIN_Priority = {
        Head = {'Panther Mask'}, --2%
        Ear1 = {'Brutal Earring'},
        Ear2 = {'Stealth Earring'},
        Hands = {'Homam Manopolas', 'Dusk Gloves'}, --3%
        Body = {'Rapparee Harness'}, --4%
        Back = {'Forager\'s Mantle'},
        Waist = {'Swift Belt'}, --6%
        Legs = {'Homam Cosciales'}, --3%
        Feet = {'Homam Gambieras', 'Dusk Ledelsens'}, --3%
    },

    EngagedEvasion_Priority = {
        Head = {'Optical Hat'},
        Ear1 = {'Novia Earring'},
        Ear2 = {'Ethereal Earring'},
        Hands = {'Homam Manopolas', 'Dusk Gloves'}, --3%
        Body = {'Scorpion Harness'},
        Back = {'Forager\'s Mantle'},
        Waist = {'Swift Belt'}, --6%
        Legs = {'Homam Cosciales'}, --3%
        Feet = {'Homam Gambieras', 'Dusk Ledelsens'}, --3%
    },

    EngagedEvasionNIN_Priority = {
        Head = {'Optical Hat'},
        Ear1 = {'Novia Earring'},
        Ear2 = {'Stealth Earring'},
        Hands = {'Homam Manopolas', 'Dusk Gloves'}, --3%
        Body = {'Scorpion Harness'},
        Back = {'Forager\'s Mantle'},
        Waist = {'Swift Belt'}, --6%
        Legs = {'Homam Cosciales'}, --3%
        Feet = {'Homam Gambieras', 'Dusk Ledelsens'}, --3%
    },

    SA_Priority = { -- DEX > Attack > STR
        Head = {'Assassin\'s Bonnet'}, -- DEX +5
        Neck = {'Love Torque'}, -- DEX +5
        Ear1 = {'Merman\'s Earring'}, -- Attack +6
        Ear2 = {'Brutal Earring'}, -- DA +5%
        Body = {'Rapparee Harness'}, -- Haste +4%, Need a Dragon Harness
        Hands = {'Dusk Gloves'}, -- Attack +5
        Ring1 = {'Rajas Ring'}, -- DEX +5
        Ring2 = {'Flame Ring'}, -- STR +5
        Back = {'Forager\'s Mantle'}, -- Attack +15, STR +3
        Waist = {'Warwolf Belt'}, -- DEX +5, STR +5
        Legs = {'Homam Cosciales'}, -- Haste +3%, Get dusk legs
        Feet = {'Rogue\'s Poulaines'}, -- DEX +3
    },

    MP_Priority = {
        Body = {'Elder\'s Surcoat'},
        Hands = {'Elder\'s Bracers'},
        Ring1 = {'Ether Ring', 'Astral Ring'},
        Ring2 = {'Astral Ring'},
        Legs = {'Elder\'s Braguette'},
        Feet = {'Elder\'s Sandals'},
    },

    SpellHaste_Priority = {
        Head = {'Panther Mask'}, --2%
        Hands = {'Homam Manopolas', 'Dusk Gloves'}, --3%
        Body = {'Rapparee Harness'}, --4%
        Waist = {'Swift Belt'}, --6%
        Legs = {'Homam Cosciales'}, --3%
        Feet = {'Homam Gambieras', 'Dusk Ledelsens'}, --3%
    },

    BlueCotehardie_Priority = {
        Body = {'Blue Cotehardie'},
    },

    Gilfinder_Priority = {
        Hands = {'Andvaranauts'},
    },

    CrossbowBolt_Priority = {
        Ammo = {'Crossbow Bolt'},
    },

    AcidBolt_Priority = {
        Ammo = {'Acid Bolt'},
    },

    SleepBolt_Priority = {
        Ammo = {'Sleep Bolt'},
    },

    BloodyBolt_Priority = { --INT
        Ammo = {'Bloody Bolt'},
    },

    WS_Priority = {
        Head = {'Assassin\'s Bonnet', 'Rogue\'s Bonnet'},
        Neck = {'Love Torque'},
        Ear1 = {'Merman\'s Earring'},
        Ear2 = {'Ethereal Earring'},
        Body = {'Hecatomb Harness', 'Scorpion Harness'},
        Hands = {'Hecatomb Mittens', 'Rogue\'s Armlets'},
        Ring1 = {'Rajas Ring'},
        Ring2 = {'Toreador\'s Ring'},
        Back = {'Forager\'s Mantle'},
        Waist = {'Warwolf Belt', 'Ryl.Kgt. Belt'},
        Feet = {'Hct. Leggings', 'Rogue\'s Poulaines'},
    },

    WeaponSkillEvis_Priority = {
        Head = {'Panther Mask'},
    },

    WeaponSkillSharkBite_Priority = {
        Ring2 = {'Flame Ring'},
    },

    TH_Priority = {
        Neck = {'Nanaa\'s Charm'},
        Hands = {'Assassin\'s Armlets'},
    },

    StyleLock = {
        Head = 'Assassin\'s Bonnet',
        Body = 'Hecatomb Harness',
        Hands = 'Andvaranauts',
        Legs = 'Homam Cosciales',
        Feet = 'Hct. Leggings',
    },

    IdleTown_Priority = {
        Neck = {'Nanaa\'s Charm'},
        Hands = {'Assassin\'s Armlets'},
    },

    IdleTownNIN_Priority = {
        Neck = {'Nanaa\'s Charm'},
        Hands = {'Assassin\'s Armlets'},
    },

    PetReadyDefault = {

    },

    PetAttack_Priority = {
        Ear2 = {'Beastly Earring'},
    },

    Reward_Priority = { -- MND
        Ammo = {'Pet Food Zeta', 'Pet Fd. Epsilon', 'Pet Food Delta', 'Pet Fd. Gamma', 'Pet Food Beta', 'Pet Food Alpha'},
    },

    Charm_Priority = { -- CHR +15 & Charm +5
        Head = {'Panther Mask'}, -- CHR +5
        Ear2 = {'Ethereal Earring'}, -- Nothing; keeps Beastly Earring off
        Neck = {'Temp. Torque'}, -- CHR +5
        Body = {'Elder\'s Surcoat'}, -- CHR +1
        Waist = {'Ryl.Kgt. Belt'}, -- CHR +2
        Back = {'Trimmer\'s Mantle'}, -- Charm +5
        Legs = {'Elder\'s Braguette'}, -- CHR +2
    },

    EXPRing = {
        Ring1 = 'Chariot Band',
    },

    Hide_Priority = {
        Body = {'Rogue\'s Vest'},
    },

    --local stealChance = 50 + stealMod * 2 + thfLevel - target:getMainLvl()
    --Against a level 75 target: 50% + StealMod chance to steal
    --Level difference of X between myself and target are +/- X to that percent chance
    --Need: Rabbit Charm (+1 Neck)
    StealBig_Priority = { -- +11 Steal w/o Knife, +13 w/ Knife
        --Main = {'Btm. Knife'}, -- +2 Steal
        Sub = {'Ungur Boomerang'}, -- +8 HP
        Head = {'Rogue\'s Bonnet'}, -- +1 +13 HP
        Ear1 = {'Physical Earring'}, -- +25 HP
        Ear2 = {'Physical Earring'}, -- +25 HP
        Body = {'Rogue\'s Vest'}, -- +20 HP
        Hands = {'Thief\'s Kote'}, -- +3 Steal
        Ring1 = {'Bomb Queen Ring'}, -- +75 HP
        Ring2 = {'Rogue\'s Ring'}, -- +3 Steal when < 75% HP and TP < 1000
        Back = {'Gigant Mantle'}, -- +80 HP
        Waist = {'Koenigs Belt'}, -- +20 HP
        Legs = {'Assassin\'s Culottes'}, -- +5 Steal
        Feet = {'Rogue\'s Poulaines'}, -- +2 Steal
    }, -- 1503

    Steal_Priority = { -- +11 Steal w/o Knife, +13 w/ Knife
        --Main = {'Btm. Knife'}, -- +2 Steal
        --Sub = {'Ungur Boomerang'}, -- +8 HP
        Head = {'Rogue\'s Bonnet'}, -- +1 +13 HP
        Ear1 = {'Ethereal Earring'}, -- +25 HP
        --Ear2 = {'Physical Earring'}, -- +25 HP
        Body = {'Rogue\'s Vest'}, -- +20 HP
        Hands = {'Thief\'s Kote'}, -- +3 Steal
        Ring1 = {'Bomb Queen Ring'}, -- +75 HP
        Ring2 = {'Rogue\'s Ring'}, -- +3 Steal when < 75% HP and TP < 1000
        --Back = {'Gigant Mantle'}, -- +80 HP
        --Waist = {'Koenigs Belt'}, -- +20 HP
        Legs = {'Assassin\'s Culottes'}, -- +5 Steal
        Feet = {'Rogue\'s Poulaines'}, -- +2 Steal
    }, -- 1381

    Flee_Priority = {
        Feet = {'Rogue\'s Poulaines'},
    },

    HpDown_Priority = {
        Neck = {'Star Necklace'}, -- -15
        --Body = {'Blue Cotehardie'}, -- -40
        Hands = {'Thief\'s Kote'},
        Ring1 = {'Ether Ring'}, -- -35
        Ring2 = {'Astral Ring'}, -- -25
        Waist = {'Scouter\'s Rope'}, -- -40
        Legs = {'Elder\'s Braguette'},
        Feet = {'Elder\'s Sandals'},
    }, -- 1129

    Warp = {
        Main = 'Warp Cudgel',
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

profile.OnLoad = function()
    draginclude.OnLoad(sets, {'Default', 'Evasion'}, {'None', 'Field', 'Fishing'});

    AshitaCore:GetChatManager():QueueCommand(-1,'/alias /RAacid /lac fwd RAacid ');
    AshitaCore:GetChatManager():QueueCommand(-1,'/alias /RAbloody /lac fwd RAbloody ');
    AshitaCore:GetChatManager():QueueCommand(-1,'/alias /RAsleep /lac fwd RAsleep ');
    AshitaCore:GetChatManager():QueueCommand(-1,'/alias /ungur /lac fwd ungur ');
    AshitaCore:GetChatManager():QueueCommand(-1,'/alias /crossbow /lac fwd crossbow ');
    AshitaCore:GetChatManager():QueueCommand(-1,'/alias /th /lac fwd th ');
    AshitaCore:GetChatManager():QueueCommand(-1,'/alias /th2 /lac fwd th2 ');    
    AshitaCore:GetChatManager():QueueCommand(-1,'/alias /gilfinder /lac fwd gilfinder ');
end

profile.OnUnload = function()
    draginclude.OnUnload();
end

profile.HandleCommand = function(args)

    if (args[1] == 'RAacid') then
        gFunc.Message('RAacid');
        Settings.CurrentBolt = 'Acid Bolt';
    elseif (args[1] == 'RAbloody') then
        gFunc.Message('RAbloody');
        Settings.CurrentBolt = 'Bloody Bolt';
    elseif (args[1] == 'RAsleep') then
        gFunc.Message('RAsleep');
        Settings.CurrentBolt = 'Sleep Bolt';
    elseif (args[1] == 'ungur') then
        gFunc.Message('ungur');
        Settings.CurrentRanged = 'Ungur';
    elseif (args[1] == 'crossbow') then
        gFunc.Message('crossbow');
        Settings.CurrentRanged = 'Crossbow';
    elseif (args[1] == 'th') then
        Settings.LockTH = not Settings.LockTH;

        gFunc.Message('th ' .. tostring(Settings.LockTH));
    elseif (args[1] == 'th2') then
        Settings.LockTH2 = not Settings.LockTH2;

        gFunc.Message('th2 ' .. tostring(Settings.LockTH2));
    elseif (args[1] == 'gilfinder') then
        Settings.LockGilfinder = not Settings.LockGilfinder;

        gFunc.Message('LockGilfinder ' .. tostring(Settings.LockGilfinder));
    elseif (args[1] == 'lowhp') then
        gFunc.LockSet(sets.HpDown, 10);
    elseif (args[1] == 'stealhp') then
        gFunc.LockSet(sets.Steal, 10);
    end

    draginclude.HandleCommand(args);
    draginclude.HandleBstCoreCommands(args, nil);
end

profile.LateInitialize = function()
    local timestamp = os.time();
    local player = gData.GetPlayer();

    if timestamp >= Settings.LateInitialized.TimeToUse then
        -- Setting a Style Lock prevents the character from blinking
        -- The delay in setting this is to prevent a failure to set the stylelock on first load
        gFunc.LockStyle(sets.StyleLock);

        AshitaCore:GetChatManager():QueueCommand(1, '/macro book 18');
        AshitaCore:GetChatManager():QueueCommand(1, '/macro set 6');

        --[[ Set you job macro defaults here]]
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
    local pet = gData.GetPet();
    local petAction = gData.GetPetAction();
    local player = gData.GetPlayer();
    local myLevel = AshitaCore:GetMemoryManager():GetPlayer():GetMainJobLevel();
    local sa = gData.GetBuffCount('Sneak Attack');

    if (myLevel ~= Settings.CurrentLevel) then
        gFunc.Message('Syncing Gear - Lv. ' .. myLevel);
        Settings.CurrentLevel = myLevel;

        gFunc.EvaluateLevels(profile.Sets, Settings.CurrentLevel);
    end

    if Settings.LateInitialized.Initialized == false then
        if Settings.LateInitialized.TimeToUse == 0 then
            Settings.LateInitialized.TimeToUse = timestamp + 11;
        else
            profile.LateInitialize();
        end
    end

    if Settings.CurrentRanged == 'Ungur' then
        gFunc.EquipSet(sets.RangedUngur);
    elseif Settings.CurrentRanged == 'Crossbow' then
        gFunc.EquipSet(sets.RangedCrossbow);
    end

    if draginclude.dragSettings.TpVariant == 1 then
        gFunc.EquipSet(sets.Default);

        if player.SubJob == 'NIN' then
            gFunc.EquipSet(sets.DefaultNIN);
        end
        
        if player.Status == 'Engaged' then
            if player.SubJob == 'NIN' then
                gFunc.EquipSet(sets.EngagedNIN);
            else
                gFunc.EquipSet(sets.Engaged);
            end

            if sa == 1 then
                gFunc.EquipSet(sets.SA);
            end
        end
    elseif draginclude.dragSettings.TpVariant == 2 then
        gFunc.EquipSet(sets.Default);

        if player.SubJob == 'NIN' then
            gFunc.EquipSet(sets.DefaultNIN);
        end

        gFunc.EquipSet(sets.Evasion);

        if player.Status == 'Engaged' then
            if player.SubJob == 'NIN' then
                gFunc.EquipSet(sets.EngagedEvasionNIN);
            else
                gFunc.EquipSet(sets.EngagedEvasion);
            end

            if sa == 1 then
                gFunc.EquipSet(sets.SA);
            end
        end
    end

    --if (player.SubJob == 'BLM' or player.SubJob == 'WHM' or player.SubJob == 'RDM' or player.SubJob == 'SMN') and player.MP < 41 then
        --gFunc.EquipSet(sets.BlueCotehardie);
    --end

    if (pet ~= nil) then
        if (petAction ~= nil) then
            HandlePetAction(petAction);
            return;
        elseif pet.Status == 'Engaged' then
            gFunc.EquipSet(sets.PetAttack);
        end
    end

    if (zone.Area ~= nil) and (draginclude.Towns:contains(zone.Area)) then 
        if player.SubJob == 'NIN' then
            gFunc.EquipSet(sets.IdleTownNIN);
        else
            gFunc.EquipSet(sets.IdleTown);
        end
    end

    draginclude.HandleDefault();
    draginclude.CheckSkillingVariant();
    draginclude.CheckStatusArmorSwaps(Settings.StatusArmorSwaps, Settings.CurrentLevel);

    if Settings.LockTH or (player.Status == 'Engaged' and not isTargetTagged()) then
        gFunc.EquipSet(sets.TH);
        --gFunc.Message('TH Engaged');
    elseif Settings.LockGilfinder then
        gFunc.EquipSet(sets.Gilfinder);
    end
end

profile.HandleAbility = function()
    local ability = gData.GetAction();

    if string.match(ability.Name, 'Reward') then
        gFunc.EquipSet(sets.Reward);
    elseif string.match(ability.Name, 'Charm') then
        gFunc.EquipSet(sets.Charm);
    elseif string.match(ability.Name, 'Hide') then
        gFunc.EquipSet(sets.Hide);
    elseif string.match(ability.Name, 'Flee') then
        gFunc.EquipSet(sets.Flee);
    elseif string.match(ability.Name, 'Steal') then
        gFunc.EquipSet(sets.Steal);
    elseif string.match(ability.Name, 'Mug') then

    elseif string.match(ability.Name, 'Bully') then

    end
end

profile.HandleItem = function()
    --local item = gData.GetAction();

    gFunc.EquipSet(sets.Evasion);
end

profile.HandlePrecast = function()
    --local spell = gData.GetAction();

    gFunc.EquipSet(sets.FastCast);
end

profile.HandleMidcast = function()
    local spell = gData.GetAction();

    if spell.Name == 'Invisible' then
        gFunc.EquipSet(sets.Invisible);
    elseif spell.Name == 'Sneak' then
        gFunc.EquipSet(sets.Sneak);
    elseif string.contains(spell.Name, 'Utsusemi') then
        gFunc.EquipSet(sets.Evasion);
        gFunc.EquipSet(sets.SpellHaste);
    end

    if Settings.LockTH or (not isTargetTagged()) then
        gFunc.EquipSet(sets.TH);
    end
end

profile.HandlePreshot = function()
    if Settings.CurrentRanged == 'Crossbow' then
        if Settings.CurrentBolt == 'Acid Bolt' then
            gFunc.EquipSet(sets.AcidBolt);
        elseif Settings.CurrentBolt == 'Bloody Bolt' then
            gFunc.EquipSet(sets.BloodyBolt);
        elseif Settings.CurrentBolt == 'Sleep Bolt' then
            gFunc.EquipSet(sets.SleepBolt);
        end
    end
end

profile.HandleMidshot = function()
    --local player = gData.GetPlayer();

    gFunc.EquipSet(sets.Evasion);

    if Settings.CurrentRanged == 'Crossbow' and Settings.CurrentBolt == 'Bloody Bolt' then
        gFunc.EquipSet(sets.RangedINT);
    else
        gFunc.EquipSet(sets.RangedAcc);
    end

    if Settings.LockTH or (not isTargetTagged()) then
        gFunc.EquipSet(sets.TH);
        gFunc.Message('TH applied');
    end
end

profile.HandleWeaponskill = function()
    local action = gData.GetAction();

    gFunc.EquipSet(sets.WS);

    if string.contains(action.Name, 'Evisceration') then
        gFunc.EquipSet(sets.WeaponSkillEvis);
    elseif string.contains(action.Name, 'Shark Bite') then
        gFunc.EquipSet(sets.WeaponSkillSharkBite);
    end

    if Settings.LockTH or (not isTargetTagged()) then
        gFunc.EquipSet(sets.TH);
        gFunc.Message('TH applied');
    end
end

return profile;