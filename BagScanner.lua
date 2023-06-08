local _, addon = ...

local itemIsLocked = function(itemID)
    return addon.tableContains(addon.lockedItems, itemID)
end

local itemIsWhitelisted = function (itemID)
    return addon.tableContains(addon.whitelist, itemID)
end

local itemIsBlacklisted = function (itemID)
    return addon.tableContains(addon.blacklist, itemID)
end

local containerItemIsOpenable = function(containerItemInfo)
    if containerItemInfo and containerItemInfo["itemID"] then
        local itemID = containerItemInfo["itemID"]
        return not itemIsLocked(itemID) and not itemIsBlacklisted(itemID) and (containerItemInfo["hasLoot"] or itemIsWhitelisted(itemID))
    end
end

local getLootableBagItems = function()
    local lootableBagItems = {}
    for i=0, 4 do
        mergeTables(lootableBagItems, getLootableBagItemsByBagID(i))
    end
    return lootableBagItems
end

-- Creates a table with entries of {itemInfo, bagID, bagSlot} for every lootable item in the bag 
local getLootableBagItemsByBagID = function(bagID)
    local lootableBagItems = {}
    for i=1, C_Container.GetContainerNumSlots(bagID) do
        local containerItemInfo = C_Container.GetContainerItemInfo(bagID, i)
        if containerItemInfo then
            if containerItemIsOpenable(containerItemInfo) then
                table.insert(lootableBagItems, {itemInfo=containerItemInfo, bagID=bagID, bagSlot=i})
            end
        end
    end
    return lootableBagItems
end


-- Exports:
addon.getLootableBagItems = getLootableBagItems
addon.getLootableBagItemsByBagID = getLootableBagItemsByBagID
