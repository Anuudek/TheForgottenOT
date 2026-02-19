local addTutor = TalkAction("/addtutor")

function addTutor.onSay(player, words, param)
    logCommand(player, words, param)

    if param == "" then
        player:sendCancelMessage("Player name param required.")
        return true
    end

    local split = param:split(",")
    local name = split[1]

    local targetPlayer = Player(name)
    if not targetPlayer then
        player:sendCancelMessage("Player " .. string.titleCase(name) .. " is not online.")
        return true
    end

    if targetPlayer:getAccountType() ~= ACCOUNT_TYPE_NORMAL or targetPlayer:getGroup():getId() ~= 1 then
        player:sendCancelMessage("You can only promote a normal player (Group 1) to a Tutor.")
        return true
    end

    targetPlayer:setAccountType(ACCOUNT_TYPE_TUTOR)
    targetPlayer:setGroup(Group(2))

    targetPlayer:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have been promoted to a Tutor by " .. player:getName() .. ".")
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have promoted " .. targetPlayer:getName() .. " to a Tutor.")
    targetPlayer:sendTextMessage(MESSAGE_STATUS, "Please relogin to update your permissions.")
    
    return true
end

addTutor:separator(" ")
addTutor:groupType("god")
addTutor:register()

local removeTutor = TalkAction("/removetutor")

function removeTutor.onSay(player, words, param)
    logCommand(player, words, param)

    if param == "" then
        player:sendCancelMessage("Player name param required.")
        return true
    end

    local split = param:split(",")
    local name = split[1]

    local targetPlayer = Player(name)
    if not targetPlayer then
        player:sendCancelMessage("Player " .. string.titleCase(name) .. " is not online.")
        return true
    end

    if targetPlayer:getAccountType() ~= ACCOUNT_TYPE_TUTOR then
        player:sendCancelMessage("This player is not a Tutor. Use /removeseniortutor if they are Senior.")
        return true
    end

    targetPlayer:setAccountType(ACCOUNT_TYPE_NORMAL)
    targetPlayer:setGroup(Group(1))

    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have demoted " .. targetPlayer:getName() .. " to a normal player.")
    targetPlayer:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have been demoted to a normal player.")
    targetPlayer:sendTextMessage(MESSAGE_STATUS, "Please relogin to update your permissions.")
    
    return true
end

removeTutor:separator(" ")
removeTutor:groupType("god")
removeTutor:register()

local addSeniorTutor = TalkAction("/addseniortutor")

function addSeniorTutor.onSay(player, words, param)
    logCommand(player, words, param)

    if param == "" then
        player:sendCancelMessage("Player name param required.")
        return true
    end

    local split = param:split(",")
    local name = split[1]

    local targetPlayer = Player(name)
    if not targetPlayer then
        player:sendCancelMessage("Player " .. string.titleCase(name) .. " is not online.")
        return true
    end

    if targetPlayer:getAccountType() == ACCOUNT_TYPE_SENIORTUTOR then
        player:sendCancelMessage("This player is already a Senior Tutor.")
        return true
    end

    if targetPlayer:getAccountType() ~= ACCOUNT_TYPE_TUTOR then
        player:sendCancelMessage("You can only promote a current Tutor to Senior Tutor. Use /addtutor first.")
        return true
    end

    targetPlayer:setAccountType(ACCOUNT_TYPE_SENIORTUTOR)
    targetPlayer:setGroup(Group(3))

    targetPlayer:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have been promoted to a Senior Tutor by " .. player:getName() .. ".")
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have promoted " .. targetPlayer:getName() .. " to a Senior Tutor.")
    targetPlayer:sendTextMessage(MESSAGE_STATUS, "Please relogin to update your permissions.")
    
    return true
end

addSeniorTutor:separator(" ")
addSeniorTutor:groupType("god")
addSeniorTutor:register()

local removeSeniorTutor = TalkAction("/removeseniortutor")

function removeSeniorTutor.onSay(player, words, param)
    logCommand(player, words, param)

    if param == "" then
        player:sendCancelMessage("Player name param required.")
        return true
    end

    local split = param:split(",")
    local name = split[1]

    local targetPlayer = Player(name)
    if not targetPlayer then
        player:sendCancelMessage("Player " .. string.titleCase(name) .. " is not online.")
        return true
    end

    if targetPlayer:getAccountType() ~= ACCOUNT_TYPE_SENIORTUTOR then
        player:sendCancelMessage("You can only demote a Senior Tutor with this command.")
        return true
    end

    targetPlayer:setAccountType(ACCOUNT_TYPE_TUTOR)
    targetPlayer:setGroup(Group(2))

    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have demoted " .. targetPlayer:getName() .. " to a Tutor.")
    targetPlayer:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have been demoted to a Tutor by " .. player:getName() .. ".")
    targetPlayer:sendTextMessage(MESSAGE_STATUS, "Please relogin to update your permissions.")
    
    return true
end

removeSeniorTutor:separator(" ")
removeSeniorTutor:groupType("god")
removeSeniorTutor:register()