local profile = {};

local Settings = {
    LateInitialized = {
        Initialized = false,
        TimeToUse = 0,
    },
    TpVariant = 1,
    SkillingVariant = 1,
    FishingVariant = 1,
    CurrentLevel = 0,
};

local sets = {
    Default_Priority = {
	    Head = {'Emperor Hairpin'},
	    Neck = {'T.K. Army Collar'},
	    Ear1 = {'Dodge Earring'},
	    Ear2 = {'Dodge Earring'},
	    Body = {'Scorpion Harness'},
	    Hands = {'Ryl.Kgt. Mufflers'},
	    Ring1 = {'Bomb Queen Ring'},
	    Ring2 = {'Sattva Ring'},
	    Back = {'Jaguar Mantle'},
	    Waist = {'Swift Belt'},
	    Legs = {'Kingdom Trousers'},
	    Feet = {'Fuma Kyahan'},
    },

    FastCast_Priority = {
        Ear2 = {'Loquac. Earring'},
    },

    Evasion_Priority = {
	    Head = {'Emperor Hairpin'},
	    Neck = {'T.K. Army Collar'},
	    Ear1 = {'Dodge Earring'},
	    Ear2 = {'Dodge Earring'},
	    Body = {'Scorpion Harness'},
	    Hands = {'Ryl.Kgt. Mufflers'},
	    Ring1 = {'Bomb Queen Ring'},
	    Ring2 = {'Sattva Ring'},
	    Back = {'Jaguar Mantle'},
	    Waist = {'Swift Belt'},
	    Legs = {'Kingdom Trousers'},
	    Feet = {'Fuma Kyahan'},
    },

    Engaged_Priority = {
    	Head = {'Emperor Hairpin'},
    	Neck = {'Peacock Amulet'},
    	Ear1 = {'Dodge Earring'},
    	Ear2 = {'Dodge Earring'},
    	Body = {'Scorpion Harness'},
    	Hands = {'Ochiudo\'s Kote'},
    	Ring1 = {'Toreador\'s Ring'},
    	Ring2 = {'Toreador\'s Ring'},
    	Back = {'Jaguar Mantle'},
    	Waist = {'Swift Belt'},
    	Legs = {'Kingdom Trousers'},
    	Feet = {'Fuma Kyahan'},
    },

    SpellHaste_Priority = {
        Head = {'Panther Mask'}, --2%
        Hands = {'Dusk Gloves'}, --3%
        Waist = {'Swift Belt'}, --4%
        Legs = {'Byakko\'s Haidate'}, --6%
        Feet = {'Dusk Ledelsens'}, --2%
    },

    WS_Priority = {
    	Head = {'Voyager Sallet'},
    	Neck = {'Peacock Amulet'},
    	Ear1 = {'Fang Earring'},
    	Ear2 = {'Fang Earring'},
    	Body = {'Haubergeon'},
    	Hands = {'Ochiudo\'s Kote'},
    	Ring1 = {'Puissance Ring'},
    	Ring2 = {'Toreador\'s Ring'},
    	Back = {'Jaguar Mantle'},
    	Waist = {'Life Belt'},
    	Legs = {'Ryl.Kgt. Breeches'},
    	Feet = {'Savage Gaiters'},
    },

    StyleLock = {
        Head = '',
        Body = '',
        Hands = '',
        Legs = '',
        Feet = '',
    },

    Fishing = {

    },

    MovementSpeed_Priority = {
        Feet = {'Ninja Kyahan'},
    },

    PetAttack_Priority = {
        Ear2 = {'Beastly Earring'},
    },

    Reward_Priority = { -- MND
        Ammo = {'Pet Food Zeta', 'Pet Fd. Epsilon', 'Pet Food Delta', 'Pet Fd. Gamma', 'Pet Food Beta', 'Pet Food Alpha'},
    },

    Charm_Priority = {
        Head = {'Ninja Hatsuburi'},
	    Neck = {'Star Necklace'},
	    Body = {'Savage Separates'},
	    Ring1 = {'Hope Ring'},
	    Ring2 = {'Hope Ring'},
	    Back = {'Trimmer\'s Mantle'},
	    Feet = {'Savage Gaiters'},
    },

    Sneak = {
        Hands = 'Dream Mittens +1',
    },

    Invisible = {
        Feet = 'Dream Boots +1',
    },
};

profile.Sets = sets;

TpVariantTable = { -- cycle through with /lac fwd tpset
--    [1] = 'Default',
--    [2] = 'Evasion',
};

SkillingVariantTable = { -- cycle through with /lac fwd tpset
--    [1] = 'None',
--    [2] = 'Field',
--    [3] = 'Fishing',
};

Towns = T{'Tavnazian Safehold','Al Zahbi','Aht Urhgan Whitegate','Nashmau','Southern San d\'Oria [S]','Bastok Markets [S]','Windurst Waters [S]','San d\'Oria-Jeuno Airship','Bastok-Jeuno Airship','Windurst-Jeuno Airship','Kazham-Jeuno Airship','Southern San d\'Oria','Northern San d\'Oria','Port San d\'Oria','Chateau d\'Oraguille','Bastok Mines','Bastok Markets','Port Bastok','Metalworks','Windurst Waters','Windurst Walls','Port Windurst','Windurst Woods','Heavens Tower','Ru\'Lude Gardens','Upper Jeuno','Lower Jeuno','Port Jeuno','Rabao','Selbina','Mhaura','Kazham','Norg','Mog Garden','Celennia Memorial Library','Western Adoulin','Eastern Adoulin'};


local function HandlePetAction(PetAction)
    gFunc.EquipSet(sets.PetReadyDefault);
end

profile.OnLoad = function()
    tpVariantTable = {'Default', 'Evasion'};
    skillingVariantTable = {'None', 'Fishing'};

    for k, v in pairs(tpVariantTable) do
        TpVariantTable[k] = v;
        print('[' .. k .. ', ' .. v .. ']');
    end

    for k, v in pairs(skillingVariantTable) do
        SkillingVariantTable[k] = v;
        print('[' .. k .. ', ' .. v .. ']');
    end

    AshitaCore:GetChatManager():QueueCommand(-1,'/alias /tp /lac fwd TpVariant');
    AshitaCore:GetChatManager():QueueCommand(-1,'/alias /skill /lac fwd SkillingVariant');
    AshitaCore:GetChatManager():QueueCommand(-1,'/alias /fish /lac fwd FishingVariant');
end

profile.OnUnload = function()
    
end

profile.HandleCommand = function(args)
    
    -- If forward slash is pressed
    if (args[1] == 'TpVariant') then

        -- Iterate the set index by 1
        Settings.TpVariant = Settings.TpVariant + 1;

        -- If that index we made is out of bounds of the actual set (like if it's 4 but there's only 3)
        if (Settings.TpVariant > #TpVariantTable) then 

            -- Set it back to 1
            Settings.TpVariant = 1;
        end

        gFunc.Message('Set: ' .. TpVariantTable[Settings.TpVariant]); --display the set
    elseif (args[1] == 'SkillingVariant') then

        -- Iterate the set index by 1
        Settings.SkillingVariant = Settings.SkillingVariant + 1;

        -- If that index we made is out of bounds of the actual set (like if it's 4 but there's only 3)
        if (Settings.SkillingVariant > #SkillingVariantTable) then

            -- Set it back to 1
            Settings.SkillingVariant = 1;
        end

        gFunc.Message('Skilling Set: ' .. SkillingVariantTable[Settings.SkillingVariant]); --display the set
    elseif (args[1] == 'FishingVariant') then

        -- Iterate the set index by 1
        Settings.FishingVariant = Settings.FishingVariant + 1;

        -- If that index we made is out of bounds of the actual set (like if it's 4 but there's only 3)
        if (Settings.FishingVariant > 2) then

            -- Set it back to 1
            Settings.FishingVariant = 1;
        end

        gFunc.Message('Skilling Set: ' .. SkillingVariantTable[Settings.SkillingVariant]); --display the set
    end
end

profile.LateInitialize = function()
    local timestamp = os.time();
    local player = gData.GetPlayer();

    if timestamp >= Settings.LateInitialized.TimeToUse then
        -- Setting a Style Lock prevents the character from blinking
        -- The delay in setting this is to prevent a failure to set the stylelock on first load
        gFunc.LockStyle(sets.StyleLock);

        -- Set this to your default NIN macro book
        AshitaCore:GetChatManager():QueueCommand(1, '/macro book 18');
        AshitaCore:GetChatManager():QueueCommand(1, '/macro set 6');
 
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
    local time = zone.Time;
    local myLevel = AshitaCore:GetMemoryManager():GetPlayer():GetMainJobLevel();

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

    if Settings.TpVariant == 1 then -- Default
        gFunc.EquipSet(sets.Default);

        if player.Status == 'Engaged' then
            gFunc.EquipSet(sets.Engaged);
        else
            if player.IsMoving and (time < 6 or time > 18) then
                gFunc.EquipSet(sets.MovementSpeed);
            end
        end
    elseif Settings.TpVariant == 2 then -- Evasion
        gFunc.EquipSet(sets.Evasion);
    end

    if (pet ~= nil) then
        if (petAction ~= nil) then
            HandlePetAction(petAction);
            return;
        end
    end

    if Settings.SkillingVariant == 2 then
        gFunc.EquipSet(sets.Fishing);
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
end

profile.HandleWeaponskill = function()
    local action = gData.GetAction();

    gFunc.EquipSet(sets.WS);
end

return profile;