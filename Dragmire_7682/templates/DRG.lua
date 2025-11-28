local profile = {};

local Settings = {
    LateInitialized = {
        Initialized = false,
        TimeToUse = 0,
    },
    CurrentLevel = 0,
    TpVariant = 1,
};

local sets = {
    Default_Priority = {
        Ammo = {'Tiphia Sting'},
        Head = {'Wyvern Helm'},
        Neck = {'Merman\'s Gorget'},
        Ear1 = {'Brutal Earring'},
        Ear2 = {'Beastly Earring'},
        Body = {'Barone Corazza'},
        Hands = {'Wyrm Fng.Gnt.'},
        Ring1 = {'Rajas Ring'},
        Ring2 = {'Toreador\'s Ring'},
        Back = {'Amemet Mantle +1'},
        Waist = {'Swift Belt'},
        Legs = {'Barone Cosciales'},
        Feet = {'Drn. Greaves +1'},
    },

    DefaultLowHp_Priority = {

    },

    Engaged_Priority = { -- Haste +9% (Missing Ace's Helm/Homam Head/Horus Helm, Homam Body/Wyrm Mail +1, Blitz Ring, Homam Legs, Homam Feet)
        Ammo = {'Tiphia Sting'},
        Head = {'Optical Hat'},
        Neck = {'Merman\'s Gorget'},
        Ear1 = {'Brutal Earring'},
        Ear2 = {'Beastly Earring'},
        Body = {'Scorpion Harness'},
        Hands = {'Homam Manopolas'}, -- Haste +3%
        Ring1 = {'Rajas Ring'},
        Ring2 = {'Toreador\'s Ring'},
        Back = {'Amemet Mantle +1'},
        Waist = {'Swift Belt'}, -- Haste +4%
        Legs = {'Drn. Brais +1'},
        Feet = {'Dusk Ledelsens'}, -- Haste +2%
    },

    Mage_Priority = {
        Ammo = {'Hedgehog Bomb'},
        Head = {'Wyvern Helm'},
        Neck = {'Merman\'s Gorget'},
        Ear1 = {'Brutal Earring'},
        Ear2 = {'Ethereal Earring'},
        Body = {'Barone Corazza'},
        Hands = {'Wyrm Fng.Gnt.'},
        Ring1 = {'Rajas Ring'},
        Ring2 = {'Toreador\'s Ring'},
        Back = {'Amemet Mantle +1'},
        Waist = {'Swift Belt'},
        Legs = {'Barone Cosciales'},
        Feet = {'Drn. Greaves +1'},
    },

    EngagedMage_Priority = { -- Haste +9% (Missing Ace's Helm/Homam Head/Horus Helm, Homam Body/Wyrm Mail +1, Blitz Ring, Homam Legs, Homam Feet)
        Ammo = {'Hedgehog Bomb'},
        Head = {'Optical Hat'},
        Neck = {'Merman\'s Gorget'},
        Ear1 = {'Brutal Earring'},
        Ear2 = {'Ethereal Earring'},
        Body = {'Scorpion Harness'},
        Hands = {'Homam Manopolas'}, -- Haste +3%
        Ring1 = {'Rajas Ring'},
        Ring2 = {'Toreador\'s Ring'},
        Back = {'Amemet Mantle +1'},
        Waist = {'Swift Belt'}, -- Haste +4%
        Legs = {'Drn. Brais +1'},
        Feet = {'Dusk Ledelsens'}, -- Haste +2%
    },

    Parry_Priority = {
        
    },

    PDT_Priority = { 
        Head = {'Darksteel Cap'}, -- PDT -1%
        Body = {'Gavial Mail'}, -- PDT -3%, MDT -3%
        Hands = {'Darksteel Mittens'}, -- PDT -1%
        Legs = {'Gavial Cuisses'}, -- PDT -3%
        Feet = {'Gavial Greaves'}, -- PDT -2%
    },

    MDT_Priority = {
        Head = {'Gavial Mask'}, -- MDT -2%
        Neck = {'Jeweled Collar'},
        Ear1 = {'Merman\'s Earring'}, -- MDT -2%
        Ear2 = {'Merman\'s Earring'}, -- MDT -2%
        Body = {'Gavial Mail'}, -- PDT -3%, MDT -3%
        Hands = {'Darksteel Mittens'}, -- PDT -1%
        Ring1 = {'Coral Ring'}, -- MDT -3%
        Ring2 = {'Coral Ring'}, -- MDT -3%
        --Waist = {'Friar\'s Rope'},
        Legs = {'Coral Cuisses +1'}, -- MDT -3%
        Feet = {'Coral Greaves'}, -- MDT -1%
    },

    MP_Priority = {
        
    },

    Evasion_Priority = {

    },

    WeaponSkill_Priority = {
        Ammo = {'Tiphia Sting'},
        Head = {'Wyrm Helm'},
        Neck = {'Merman\'s Gorget'},
        Ear1 = {'Brutal Earring',},
        Ear2 = {'Beastly Earring'},
        Body = {'Scorpion Harness'},
        Hands = {'Pallas\'s Bracelets'},
        Ring1 = {'Rajas Ring'},
        Ring2 = {'Flame Ring'},
        Back = {'Amemet Mantle +1'},
        Waist = {'Warwolf Belt'},
        Legs = {'Barone Cosciales'}, 
        Feet = {'Drn. Greaves +1'},
    },

    WeaponSkillWheeling_Priority = {
        Ammo = {'Tiphia Sting'},
        Head = {'Wyrm Helm'},
        Neck = {'Merman\'s Gorget'},
        Ear1 = {'Brutal Earring',},
        Ear2 = {'Beastly Earring'},
        Body = {'Scorpion Harness'},
        Hands = {'Pallas\'s Bracelets'},
        Ring1 = {'Rajas Ring'},
        Ring2 = {'Flame Ring'},
        Back = {'Amemet Mantle +1'},
        Waist = {'Warwolf Belt'},
        Legs = {'Barone Cosciales'}, 
        Feet = {'Drn. Greaves +1'},
    },

    WeaponSkillImpulseDrive_Priority = {
        Ammo = {'Tiphia Sting'},
        Head = {'Wyrm Helm'},
        Neck = {'Merman\'s Gorget'},
        Ear1 = {'Brutal Earring',},
        Ear2 = {'Beastly Earring'},
        Body = {'Scorpion Harness'},
        Hands = {'Pallas\'s Bracelets'},
        Ring1 = {'Rajas Ring'},
        Ring2 = {'Flame Ring'},
        Back = {'Amemet Mantle +1'},
        Waist = {'Warwolf Belt'},
        Legs = {'Barone Cosciales'}, 
        Feet = {'Drn. Greaves +1'},
    },

    WeaponSkillPenta_Priority = {
        Ammo = {'Tiphia Sting'},
        Head = {'Optical Hat'},
        Neck = {'Merman\'s Gorget'},
        Ear1 = {'Brutal Earring',},
        Ear2 = {'Beastly Earring'},
        Body = {'Scorpion Harness'},
        Hands = {'Wyrm Fng.Gnt.'},
        Ring1 = {'Rajas Ring'},
        Ring2 = {'Toreador\'s Ring'},
        Back = {'Amemet Mantle +1'},
        Waist = {'Life Belt'},
        Legs = {'Barone Cosciales'}, 
        Feet = {'Drn. Greaves +1'},
    },

    Precast_Priority = {

    },

    Midcast_Priority = { -- +HP
        Ammo = {''},
        Head = {'Drachen Armet'},
        Neck = {'Bloodbead Amulet'},
        Ear1 = {'Loquac. Earring'},
        Ear2 = {'Ethereal Earring'},
        Body = {'Wyrm Mail'},
        Hands = {'Pallas\'s Bracelets'},
        Ring2 = {'Toreador\'s Ring'},
        Legs = {'Drn. Brain +1'},
        Feet = {'Dusk Ledelsens'},
    },

    StyleLock = {
        Main = 'Relic Lance',
        Head = 'Ace\'s Helm',
        Body = 'Hecatomb Harness',
        Hands = 'Homam Manopolas',
        Legs = 'Homam Cosciales',
        Feet = 'Homam Gambieras',
    },

    StyleLockRelic = {
        Main = 'Love Halberd',
        Head = 'Wyrm Armet',
        Body = 'Wyrm Mail',
        Hands = 'Wyrm Fng.Gnt.',
        Legs = 'Wyrm Brais',
        Feet = 'Wyrm Greaves',
    },

    StyleLockAF = {
        Main = 'Love Halberd',
        Head = 'Drachen Armet',
        Body = 'Drachen Mail',
        Hands = 'Drachen Fng. Gnt.',
        Legs = 'Drachen Brais',
        Feet = 'Drn. Greaves +1',
    },

    StyleLockRSE = {
        Main = 'Love Halberd',
        Head = 'Egg Helm',
        Body = 'Elder\'s Surcoat',
        Hands = 'Elder\'s Bracers',
        Legs = 'Elder\'s Braguette',
        Feet = 'Elder\'s Sandals'
    },

    BreathBonusHealing_Priority = {
        Head = {'Wyrm Armet', 'Drachen Armet'},
        Body = {'Wyvern Mail'},
		Hands = {'Ostreger Mitts'},
        Legs = {'Drn. Brais +1'},
    },

    BreathBonusElemental_Priority = {
        Head = {'Wyrm Armet', 'Drachen Armet'},
    },

    CallWyvern_Priority = {
        Body = {'Wyrm Mail'},
    },

    Jump_Priority = { 
        Legs = {'Barone Cosciales'},
        Feet = {'Drn. Greaves +1'},
    },

    HighJump_Priority = { 
        Legs = {'Barone Cosciales'},
        Feet = {'Drn. Greaves +1'},
    },

    AncientCircle_Priority = {
        Legs = {'Drn. Brais +1'},
    },

    Resting_Priority = {
        Body = {'Wyvern Mail'},
        --Feet = {'Wyrm Greaves'},
    },

    PetIdle_Priority = {
        --Body = {'Drachen Mail'},
    },

    Idle_Priority = { -- When you get W. Legs, uncomment the Legs slot below
        --Legs = {'Crimson Cuisses'},
    },

    Sneak_Priority = {
        Feet = {'Dream Boots +1'},
    },

    Invisible_Priority = {
        Hands = {'Dream Mittens +1'},
    },
};

profile.Sets = sets;

local TpVariantTable = { -- cycle through with /lac fwd tpset
    [1] = 'Default',
    [2] = 'PDT',
    [3] = 'MDT',
};

local Towns = T{'Tavnazian Safehold','Al Zahbi','Aht Urhgan Whitegate','Nashmau','Southern San d\'Oria [S]','Bastok Markets [S]','Windurst Waters [S]','San d\'Oria-Jeuno Airship','Bastok-Jeuno Airship','Windurst-Jeuno Airship','Kazham-Jeuno Airship','Southern San d\'Oria','Northern San d\'Oria','Port San d\'Oria','Chateau d\'Oraguille','Bastok Mines','Bastok Markets','Port Bastok','Metalworks','Windurst Waters','Windurst Walls','Port Windurst','Windurst Woods','Heavens Tower','Ru\'Lude Gardens','Upper Jeuno','Lower Jeuno','Port Jeuno','Rabao','Selbina','Mhaura','Kazham','Norg','Mog Garden','Celennia Memorial Library','Western Adoulin','Eastern Adoulin'};

local function HandlePetAction(PetAction)
    if string.contains(PetAction.Name, 'Healing Breath') then
        gFunc.EquipSet(sets.BreathBonusHealing);
    else
        gFunc.EquipSet(sets.BreathBonusElemental);
    end
end

local function LateInitialize()
    local timestamp = os.time();
    local player = gData.GetPlayer();

    if timestamp >= Settings.LateInitialized.TimeToUse then
        -- Setting a Style Lock prevents the character from blinking
        gFunc.LockStyle(sets.StyleLockRelic);

        Settings.LateInitialized.Initialized = true;
        gFunc.Message('LateInitialized');
    end
end

profile.OnLoad = function()
    AshitaCore:GetChatManager():QueueCommand(-1,'/alias /tpvariant /lac fwd TpVariant ');
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
    end
end

profile.HandleDefault = function()
    local timestamp = os.time();
    local petAction = gData.GetPetAction();
    local pet = gData.GetPet();
    local player = gData.GetPlayer();
    local party = AshitaCore:GetMemoryManager():GetParty();
    local zone = gData.GetEnvironment();
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

    -- Engaged Section
    if player.Status == 'Engaged' then

        if player.SubJob == 'WHM' or player.SubJob == 'RDM' or player.SubJob == 'BLM' then
            gFunc.EquipSet(sets.EngagedMage);
        else
            gFunc.EquipSet(sets.Engaged);
        end
        
    -- Resting Section
    elseif (player.Status == 'Resting') then

        gFunc.EquipSet(sets.Idle);

        if pet ~= nil and pet.HPP < 100 then
            gFunc.EquipSet(sets.PetIdle);
        end

        -- Switch to Resting gear
        gFunc.EquipSet(sets.Resting);

    -- Idle Section
    else
        if player.SubJob == 'WHM' or player.SubJob == 'RDM' or player.SubJob == 'BLM' then
            gFunc.EquipSet(sets.Mage);
        else
            gFunc.EquipSet(sets.Default);
        end
    end

    if Settings.TpVariant == 1 then
        -- Nothing
    elseif Settings.TpVariant == 2 then --Use PDT set
        gFunc.EquipSet(sets.PDT);
    elseif Settings.TpVariant == 3 then --Use MDT set
        gFunc.EquipSet(sets.MDT);
    end

    if (petAction ~= nil) then
        HandlePetAction(petAction);
        return;
    end
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
    end
end

profile.HandleItem = function()
    local item = gData.GetAction();
end

profile.HandlePrecast = function()
    local spell = gData.GetAction();

    gFunc.Message(spell.Name);
end

profile.HandleMidcast = function()
    local spell = gData.GetAction();

    gFunc.EquipSet(sets.Midcast);

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
    local player = gData.GetPlayer();

    gFunc.Message(action.Name);

    gFunc.EquipSet(sets.WeaponSkill);

    if string.contains(action.Name, 'Penta') then
        gFunc.EquipSet(sets.WeaponSkillPenta);
    elseif action.Name == 'Wheeling Thrust' then
        gFunc.EquipSet(sets.WeaponSkillWheeling);
    elseif action.Name == 'Impulse Drive' then
        gFunc.EquipSet(sets.WeaponSkillImpulseDrive);
    end
end

return profile;