local seal = T{};
local setTimer = false;
local timeToUse = 0;

ashita.events.register('text_in', 'FishAid2_HandleText', function (e)
    if (e.injected == true) then
        return;
    end

    local timestamp = os.time();

    if setTimer == true and timeToUse >= timestamp then
        timeToUse = 0;
        setTimer = false;
        AshitaCore:GetChatManager():QueueCommand(-1,'/tt custom "seal" 295s ');
    end

    if (string.match(e.message, 'You find a%seal%') ~= nil) then
        if setTimer == false then
            local timestamp = os.time();

            timeToUse = timestamp + 5;
            setTimer = true;
        end
    end
end);