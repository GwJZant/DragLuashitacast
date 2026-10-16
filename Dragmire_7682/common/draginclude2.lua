local draginclude2 = T{};

draginclude2.dragSettings = {
	CurrentLevel = 0,
	Hybrid = false, -- Controls if PDTHybrid or PDT sets are used
	PDT = false,
	MDT = false,
	Mandy = false,
	Tav = false,
	Treat = false,
};

draginclude2.sets = T{
	PDTHybrid_Priority = { -- PDT -5%, MDT -3%
		Ear1 = {'Merman\'s Earring'}, -- MDT -2%
		Ear2 = {'Merman\'s Earring'}, -- MDT -2%
		Ring1 = {'Merman\'s Ring'}, -- MDT -4%
		Ring2 = {'Jelly Ring'}, -- PDT -5%, MDT +5%
	},
	
	PDT_Priority = { -- PDT -5%
		Ring2 = {'Jelly Ring'}, -- PDT -5%
	},
	
	MDT_Priority = { -- MDT -12%
		Ear1 = {'Merman\'s Earring'}, -- MDT -2%
		Ear2 = {'Merman\'s Earring'}, -- MDT -2%
		Ring1 = {'Merman\'s Ring'}, -- MDT -4%
		Ring2 = {'Merman\'s Ring'}, -- MDT -4%
	},
	
	TreatStaff = {
		Main = 'Treat Staff II',
	},
	
	TavRing = {
		Ring2 = 'Tavnazian Ring',
	},
	
	MandySuit = {
		Body = 'Mandra. Suit',
		Legs = 'displaced',
		Feet = 'displaced',
	},
};

function draginclude2.OnLoad()
    AshitaCore:GetChatManager():QueueCommand(-1,'/alias /mdt /lac fwd MDT');
    AshitaCore:GetChatManager():QueueCommand(-1,'/alias /pdt /lac fwd PDT');
    AshitaCore:GetChatManager():QueueCommand(-1,'/alias /mandy /lac fwd Mandy');
    AshitaCore:GetChatManager():QueueCommand(-1,'/alias /tav /lac fwd Tav');
    AshitaCore:GetChatManager():QueueCommand(-1,'/alias /treat /lac fwd Treat');
    AshitaCore:GetChatManager():QueueCommand(-1,'/alias /hybrid /lac fwd Hybrid');
end

function draginclude2.HandleCommand(args)
	if args[1] == 'MDT' then
        draginclude2.dragSettings.MDT = not Settings.MDT;

        gFunc.Message('MDT ' .. tostring(Settings.MDT));
	elseif args[1] == 'PDT' then
        draginclude2.dragSettings.PDT = not Settings.PDT;

        gFunc.Message('PDT ' .. tostring(Settings.PDT));
	elseif args[1] == 'Hybrid' then
        draginclude2.dragSettings.Hybrid = not Settings.Hybrid;

        gFunc.Message('Hybrid ' .. tostring(Settings.Hybrid));
	elseif args[1] == 'Mandy' then
        draginclude2.dragSettings.Mandy = not Settings.Mandy;

        gFunc.Message('Mandy ' .. tostring(Settings.Mandy));
	elseif args[1] == 'Tav' then
        draginclude2.dragSettings.Tav = not Settings.Tav;

        gFunc.Message('Tav ' .. tostring(Settings.Tav));
	elseif args[1] == 'Treat' then
        draginclude2.dragSettings.Treat = not Settings.Treat;

        gFunc.Message('Treat ' .. tostring(Settings.Treat));
	end
end

function draginclude2.HandlePrioritySets(jobSets)
	local myLevel = AshitaCore:GetMemoryManager():GetPlayer():GetMainJobLevel();

    -- Determining current level for Priority EquipSet purposes
    if (myLevel ~= draginclude2.dragSettings.CurrentLevel) then
        gFunc.EvaluateLevels(draginclude2.sets, myLevel);
		
		-- This logic adds all job sets to draginclude2.sets and overwrites existing sets
		-- This avoids repeated checks in HandleDefault
		if jobSets then
            for setName, setContent in pairs(jobSets) do
                draginclude2.sets[setName] = setContent;
            end
        end
		
        draginclude2.dragSettings.CurrentLevel = myLevel;
    end
end

function draginclude2.HandleDefault(jobSets)
	if draginclude2.dragSettings.MDT then
		gFunc.EquipSet(draginclude2.sets.MDT);
	elseif draginclude2.dragSettings.PDT then
		if draginclude2.dragSettings.Hybrid then
			gFunc.EquipSet(draginclude2.sets.PDTHybrid);
		else		
			gFunc.EquipSet(draginclude2.sets.PDT);
		end
	end
	
	if draginclude2.dragSettings.Mandy then
		gFunc.EquipSet(draginclude2.sets.MandySuit);
	end

	if draginclude2.dragSettings.Tav then
		gFunc.EquipSet(draginclude2.sets.TavRing);
	end

	if draginclude2.dragSettings.Treat then
		gFunc.EquipSet(draginclude2.sets.TreatStaff);
	end
end
