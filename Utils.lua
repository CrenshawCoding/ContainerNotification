local _, addon = ...

local itemIsLocked = function(itemID)
    for _, value in ipairs(addon.lockedItems) do
        if itemID == value then
            return true
        end
    end
    return false
end

local itemIsWhitelisted = function (itemID)
    for _, value in ipairs(addon.whitelist) do
        if itemID == value then
            return true
        end
    end
    return false
end

local itemIsBlacklisted = function (itemID)
    return false
end

local containerItemIsOpenable = function(containerItemInfo)
    if containerItemInfo and containerItemInfo["itemID"] then
        local itemID = containerItemInfo["itemID"]
        return not itemIsLocked(itemID) and not itemIsBlacklisted(itemID) and (containerItemInfo["hasLoot"] or itemIsWhitelisted(itemID))
    end
end

-- Exports:
addon.itemIsLocked = itemIsLocked
addon.containerItemIsOpenable = containerItemIsOpenable