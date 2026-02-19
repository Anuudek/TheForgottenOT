local vipGod = TalkAction("/vip")

local config = {
    minDays = 1, -- dias mínimos
    maxDays = 90, -- dias máximos
}

function vipGod.onSay(player, words, param)
    if not configManager.getBoolean(configKeys.VIP_SYSTEM_ENABLED) then
        player:sendCancelMessage("Vip System are not enabled!")
        return true
    end

    if param == "" then
        player:sendTextMessage(MESSAGE_LOOK, "Command invalid.\nUsage:\n/vip <action>, <name>, [, <value>]\n\nAvailable actions:\ncheck, adddays, removedays, remove")
        return true
    end

    logCommand(player, words, param)

    local params = param:split(",")
    
    local action = params[1] and params[1]:trim():lower() or nil
    local targetName = params[2] and params[2]:trim() or nil

    if not action or not targetName then
        player:sendTextMessage(MESSAGE_LOOK, "Command invalid.\nUsage:\n/vip <action>, <name>, [, <value>]")
        return true
    end

    local target = Player(targetName)
    if not target then
        player:sendTextMessage(MESSAGE_LOOK, string.format('Player "%s" is not online or does not exist!', targetName))
        return true
    end

    local targetVipDays = target:getVipDays()
    targetName = target:getName()

    if action == "check" then
        player:sendTextMessage(MESSAGE_STATUS, string.format('"%s" has %s VIP day(s) left.', targetName, (targetVipDays == 0xFFFF and "infinite" or targetVipDays)))
    elseif action == "adddays" then
        local amount = tonumber(params[3])
        if not amount or amount <= 0 then
            player:sendCancelMessage("<value> has to be a numeric value.")
            return true
        end

        if amount < config.minDays or amount > config.maxDays then
            player:sendTextMessage(MESSAGE_LOOK, string.format("You can only add %d to %d VIP days at a time.", config.minDays, config.maxDays))
            return true
        end

        target:addPremiumDays(amount)
        if target.onAddVip then target:onAddVip(amount) end 
        target:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
        player:sendTextMessage(MESSAGE_STATUS, string.format('"%s" received %d VIP day(s) and now has %d VIP day(s)', targetName, amount, target:getVipDays()))
    elseif action == "removedays" then
        local amount = tonumber(params[3])
        if not amount then
            player:sendTextMessage(MESSAGE_LOOK, "<value> has to be a numeric value.")
            return true
        end
        if amount > targetVipDays then
            target:removePremiumDays(targetVipDays)
            if target.onRemoveVip then target:onRemoveVip() end
            target:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
            player:sendTextMessage(MESSAGE_STATUS, string.format("You removed all VIP days from %s.", targetName))
        else
            target:removePremiumDays(amount)
            player:sendTextMessage(MESSAGE_STATUS, string.format("%s lost %s VIP day(s) and now has %s VIP day(s).", targetName, amount, target:getVipDays()))
        end
    elseif action == "remove" then
        target:removePremiumDays(targetVipDays)
        if target.onRemoveVip then target:onRemoveVip() end
        target:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
        player:sendTextMessage(MESSAGE_STATUS, string.format("You removed all VIP days from %s.", targetName))
    else
        player:sendTextMessage(MESSAGE_LOOK, "Action not found. Available: check, adddays, removedays, remove")
    end
    return true
end

vipGod:separator(" ")
vipGod:groupType("god")
vipGod:register()