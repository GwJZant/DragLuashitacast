local profile = {};
draginclude = gFunc.LoadFile('common\\draginclude.lua');

local Settings = {
    -- Default settings for jug/food preferences
    DragoonSettings = {
        HealingBreathHPPDrachen = 50,
        HealingBreathHPPThreshold = 33,
        HealingBreathMessageFrequency = 2,
        HealingMessageTimeToNotify = 0
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
};

local sets = {
    Default_Priority = {
        Ammo = {'Tiphia Sting', 'Happy Egg'},
        Head = {'Optical Hat', 'Emperor Hairpin', 'Shep. Bonnet'},
        Neck = {'Love Torque', 'Peacock Amulet',},
        Ear1 = {'Beastly Earring', 'Spike Earring'},
        Ear2 = {'Brutal Earring', 'Merman\'s Earring'},
        Body = {'Wym. Mail +1', 'Elder\'s Surcoat', 'Dream Robe +1',},
        Hands = {'Homam Manopolas',},
        Ring1 = {'Rajas Ring'},
        Ring2 = {'Blitz Ring'},
        Back = {'Forager\'s Mantle', 'Amemet Mantle', 'Nomad\'s Mantle',},
        Waist = {'Sonic Belt'},
        Legs = {'Drn. Brais +1', 'Elder\'s Braguette'},
        Feet = {'Homam Gambieras', 'Elder\'s Sandals'},
    },

    DefaultLowHp_Priority = {

    },

    Engaged_Priority = { --22% Haste (Missing: Dusk Gloves +1(1%))
        Head = {'Ace\'s Helm'}, --4%
        Body = {'Wym. Mail +1'}, -- +2%
        Hands = {'Homam Manopolas'}, --3%
        Ring2 = {'Blitz Ring'}, --1%
        Waist = {'Sonic Belt'}, --6%
        Legs = {'Homam Cosciales'}, --3%
        Feet = {'Homam Gambieras'}, --3%
    },

    Mage_Priority = {
        Ammo = {'Tiphia Sting', 'Happy Egg'},
        Head = {'Ace\'s Helm', 'Shep. Bonnet'},
        Neck = {'Love Torque', 'Peacock Amulet'},
        Ear1 = {'Beastly Earring', 'Spike Earring'},
        Ear2 = {'Brutal Earring', 'Merman\'s Earring'},
        Body = {'Wym. Mail +1', 'Elder\'s Surcoat'},
        Hands = {'Homam Manopolas'},
        Ring1 = {'Rajas Ring'},
        Ring2 = {'Blitz Ring'},
        Back = {'Forager\'s Mantle'},
        Waist = {'Sonic Belt'},
        Legs = {'Homam Cosciales', 'Elder\'s Braguette'},
        Feet = {'Homam Gambieras'},
    },

    Parry_Priority = {
        Ear2 = {'Ethereal Earring'},
        Ring1 = {'Rajas Ring'},
        Ring2 = {'Toreador\'s Ring'},
        Waist = {'Sonic Belt'},
    },

    PDT_Priority = {
        Ear1 = {'Loquac. Earring'},
        Ear2 = {'Ethereal Earring'},
        Ring2 = {'Jelly Ring'},
        Back = {'Boxer\'s Mantle'},
    },

    MDT_Priority = {
        Ear1 = {'Loquac. Earring'},
        Ear2 = {'Ethereal Earring'},
    },

    MP_Priority = {
        Ammo = {'Hedgehog Bomb', 'Phtm. Tathlum'},
        Head = {},
        Neck = {'Rep.Mythril Medal'},
        Ear1 = {'Beastly Earring'},
        Ear2 = {'Phantom Earring'},
        Body = {'Elder\'s Surcoat'},
        Hands = {'Elder\'s Bracers'},
        Ring1 = {'Astral Ring'},
        Ring2 = {'Ether Ring'},
        Back = {},
        Waist = {},
        Legs = {'Elder\'s Braguette'},
        Feet = {'Elder\'s Sandals'},
    },

    Evasion_Priority = {

    },

    WeaponSkill_Priority = {
        Ammo = {'Tiphia Sting'},
        Head = {'Ace\'s Helm'},
        Neck = {'Peacock Amulet'},
        Ear1 = {'Beastly Earring',},
        Ear2 = {'Brutal Earring'},
        Body = {'Hecatomb Harness'},
        Hands = {'Wyrm Fng.Gnt.'},
        Ring1 = {'Rajas Ring'},
        Ring2 = {'Toreador\'s Ring'},
        Back = {'Forager\'s Mantle'},
        Waist = {'Warwolf Belt'},
        Legs = {'Barone Cosciales'},
        Feet = {'Hct. Leggings'},
    },

    WeaponSkillPenta_Priority = {
        Waist = {'Wyrm Belt'},
    },

    WeaponSkillLight_Priority = {
        Neck = {'Light Gorget'},
    },

    Precast_Priority = {

    },

    Midcast_Priority = { -- +HP
        Ammo = {'Happy Egg'},
        Head = {'Drachen Armet'},
        Ear1 = {'Loquac. Earring'},
        Body = {'Wyrm Mail +1'},
        Hands = {'Homam Manopolas'},
        Ring1 = {'Bloodbead Ring'},
        Ring2 = {'Bomb Queen Ring'},
        Legs = {'Homam Cosciales'},
        Feet = {'Homam Gambieras'},
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
        Body = 'Wyrm Mail +1',
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
        Head = {'Wyrm Armet', 'Drachen Armet', 'Shep. Bonnet'},
        Body = {'Wyvern Mail'},
		Hands = {'Ostrenger Mitts'},
        Legs = {'Drn. Brais +1'},
		Feet = {'Homam Gambieras'},
    },

    BreathBonusElemental_Priority = {
        Head = {'Wyrm Armet', 'Drachen Armet', 'Shep. Bonnet'},
    },

    CallWyvern_Priority = {
        Body = {'Wyrm Mail +1'},
    },

    Jump_Priority = { --VIT
        Body = {'Barone Corazza'},
        Waist = {'Wyrm Belt'},
        Legs = {'Barone Cosciales'},
        Feet = {'Drn. Greaves +1'},
    },

    HighJump_Priority = { --VIT
        Body = {'Barone Corazza'},
        Waist = {'Wyrm Belt'},
        Ring2 = {'Vaulter\'s Ring'},
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

    Idle_Priority = {
        --Body = {'Barone Corazza'},
        Legs = {'Crimson Cuisses'},
    },

    IdleTown_Priority = {
        Ammo = {'Tiphia Sting'},
        Head = {'Ace\'s Helm'},
        Neck = {'Love Torque'},
        Ear1 = {'Loquac. Earring'},
        Ear2 = {'Ethereal Earring'},
        Body = {'Wym. Mail +1'},
        Hands = {'Homam Manopolas'},
        Ring1 = {'Jelly Ring'},
        Ring2 = {'Blitz Ring'},
        Back = {'Forager\'s Mantle'},
        Waist = {'Sonic Belt'},
        Legs = {'Crimson Cuisses'},
        Feet = {'Homam Gambieras'},
    },

    EXPRing = {
        Ring1 = 'Emperor Band',
    },

    Warp = {
        Main = 'Warp Cudgel',
    },

    Sneak_Priority = {
        Feet = {'Dream Boots +1'},
    },

    Invisible_Priority = {
        Hands = {'Dream Mittens +1'},
    },
};

profile.Sets = sets;

local function HandlePetAction(PetAction, subjob)

    gFunc.Message(PetAction.Name .. ' - ' .. PetAction.Type);

    if string.contains(PetAction.Name, 'Healing Breath') then
        gFunc.EquipSet(sets.BreathBonusHealing);
    else
        gFunc.EquipSet(sets.BreathBonusElemental);
    end
end

local function CheckHealingBreath()
    local timestamp = os.time();
    local pet = gData.GetPet();

    if pet ~= nil and Settings.DragoonSettings.HealingMessageTimeToNotify ~= 0 and timestamp >= Settings.DragoonSettings.HealingMessageTimeToNotify then
        gFunc.Message('Healing Breath is ONLINE');
        Settings.DragoonSettings.HealingMessageTimeToNotify = 0;
    end
end

local function LateInitialize()
    local timestamp = os.time();
    local player = gData.GetPlayer();

    if timestamp >= Settings.LateInitialized.TimeToUse then
        -- Setting a Style Lock prevents the character from blinking
        gFunc.LockStyle(sets.StyleLock);

        --[[ Set your job macro defaults here]]
        if player.SubJob == 'RDM' then
            AshitaCore:GetChatManager():QueueCommand(1, '/macro book 15');
            AshitaCore:GetChatManager():QueueCommand(1, '/macro set 2');
        elseif player.SubJob == 'WHM' then
            AshitaCore:GetChatManager():QueueCommand(1, '/macro book 15');
            AshitaCore:GetChatManager():QueueCommand(1, '/macro set 3');
            gFunc.Message('WHM Macro Book');
        elseif player.SubJob == 'THF' then
            AshitaCore:GetChatManager():QueueCommand(1, '/macro book 15');
            AshitaCore:GetChatManager():QueueCommand(1, '/macro set 4');
            gFunc.Message('THF Macro Book');
        elseif player.SubJob == 'WAR' then
            AshitaCore:GetChatManager():QueueCommand(1, '/macro book 15');
            AshitaCore:GetChatManager():QueueCommand(1, '/macro set 5');
            gFunc.Message('WAR Macro Book');
        elseif player.SubJob == 'NIN' then
            AshitaCore:GetChatManager():QueueCommand(1, '/macro book 15');
            AshitaCore:GetChatManager():QueueCommand(1, '/macro set 6');
            gFunc.Message('NIN Macro Book');
        elseif player.SubJob == 'SAM' then
            AshitaCore:GetChatManager():QueueCommand(1, '/macro book 15');
            AshitaCore:GetChatManager():QueueCommand(1, '/macro set 7');
            gFunc.Message('SAM Macro Book');
        else
            AshitaCore:GetChatManager():QueueCommand(1, '/macro book 15');
            AshitaCore:GetChatManager():QueueCommand(1, '/macro set 8');
            gFunc.Message('DEFAULT Macro Book');
        end

        -- DRG Core Commands
        AshitaCore:GetChatManager():QueueCommand(-1,'/bind 2 /lac fwd Jump ');
        AshitaCore:GetChatManager():QueueCommand(-1,'/bind 3 /lac fwd CallWyvern ');
        AshitaCore:GetChatManager():QueueCommand(-1,'/bind 4 /lac fwd HighJump ');
        AshitaCore:GetChatManager():QueueCommand(-1,'/bind 5 /lac fwd SuperJump ');
        AshitaCore:GetChatManager():QueueCommand(-1,'/bind 9 /lac fwd SpiritLink ');
        AshitaCore:GetChatManager():QueueCommand(-1,'/bind 0 /lac fwd SteadyWing');

        Settings.LateInitialized.Initialized = true;
        gFunc.Message('LateInitialized');
    end
end

profile.OnLoad = function()
    draginclude.OnLoad(sets, {'Default', 'PDT', 'MDT'}, {'None', 'Field', 'Fishing'});
end

profile.OnUnload = function()
    draginclude.OnUnload();
end

profile.HandleCommand = function(args)
    draginclude.HandleCommand(args, sets);
    draginclude.HandleDrgCoreCommands(args);
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

    -- Checking if Healing Breath is online
    if player.SubJob == 'WHM' or player.SubJob == 'RDM' or player.SubJob == 'BLM' or player.SubJob == 'SMN' then
        for index = 0, gData.GetParty().Count - 1, 1 do -- Party index 0-5 is 6 main party members (0 is you)

            if index > 5 then -- Healing Breath doesn't work on Alliance members outside your party so stop counting
                break;
            end

            local hpp = party:GetMemberHPPercent(index);
            local partyMemberZone = party:GetMemberZone(index);

            --gFunc.Message(index);
            --gFunc.Message(hpp);

            -- Party Members outside the zone count as having 0 HP so we need to make sure we check only within current zone
            if Settings.CurrentLevel >= 60 and hpp ~= 0 and hpp < Settings.DragoonSettings.HealingBreathHPPDrachen and myZone == partyMemberZone then
                if Settings.DragoonSettings.HealingMessageTimeToNotify == 0 then
                    Settings.DragoonSettings.HealingMessageTimeToNotify = timestamp + Settings.DragoonSettings.HealingBreathMessageFrequency;
                end
            elseif hpp ~= 0 and hpp <= Settings.DragoonSettings.HealingBreathHPPThreshold and myZone == partyMemberZone then
                if Settings.DragoonSettings.HealingMessageTimeToNotify == 0 then
                    Settings.DragoonSettings.HealingMessageTimeToNotify = timestamp + Settings.DragoonSettings.HealingBreathMessageFrequency;
                end
            end
        end
    end

    if player.SubJob == 'WHM' or player.SubJob == 'RDM' or player.SubJob == 'BLM' then
        if player.MP <= 75 then
            gFunc.EquipSet(sets.Default);
        else
            --gFunc.EquipSet(sets.Default);
            gFunc.EquipSet(sets.Mage);
        end
        
    else
        gFunc.EquipSet(sets.Default);
    end

    -- Engaged Section
    if player.Status == 'Engaged' then

        gFunc.EquipSet(sets.Engaged);

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
        gFunc.EquipSet(sets.Idle);

        if pet ~= nil and pet.HPP < 100 then
            gFunc.EquipSet(sets.PetIdle);
        end
    end

    -- Forward slash toggle between Default and Evasion
    if draginclude.dragSettings.TpVariant == 1 then
        -- Nothing
    elseif draginclude.dragSettings.TpVariant == 2 then --Use PDT set
        gFunc.EquipSet(sets.PDT);

    elseif draginclude.dragSettings.TpVariant == 3 then --Use MDT set
        gFunc.EquipSet(sets.MDT);
    end

    if (petAction ~= nil) then
        HandlePetAction(petAction, player.SubJob);
        return;
    end

    if (zone.Area ~= nil) and (draginclude.Towns:contains(zone.Area)) then 
        gFunc.EquipSet(sets.IdleTown);
    end

    CheckHealingBreath();

    draginclude.HandleDefault();
    draginclude.CheckSkillingVariant();
    draginclude.CheckStatusArmorSwaps(Settings.StatusArmorSwaps, Settings.CurrentLevel);
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
end

profile.HandleMidcast = function()
    local spell = gData.GetAction();

    gFunc.Message(spell.Name);

    gFunc.EquipSet(sets.Midcast);

    if draginclude.dragSettings.TpVariant ~= 2 then
        if (spell.Skill == 'Ninjutsu') then
	    	if string.contains(spell.Name, 'Utsusemi') then
                gFunc.EquipSet(sets.Evasion);
	    	end
	    end

        if spell.Name == 'Invisible' then
            gFunc.EquipSet(sets.Invisible);
        elseif spell.Name == 'Sneak' then
            gFunc.EquipSet(sets.Sneak);
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
    local player = gData.GetPlayer();

    gFunc.Message(action.Name);

    if player.SubJob ~= 'WHM' and player.SubJob ~= 'RDM' and player.SubJob ~= 'BLM' then

        gFunc.EquipSet(sets.WeaponSkill);

        if string.contains(action.Name, 'Penta') then
            gFunc.EquipSet(sets.WeaponSkillPenta);

        elseif string.contains(action.Name, 'Wheeling') or string.contains(action.Name, 'Skewer') or string.contains(action.Name, 'Thunder') or string.contains(action.Name, 'Vorpal') then
            gFunc.EquipSet(sets.WeaponSkillLight);
        end
    end

    draginclude.HandleWeaponSkill(action);
end

return profile;