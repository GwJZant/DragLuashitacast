local profile = {};
draginclude = gFunc.LoadFile('common\\draginclude.lua');

-- START SETTINGS
local Settings = {
    -- Default settings for jug/food preferences
    -- LullabyMelodia SaberFamiliar CourierCarrie MiteFamiliar
    JugPetSettings = {
        -- This toggle configures which jugs the 'JugChange' command will loop through
        DefaultJugs = {draginclude.JugPetConfig.LullabyMelodia, draginclude.JugPetConfig.VoraciousAudrey, draginclude.JugPetConfig.CourierCarrie, draginclude.JugPetConfig.MiteFamiliar},
        CurrentJug = 1,
    },
    -- Settings used for a delay initilization of macro books and style locking since those aren't always populated the moment you load a Lua file
    LateInitialized = {
        Initialized = false,
        TimeToUse = 0,
    },
    -- Settings to enable some unique armor swapping. See draginclude for full options available
    StatusArmorSwaps = {
        OpoopoNecklace = false,
        PresidentialHairpin = false,
    },
    -- Used for handling Priority gear swapping
    CurrentLevel = 0,
};
-- END SETTINGS

local sets = {
    Default_Priority = {
        Ammo = {},
        Head = {'Bone Mask +1'},
        Neck = {'Beast Whistle'},
        Ear1 = {},
        Ear2 = {},
        Body = {'Beetle Harness +1'},
        Hands = {'Battle Gloves'},
        Ring1 = {'San d\'Orian Ring'},
        Ring2 = {},
        Back = {'Nomad\'s Mantle'},
        Waist = {},
        Legs = {'Ryl.Ftm. Trousers'},
        Feet = {'Btl. Leggings +1'},
    },

    IdleTown_Priority = {
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

    PetAcc_Priority = {
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

    PetAccWHM_Priority = {
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

    EvasionWHM_Priority = {
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

    WeaponSkill_Priority = {
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

    WeaponSkillLight_Priority = {
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

    Gaudy_Priority = {
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

    Midcast_Priority = {
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

    Precast_Priority = {
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

    Stoneskin_Priority = {
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

    Enhancing_Priority = {
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

    Healing_Priority = {
        
    },

    WeaponsTPNIN_Priority = {   
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

    WeaponsGaudyNIN_Priority = {
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

    WeaponsTP_Priority = {
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

    WeaponsGaudy_Priority = {
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

    Relaxing_Priority = {
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

    StealthEarring_Priority = {
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

    StyleLockAF = {
    },

    StyleLockGeneric = {
        Head = 'Bone Mask +1',
        Body = 'Beetle Harness +1',
        Hands = 'Battle Gloves',
        Legs = 'Ryl.Ftm. Trousers',
        Feet = 'Beetle Leggings +1',
    },

    StyleLockRSE = {
    },

    StyleLockWinter = {
    },

    StyleLockBeastok = {
    },

    StyleLockHydra = {
    },

    -- Uses Relic body to remove status ailments
    RewardSTATUS_Priority = {
        Ammo = {'Pet Food Zeta','Pet Food Delta', 'Pet Fd. Gamma', 'Pet Food Beta', 'Pet Food Alpha'},
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

    -- Uses Kirin's Osode to maximize healing, does not remove status ailments
    RewardHP_Priority = {
        Ammo = {'Pet Food Zeta','Pet Food Delta', 'Pet Fd. Gamma', 'Pet Food Beta', 'Pet Food Alpha'},
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

    Call_Priority = { -- Default Jug
        Ammo = Settings.JugPetSettings.DefaultJugs[Settings.JugPetSettings.CurrentJug].DefaultJug,
        Hands = {},
    },

    Charm_Priority = {
        Ammo = {},
        Head = {},
        Neck = {'Beast Whistle'}, -- CHR +2
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
};

profile.Sets = sets;

local function HandlePetAction(PetAction)
    gFunc.EquipSet(sets.PetAcc);
end

profile.OnLoad = function()
    draginclude.OnLoad(sets, {'Default', 'PetAcc', 'Evasion'}, {'None', 'Field', 'Fishing'});

    -- BST Core Commands
    AshitaCore:GetChatManager():QueueCommand(-1,'/bind 1 /lac fwd PetAtk ');
    AshitaCore:GetChatManager():QueueCommand(-1,'/bind 2 /lac fwd Charm ');
    AshitaCore:GetChatManager():QueueCommand(-1,'/bind 3 /lac fwd CallBeast ');
    AshitaCore:GetChatManager():QueueCommand(-1,'/bind 4 /lac fwd PetSTA ');
    AshitaCore:GetChatManager():QueueCommand(-1,'/bind 5 /lac fwd PetAOE ');
    AshitaCore:GetChatManager():QueueCommand(-1,'/bind 6 /lac fwd PetSpec ');
    AshitaCore:GetChatManager():QueueCommand(-1,'/bind 8 /lac fwd Stay ');
    AshitaCore:GetChatManager():QueueCommand(-1,'/bind 9 /lac fwd Heel ');
    AshitaCore:GetChatManager():QueueCommand(-1,'/bind 0 /lac fwd RewardHP ');
    AshitaCore:GetChatManager():QueueCommand(-1,'/bind +0 /lac fwd RewardSTATUS ');
end

profile.OnUnload = function()
    draginclude.OnUnload();
end

profile.HandleCommand = function(args)
    draginclude.HandleCommand(args, sets);
    draginclude.HandleBstCoreCommands(args, Settings.JugPetSettings.DefaultJugs[Settings.JugPetSettings.CurrentJug]);

    -- Toggle to control what my current Jug is.
    -- Like TpVariant, we use a variable (CurrentJug) that holds an integer that represents which jug I'm on
    -- Use this command [ /lac fwd JugChange ] to cycle this.
    -- Will update current Jug to use with Call Beast and the 3 pet abilities bound to 4-6
    if (args[1] == 'JugChange') then
        Settings.JugPetSettings.CurrentJug = Settings.JugPetSettings.CurrentJug + 1;

        -- If that index we made is out of bounds of the actual set (like if it's 4 but there's only 3)
        if (Settings.JugPetSettings.CurrentJug > #Settings.JugPetSettings.DefaultJugs) then

            -- Set it back to 1
            Settings.JugPetSettings.CurrentJug = 1;
        end

        sets.Call.Ammo = Settings.JugPetSettings.DefaultJugs[Settings.JugPetSettings.CurrentJug].DefaultJug;
        gFunc.Message('Current Jug: ' .. Settings.JugPetSettings.DefaultJugs[Settings.JugPetSettings.CurrentJug].Name); --display the set
    end
end

--This function is used because when you load the game and for brief moments, like when switching jobs, your levels are counted as 0
--This means if you put your Style Lock in profile.OnLoad(), it'll fail when you first start the game up
profile.LateInitialize = function()
    local timestamp = os.time();
    local player = gData.GetPlayer();

    if timestamp >= Settings.LateInitialized.TimeToUse then
        -- Setting a Style Lock prevents the character from blinking
        -- The delay in setting this is to prevent a failure to set the stylelock on first load
        if player.SubJob ~= 'WHM' then
            gFunc.LockStyle(sets.StyleLockGeneric);
        else
            gFunc.LockStyle(sets.StyleLockGeneric);
        end

        --[[ Set you job macro defaults here]]
        if player.SubJob == 'NIN' then
            gFunc.Message('NIN Macro Book');
            AshitaCore:GetChatManager():QueueCommand(1, '/macro book 9');
            AshitaCore:GetChatManager():QueueCommand(1, '/macro set 3');
        elseif player.SubJob == 'THF' then
            gFunc.Message('THF Macro Book');
            AshitaCore:GetChatManager():QueueCommand(1, '/macro book 9');
            AshitaCore:GetChatManager():QueueCommand(1, '/macro set 4');
        elseif player.SubJob == 'WHM' or player.SubJob == 'RDM' then
            gFunc.Message('WHM Macro Book');
            AshitaCore:GetChatManager():QueueCommand(1, '/macro book 9');
            AshitaCore:GetChatManager():QueueCommand(1, '/macro set 5');
        else
            gFunc.Message('DEFAULT Macro Book');
            AshitaCore:GetChatManager():QueueCommand(1, '/macro book 9');
            AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1');
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
    local mainWeapon = gData.GetEquipment().Main;
    local subWeapon = gData.GetEquipment().Sub;

    -- Evaluate my sets to account for a level sync
    if (myLevel ~= Settings.CurrentLevel) then
        gFunc.Message('Syncing Gear - Lv. ' .. myLevel);
        Settings.CurrentLevel = myLevel;

        gFunc.EvaluateLevels(profile.Sets, Settings.CurrentLevel);
    end

    -- Check if we need to LateInitialize
    -- If we have not LateInitialize'd, set a timer for 11 seconds then do it after that time has elapsed and never again
    if Settings.LateInitialized.Initialized == false then
        if Settings.LateInitialized.TimeToUse == 0 then
            Settings.LateInitialized.TimeToUse = timestamp + 11;
        else
            profile.LateInitialize();
        end
    end

    -- 1 = Default
    if draginclude.dragSettings.TpVariant == 1 then

        gFunc.EquipSet(sets.Default);

        if player.Status == 'Engaged' then
            gFunc.EquipSet(sets.Engaged);
        end
        
        if player.SubJob == 'WHM' or player.SubJob == 'RDM' then
            if player.MP >= 70 and player.Status ~= 'Engaged' then
                gFunc.EquipSet(sets.MP);
            elseif player.MP < 50 then
                gFunc.EquipSet(sets.Gaudy);
            end

            if player.Status == 'Resting' then
                gFunc.EquipSet(sets.Relaxing);
            end
        elseif player.SubJob == 'NIN' then
            if player.Status == 'Engaged' then
                gFunc.EquipSet(sets.StealthEarring);
            end
        end

    -- 2 = Pet Accuracy
    elseif draginclude.dragSettings.TpVariant == 2 then 
        if player.SubJob == 'WHM' or player.SubJob == 'RDM' then
            gFunc.EquipSet(sets.PetAccWHM);

            if player.Status == 'Resting' then
                gFunc.EquipSet(sets.Relaxing);
            end
        else
            gFunc.EquipSet(sets.PetAcc);
        end
    -- 3 = Evasion (I never use this one)
    elseif draginclude.dragSettings.TpVariant == 3 then 
        if player.SubJob == 'WHM' or player.SubJob == 'RDM' then
            gFunc.EquipSet(sets.EvasionWHM);

            if player.Status == 'Resting' then
                gFunc.EquipSet(sets.Relaxing);
            end
        else
            gFunc.EquipSet(sets.Evasion);
        end
    end

    -- Check if my pet is readying a Ready/Sic move
    if (pet ~= nil) then
        if player.Status ~= 'Engaged' and pet.Status == 'Engaged' then
            gFunc.EquipSet(sets.PetAcc);
        end

        if (petAction ~= nil) then
            HandlePetAction(petAction);
            return;
        end
    end

    -- Equip Gaudy Harness if a Rune Axe is in hand and we have less than 50 mp
    if ((mainWeapon ~= nil and mainWeapon.Name == 'Rune Axe') or (subWeapon ~= nil and subWeapon.Name == 'Rune Axe')) and player.MP < 50 and player.Status == 'Engaged' then
        gFunc.EquipSet(sets.Gaudy);
    end

    -- Put town gear on
    if (zone.Area ~= nil) and (draginclude.Towns:contains(zone.Area)) then 
        gFunc.EquipSet(sets.IdleTown);
    end

    draginclude.HandleDefault(Settings.JugPetSettings);
    draginclude.CheckSkillingVariant();
    draginclude.CheckStatusArmorSwaps(Settings.StatusArmorSwaps, Settings.CurrentLevel);
end

profile.HandleAbility = function()
    local pet = gData.GetPet();
    local ability = gData.GetAction();

    --gFunc.EvaluateLevels(profile.Sets, Settings.CurrentLevel);
    gFunc.Message(ability.Name);

    if string.match(ability.Name, 'Call Beast') then
        gFunc.EquipSet(sets.Call);
        AshitaCore:GetChatManager():QueueCommand(1, '/tt custom "' .. Settings.JugPetSettings.DefaultJugs[Settings.JugPetSettings.CurrentJug].Name .. ' Duration" ' .. Settings.JugPetSettings.DefaultJugs[Settings.JugPetSettings.CurrentJug].DurationMinutes .. 'm');
    elseif string.match(ability.Name, 'Reward') then

        if draginclude.dragSettings.RewardType == 'HP' then
            gFunc.EquipSet(sets.RewardHP);
        elseif draginclude.dragSettings.RewardType == 'STATUS' then
            gFunc.EquipSet(sets.RewardSTATUS);
        else
            gFunc.EquipSet(sets.RewardHP);
        end
    elseif string.match(ability.Name, 'Charm') then
        gFunc.EquipSet(sets.Charm);
    end

    draginclude.HandleAbility(ability);
end

profile.HandleItem = function()
    local item = gData.GetAction();
end

profile.HandlePrecast = function()
    local spell = gData.GetAction();

    gFunc.EquipSet(sets.Precast);
end

profile.HandleMidcast = function()
    local spell = gData.GetAction();

    gFunc.Message('Midcast');

    gFunc.EquipSet(sets.SpellHaste);

    if spell.Name == 'Invisible' then
        gFunc.EquipSet(sets.Invisible);
    elseif spell.Name == 'Sneak' then
        gFunc.EquipSet(sets.Sneak);
    elseif spell.Name == 'Stoneskin' then
        gFunc.EquipSet(sets.Stoneskin); 
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

    gFunc.EquipSet(sets.WeaponSkill);

    if string.contains(action.Name, 'Decimation') or string.contains(action.Name, 'Mistral') or string.contains(action.Name, 'Vorpal') then
        gFunc.EquipSet(sets.WeaponSkillLight);
    end

    draginclude.HandleWeaponSkill(action);
end

return profile;