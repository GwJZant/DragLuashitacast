local profile = {};
draginclude = gFunc.LoadFile('common\\draginclude.lua');

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
    LockTH = false,
    LockTH2 = false,
    LockGilfinder = false,
};

local sets = {
    Default_Priority = {
        Ammo = {},
        Head = {'Centurion\'s Visor', 'Bone Mask +1'},
        Neck = {},
        Ear1 = {},
        Ear2 = {},
        Body = {'Beetle Harness +1', 'Tarutaru Kaftan'},
        Hands = {'Tarutaru Mitts'},
        Ring1 = {'San d\'Orian Ring'},
        Ring2 = {},
        Back = {'Nomad\'s Mantle'},
        Waist = {},
        Legs = {'Ryl.Ftm. Trousers', 'Tarutaru Braccae'},
        Feet = {'Btl. Leggings +1', 'Tarutaru Clomps'},
    },

    RangedAcc_Priority = {
        Ammo = {},
        Head = {},
        Neck = {},
        Ear1 = {},
        Ear2 = {},
        Body = {},
        Hands = {},
        Ring1 = {},
        Ring2 = {},
        Back = {},
        Waist = {},
        Legs = {},
        Feet = {},
    },

    RangedINT_Priority = {
        Ammo = {},
        Head = {},
        Neck = {},
        Ear1 = {},
        Ear2 = {},
        Body = {},
        Hands = {},
        Ring1 = {},
        Ring2 = {},
        Back = {},
        Waist = {},
        Legs = {},
        Feet = {},
    },

    RangedUngur_Priority = {
        --Range = {'Ungur Boomerang'},
    },

    RangedCrossbow_Priority = {
        --Range = {'Velocity Bow'},
    },

    DefaultNIN_Priority = {
        --Ear2 = {'Stealth Earring'},
    },

    FastCast_Priority = {
        --Ear2 = {'Loquac. Earring'},
        --Legs = {'Homam Cosciales'},
    },

    Evasion_Priority = {
        Ammo = {},
        Head = {},
        Neck = {},
        Ear1 = {},
        Ear2 = {},
        Body = {},
        Hands = {},
        Ring1 = {},
        Ring2 = {},
        Back = {},
        Waist = {},
        Legs = {},
        Feet = {},
    },

    Engaged_Priority = {
        Ammo = {},
        Head = {},
        Neck = {},
        Ear1 = {},
        Ear2 = {},
        Body = {},
        Hands = {},
        Ring1 = {},
        Ring2 = {},
        Back = {},
        Waist = {},
        Legs = {},
        Feet = {},
    },

    EngagedNIN_Priority = {
        Ammo = {},
        Head = {},
        Neck = {},
        Ear1 = {},
        Ear2 = {},
        Body = {},
        Hands = {},
        Ring1 = {},
        Ring2 = {},
        Back = {},
        Waist = {},
        Legs = {},
        Feet = {},
    },

    EngagedEvasion_Priority = {
        Ammo = {},
        Head = {},
        Neck = {},
        Ear1 = {},
        Ear2 = {},
        Body = {},
        Hands = {},
        Ring1 = {},
        Ring2 = {},
        Back = {},
        Waist = {},
        Legs = {},
        Feet = {},
    },

    EngagedEvasionNIN_Priority = {
        Ammo = {},
        Head = {},
        Neck = {},
        Ear1 = {},
        Ear2 = {},
        Body = {},
        Hands = {},
        Ring1 = {},
        Ring2 = {},
        Back = {},
        Waist = {},
        Legs = {},
        Feet = {},
    },

    SA_Priority = { -- DEX > Attack > STR
    Ammo = {},
    Head = {},
    Neck = {},
    Ear1 = {},
    Ear2 = {},
    Body = {},
    Hands = {},
    Ring1 = {},
    Ring2 = {},
    Back = {},
    Waist = {},
    Legs = {},
    Feet = {},
    },

    MP_Priority = {
        Ammo = {},
        Head = {},
        Neck = {},
        Ear1 = {},
        Ear2 = {},
        Body = {},
        Hands = {},
        Ring1 = {},
        Ring2 = {},
        Back = {},
        Waist = {},
        Legs = {},
        Feet = {},
    },

    SpellHaste_Priority = {
        Ammo = {},
        Head = {},
        Neck = {},
        Ear1 = {},
        Ear2 = {},
        Body = {},
        Hands = {},
        Ring1 = {},
        Ring2 = {},
        Back = {},
        Waist = {},
        Legs = {},
        Feet = {},
    },

    BlueCotehardie_Priority = {
        --Body = {'Blue Cotehardie'},
    },

    Gilfinder_Priority = {
        --Hands = {'Andvaranauts'},
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
        Ammo = {},
        Head = {},
        Neck = {},
        Ear1 = {},
        Ear2 = {},
        Body = {},
        Hands = {},
        Ring1 = {},
        Ring2 = {},
        Back = {},
        Waist = {},
        Legs = {},
        Feet = {},
    },

    WeaponSkillEvis_Priority = {
        --Head = {'Panther Mask'},
    },

    WeaponSkillSharkBite_Priority = {
        --Ring2 = {'Flame Ring'},
    },

    TH_Priority = {
        --Neck = {'Nanaa\'s Charm'},
        --Hands = {'Assassin\'s Armlets'},
    },

    StyleLock = {
        Head = '',
        Body = '',
        Hands = '',
        Legs = '',
        Feet = '',
    },

    IdleTown_Priority = {
        --Neck = {'Nanaa\'s Charm'},
        --Hands = {'Assassin\'s Armlets'},
    },

    IdleTownNIN_Priority = {
        --Neck = {'Nanaa\'s Charm'},
        --Hands = {'Assassin\'s Armlets'},
    },

    PetReadyDefault = {

    },

    PetAttack_Priority = {
        Ear2 = {'Beastly Earring'},
    },

    Reward_Priority = { -- MND
        Ammo = {'Pet Food Zeta', 'Pet Fd. Epsilon', 'Pet Food Delta', 'Pet Fd. Gamma', 'Pet Food Beta', 'Pet Food Alpha'},
    },

    Charm_Priority = {
        Ammo = {},
        Head = {},
        Neck = {},
        Ear1 = {},
        Ear2 = {},
        Body = {},
        Hands = {},
        Ring1 = {},
        Ring2 = {},
        Back = {},
        Waist = {},
        Legs = {},
        Feet = {},
    },

    EXPRing = {
        Ring1 = 'Chariot Band',
    },

    Hide_Priority = {
        --Body = {'Rogue\'s Vest'},
    },

    --local stealChance = 50 + stealMod * 2 + thfLevel - target:getMainLvl()
    --Against a level 75 target: 50% + StealMod chance to steal
    --Level difference of X between myself and target are +/- X to that percent chance
    --Need: Rabbit Charm (+1 Neck)
    StealBig_Priority = { 
        Ammo = {},
        Head = {},
        Neck = {},
        Ear1 = {},
        Ear2 = {},
        Body = {},
        Hands = {},
        Ring1 = {},
        Ring2 = {},
        Back = {},
        Waist = {},
        Legs = {},
        Feet = {},
    }, -- 1503

    Steal_Priority = { 
        Ammo = {},
        Head = {},
        Neck = {},
        Ear1 = {},
        Ear2 = {},
        Body = {},
        Hands = {},
        Ring1 = {},
        Ring2 = {},
        Back = {},
        Waist = {},
        Legs = {},
        Feet = {},
    }, -- 1381

    Flee_Priority = {
        --Feet = {'Rogue\'s Poulaines'},
    },

    HpDown_Priority = {
        Ammo = {},
        Head = {},
        Neck = {},
        Ear1 = {},
        Ear2 = {},
        Body = {},
        Hands = {},
        Ring1 = {},
        Ring2 = {},
        Back = {},
        Waist = {},
        Legs = {},
        Feet = {},
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

        AshitaCore:GetChatManager():QueueCommand(1, '/macro book 3');
        AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1');

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

    if draginclude.dragSettings.TpVariant == 1 then
        gFunc.EquipSet(sets.Default);

    elseif draginclude.dragSettings.TpVariant == 2 then
        gFunc.EquipSet(sets.Default);

        gFunc.EquipSet(sets.Evasion);
    end

    if (pet ~= nil) then
        if (petAction ~= nil) then
            HandlePetAction(petAction);
            return;
        elseif pet.Status == 'Engaged' then
            gFunc.EquipSet(sets.PetAttack);
        end
    end

    draginclude.HandleDefault();
    draginclude.CheckSkillingVariant();
    draginclude.CheckStatusArmorSwaps(Settings.StatusArmorSwaps, Settings.CurrentLevel);
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
    elseif Settings.LockTH or (not isTargetTagged()) then
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

    if Settings.CurrentRanged == 'Crossbow' and (Settings.CurrentBolt == 'Bloody Bolt' or Settings.CurrentBolt == 'Sleep Bolt') then
        gFunc.EquipSet(sets.RangedINT);
    else
        gFunc.EquipSet(sets.RangedAcc);
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
end

return profile;