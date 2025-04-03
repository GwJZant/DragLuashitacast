local profile = {};
gcdisplay = gFunc.LoadFile('common\\gcdisplay.lua');
gcinclude = gFunc.LoadFile('common\\gcinclude.lua');
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
};

local sets = {
    Default_Priority = {
        Head = {'Centurion\'s Visor'},
        Neck = {'Peacock Amulet'},
        Ear1 = {'Drone Earring'}, --EVA +3
        Ear2 = {'Dodge Earring'}, --AGI +3
        Body = {'Elder\'s Surcoat'},
        Hands = {'Elder\'s Bracers'},
        Ring1 = {'Bastokan Ring'},
        Ring2 = {'Rajas Ring'},
        Back = {'Nomad\'s Mantle'},
        Waist = {'Friar\'s Rope'},
        Legs = {'Elder\'s Braguette'},
        Feet = {'Elder\'s Sandals'},
    },

    Evasion_Priority = { --EVA, AGI
        Head = {'Centurion\'s Visor'},
        Neck = {'Peacock Amulet'},
        Ear1 = {'Drone Earring'}, --EVA +3
        Ear2 = {'Dodge Earring'}, --AGI +3
        Body = {'Elder\'s Surcoat'},
        Hands = {'Elder\'s Bracers'},
        Ring1 = {'Bastokan Ring'},
        Ring2 = {'Rajas Ring'},
        Back = {'Nomad\'s Mantle'},
        Waist = {'Friar\'s Rope'},
        Legs = {'Elder\'s Braguette'},
        Feet = {'Elder\'s Sandals'},
    },

    StyleLockSummer = {
        Head = 'Centurion\'s Visor',
        Body = 'Elder Gilet +1',
        --Hands = 'Scp. Gauntlets',
        Legs = 'Elder Trunks',
        --Feet = 'Homam Gambieras',
    },

    PetReadyDefault = {
        
    },

    PetAttack = {
        
    },

    Reward_Priority = { -- MND
        Ammo = {'Pet Fd. Epsilon', 'Pet Food Delta', 'Pet Food Beta', 'Pet Food Alpha'},
    },

    Charm_Priority = {
        Neck = {'Flower Necklace'},
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
        gFunc.LockStyle(sets.StyleLockSummer);

        --[[ Set your job macro defaults here]]
        if player.SubJob == 'BST' then
            AshitaCore:GetChatManager():QueueCommand(1, '/macro book 13');
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
        else
            AshitaCore:GetChatManager():QueueCommand(1, '/macro book 13');
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
    local myLevel = AshitaCore:GetMemoryManager():GetPlayer():GetMainJobLevel();

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