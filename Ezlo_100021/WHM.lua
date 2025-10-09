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
        Neck = {'Ajari Necklace', 'Holy Phial'},
        Ear1 = {'Geist Earring'},
        Ear2 = {'Geist Earring'},
        Body = {'Wonder Kaftan', 'Seer\'s Tunic', 'Tarutaru Kaftan'},
        Hands = {'Battle Gloves'},
        Ring1 = {'Aquamarine Ring', 'Turquoise Ring', 'San d\'Orian Ring'},
        Ring2 = {'Aquamarine Ring', 'Turquoise Ring'},
        Back = {'Red Cape +1', 'Trimmer\'s Mantle'},
        Waist = {'Swift Belt', 'Life Belt'},
        Legs = {'Wonder Braccae', 'Seer\'s Slacks', 'Tarutaru Braccae'},
        Feet = {'Healer\'s Duckbills', 'Wonder Clomps', 'Tarutaru Clomps'},
    },

    RestingMP_Priority = {
        Ammo = {''},
        Head = {''},
        Neck = {'Checkered Scarf'}, -- HMP +1
        Ear1 = {''},
        Ear2 = {''},
        Body = {'Seer\'s Tunic'}, -- HMP +1
        Hands = {''},
        Ring1 = {''},
        Ring2 = {''},
        Back = {''},
        Waist = {''},
        Legs = {''},
        Feet = {''},
    },

    RestingMPBLM_Priority = {
        Ammo = {''},
        Head = {''},
        Neck = {'Checkered Scarf'}, -- HMP +1
        Ear1 = {''},
        Ear2 = {''},
        Body = {'Seer\'s Tunic'}, -- HMP +1
        Hands = {''},
        Ring1 = {''},
        Ring2 = {''},
        Back = {'Wizard\'s Mantle'}, -- HMP +1 when /BLM
        Waist = {''},
        Legs = {''},
        Feet = {''},
    },

    VermillionCloak = {
        Head = 'displaced',
        Body = 'Vermillion Cloak',
    },

    MeleeEngaged_Priority = {
        Ammo = {'Holy Ampulla', 'Morion Tathlum'},
        Head = {'Emperor Hairpin'},
        Neck = {'Ajari Necklace', 'Holy Phial'},
        Ear1 = {'Spike Earring', 'Beetle Earring +1'},
        Ear2 = {'Spike Earring', 'Beetle Earring +1'},
        Body = {'Wonder Kaftan', 'Seer\'s Tunic', 'Tarutaru Kaftan'},
        Hands = {'Battle Gloves'},
        Ring1 = {'Toreador\'s Ring', 'San d\'Orian Ring'},
        Ring2 = {'Sniper\'s Ring'},
        Back = {'Red Cape +1', 'Trimmer\'s Mantle'},
        Waist = {'Swift Belt', 'Life Belt'},
        Legs = {'Wonder Braccae', 'Seer\'s Slacks', 'Tarutaru Braccae'},
        Feet = {'Wonder Clomps', 'Tarutaru Clomps'},
    },

    MND_Priority = { -- MND +21
        Ammo = {'Holy Ampulla'}, -- MND +1
        Neck = {'Ajari Necklace', 'Holy Phial'}, -- MND +6
        Ear1 = {'Geist Earring'}, -- MND +1
        Ear2 = {'Geist Earring'}, -- MND +1
        Body = {'Wonder Kaftan'}, -- MND +1
        Ring1 = {'Aquamarine Ring', 'Turquoise Ring'}, -- MND +3
        Ring2 = {'Aquamarine Ring', 'Turquoise Ring'}, -- MND +3
        Back = {'Red Cape +1'}, -- MND +3
        Waist = {'Swift Belt'},
        Legs = {'Wonder Braccae'}, -- MND +2
        Feet = {'Healer\'s Duckbills'}, -- SIRD 20%
    },

    MNDEnfeeb_Priority = { -- MND +20 Enfeebling Skill +5
        Ammo = {'Holy Ampulla'}, -- MND +1
        Neck = {'Ajari Necklace', 'Holy Phial'}, -- MND +6
        Ear1 = {'Geist Earring'}, -- MND +1
        Ear2 = {'Geist Earring'}, -- MND +1
        Body = {'Shaman\'s Cloak', 'Wonder Kaftan'}, -- Enfeebling Skill +5
        Ring1 = {'Aquamarine Ring', 'Turquoise Ring'}, -- MND +3
        Ring2 = {'Aquamarine Ring', 'Turquoise Ring'}, -- MND +3
        Back = {'Red Cape +1'}, -- MND +3
        Waist = {'Swift Belt'},
        Legs = {'Wonder Braccae'}, -- MND +2
        Feet = {'Healer\'s Duckbills'}, -- SIRD 20%
    },

    INT_Priority = { -- INT +13
        Neck = {'Checkered Scarf'}, -- INT +2
        Ear1 = {'Morion Earring'}, -- INT +1
        Ear2 = {'Morion Earring'}, -- INT +1
        Body = {'Shaman\'s Cloak'}, -- INT +4
        Ring1 = {'Zircon Ring', 'Eremite\'s Ring'}, -- INT +3
        Ring2 = {'Zircon Ring', 'Eremite\'s Ring'}, -- INT +3
        Waist = {'Swift Belt'},
        Feet = {'Healer\'s Duckbills'}, -- INT +3 SIRD 20%
    },

    INTEnfeeb_Priority = { -- INT +17 Enfeebling Skill +5
        Neck = {'Checkered Scarf'}, -- INT +2
        Ear1 = {'Morion Earring'}, -- INT +1
        Ear2 = {'Morion Earring'}, -- INT +1
        Body = {'Shaman\'s Cloak'}, -- INT +4 Enfeebling Skill +5
        Ring1 = {'Zircon Ring', 'Eremite\'s Ring'}, -- INT +3
        Ring2 = {'Zircon Ring', 'Eremite\'s Ring'}, -- INT +3
        Waist = {'Swift Belt'},
        Feet = {'Healer\'s Duckbills'}, -- INT +3 SIRD 20%
    },

    INTElemental_Priority = { -- INT +17 Elemental Skill +5
        Neck = {'Checkered Scarf'}, -- INT +2
        Ear1 = {'Morion Earring'}, -- INT +1
        Ear2 = {'Morion Earring'}, -- INT +1
        Body = {'Shaman\'s Cloak'}, -- INT +4 Elemental Skill +5
        Ring1 = {'Zircon Ring', 'Eremite\'s Ring'}, -- INT +3
        Ring2 = {'Zircon Ring', 'Eremite\'s Ring'}, -- INT +3
        Waist = {'Swift Belt'},
        Feet = {'Healer\'s Duckbills'}, -- INT +3 SIRD 20%
    },

    MedicineRing_Priority = {
        Ring2 = {'Medicine Ring'}, -- Cure Potency +10% while HP <= 75% and TP <= 1000
    },

    HPDown_Priority = {
        Ring1 = {'Ether Ring'},
        Ring2 = {'Astral Ring'},
    },

    Precast_Priority = {
        Waist = {'Swift Belt'}, -- Haste 4%
    },

    SpellHaste_Priority = {
        Waist = {'Swift Belt'},
        Feet = {'Healer\'s Duckbills'}, -- INT +3 SIRD 20%
    },

    DarkSkill_Priority = { -- INT +17
        Neck = {'Checkered Scarf'}, -- INT +2
        Ear1 = {'Morion Earring'}, -- INT +1
        Ear2 = {'Morion Earring'}, -- INT +1
        Body = {'Shaman\'s Cloak'}, -- INT +4
        Ring1 = {'Zircon Ring', 'Eremite\'s Ring'}, -- INT +3
        Ring2 = {'Zircon Ring', 'Eremite\'s Ring'}, -- INT +3
        Waist = {'Swift Belt'},
        Feet = {'Healer\'s Duckbills'}, -- INT +3 SIRD 20%
    },

    MNDEnhancingSkill_Priority = {
        Ammo = {'Holy Ampulla'}, -- MND +1
        Neck = {'Ajari Necklace', 'Holy Phial'}, -- MND +6
        Ear1 = {'Geist Earring'}, -- MND +1
        Ear2 = {'Geist Earring'}, -- MND +1
        Body = {'Wonder Kaftan'}, -- MND +1
        Ring1 = {'Aquamarine Ring', 'Turquoise Ring'}, -- MND +3
        Ring2 = {'Aquamarine Ring', 'Turquoise Ring'}, -- MND +3
        Back = {'Red Cape +1'}, -- MND +3
        Waist = {'Swift Belt'},
        Legs = {'Wonder Braccae'}, -- MND +2
        Feet = {'Healer\'s Duckbills'}, -- SIRD 20%
    },

    CurePrecast_Priority = {
        Feet = {'Cure Clogs'}, -- Cure Cast -15%
    },

    RuckesRung_Priority = {
        --Main = {'Rucke\'s Rung'},
    },
    
    Fire_Priority = {
        Main = {'Fire Staff'},
    },

    Ice_Priority = {
        Main = {'Ice Staff'},
    },

    Wind_Priority = {
        Main = {'Wind Staff'},
    },

    Earth_Priority = {
        Main = {'Earth Staff'},
    },

    Thunder_Priority = {
        Main = {'Thunder Staff'},
    },

    Water_Priority = {
        Main = {'Water Staff'},
    },

    Light_Priority = {
        Main = {'Light Staff'},
    },

    Dark_Priority = {
        Main = {'Dark Staff'},
    },

    Weaponskill_Priority = {
        Hands = {'Wonder Mitts'},
    },

    StyleLockSummer = {
        Main = 'Light Staff',
        Head = 'Emperor Hairpin',
        Body = 'Wonder Maillot +1',
        Legs = 'Taru. Trunks +1',
    },

    StyleLockGeneric = {
        Main = 'Light Staff',
        Body = 'Shaman\'s Cloak',
        Hands = 'Wonder Mitts',
        Legs = 'Seer\'s Slacks',
        Feet = 'Healer\'s Duckbills',
    },

    PetReadyDefault = {

    },

    PetAttack = {

    },

    Reward_Priority = { -- MND +14
        Ammo = {'Pet Food Zeta', 'Pet Fd. Epsilon', 'Pet Food Delta', 'Pet Fd. Gamma', 'Pet Food Beta', 'Pet Food Alpha'},
        Neck = {'Holy Phial'}, -- MND +3
        Ear1 = {'Geist Earring'}, -- MND +1
        Ear2 = {'Geist Earring'}, -- MND +1
        Body = {'Wonder Kaftan'}, -- MND +1
        Ring1 = {'Aquamarine Ring', 'Turquoise Ring'}, -- MND +3
        Ring2 = {'Aquamarine Ring', 'Turquoise Ring'}, -- MND +3
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
    draginclude.OnLoad(sets, {'NoStaffSwap', 'StaffSwap'}, {'None', 'Field'});
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
        gFunc.LockStyle(sets.StyleLockGeneric);

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

    -- Forward slash toggle between NoStaffSwap and StaffSwap
    if draginclude.dragSettings.TpVariant == 1 then

        gFunc.EquipSet(sets.Default);
        
        -- Engaged Section
        if player.Status == 'Engaged' then
            gFunc.EquipSet(sets.MeleeEngaged);
        
        -- Resting Section
        elseif (player.Status == 'Resting') then
            if player.SubJob == 'BLM' then
                gFunc.EquipSet(sets.RestingMPBLM);
            else
                gFunc.EquipSet(sets.RestingMP);
            end
            
            if Settings.CurrentLevel >= 59 then
                gFunc.EquipSet(sets.VermillionCloak);
            end
        -- Idle Section
        else
            if Settings.CurrentLevel >= 59 then
                gFunc.EquipSet(sets.VermillionCloak);
            end
        end

    elseif draginclude.dragSettings.TpVariant == 2 then --StaffSwap
        gFunc.EquipSet(sets.Default);

        -- Resting Section
        if (player.Status == 'Resting') then
            gFunc.EquipSet(sets.Dark);

            if player.SubJob == 'BLM' then
                gFunc.EquipSet(sets.RestingMPBLM);
            else
                gFunc.EquipSet(sets.RestingMP);
            end

            if Settings.CurrentLevel >= 59 then
                gFunc.EquipSet(sets.VermillionCloak);
            end
        -- Idle Section
        else
            gFunc.EquipSet(sets.Earth);

            if Settings.CurrentLevel >= 59 then
                gFunc.EquipSet(sets.VermillionCloak);
            end
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

        -- Light Staff when in StaffMode
        if draginclude.dragSettings.TpVariant == 2 then
            gFunc.EquipSet(sets.Light);
        end
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

    if draginclude.dragSettings.TpVariant == 1 then
        -- Don't swap weapons
    elseif draginclude.dragSettings.TpVariant == 2 then
        if string.contains(spell.Name, 'Cure') or string.contains(spell.Name, 'Curaga') then
            gFunc.EquipSet(sets.RuckesRung);
        end
    end

    gFunc.EquipSet(sets.Precast);

    if string.contains(spell.Name, 'Cure') or string.contains(spell.Name, 'Curaga') then
        gFunc.EquipSet(sets.CurePrecast);
    end
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
            if string.contains(spell.Name, 'Regen') then
                gFunc.EquipSet(sets.RuckesRung);
            else
                gFunc.EquipSet(sets.Light);
            end
        elseif spell.Element == 'Dark' then
            gFunc.EquipSet(sets.Dark);
        end
    end

    if spell.Name == 'Invisible' then
        gFunc.EquipSet(sets.Invisible);
    elseif spell.Name == 'Sneak' then
        gFunc.EquipSet(sets.Sneak);
    elseif spell.Name == 'Stoneskin' then
        gFunc.EquipSet(sets.MNDEnhancingSkill);
    elseif string.contains(spell.Name, 'Spikes') then
        gFunc.EquipSet(sets.INT);
    elseif spell.Skill == 'Ninjutsu' then
        gFunc.EquipSet(sets.SpellHaste);
    elseif spell.Skill == 'Enfeebling Magic' and not string.contains(spell.Name, 'Dia' )then -- Dia and Dia II need zero gearswap
        if spell.Type == 'White Magic' then
            gFunc.EquipSet(sets.MNDEnfeeb);

            equipObiIfApplicable(spell.Element);
        elseif spell.Type == 'Black Magic' then
            gFunc.EquipSet(sets.INTEnfeeb);

            equipObiIfApplicable(spell.Element);
        end
    elseif spell.Skill == 'Enhancing Magic' then
        if spell.Name == 'Haste' then
            gFunc.EquipSet(sets.SpellHaste);
        elseif string.contains(spell.Name, 'Bar') or spell.Name == 'Phalanx' then -- Barspells need raw Enhancing Skill
            gFunc.EquipSet(sets.MNDEnhancingSkill);

        elseif string.contains(spell.Name, 'Regen') then -- Rucke's Rung
            gFunc.EquipSet(sets.Regen);
        end
    elseif spell.Skill == 'Healing Magic' then
    
        if string.contains(spell.Name, 'Cur') then
            gFunc.EquipSet(sets.MND);

            if player.HPP <= 75 then
                gFunc.EquipSet(sets.MedicineRing);
            end
        elseif not string.contains(string.lower(spell.Name), 'raise') then
            gFunc.EquipSet(sets.MND);
        else
            gFunc.EquipSet(sets.SpellHaste);
        end
    elseif spell.Skill == 'Elemental Magic' then
        if spell.Name == 'Drown' or spell.Name == 'Frost' or spell.Name == 'Choke' or spell.Name == 'Rasp' or spell.Name == 'Shock' or spell.Name == 'Burn' then
            gFunc.EquipSet(sets.INTElemental);
        else
            gFunc.EquipSet(sets.INTElemental);
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