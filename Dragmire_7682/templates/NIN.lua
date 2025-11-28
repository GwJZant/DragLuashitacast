local profile = {};

local Settings = {
    LateInitialized = {
        Initialized = false,
        TimeToUse = 0,
    },
    CurrentLevel = 0,
};

local sets = {
    Default_Priority = {
        Ammo = {'Morion Tathlum'},
        Head = {'Emperor Hairpin'},
        Neck = {'Ryl.Sqr. Collar'},
        Ear1 = {'Beetle Earring +1'},
        Ear2 = {'Beetle Earring +1'},
        Body = {'Wonder Kaftan', 'Beetle Harness +1', 'Tarutaru Kaftan'},
        Hands = {'Tarutaru Mitts'},
        Ring1 = {'San d\'Orian Ring'},
        Ring2 = {'Tamas Ring'},
        Back = {'Trimmer\'s Mantle'},
        Waist = {},
        Legs = {'Wonder Braccae', 'Ryl.Ftm. Trousers', 'Tarutaru Braccae'},
        Feet = {'Wonder Clomps', 'Tarutaru Clomps'},
    },

    MND_Priority = {
        Ammo = {''},
        Head = {''},
        Neck = {'Holy Phial'},
        Ear1 = {'Geist Earring'},
        Ear2 = {'Geist Earring'},
        Body = {'Wonder Kaftan'},
        Hands = {''},
        Ring1 = {'San d\'Orian Ring'},
        Ring2 = {'Tamas Ring'},
        Back = {''},
        Waist = {''},
        Legs = {'Wonder Braccae'},
        Feet = {''},
    },

    INT_Priority = {
        Ammo = {'Morion Tathlum'},
        Head = {''},
        Neck = {''},
        Ear1 = {'Morion Earring'},
        Ear2 = {'Morion Earring'},
        Body = {''},
        Hands = {''},
        Ring1 = {'Eremite\'s Ring'},
        Ring2 = {'Tamas Ring'},
        Back = {''},
        Waist = {''},
        Legs = {''},
        Feet = {''},
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

    StyleLock = {
        Head = '',
        Body = '',
        Hands = '',
        Legs = '',
        Feet = '',
    },

    PetReadyDefault = {

    },

    PetAttack_Priority = {
        
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
        Back = {'Trimmer\'s Mantle'},
        Waist = {},
        Legs = {},
        Feet = {},
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
    
end

profile.OnUnload = function()
    
end

profile.HandleCommand = function(args)
    
end

profile.LateInitialize = function()
    local timestamp = os.time();
    local player = gData.GetPlayer();

    if timestamp >= Settings.LateInitialized.TimeToUse then
        -- Setting a Style Lock prevents the character from blinking
        -- The delay in setting this is to prevent a failure to set the stylelock on first load
        gFunc.LockStyle(sets.StyleLock);
 
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

    gFunc.EquipSet(sets.Default);

    if player.Status == 'Engaged' then
        gFunc.EquipSet(sets.Engaged);
    end

    if (pet ~= nil) then
        if (petAction ~= nil) then
            HandlePetAction(petAction);
            return;
        elseif pet.Status == 'Engaged' then
            gFunc.EquipSet(sets.PetAttack);
        end
    end
end

profile.HandleAbility = function()
    local ability = gData.GetAction();

    if string.match(ability.Name, 'Reward') then
        gFunc.EquipSet(sets.Reward);
    elseif string.match(ability.Name, 'Charm') then
        gFunc.EquipSet(sets.Charm);
    end
end

profile.HandleItem = function()
    --local item = gData.GetAction();
end

profile.HandlePrecast = function()
    --local spell = gData.GetAction();
end

profile.HandleMidcast = function()
    local spell = gData.GetAction();

    if spell.Type == 'White Magic' then
        gFunc.EquipSet(sets.MND);
    elseif spell.Type == 'Black Magic' then
        gFunc.EquipSet(sets.INT);
    end
end

profile.HandlePreshot = function()
    
end

profile.HandleMidshot = function()

end

profile.HandleWeaponskill = function()
    gFunc.EquipSet(sets.WS);
end

return profile;