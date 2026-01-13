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
        Ammo = {'Morion Tathlum'},
        Head = {'Emperor Hairpin'},
        Neck = {'Holy Phial'},
        Ear1 = {'Morion Earring'},
        Ear2 = {'Morion Earring'},
        Body = {'Wonder Kaftan', 'Seer\'s Tunic'},
        Hands = {'Wonder Mitts'},
        Ring1 = {'Tamas Ring', 'Eremite\'s Ring'},
        Ring2 = {'Eremite\'s Ring'},
        Back = {'Red Cape +1'},
        Waist = {'Swift Belt', 'Druid\'s Rope'},
        Legs = {'Wonder Braccae', 'Seer\'s Slacks'},
        Feet = {'Wonder Clomps'},
    },

    RestingMP_Priority = {
        Ammo = {''},
        Head = {''},
        Neck = {'Checkered Scarf'},
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

    MeleeEngaged_Priority = {
        Ammo = {'Morion Tathlum'},
        Head = {'Emperor Hairpin'},
        Neck = {'Holy Phial'},
        Ear1 = {'Beetle Earring +1'},
        Ear2 = {'Beetle Earring +1'},
        Body = {'Seer\'s Tunic'},
        Hands = {'Wonder Mitts'},
        Ring1 = {'San d\'Orian Ring'},
        Ring2 = {'Eremite\'s Ring'},
        Back = {'Trimmer\'s Mantle'},
        Waist = {''},
        Legs = {'Seer\'s Slacks'},
        Feet = {'Wonder Clomps'},
    },

    INT_Priority = {
        Ammo = {'Morion Tathlum'}, -- INT +1
        Head = {'Seer\'s Crown +1'}, -- INT +3
        Neck = {'Black Neckerchief'}, -- INT +1
        Ear1 = {'Morion Earring'}, -- INT +1
        Ear2 = {'Abyssal Earring', 'Morion Earring'}, -- INT +1
        Body = {'Mage\'s Robe'}, -- INT +1
        Hands = {'Seer\'s Mitts +1'}, -- INT +2 
        Ring1 = {'Tamas Ring', 'Eremite\'s Ring'}, -- INT +5
        Ring2 = {'Zircon Ring', 'Eremite\'s Ring'}, -- INT +2
        Back = {'Red Cape +1'}, -- INT +3
        Waist = {'Druid\'s Rope'}, -- INT +1
        Legs = {'Seer\'s Slacks'}, -- INT +1
        Feet = {},
    },

    MND_Priority = {
        Ammo = {},
        Head = {},
        Neck = {'Holy Phial'}, -- MND +1
        Ear1 = {'Geist Earring'}, -- MND +1
        Ear2 = {'Geist Earring'}, -- MND +1
        Body = {'Wonder Kaftan'}, -- MND +1
        Hands = {},
        Ring1 = {'Tamas Ring',}, -- MND +5
        Ring2 = {'Aquamarine Ring', 'Turquoise\'s Ring'}, -- MND +2
        Back = {'Red Cape +1'}, -- MND +3
        Waist = {'Druid\'s Rope'}, -- MND +1
        Legs = {'Wonder Braccae'}, -- MND +2
        Feet = {},
    },

    StyleLock = {
        Head = 'Emperor Hairpin',
        Body = 'Mage\'s Robe',
        Hands = 'Seer\'s Mitts +1',
        Legs = 'Seer\'s Slacks',
        Feet = 'Wonder Clomps',
    },

    PetReadyDefault = {

    },

    PetAttack = {

    },

    Reward_Priority = { -- MND
        Ammo = {'Pet Fd. Epsilon', 'Pet Food Delta', 'Pet Food Beta', 'Pet Food Alpha'},
        Neck = {'Holy Phial'},
        Body = {'Wonder Kaftan'},
        Ring1 = {'San d\'Orian Ring'},
        Legs = {'Wonder Braccae'},
    },

    Charm_Priority = {
        Ammo = {''},
        Head = {''},
        Neck = {'Flower Necklace'},
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

    Sneak = {
        Hands = 'Dream Mittens +1',
    },

    Invisible = {
        Feet = 'Dream Boots +1',
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
    Dark = "Anrin Obi"
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
    draginclude.OnLoad(sets, {'NoStaffSwap', 'StaffSwap'}, {'None', 'Field'});
end

profile.OnUnload = function()
    draginclude.OnUnload();
end

profile.HandleCommand = function(args)
    if (args[1] == 'WeaponTypeToggle') then
        Settings.WeaponTypeToggle = not Settings.WeaponTypeToggle;

        if Settings.WeaponTypeToggle then
            gFunc.Message('WeaponTypeToggle SWORD');
        else
            gFunc.Message('WeaponTypeToggle DAGGER');
        end
    elseif (args[1] == 'pdt') then
        Settings.PDT = not Settings.PDT;

        if Settings.PDT then
            gFunc.Message('PDT ON');
        else
            gFunc.Message('PDT OFF');
        end
    elseif (args[1] == 'Martial') then
        Settings.MartialKnife = not Settings.MartialKnife;

        if Settings.MartialKnife then
            gFunc.Message('MartialKnife ON');
        else
            gFunc.Message('MartialKnife OFF');
        end
    elseif (args[1] == 'haste') then
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma "Haste" <stpc>');
    elseif (args[1] == 'refresh') then
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma "Refresh" <stpc>');
    elseif (args[1] == 'regen') then
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma "Regen" <stpc>');
    elseif (args[1] == 'regen2') then
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma "Regen II" <stpc>');
    elseif (args[1] == 'regen3') then
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma "Regen III" <stpc>');
    elseif (args[1] == 'cure5') then
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma "Cure V" <stpc>');
    elseif (args[1] == 'gravity') then
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma "Gravity" <stnpc>');
    elseif (args[1] == 'stoneskin') then
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma "Stoneskin" <me>');
    elseif (args[1] == 'silence') then
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma "Silence" <stnpc>');
    elseif (args[1] == 'drain') then
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma "Drain" <stnpc>');
    elseif (args[1] == 'aspir') then
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma "Aspir" <stnpc>');
    elseif (args[1] == 'bind') then
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma "Bind" <stnpc>');
    elseif (args[1] == 'sleepga') then
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma "Sleepga" <stnpc>');
    elseif (args[1] == 'sleep') then
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma "Sleep" <stnpc>');
    elseif (args[1] == 'paralyze') then
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma "Paralyze" <stnpc>');
    elseif (args[1] == 'slow') then
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma "Slow" <stnpc>');
    elseif (args[1] == 'icespikes') then
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma "Ice Spikes" <me>');
    elseif (args[1] == 'blazespikes') then
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma "Blaze Spikes" <me>');
    elseif (args[1] == 'shockspikes') then
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma "Shock Spikes" <me>');
    elseif (args[1] == 'phalanx') then
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma "Phalanx" <me>');
    elseif (args[1] == 'blink') then
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma "Blink" <me>');
    elseif (args[1] == 'enspell') then
        local environment = gData.GetEnvironment();
        local dayElement = environment.DayElement;
        local weatherElement = environment.WeatherElement;
        local isDoubleWeather = string.find(environment.Weather, "x2");
        local spellName = 'Enblizzard';

        if isDoubleWeather or dayElement == 'Light' or dayElement == 'Dark' then
            if weatherElement == 'Wind' then
                spellName = 'Enaero';
            elseif weatherElement == 'Ice' then
                spellName = 'Enblizzard';
            elseif weatherElement == 'Fire' then
                spellName = 'Enfire';
            elseif weatherElement == 'Earth' then
                spellName = 'Enstone';
            elseif weatherElement == 'Thunder' then
                spellName = 'Enthunder';
            elseif weatherElement == 'Water' then
                spellName = 'Enwater';
            end
        else
            if dayElement == 'Wind' then
                spellName = 'Enaero';
            elseif dayElement == 'Ice' then
                spellName = 'Enblizzard';
            elseif dayElement == 'Fire' then
                spellName = 'Enfire';
            elseif dayElement == 'Earth' then
                spellName = 'Enstone';
            elseif dayElement == 'Thunder' then
                spellName = 'Enthunder';
            elseif dayElement == 'Water' then
                spellName = 'Enwater';
            end
        end
        AshitaCore:GetChatManager():QueueCommand(-1,'/ma ' .. spellName .. ' <me>');
    end

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
            AshitaCore:GetChatManager():QueueCommand(1, '/macro book 1');
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
            gFunc.EquipSet(sets.MeleeEngaged);
        -- Resting Section
        elseif (player.Status == 'Resting') then
            gFunc.EquipSet(sets.RestingMP);
        -- Idle Section
        else

        end

    elseif draginclude.dragSettings.TpVariant == 2 then --Use default set
        gFunc.EquipSet(sets.Default);
        
        -- Engaged Section
        if player.Status == 'Engaged' then
            gFunc.EquipSet(sets.MeleeEngaged);
        -- Resting Section
        elseif (player.Status == 'Resting') then
            gFunc.EquipSet(sets.RestingMP);
        -- Idle Section
        else
            gFunc.EquipSet(sets.Earth);
        end
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
end

profile.HandleMidcast = function()
    local spell = gData.GetAction();
    local player = gData.GetPlayer();
    local target = gData.GetActionTarget();

    if draginclude.dragSettings.TpVariant == 1 then
        -- Don't swap weapons
    elseif draginclude.dragSettings.TpVariant == 2 then
        if spell.Element == 'Fire' then
            gFunc.EquipSet(sets.Fire);
        elseif spell.Element == 'Ice' then
            gFunc.EquipSet(sets.Ice);
        elseif spell.Element == 'Wind' then
            gFunc.EquipSet(sets.Wind);
        elseif spell.Element == 'Earth' then
            gFunc.EquipSet(sets.Earth);
        elseif spell.Element == 'Thunder' then
            gFunc.EquipSet(sets.Thunder);
        elseif spell.Element == 'Water' then
            gFunc.EquipSet(sets.Water);
        elseif spell.Element == 'Light' then
            gFunc.EquipSet(sets.Light);
        elseif spell.Element == 'Dark' then
            gFunc.EquipSet(sets.Dark);
        end
    end

    if spell.Name == 'Invisible' then
        gFunc.EquipSet(sets.Invisible);
    elseif spell.Name == 'Sneak' then
        gFunc.EquipSet(sets.Sneak);
    elseif spell.Type == 'White Magic' then
        gFunc.EquipSet(sets.MND);
        equipObiIfApplicable(spell.Element);
    elseif spell.Type == 'Black Magic' then
        gFunc.EquipSet(sets.INT);
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

    draginclude.HandleWeaponSkill(action);
end

return profile;