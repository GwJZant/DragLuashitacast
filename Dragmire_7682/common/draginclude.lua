local draginclude = T{};
dragdisplay = gFunc.LoadFile('common\\dragdisplay.lua');
conquest = gFunc.LoadFile('common\\Conquest.lua');
local resourceManager = AshitaCore:GetResourceManager();
local inventoryManager = AshitaCore:GetMemoryManager():GetInventory();
local resources = AshitaCore:GetResourceManager();
local STORAGES = {
    [1] = { id=0, name='Inventory' },
    [2] = { id=1, name='Safe' },
    [3] = { id=2, name='Storage' },
    [4] = { id=3, name='Temporary' },
    [6] = { id=5, name='Satchel' },
    [9] = { id=8, name='Wardrobe' },
    [11]= { id=10, name='Wardrobe 2' },
};

local default_config =
{
    language    =   1
};

local config = default_config;

draginclude.sets = T{
    Pickaxe = { -- update with whatever gear you use for the Pickaxe item
        Body = 'Field Tunic',
        Hands = 'Field Gloves',
        Feet = 'Field Boots',
    },
    Fishing = { -- this set is meant as a default set for fishing, equip using /fishset
        Range = 'Comp. Fishing Rod',
        Ammo = 'Slice of Bluetail',
        Body = 'Angler\'s Tunica',
        Hands = 'Angler\'s Gloves',
        Legs = 'Angler\'s Hose',
        Feet = 'Angler\'s Boots',
    },
    Fishing2 = { -- this set is meant as a default set for fishing, equip using /fishset
        Range = 'Halcyon Rod',
        Ammo = 'Fly Lure',
        Body = 'Angler\'s Tunica',
        Hands = 'Angler\'s Gloves',
        Legs = 'Angler\'s Hose',
        Feet = 'Angler\'s Boots',
    },
    EXPRing = { -- Set to whatever EXP Ring you have
        Ring1 = 'Chariot Band',
    },
    ReraiseEarring = {
        Ear2 = 'Reraise Gorget',
    },
    ReraiseGorget = {
        Neck = 'Reraise Gorget',
    },
    Warp = { 
        Main = 'Warp Cudgel',
    },
    Tav = {
        Ring1 = 'Tavnazian Ring',
    },
    Field = { -- update with whatever gear you use for the Pickaxe item
        Body = 'Field Tunica',
        Hands = 'Field Gloves',
        Legs = 'Field Hose',
        Feet = 'Field Boots',
    },
};

draginclude.childSets = T{

};

draginclude.statusArmorSwapsDefault = T{
    OpoopoNecklace = false,
    PresidentialHairpin = true,
};

--Haven't verified all these names, I couldn't find/l a list in another lua file so I looked at screenshots and see they're all just the wiki name with no spaces, so that's what I used
draginclude.Towns = T{'Tavnazian Safehold','Al Zahbi','Aht Urhgan Whitegate','Nashmau','Southern San d\'Oria [S]','Bastok Markets [S]','Windurst Waters [S]','San d\'Oria-Jeuno Airship','Bastok-Jeuno Airship','Windurst-Jeuno Airship','Kazham-Jeuno Airship','Southern San d\'Oria','Northern San d\'Oria','Port San d\'Oria','Chateau d\'Oraguille','Bastok Mines','Bastok Markets','Port Bastok','Metalworks','Windurst Waters','Windurst Walls','Port Windurst','Windurst Woods','Heavens Tower','Ru\'Lude Gardens','Upper Jeuno','Lower Jeuno','Port Jeuno','Rabao','Selbina','Mhaura','Kazham','Norg','Mog Garden','Celennia Memorial Library','Western Adoulin','Eastern Adoulin'};
draginclude.JugPets = T{'HareFamiliar', 'SheepFamiliar', 'FlowerpotBill', 'TigerFamiliar', 'FlytrapFamiliar', 'LizardFamiliar', 'MayflyFamiliar', 'EftFamiliar', 'BeetleFamiliar', 'AntlionFamiliar', 'CrabFamiliar', 'MiteFamiliar', 'KeenearedSteffi', 'CourierCarrie', 'LullabyMelodia', 'FlowerpotBen', 'SaberSiravarde', 'FunguarFamiliar', 'ShellbusterOrob', 'ColdbloodComo', 'Homunculus', 'VoraciousAudrey', 'AmbusherAllie', 'PanzerGalahad', 'LifedrinkerLars', 'ChopsueyChucky', 'AmigoSabotender'};

-- Can use these with JugPetSettings so you don't have to delete and re-find move names
draginclude.JugPetConfig = {
    LullabyMelodia = {
        Name = 'LullabyMelodia',
        DefaultJug = 'S. Herbal Broth',
        DefaultSTA = 'Lamb Chop',
        DefaultAOE = 'Sheep Song',
        DefaultSpecial = 'Rage',
        DurationMinutes = 60,
    },
    CourierCarrie = {
        Name = 'CourierCarrie',
        DefaultJug = 'Fish Oil Broth',
        DefaultSTA = 'Big Scissors',
        DefaultAOE = 'Bubble Shower',
        DefaultSpecial = 'Scissor Guard',
        --DefaultSpecial = 'Bubble Curtain',
        DurationMinutes = 30,
    },
    CrabFamiliar = {
        Name = 'CrabFamiliar',
        DefaultJug = 'Fish Broth',
        DefaultSTA = 'Big Scissors',
        DefaultAOE = 'Bubble Shower',
        DefaultSpecial = 'Scissor Guard',
        --DefaultSpecial = 'Bubble Curtain',
        DurationMinutes = 30,
    },
    SaberSiravarde = {
        Name = 'SaberSiravarde',
        DefaultJug = 'W. Meat Broth',
        DefaultSTA = 'Razor Fang',
        DefaultAOE = 'Claw Cyclone',
        DefaultSpecial = 'Roar',
        DurationMinutes = 60,
    },
    SaberFamiliar = { --NQ Saber lv. 28
        Name = 'SaberFamiliar',
        DefaultJug = 'Meat Broth',
        DefaultSTA = 'Razor Fang',
        DefaultAOE = 'Claw Cyclone',
        DefaultSpecial = 'Roar',
        DurationMinutes = 60,
    },
    MiteFamiliar = { --NQ Diremite lv. 55
        Name = 'MiteFamiliar',
        DefaultJug = 'Blood Broth',
        DefaultSTA = 'Double Claw',
        DefaultAOE = 'Spinning Top',
        DefaultSpecial = 'Filamented Hold',
        DurationMinutes = 60,
    },
    KeenearedSteffi = {
        Name = 'KeenearedSteffi',
        DefaultJug = 'F. Carrot Broth',
        DefaultSTA = 'Foot Kick',
        DefaultAOE = 'Whirl Claws',
        DefaultSpecial = 'Dust Cloud',
        DurationMinutes = 90,
    },
    FunguarFamiliar = {
        Name = 'FunguarFamiliar',
        DefaultJug = 'Seedbed Soil',
        DefaultSTA = 'Frogkick',
        DefaultAOE = 'Silence Gas',
        DefaultSpecial = 'Dark Spore',
        DurationMinutes = 60,
    },
    FlowerpotBill = {
        Name = 'FlowerpotBill',
        DefaultJug = 'C. Carrion Broth',
        DefaultSTA = 'Head Butt',
        DefaultAOE = '',
        DefaultSpecial = 'Dream Flower',
        DurationMinutes = 60,
    },
    FlowerpotBen = {
        Name = 'FlowerpotBen',
        DefaultJug = 'C. Carrion Broth',
        DefaultSTA = 'Head Butt',
        DefaultAOE = '',
        DefaultSpecial = 'Dream Flower',
        DurationMinutes = 60,
    },
    ShellbusterOrob = {
        Name = 'ShellbusterOrob',
        DefaultJug = 'Q. Bug Broth',
        DefaultSTA = 'Venom',
        DefaultAOE = 'Cursed Sphere',
        DefaultSpecial = 'Venom',
        DurationMinutes = 60,
    },
    ColdbloodComo = {
        Name = 'ColdbloodComo',
        DefaultJug = 'C. Carrion Broth',
        DefaultSTA = 'Blockhead',
        DefaultAOE = 'Fireball',
        DefaultSpecial = 'Secretion',
        DurationMinutes = 60,
    },
    Homunculus = {
        Name = 'Homunculus',
        DefaultJug = 'C. Carrion Broth',
        DefaultSTA = 'Head Butt',
        DefaultAOE = '',
        DefaultSpecial = 'Dream Flower',
        DurationMinutes = 60,
    },
    VoraciousAudrey = {
        Name = 'VoraciousAudrey',
        DefaultJug = 'N. Grass. Broth',
        DefaultSTA = '',
        DefaultAOE = 'Soporific',
        DefaultSpecial = 'Gloeosuccus',
        DurationMinutes = 60,
    },
    AmbusherAllie = {
        Name = 'AmbusherAllie',
        DefaultJug = 'L. Mole Broth',
        DefaultSTA = 'Nimble Snap',
        DefaultAOE = 'Cyclotail',
        DefaultSpecial = 'Toxic Spit',
        DurationMinutes = 60,
    },
    PanzerGalahad = {
        Name = 'PanzerGalahad',
        DefaultJug = 'Scarlet Sap',
        DefaultSTA = 'Rhino Attack',
        DefaultAOE = 'Hi-Freq Field',
        DefaultSpecial = 'Rhino Guard',
        DurationMinutes = 60,
    },
    LifedrinkerLars = {
        Name = 'LifedrinkerLars',
        DefaultJug = 'C. Blood Broth',
        DefaultSTA = 'Double Claw',
        DefaultAOE = 'Spinning Top',
        DefaultSpecial = 'Filamented Hold',
        DurationMinutes = 60,
    },
    ChopsueyChucky = {
        Name = 'ChopsueyChucky',
        DefaultJug = 'F. Antica Broth',
        DefaultSTA = 'Mandibular Bite',
        DefaultAOE = 'Venom Spray',
        DefaultSpecial = 'Sandblast',
        DurationMinutes = 60,
    },
    AmigoSabotender = {
        Name = 'AmigoSabotender',
        DefaultJug = 'Sun Water',
        DefaultSTA = 'Needleshot',
        DefaultAOE = '',
        DefaultSpecial = '1000 Needles',
        DurationMinutes = 30,
    },
};

draginclude.dragSettings = {
    TpVariant = 1,
    SkillingVariant = 1,
    FishingVariant = 1,
    IsNude = false,
    RewardType = 'HP', -- HP/STATUS
};

draginclude.TpVariantTable = { -- cycle through with /lac fwd tpset
--    [1] = 'Default',
--    [2] = 'Evasion',
};

draginclude.SkillingVariantTable = { -- cycle through with /lac fwd tpset
--    [1] = 'None',
--    [2] = 'Field',
--    [3] = 'Fishing',
};

local skillToTorque = {
--    [1] = 'Faith Torque',
    [2] = 'Love Torque',
--    [3] = 'Fortitude Torque',
--    [4] = 'Prudence Torque',
    [5] = 'Temp. Torque',
--    [6] = 'Fortitude Torque',
--    [7] = 'Justice Torque',
    [8] = 'Love Torque',
--    [9] = 'Hope Torque',
--    [10] = 'Justice Torque',
--    [11] = 'Prudence Torque',
    [12] = 'Temp. Torque',
};

local virtueStoneWeapons = T{
    'Faith Baghnakhs',
    'Fortitude Axe',
    'Hope Staff',
    'Justice Sword',
    'Love Halberd',
    'Prudence Rod',
    'Temperance Axe',
};
    
local function GetSkill()
    local eq = gData.GetEquipment();

    if (eq.Main) then
        return eq.Main.Resource.Skill;
    end
end

--Used to see if a table has a value
local function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

--Used for counting instances of an item in a table
local function value_count (tab, val)
    local counter = 0;

    for index, value in ipairs(tab) do
        if value == val then
            counter = counter + 1;
        end
    end

    return counter;
end

--Checks if it is daytime
local function isDaytime()
    local time = gData.GetEnvironment().Time;
    return time > 7 and time < 17;
end

function draginclude.OnLoad(sets, tpVariantTable, skillingVariantTable)
    dragdisplay.Initialize:once(2);
    draginclude.SetNumpadCommands();
    gSettings.AllowAddSet = true;
    draginclude.childSets = sets;

    for k, v in pairs(tpVariantTable) do
        draginclude.TpVariantTable[k] = v;
        print('[' .. k .. ', ' .. v .. ']');
    end

    for k, v in pairs(skillingVariantTable) do
        draginclude.SkillingVariantTable[k] = v;
        print('[' .. k .. ', ' .. v .. ']');
    end
end

--Binds default custom commands
function draginclude.SetNumpadCommands()
    --send_command('bind ^f8 gs c cycle RewardMode') ctrl f8
    --send_command('bind !f8 gs c cycle CorrelationMode') alt f8
    -- Define forward slash command
    AshitaCore:GetChatManager():QueueCommand(-1,'/bind \\ /lac fwd TpVariant ');

    -- Define forward slash command
    AshitaCore:GetChatManager():QueueCommand(-1,'/bind @NUMPAD/ /lac fwd SkillingVariant ');
    AshitaCore:GetChatManager():QueueCommand(-1,'/alias /zoneinfo /lac fwd zoneinfo ');
    AshitaCore:GetChatManager():QueueCommand(-1,'/alias /relic /lac fwd relic ');
    AshitaCore:GetChatManager():QueueCommand(-1,'/alias /nude /lac fwd nude ');
    --AshitaCore:GetChatManager():QueueCommand(-1,'/bind @NUMPAD/ /lac fwd FishingVariant ');
end

function draginclude.OnUnload()
    dragdisplay.Unload();
    AshitaCore:GetChatManager():QueueCommand(-1,'/unbind 1');
    AshitaCore:GetChatManager():QueueCommand(-1,'/unbind 2');
    AshitaCore:GetChatManager():QueueCommand(-1,'/unbind 3');
    AshitaCore:GetChatManager():QueueCommand(-1,'/unbind 4');
    AshitaCore:GetChatManager():QueueCommand(-1,'/unbind 5');
    AshitaCore:GetChatManager():QueueCommand(-1,'/unbind 6');
    AshitaCore:GetChatManager():QueueCommand(-1,'/unbind 7');
    AshitaCore:GetChatManager():QueueCommand(-1,'/unbind 8');
    AshitaCore:GetChatManager():QueueCommand(-1,'/unbind 9');
    AshitaCore:GetChatManager():QueueCommand(-1,'/unbind 0');
    AshitaCore:GetChatManager():QueueCommand(-1,'/unbind @NUMPAD5');
    AshitaCore:GetChatManager():QueueCommand(-1,'/unbind @NUMPAD8');
    AshitaCore:GetChatManager():QueueCommand(-1,'/unbind @NUMPAD9');
end

--Processes various custom commands (mostly handled through numpad)
function draginclude.HandleCommand(args)
    local timestamp = os.time();

    -- If forward slash is pressed
    if (args[1] == 'TpVariant') then

        -- Iterate the set index by 1
        draginclude.dragSettings.TpVariant = draginclude.dragSettings.TpVariant + 1;

        -- If that index we made is out of bounds of the actual set (like if it's 4 but there's only 3)
        if (draginclude.dragSettings.TpVariant > #draginclude.TpVariantTable) then 

            -- Set it back to 1
            draginclude.dragSettings.TpVariant = 1;
        end

        gFunc.Message('Set: ' .. draginclude.TpVariantTable[draginclude.dragSettings.TpVariant]); --display the set
    elseif (args[1] == 'SkillingVariant') then

        -- Iterate the set index by 1
        draginclude.dragSettings.SkillingVariant = draginclude.dragSettings.SkillingVariant + 1;

        -- If that index we made is out of bounds of the actual set (like if it's 4 but there's only 3)
        if (draginclude.dragSettings.SkillingVariant > #draginclude.SkillingVariantTable) then

            -- Set it back to 1
            draginclude.dragSettings.SkillingVariant = 1;
        end

        gFunc.Message('Skilling Set: ' .. draginclude.SkillingVariantTable[draginclude.dragSettings.SkillingVariant]); --display the set
    elseif (args[1] == 'FishingVariant') then

        -- Iterate the set index by 1
        draginclude.dragSettings.FishingVariant = draginclude.dragSettings.FishingVariant + 1;

        -- If that index we made is out of bounds of the actual set (like if it's 4 but there's only 3)
        if (draginclude.dragSettings.FishingVariant > 2) then

            -- Set it back to 1
            draginclude.dragSettings.FishingVariant = 1;
        end

        gFunc.Message('Skilling Set: ' .. draginclude.SkillingVariantTable[draginclude.dragSettings.SkillingVariant]); --display the set
    elseif (args[1] == 'zoneinfo') then
        local zone = gData.GetEnvironment();
        local zoneId = AshitaCore:GetMemoryManager():GetParty():GetMemberZone(0);
        local message = zone.Area .. ' ' .. zoneId;

        if zoneId == 7 then -- Attohwa Chasm
            message = message .. ' | Citipati 3hr - Xolotl 21-24hr';
        elseif zoneId == 17 then -- Spire of Holla
            message = message .. ' | Vernal (Evasion) - Punctilious (Parrying) - Audacious (Divine) - Vivid (Healing) - Endearing (Singing)';
        elseif zoneId == 19 then -- Spire of Dem
            message = message .. ' | Violent (Buckler) - Painful (Dark) - Timorous (Enfeebling) - Brilliant (Summoning) - Venerable (String)';
        elseif zoneId == 21 then -- Spire of Mea
            message = message .. ' | Solemn (Guarding) - Valiant (Augmenting) - Pretentious (Elemental) - Malicious (Ninjutsu) - Pristine (Wind)';
        elseif zoneId == 25 then -- Misareaux Coast
            message = message .. ' | Odqan 2-5hr (Foggy weather: 02:00-07:00)';
        elseif zoneId == 145 then -- Giddeus
            message = message .. ' | Vuu Puqu 0h - Hoo Mjuu 1hr [8m repops]';
        elseif zoneId == 149 then -- Davoi
            message = message .. ' | Poisonhand Gnadgad 1hr [16m repops]';
        elseif zoneId == 151 then -- Castle Oztroja
            message = message .. ' | Mee Deggi 50m {10%} - Quu Domi 1hr {10%} [16m repops]';

            --MEE_DEGGI_THE_PUNISHER_PH  = OKOTE
            --{ Interrogator/Drummer
            --    [17395798] = 17395800, -- -207.840 -0.498 109.939
            --    [17395799] = 17395800, -- -227.415 -4.340 145.213
            --};
            --QUU_DOMI_THE_GALLANT_PH    = FUMAS
            --{ Herald (Northwest?) or Oracle (West)
            --    [17395868] = 17395870, -- 35.847 -0.500 -101.685
            --    [17395867] = 17395870, -- 59.000 -4.000 -131.000
            --};
        elseif zoneId == 159 then -- Temple of Uggalepih
            message = message .. ' | Sozu Sarberry 1hr {10%}';
        elseif zoneId == 176 then -- Sea Serpent Grotto
            message = message .. ' | Sea Hog 1hr {10%} - Wuur 2hr {10%} - Masan 4hr {10%} [16m repops]';
        elseif zoneId == 220 then -- Ship to Selbina
            message = message .. ' - No Pirates';
        elseif zoneId == 221 then -- Ship to Mhaura
            message = message .. ' - No Pirates';
        elseif zoneId == 227 then  -- Ship to Selbina Pirates
            message = message .. ' - Pirates!';
        elseif zoneId == 228 then -- Ship to Mhaura Pirates
            message = message .. ' - Pirates!';
        end

        gFunc.Message(message);
    elseif (args[1] == 'targetinfo') then
        local target = gData.GetTarget();

        gFunc.Message(target.Type);
    elseif (args[1] == 'relic') then
        draginclude.RelicCheck();
    elseif (args[1] == 'nude') then
        if draginclude.dragSettings.IsNude then
            gFunc.Message('Not nude');

            for i = 5,16,1 do
                gState.Disabled[i] = false;
            end

            draginclude.dragSettings.IsNude = false;
        else
            gFunc.Message('Nude');

            for i = 5,16,1 do
                if i ~= 10 then -- 10 = neck
                    gEquip.UnequipSlot(i);
                    gState.Disabled[i] = true;
                end
            end

            draginclude.dragSettings.IsNude = true;
        end
        
    end
end

function draginclude.HandleBstCoreCommands(args, defaultJug)
    if (args[1] == 'PetAtk') then
        AshitaCore:GetChatManager():QueueCommand(1, '/ja "Fight" <t>');
    elseif (args[1] == 'Charm') then
        AshitaCore:GetChatManager():QueueCommand(1, '/ja "Charm" <stnpc>');
    elseif (args[1] == 'CallBeast') then
        AshitaCore:GetChatManager():QueueCommand(1, '/ja "Call Beast" <me>');
    elseif (args[1] == 'PetSTA') then
        local pet = gData.GetPet();
        local jugPet = false;

        for a, b in pairs(draginclude.JugPets) do
            if (b == pet.Name) then
                jugPet = true;
            end
        end

        if jugPet == true then
            AshitaCore:GetChatManager():QueueCommand(1, '/ja "' .. defaultJug.DefaultSTA .. '" <me>');
        else
            gFunc.Message('Sic');
            AshitaCore:GetChatManager():QueueCommand(1, '/pet "Sic" <me>');
        end
    elseif (args[1] == 'PetAOE') then
        local pet = gData.GetPet();
        local jugPet = false;

        for a, b in pairs(draginclude.JugPets) do
            if (b == pet.Name) then
                jugPet = true;
            end
        end

        if jugPet == true then
            AshitaCore:GetChatManager():QueueCommand(1, '/ja "' .. defaultJug.DefaultAOE .. '" <me>');
        else
            gFunc.Message('Not a Jug');
        end
    elseif (args[1] == 'PetSpec') then
        local pet = gData.GetPet();
        local jugPet = false;

        for a, b in pairs(draginclude.JugPets) do
            if (b == pet.Name) then
                jugPet = true;
            end
        end

        if jugPet == true then
            AshitaCore:GetChatManager():QueueCommand(1, '/ja "' .. defaultJug.DefaultSpecial .. '" <me>');
        else
            gFunc.Message('Not a Jug');
        end
    elseif (args[1] == 'Stay') then
        AshitaCore:GetChatManager():QueueCommand(1, '/ja "Stay" <me>');
    elseif (args[1] == 'Heel') then
        AshitaCore:GetChatManager():QueueCommand(1, '/ja "Heel" <me>');
    elseif (args[1] == 'Reward') then
        AshitaCore:GetChatManager():QueueCommand(1, '/ja "Reward" <me>');
    elseif (args[1] == 'RewardSTATUS') then
        draginclude.dragSettings.RewardType = 'STATUS';
        AshitaCore:GetChatManager():QueueCommand(1, '/ja "Reward" <me>');
    elseif (args[1] == 'RewardHP') then
        draginclude.dragSettings.RewardType = 'HP';
        AshitaCore:GetChatManager():QueueCommand(1, '/ja "Reward" <me>');
    end
end

function draginclude.HandleDrgCoreCommands(args)
    if (args[1] == 'Jump') then
        AshitaCore:GetChatManager():QueueCommand(1, '/ja "Jump" <t>');
    elseif (args[1] == 'HighJump') then
        AshitaCore:GetChatManager():QueueCommand(1, '/ja "High Jump" <t>');
    elseif (args[1] == 'SuperJump') then
        AshitaCore:GetChatManager():QueueCommand(1, '/ja "Super Jump" <t>');
    elseif (args[1] == 'CallWyvern') then
        AshitaCore:GetChatManager():QueueCommand(1, '/ja "Call Wyvern" <me>');
    elseif (args[1] == 'SpiritLink') then
        AshitaCore:GetChatManager():QueueCommand(1, '/ja "Spirit Link" <me>');
    elseif (args[1] == 'SteadyWing') then
        AshitaCore:GetChatManager():QueueCommand(1, '/pet "Steady Wing" <me>');
    end
end

--Iterates all valid items, passing them through the items table
function draginclude.CheckItems()
    local items = {};
    for _,container in ipairs(gSettings.EquipBags) do
        local available = gData.GetContainerAvailable(container);
        if (available == true) then
            local max = gData.GetContainerMax(container);
            for index = 1,max,1 do
                local containerItem = inventoryManager:GetContainerItem(container, index);
                local item = resourceManager:GetItemById(containerItem.Id);
                if containerItem ~= nil and containerItem.Count > 0 and containerItem.Id > 0 then
                    table.insert(items, item.Name[1]);
                end
            end
        end
    end

    return items;
end

local function find(item, cleanString, useDescription)
    if (item == nil) then return false end;
    if (cleanString == nil) then return false end;

    if (string.lower(item.Name[config.language]):contains(cleanString)) then
        return true;
    elseif (item.LogNameSingular[config.language] ~= nil and string.lower(item.LogNameSingular[config.language]):contains(cleanString)) then
        return true;
    elseif (item.LogNamePlural[config.language] ~= nil and string.lower(item.LogNamePlural[config.language]):contains(cleanString)) then
        return true;
    elseif (useDescription and item.Description ~= nil and item.Description[config.language] ~= nil) then
        return (string.lower(item.Description[config.language]):contains(cleanString));
    end

    return false;
end

local function getStorage(storageIndex)
    return STORAGES[storageIndex].id, STORAGES[storageIndex].name;
end

function draginclude.CheckItemSpecific(name)
    local found = { };
    local result = { };
    local storageSlips = { };
    local total = 0;

    for k,v in ipairs(STORAGES) do
        local foundCount = 1;
        for j = 0, inventoryManager:GetContainerCountMax(v.id), 1 do
            local itemEntry = inventoryManager:GetContainerItem(v.id, j);
            if (itemEntry.Id ~= 0 and itemEntry.Id ~= 65535) then
                local item = resources:GetItemById(itemEntry.Id);

                if (item ~= nil) then
                    if item.Name[config.language] == name then
                        quantity = 1;
                        if (itemEntry.Count ~= nil and item.StackSize > 1) then
                            quantity = itemEntry.Count;
                        end

                        if result[k] == nil then
                            result[k] = { };
                            found[k] = { };
                        end

                        if found[k][itemEntry.Id] == nil then
                            found[k][itemEntry.Id] = foundCount;
                            result[k][foundCount] = { name = item.Name[config.language], count = 0 };
                            foundCount = foundCount + 1;
                        end

                        result[k][found[k][itemEntry.Id]].count = result[k][found[k][itemEntry.Id]].count + quantity;
    
                        if find(item, 'storage slip ', false) then
                            storageSlips[#storageSlips + 1] = {item, itemEntry};
                        end
                    end
                end
            end
        end
    end

    for k,v in ipairs(STORAGES) do
        if result[k] ~= nil then
            storageID, storageName = getStorage(k);
            for _,item in ipairs(result[k]) do
                quantity = '';
                if item.count > 1 then
                    quantity = string.format('[%d]', item.count)
                end
                --printf('%s: %s %s', storageName, item.name, quantity);
                total = total + item.count;
            end
        end
    end

    return total;
end

function draginclude.RelicCheck()
    local byneCount = 0;
    local pieceCount = 0;
    local shellCount = 0;

    local redeemedByneCount = 1600; -- Stage 3
    local redeemedPieceCount = 0;
    local redeemedShellCount = 400; -- Stage 2

    local requiredByneCount = 1600;
    local requiredPieceCount = 6100;
    local requiredShellCount = 10400;

    byneCount = byneCount + (100 * draginclude.CheckItemSpecific('100 Byne Bill'));
    byneCount = byneCount + draginclude.CheckItemSpecific('1 Byne Bill');
    pieceCount = pieceCount + (100 * draginclude.CheckItemSpecific('M. Silverpiece'));
    pieceCount = pieceCount + draginclude.CheckItemSpecific('O. Bronzepiece');
    shellCount = shellCount + (100 * draginclude.CheckItemSpecific('L. Jadeshell'));
    shellCount = shellCount + draginclude.CheckItemSpecific('T. Whiteshell');

    gFunc.Message('bynes: [' .. byneCount +  redeemedByneCount .. '/' .. requiredByneCount .. '] | coins: [' .. pieceCount + redeemedPieceCount .. '/' .. requiredPieceCount .. '] | shells: [' .. shellCount + redeemedShellCount .. '/' .. requiredShellCount .. ']');
end

--Equips Opo-Opo necklace when level is > 61 and player is asleep
local function CheckEquipOpoOpoNecklace(level, asleep, items)
    if asleep == true and level >= 61 and  has_value(items, 'Opo-opo Necklace') then
        gFunc.Equip('Neck', 'Opo-opo Necklace');
    end
end

--Equips Presidential Hairpin when level is >= 65
local function CheckEquipPresidentialHairpin(level, items)
    local player = gData.GetPlayer();

    if level >= 65 and has_value(items, 'President. Hairpin') and player.HPP < 98 and conquest:GetOutsideControl() == true then
        gFunc.Equip('Head', 'President. Hairpin');
    end
end

-- Put at the end of your job's HandleDefault
function draginclude.HandleDefault(settings)
    draginclude.CheckAketon();
    draginclude.CheckVirtueStone();
    dragdisplay.Update(settings);
end

function draginclude.CheckVirtueStone()
    local player = gData.GetPlayer();
    local mainWeapon = gData.GetEquipment().Main;
    local subWeapon = gData.GetEquipment().Sub;

    if player.Status == 'Engaged' and mainWeapon then
        if virtueStoneWeapons:contains(mainWeapon.Name) then
            gFunc.Equip('Ammo', 'Virtue Stone');
        elseif subWeapon then
            if virtueStoneWeapons:contains(subWeapon.Name) then
                gFunc.Equip('Ammo', 'Virtue Stone');
            end
        end
    end
end

function draginclude.CheckTorque()
    local player = gData.GetPlayer();
    local skill = GetSkill();
    local torque = skillToTorque[skill];

    if player.Status == 'Engaged' then
        if torque then
            if player.MainJobLevel >= 73 then
                gFunc.Equip('Neck', torque);
            end
        end
    end
end

function draginclude.CheckRangeTorque()
    local player = gData.GetPlayer();
    local skill = GetRangedSkill();
    local torque = skillToTorque[skill];

    if player.Status == 'Engaged' then
        if torque then
            if player.MainJobLevel >= 73 then
                gFunc.Equip('Neck', torque);
            end
        end
    end
end

function draginclude.CheckAketon()
    local zone = gData.GetEnvironment();

    if (string.contains(zone.Area, 'Bastok') or string.contains(zone.Area, 'Metalworks')) and not string.contains(zone.Area, 'Dynamis') then
        gFunc.Equip('Body', 'Republic Aketon');
    end
end

function draginclude.CheckSkillingVariant()

    if draginclude.SkillingVariantTable[draginclude.dragSettings.SkillingVariant] == 'Field' then
        if draginclude.childSets.Field ~= nil then
            gFunc.EquipSet(draginclude.childSets.Field);
        else
            gFunc.EquipSet(draginclude.sets.Field);
        end

    elseif draginclude.SkillingVariantTable[draginclude.dragSettings.SkillingVariant] == 'Fishing' then
        if draginclude.childSets.Field ~= nil then
            if draginclude.dragSettings.FishingVariant == 1 then
                gFunc.EquipSet(draginclude.childSets.Fishing);
            elseif draginclude.dragSettings.FishingVariant == 2 then
                gFunc.EquipSet(draginclude.childSets.Fishing2);
            end
        else
            if draginclude.dragSettings.FishingVariant == 1 then
                gFunc.EquipSet(draginclude.sets.Fishing);
            elseif draginclude.dragSettings.FishingVariant == 2 then
                gFunc.EquipSet(draginclude.sets.Fishing2);
            end
        end
    end
end

function draginclude.CheckStatusArmorSwaps(StatusArmorSwapSettings, level)
    local buffs = AshitaCore:GetMemoryManager():GetPlayer():GetBuffs();
    local player = gData.GetPlayer();
    local asleep = false;
    local paralyzed = false;
    local blinded = false;
    local songBuffActive = false;
    local items = draginclude.CheckItems();

    if StatusArmorSwapSettings == nil then
        StatusArmorSwapSettings = draginclude.statusArmorSwapsDefault;
    end

    -- Song buffs have IDs between 195 and 222: https://github.com/Windower/Resources/blob/master/resources_data/buffs.lua
    for _,buff in ipairs(buffs) do
        if (buff >= 195 and buff <= 222) then
            songBuffActive = true;
        elseif (buff == 2) then
            asleep = true;
        end
    end

    if player.Status == 'Engaged' then
        if StatusArmorSwapSettings.OpoopoNecklace == true then
            CheckEquipOpoOpoNecklace(level, asleep, items);
        end
	--Resting Section
    elseif (player.Status == 'Resting') then

        if StatusArmorSwapSettings.OpoopoNecklace == true then
            CheckEquipOpoOpoNecklace(level, asleep, items);
        end

        if StatusArmorSwapSettings.PresidentialHairpin == true then
            CheckEquipPresidentialHairpin(level, items);
        end

	--Idle Section
	else

        if StatusArmorSwapSettings.OpoopoNecklace == true then
            CheckEquipOpoOpoNecklace(level, asleep, items);
        end

        if StatusArmorSwapSettings.PresidentialHairpin == true then
            CheckEquipPresidentialHairpin(level, items);
        end
    end
end

--Marks cooldown tracking when using specified abilities
function draginclude.HandleAbility(ability);
    --local timestamp = os.time();
end

function draginclude.HandleWeaponSkill(weaponSkill)
    AshitaCore:GetChatManager():QueueCommand(1, '/p WS Used: «' .. weaponSkill.Name .. '»');
end

function draginclude.HandleItem(item)

end

return draginclude;