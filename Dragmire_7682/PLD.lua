local profile = {};
gcdisplay = gFunc.LoadFile('common\\gcdisplay.lua');
gcinclude = gFunc.LoadFile('common\\gcinclude.lua');
draginclude = gFunc.LoadFile('common\\draginclude.lua');

local Settings = {
    -- Default settings for jug/food preferences
    DragoonSettings = {
        HealingBreathMessageFrequency = 5,
        HealingMessageTimeToNotify = 0,
    },
    JugPetSettings = {
        DefaultFood = 'Pet Food Beta',
    },
    LateInitialized = {
        Initialized = false,
        TimeToUse = 0,
    },
    StatusArmorSwaps = {
        MelodyEarring = false,
        BatEarring = true,
        FlagellantsRope = false,
        OpoopoNecklace = true,
        FenrirsEarring = true,
        FenrirsStone = false,
        DuskGloves = false,
        ShenobiRing = false,
        GaudyHarness = false,
    },
    CurrentLevel = 0,
};

local sets = {
    Default_Priority = {
        Head = {'Ryl.Ftm. Bandana', 'Dream Hat +1'},
        Neck = {'Wing Pendant'},
        Ear1 = {'Bone Earring'}, --EVA +3
        Ear2 = {'Bone Earring'}, --AGI +3
        Body = {'Ryl.Ftm. Vest', 'Dream Robe +1'},
        Hands = {'Kingdom Gloves', 'Brass Mittens', 'Dream Mittens +1'},
        Ring1 = {'Courage Ring', 'Bastokan Ring'},
        Ring2 = {'Courage Ring'},
        Back = {'Nomad\'s Mantle', 'Dhalmel Mantle', 'Rabbit Mantle'},
        Waist = {'Warrior\'s Belt', 'Leather Belt'},
        Legs = {'Ctr. Cuisses', 'Bone Subligar +1', 'Brass Subligar', 'Dream Trousers +1'},
        Feet = {'Elder\'s Sandals', 'Bone Leggings +1', 'Brass Leggings +1', 'Dream Boots +1'},
    },

    WHM_Priority = {
        Head = {'Ryl.Ftm. Bandana', 'Dream Hat +1'},
        Neck = {'Wing Pendant'},
        Ear1 = {'Bone Earring'}, --EVA +3
        Ear2 = {'Bone Earring'}, --AGI +3
        Body = {'Ryl.Ftm. Vest', 'Dream Robe +1'},
        Hands = {'Kingdom Gloves', 'Brass Mittens', 'Dream Mittens +1'},
        Ring1 = {'Courage Ring', 'Bastokan Ring'},
        Ring2 = {'Courage Ring'},
        Back = {'Nomad\'s Mantle', 'Dhalmel Mantle', 'Rabbit Mantle'},
        Waist = {'Warrior\'s Belt', 'Leather Belt'},
        Legs = {'Ctr. Cuisses', 'Bone Subligar +1', 'Brass Subligar', 'Dream Trousers +1'},
        Feet = {'Elder\'s Sandals', 'Bone Leggings +1', 'Brass Leggings +1', 'Dream Boots +1'},
    },

    Evasion_Priority = {
        Head = {'Ryl.Ftm. Bandana', 'Dream Hat +1'},
        Neck = {'Wing Pendant'},
        Ear1 = {'Bone Earring'}, --EVA +3
        Ear2 = {'Bone Earring'}, --AGI +3
        Body = {'Ryl.Ftm. Vest', 'Dream Robe +1'},
        Hands = {'Kingdom Gloves', 'Brass Mittens', 'Dream Mittens +1'},
        Ring1 = {'Courage Ring', 'Bastokan Ring'},
        Ring2 = {'Courage Ring'},
        Back = {'Nomad\'s Mantle', 'Dhalmel Mantle', 'Rabbit Mantle'},
        Waist = {'Warrior\'s Belt', 'Leather Belt'},
        Legs = {'Ctr. Cuisses', 'Bone Subligar +1', 'Brass Subligar', 'Dream Trousers +1'},
        Feet = {'Elder\'s Sandals', 'Bone Leggings +1', 'Brass Leggings +1', 'Dream Boots +1'},
    },

    StyleLock = {
        Head = 'Ryl.Ftm. Bandana',
        Neck = '',
        Ear1 = '',
        Ear2 = '',
        Body = 'Ryl.Ftm. Vest',
        Hands = 'Brass Mittens',
        Ring1 = '',
        Ring2 = '',
        Back = '',
        Waist = '',
        Legs = 'Brass Subligar',
        Feet = 'Brass Leggings +1',
    },

    PetReadyDefault = {

    },

    PetAttack = {

    },

    Reward = { -- MND
        Ammo = Settings.JugPetSettings.DefaultFood,
    },

    Charm = {
        --Neck = 'Flower Necklace',
        --Waist = 'Corsette',
        --Legs = 'Elder\'s Braguette',
    },

    EXPRing = {
        Ring1 = 'Chariot Band',
    },

    Warp = {
        Main = 'Warp Cudgel',
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
    draginclude.OnLoad(sets, {'Default', 'Evasion'}, {'None', 'Field', 'Fishing'});
end

profile.OnUnload = function()
    draginclude.OnUnload();
end

profile.HandleCommand = function(args)
    draginclude.HandleCommand(args, sets);
    draginclude.HandleBstCoreCommands(args, nil);
end

profile.LateInitialize = function()
    local timestamp = os.time();
    local player = gData.GetPlayer();

    if timestamp >= Settings.LateInitialized.TimeToUse then
        -- Setting a Style Lock prevents the character from blinking
        gFunc.LockStyle(sets.StyleLock);

        --[[ Set your job macro defaults here]]
        if player.SubJob == 'BST' then
            AshitaCore:GetChatManager():QueueCommand(1, '/macro book 11');
            AshitaCore:GetChatManager():QueueCommand(1, '/macro set 5');

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
        elseif player.SubJob == 'BST' then
            AshitaCore:GetChatManager():QueueCommand(1, '/macro book 11');
            AshitaCore:GetChatManager():QueueCommand(1, '/macro set 5');
        else
            AshitaCore:GetChatManager():QueueCommand(1, '/macro book 11');
            AshitaCore:GetChatManager():QueueCommand(1, '/macro set 5');
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

    -- Forward slash toggle between Default and Evasion
    if draginclude.dragSettings.TpVariant == 1 then

        if player.SubJob == 'WHM' then
            gFunc.EquipSet(sets.WHM);
        else
            gFunc.EquipSet(sets.Default);
        end
        

        -- Engaged Section
        if player.Status == 'Engaged' then

            -- Switch to Evasion gear when I'm low on health
            if player.HPP < 50 then
                gFunc.EquipSet(sets.Evasion);
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

    if (pet ~= nil) then
        if (petAction ~= nil) then
            HandlePetAction(petAction);
            return;
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
        gFunc.EquipSet(sets.Charm);
    elseif string.match(ability.Name, 'Fight') then
        -- Fight set
    elseif string.match(ability.Name, 'Sic') then
        -- Sic set
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
    local myLevel = AshitaCore:GetMemoryManager():GetPlayer():GetMainJobLevel();

    if (myLevel ~= Settings.CurrentLevel) then
        gFunc.EvaluateLevels(profile.Sets, myLevel);
        Settings.CurrentLevel = myLevel;
    end

    if (spell.Skill == 'Ninjutsu') then
		if string.contains(spell.Name, 'Utsusemi') then
            gFunc.EquipSet(sets.Evasion);

			if songBuffActive == true then
				gFunc.Equip('Ear1', 'Melody Earring');
			end
		end
	end

    draginclude.CheckStatusArmorSwaps(Settings.StatusArmorSwaps, Settings.CurrentLevel);
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