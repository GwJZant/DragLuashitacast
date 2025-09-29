local profile = {};
draginclude = gFunc.LoadFile('common\\draginclude.lua');

local Settings = {
    LateInitialized = {
        Initialized = false,
        TimeToUse = 0,
    },
    StatusArmorSwaps = {
        OpoopoNecklace = false,
    },
    CurrentLevel = 0,
};

local sets = {
    Default_Priority = {
        Ammo = {'Holy Ampulla', 'Morion Tathlum'},
        Head = {'Emperor Hairpin'},
        Neck = {'Holy Phial'},
        Ear1 = {'Beetle Earring +1'},
        Ear2 = {'Beetle Earring +1'},
        Body = {'Wonder Kaftan', 'Seer\'s Tunic', 'Tarutaru Kaftan'},
        Hands = {'Battle Gloves'},
        Ring1 = {'San d\'Orian Ring'},
        Ring2 = {'Eremite\'s Ring'},
        Back = {'Trimmer\'s Mantle'},
        Waist = {},
        Legs = {'Wonder Braccae', 'Seer\'s Slacks', 'Tarutaru Braccae'},
        Feet = {'Wonder Clomps', 'Tarutaru Clomps'},
    },

    RestingMP_Priority = {
        Ammo = {''},
        Head = {''},
        Neck = {''},
        Ear1 = {''},
        Ear2 = {''},
        Body = {'Seer\'s Tunic'},
        Hands = {''},
        Ring1 = {''},
        Ring2 = {''},
        Back = {''},
        Waist = {''},
        Legs = {''},
        Feet = {''},
    },

    MND_Priority = { -- MND +8
        Ammo = {'Holy Ampulla'}, -- MND +1
        Neck = {'Holy Phial'}, -- MND +3
        Body = {'Wonder Kaftan'}, -- MND +1
        Ring1 = {'San d\'Orian Ring'}, -- MND +1
        Legs = {'Wonder Braccae'}, -- MND +2
    },

    INT_Priority = { -- INT +4
        Ring1 = {'Eremite\'s Ring'}, -- INT +2
        Ring2 = {'Eremite\'s Ring'}, -- INT +2
    },

    HPDown_Priority = {
        Ring1 = {'Ether Ring'},
        Ring2 = {'Astral Ring'},
    },

    SpellHaste_Priority = {

    },

    DarkSkill_Priority = {

    },

    EnhancingSkill_Priority = {

    },

    Weaponskill_Priority = {
        Hands = {'Wonder Mitts'},
    },

    StyleLockSummer = {
        Head = 'Emperor Hairpin',
        Body = 'Wonder Maillot +1',
        Legs = 'Taru. Trunks +1',
    },

    PetReadyDefault = {

    },

    PetAttack = {

    },

    Reward_Priority = { -- MND +7
        Ammo = {'Pet Fd. Epsilon', 'Pet Food Delta', 'Pet Fd. Gamma', 'Pet Food Beta', 'Pet Food Alpha'},
        Neck = {'Holy Phial'}, -- MND +3
        Body = {'Wonder Kaftan'}, -- MND +1
        Ring1 = {'San d\'Orian Ring'}, -- MND +1
        Legs = {'Wonder Braccae'}, -- MND +2
    },

    Charm_Priority = {
        Ammo = {''},
        Head = {''},
        Neck = {'Flower Necklace'}, -- CHR +3
        Ear1 = {''},
        Ear2 = {''},
        Body = {''},
        Hands = {''},
        Ring1 = {''},
        Ring2 = {''},
        Back = {'Trimmer\'s Mantle'},
        Waist = {''},
        Legs = {''},
        Feet = {''},
    },

    EXPRing = {
        Ring1 = 'Chariot Band',
    },

    Warp = {
        Main = 'Warp Cudgel',
    },
};

profile.Sets = sets;

local ObiTable = {
    --Fire = "Karin Obi",
    --Earth = "Dorin Obi",
    --Water = "Suirin Obi",
    --Wind = "Furin Obi",
    --Ice = "Hyorin Obi",
    --Thunder = "Rairin Obi",
    --Light = "Korin Obi",
    --Dark = "Anrin Obi"
}

local ElementWeaknessTable = {
    Fire = "Water",
    Ice = "Fire",
    Wind = "Ice",
    Earth = "Wind",
    Thunder = "Earth",
    Water = "Thunder",
    Light = "Dark",
    Dark = "Light"
}

local obiBonus = function(spellElement)
    local environment = gData.GetEnvironment();
    local dayElement = environment.DayElement;
    local weatherElement = environment.WeatherElement;
    local isDoubleWeather = string.find(environment.Weather, "x2");

    local bonus = 0;
    if (spellElement == dayElement) then
        bonus = bonus + 10;
    end

    if (spellElement == weatherElement) then
        if (isDoubleWeather) then
            bonus = bonus + 25;
        else
            bonus = bonus + 10;
        end
    end

    if (dayElement == ElementWeaknessTable[spellElement]) then
        bonus = bonus - 10;
    end

    if (weatherElement == ElementWeaknessTable[spellElement]) then
        if (isDoubleWeather) then
            bonus = bonus - 25;
        else
            bonus = bonus - 10;
        end
    end

    return bonus;
end

local equipObiIfApplicable = function(spellElement)
    local obiBonus = obiBonus(spellElement);
    if (obiBonus > 0) then
        print("Obi Bonus: " .. obiBonus .. "%");
        gFunc.Equip("waist", ObiTable[spellElement]);
    end
end

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
            AshitaCore:GetChatManager():QueueCommand(1, '/macro book 6');
            AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1');

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
            AshitaCore:GetChatManager():QueueCommand(1, '/macro book 6');
            AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1');
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

        gFunc.EquipSet(sets.Default);
        

        -- Engaged Section
        if player.Status == 'Engaged' then
        
        -- Resting Section
        elseif (player.Status == 'Resting') then
            gFunc.EquipSet(sets.RestingMP);
        -- Idle Section
        else

        end

    elseif draginclude.dragSettings.TpVariant == 2 then --Use default set
        
    end

    if (pet ~= nil) then
        if (petAction ~= nil) then
            HandlePetAction(petAction);
            return;
        end
    end

    draginclude.HandleDefault();
    draginclude.CheckSkillingVariant();
end

profile.HandleAbility = function()
    local pet = gData.GetPet();
    local ability = gData.GetAction();

    if string.match(ability.Name, 'Reward') then
        gFunc.EquipSet(sets.Reward);
    elseif string.match(ability.Name, 'Charm') then
        gFunc.LockSet(sets.Charm, 1);
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

    if string.contains(spell.Name, 'Cure') then
        gFunc.EquipSet(sets.HPDown);
    end
end

profile.HandleMidcast = function()
    local spell = gData.GetAction();
    local player = gData.GetPlayer();
    local target = gData.GetActionTarget();

    if spell.Name == 'Invisible' then
        gFunc.EquipSet(sets.Invisible);
    elseif spell.Name == 'Sneak' then
        gFunc.EquipSet(sets.Sneak);
    elseif spell.Name == 'Stoneskin' then
        gFunc.EquipSet(sets.MND);
    elseif string.contains(spell.Name, 'Spikes') then
        gFunc.EquipSet(sets.INT);
    elseif spell.Skill == 'Ninjutsu' then
        gFunc.EquipSet(sets.SpellHaste);
    elseif spell.Skill == 'Enfeebling Magic' and not string.contains(spell.Name, 'Dia' )then -- Dia and Dia II need zero gearswap
        if spell.Type == 'White Magic' then
            gFunc.EquipSet(sets.MND);

            equipObiIfApplicable(spell.Element);
        elseif spell.Type == 'Black Magic' then
            gFunc.EquipSet(sets.INT);

            equipObiIfApplicable(spell.Element);
        end
    elseif spell.Skill == 'Enhancing Magic' then
        if spell.Name == 'Haste' then
            gFunc.EquipSet(sets.SpellHaste);
        elseif string.contains(spell.Name, 'Bar') or spell.Name == 'Phalanx' then -- Barspells need raw Enhancing Skill
            gFunc.EquipSet(sets.EnhancingSkill);
        end
    elseif spell.Skill == 'Healing Magic' then
    
        if (not string.contains(spell.Name, 'Reraise')) and (not string.contains(spell.Name, 'Raise')) then
            gFunc.EquipSet(sets.MND);
        elseif string.contains(spell.Name, 'Raise') then
            gFunc.EquipSet(sets.SpellHaste);
        end
    elseif spell.Skill == 'Elemental Magic' then
        if spell.Name == 'Drown' or spell.Name == 'Frost' or spell.Name == 'Choke' or spell.Name == 'Rasp' or spell.Name == 'Shock' or spell.Name == 'Burn' then
            gFunc.EquipSet(sets.INT);
        else
            gFunc.EquipSet(sets.INT);
        end

        equipObiIfApplicable(spell.Element);
    elseif spell.Skill == 'Dark Magic' and spell.Name ~= 'Bio' then -- Bio needs zero gearswap

        if spell.Name == 'Drain' or spell.Name == 'Aspir' then
            gFunc.EquipSet(sets.DarkSkill);
        elseif spell.Name == 'Bio II' then -- Bio needs raw Dark Skill
            gFunc.EquipSet(sets.DarkSkill);
        else
            gFunc.EquipSet(sets.INT);
        end

        equipObiIfApplicable(spell.Element);
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

    gFunc.EquipSet(sets.Weaponskill);

    draginclude.HandleWeaponSkill(action);
end

return profile;