local profile = {};
gcdisplay = gFunc.LoadFile('common\\gcdisplay.lua');
gcinclude = gFunc.LoadFile('common\\gcinclude.lua');
draginclude = gFunc.LoadFile('common\\draginclude.lua');

local Settings = {
    -- Default settings for jug/food preferences
    JugPetSettings = {
        DefaultFood = 'Pet Food Alpha',
    },
    LateInitialized = {
        Initialized = false,
        TimeToUse = 0,
    },
    StatusArmorSwaps = {
        MelodyEarring = false,
        BatEarring = false,
        FlagellantsRope = false,
        OpoopoNecklace = true,
        FenrirsEarring = false,
        FenrirsStone = false,
        DuskGloves = false,
        ShenobiRing = false,
        GaudyHarness = false,
    },
    CurrentLevel = 0,
};

local sets = {
    Default_Priority = {
        Ammo = {'Happy Egg'},
        Head = {'Pumpkin Head'},
        Neck = {'Peacock Amulet'},
        Ear1 = {''}, --EVA +3
        Ear2 = {'Dodge Earring'}, --EVA +3
        Body = {'Elder\'s Surcoat', 'Angler\'s Tunica', 'Dream Robe +1'},
        Hands = {'Elder\'s Bracers', 'Angler\'s Gloves', 'Dream Mittens +1'},
        Ring1 = {'Rajas Ring'},
        Ring2 = {''},
        Back = {'Trimmer\'s Mantle'},
        Waist = {'Rabbit Belt'},
        Legs = {'Elder\'s Braguette', 'Angler\'s Hose', 'Dream Trousers +1'},
        Feet = {'Elder\'s Sandals', 'Angler\'s Boots', 'Dream Boots +1'},
    },

    StyleLock = {
        Head = '',
        Body = '',
        Hands = '',
        Legs = '',
        Feet = '',
    },

    Paeon_Priority = {
        Range = {'Cornette +1'},
    },

    Minuet_Priority = {
        Range = {'Cornette +1'},
    },

    Requiem_Priority = {
        Range = {'Flute +1'},
    },

    Madrigal_Priority = {
        Range = {'Cornette +1'},
    },

    March_Priority = {
        Range = {'Cornette +1'},
    },

    Orphic_Priority = {
        Ammo = {'Orphic Egg'},
    },

    PetReadyDefault = {

    },

    PetAttack = {

    },

    Reward_Priority = { -- MND
        Ammo = {'Pet Food Zeta', 'Pet Fd. Epsilon', 'Pet Food Delta', 'Pet Fd. Gamma', 'Pet Food Beta', 'Pet Food Alpha'},
    },

    Charm_Priority = {
        --Neck = 'Flower Necklace',
        --Waist = 'Corsette',
        Back = {'Trimmer\'s Mantle'},
        Legs = {'Elder\'s Braguette'},
    },

    EXPRing = {
        Ring1 = 'Chariot Band',
    },

    Warp = {
        Main = 'Warp Cudgel',
    },
};

profile.Sets = sets;

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
            AshitaCore:GetChatManager():QueueCommand(1, '/macro book 5');
            AshitaCore:GetChatManager():QueueCommand(1, '/macro set 3');

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
        else
            AshitaCore:GetChatManager():QueueCommand(1, '/macro book 5');
            AshitaCore:GetChatManager():QueueCommand(1, '/macro set 4');
        end

        Settings.LateInitialized.Initialized = true;
        gFunc.Message('LateInitialized');
    end
end

profile.HandleDefault = function()
    local buffs = AshitaCore:GetMemoryManager():GetPlayer():GetBuffs();
    local timestamp = os.time();
    local pet = gData.GetPet();
    local petAction = gData.GetPetAction();
    local player = gData.GetPlayer();
    local party = AshitaCore:GetMemoryManager():GetParty();
    local myLevel = AshitaCore:GetMemoryManager():GetPlayer():GetMainJobLevel();
    local songBuffActive = false;

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

    -- Song buffs have IDs between 195 and 222: https://github.com/Windower/Resources/blob/master/resources_data/buffs.lua
    for _,buff in ipairs(buffs) do
        if (buff >= 195 and buff <= 222) then
            songBuffActive = true;
        end
    end

    -- Forward slash toggle between Default and Evasion
    if draginclude.dragSettings.TpVariant == 1 then

        gFunc.EquipSet(sets.Default);

        if songBuffActive == true then
            gFunc.EquipSet(sets.Orphic);
        end
        
        -- Engaged Section
        if player.Status == 'Engaged' then
        
        -- Resting Section
        elseif (player.Status == 'Resting') then

        -- Idle Section
        else

        end

    elseif draginclude.dragSettings.TpVariant == 2 then --Use default set
        gFunc.EquipSet(sets.Default);
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

    gFunc.Message (spell.Skill);
    gFunc.Message (spell.Name);
    
    if spell.Skill == 'Singing' then
        if string.contains(spell.Name, 'Paeon') then
            gFunc.EquipSet(sets.Paeon);
        elseif string.contains(spell.Name, 'Minuet') then
            gFunc.EquipSet(sets.Minuet);
        elseif string.contains(spell.Name, 'Requiem') then
            gFunc.EquipSet(sets.Requiem);
        elseif string.contains(spell.Name, 'Madrigal') then
            gFunc.EquipSet(sets.Madrigal);
        elseif string.contains(spell.Name, 'March') then
            gFunc.EquipSet(sets.March);
		end
    elseif spell.Skill == 'Ninjutsu' then
		if string.contains(spell.Name, 'Utsusemi') then
            gFunc.EquipSet(sets.Evasion);
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
end

return profile;