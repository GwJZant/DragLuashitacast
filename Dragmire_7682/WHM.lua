local profile = {};
draginclude = gFunc.LoadFile('common\\draginclude.lua');

local Settings = {
    -- Default settings for jug/food preferences
    JugPetSettings = {
        DefaultFood = 'Pet Fd. Gamma',
    },
    StatusArmorSwaps = {

    },
    CurrentLevel = 0,
};

local sets = {
    Default = {
        Head = 'Lgn. Circlet',
        Neck = 'Spike Necklace', 
        Ear1 = 'Drone Earring', 
        Ear2 = 'Dodge Earring',  
        Body = 'Frost Robe', 
        Hands = 'Battle Gloves', 
        Ring1 = 'Courage Ring',
        Ring2 = 'Courage Ring',
        Back = 'White Cape',
        Waist = 'Silver Obi +1',
        Legs = 'Wool Slops', 
        Feet = 'Win. Gaiters', 
    },

    Evasion = { 
        Head = '',
        Neck = 'Spike Necklace', 
        Ear1 = 'Drone Earring', 
        Ear2 = 'Dodge Earring', 
        Body = '', 
        Hands = 'Battle Gloves', 
        Ring1 = 'Courage Ring',
        Ring2 = 'Courage Ring',
        Back = '',
        Waist = '',
        Legs = '', 
        Feet = '', 
    },

    Eco = {
        Head = 'Silver Hairpin',
        Neck = 'Spike Necklace', 
        Ear1 = 'Energy Earring', 
        Ear2 = 'Energy Earring', 
        Body = 'Doublet', 
        Hands = 'Battle Gloves', 
        Ring1 = 'Courage Ring',
        Ring2 = 'Courage Ring',
        Back = 'Cotton Cape +1',
        Waist = 'Silver Obi +1',
        Legs = 'Trader\'s Slops', 
        Feet = 'Mage\'s Sandals', 
    },

    StyleLock = {
        Head = 'Dream Hat +1',
        Neck = 'Spike Necklace', 
        Ear1 = 'Drone Earring', 
        Ear2 = 'Dodge Earring',  
        Body = 'Frost Robe', 
        Hands = 'Battle Gloves', 
        Ring1 = 'Courage Ring',
        Ring2 = 'Courage Ring',
        Back = 'White Cape',
        Waist = 'Silver Obi +1',
        Legs = 'Wool Slops', 
        Feet = 'Win. Gaiters', 
    },

    StyleLockFishing = {
        Head = '',
        Neck = '', 
        Ear1 = '', 
        Ear2 = '', 
        Body = '', 
        Hands = '', 
        Ring1 = '',
        Ring2 = '',
        Back = '',
        Waist = '',
        Legs = '', 
        Feet = '', 
    },

    TP_Acc = {
        Head = 'Silver Hairpin',
        Neck = 'Wing Pendant',
        Ear1 = 'Drone Earring', 
        Ear2 = 'Dodge Earring', 
        Body = 'Doublet', 
        Hands = 'Battle Gloves', 
        Ring1 = 'Courage Ring',
        Ring2 = 'Courage Ring',
        Back = 'Cotton Cape +1',
        Waist = 'Silver Obi +1',
        Legs = 'Trader\'s Slops', 
        Feet = 'Mage\'s Sandals', 
    },

    PetReadyDefault = {
        Head = 'Shep. Bonnet',
    },

    PetAttack = {
        Head = 'Shep. Bonnet',
    },

    Reward = { -- MND
        Ammo = Settings.JugPetSettings.DefaultFood,
        Neck = 'Wing Pendant',
    },

    Charm = {
        Neck = 'Flower Necklace',
    },

    Sneak = {
        Hands = 'Dream Mittens +1',
    },

    Invisible = {
        Feet = 'Dream Boots +1',
    },
};

profile.Sets = sets;

profile.Packer = {
    {Name = Settings.JugPetSettings.DefaultFood, Quantity = 'all'},
    {Name = Settings.JugPetSettings.DefaultJug, Quantity = 'all'},
};

local function HandlePetAction(PetAction)
    gFunc.EquipSet(sets.PetReadyDefault);
end

profile.OnLoad = function()
    local player = gData.GetPlayer();

    draginclude.OnLoad(sets, {'Default', 'Evasion'}, {'None', 'Field', 'Fishing'});

    gFunc.LockStyle(sets.StyleLock);

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

    --[[ Set you job macro defaults here]]
    AshitaCore:GetChatManager():QueueCommand(1, '/macro book 19');
    AshitaCore:GetChatManager():QueueCommand(1, '/macro set 5');
end

profile.OnUnload = function()
    draginclude.OnUnload();
end

profile.HandleCommand = function(args)
    draginclude.HandleCommand(args, sets);
    draginclude.HandleBstCoreCommands(args, nil);
end

profile.HandleDefault = function()
    local timestamp = os.time();
    local zone = gData.GetEnvironment();
    local pet = gData.GetPet();
    local petAction = gData.GetPetAction();
    local player = gData.GetPlayer();
    local myLevel = AshitaCore:GetMemoryManager():GetPlayer():GetMainJobLevel();

    -- Determining current level for Priority EquipSet purposes
    if (myLevel ~= Settings.CurrentLevel) then
        gFunc.EvaluateLevels(profile.Sets, myLevel);
        Settings.CurrentLevel = myLevel;
    end

    -- Forward slash toggle between Default, Evasion, and Fishing sets
    if draginclude.dragSettings.TpVariant == 1 then --Use the Default set
        gFunc.EquipSet(sets.Default);

        -- Engaged Section
        if player.Status == 'Engaged' then

            -- Switch to Evasion gear when I'm low on health
            if player.HPP < 50 then
                gFunc.EquipSet(sets.Evasion);
            end

            if player.HPP <= 5 then
                AshitaCore:GetChatManager():QueueCommand(-1,'/ja Benediction <me> ');
            end
        
        -- Resting Section
        elseif (player.Status == 'Resting') then

            -- Switch to Evasion gear while resting to avoid getting hit
            gFunc.EquipSet(sets.Evasion);

        -- Idle Section
        else

        end

    elseif draginclude.dragSettings.TpVariant == 2 then --Use default set
        gFunc.EquipSet(sets.Evasion);

    end

    if player.SubJob == 'BST' then
        if (pet ~= nil) then
            if (petAction ~= nil) then
                HandlePetAction(petAction);
                return;
            end

            draginclude.CheckDoPetActions(player, pet, 'WHM');
        end
    end

    draginclude.HandleDefault();
    draginclude.CheckSkillingVariant();
    draginclude.CheckStatusArmorSwaps(Settings.StatusArmorSwaps, Settings.CurrentLevel);
end

profile.HandleAbility = function()
    local pet = gData.GetPet();
    local ability = gData.GetAction();

    if string.match(ability.Name, 'Call Beast') or string.match(ability.Name, 'Bestial Loyalty') then
        --gFunc.EquipSet(sets.Call);
    elseif string.match(ability.Name, 'Reward') then
        gFunc.EquipSet(sets.Reward);
    elseif string.match(ability.Name, 'Charm') then
        gFunc.EquipSet(sets.Charm);
    elseif string.match(ability.Name, 'Fight') then
        -- Check draginclude for definition
        draginclude.HandleFight(pet);
    elseif string.match(ability.Type, 'Ready') then
        -- Check draginclude for definition
        draginclude.HandleReady(ability);
    end
end

profile.HandleItem = function()
    local item = gData.GetAction();

    gFunc.Message('HandleItem');

    draginclude.HandleItem(item);
end

profile.HandlePrecast = function()
    local spell = gData.GetAction();
end

profile.HandleMidcast = function()
    local player = gData.GetPlayer();
    local spell = gData.GetAction();
    local buffs = AshitaCore:GetMemoryManager():GetPlayer():GetBuffs();
    local songBuffActive = false;

    -- Check if I have any song buffs
    for _,buff in ipairs(buffs) do
        if (buff >= 195 and buff <= 222) then
            songBuffActive = true;
        end
    end 

    gFunc.EquipSet(sets.TP_Acc);

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
end

return profile;