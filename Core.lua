local addonName, addon = ...
local BAG_UPDATE_EVENT = "BAG_UPDATE"

local DEBUG = false
local logLevelDebug = true

local eventFrame = CreateFrame("frame")
eventFrame:RegisterEvent(BAG_UPDATE_EVENT)

local foundItem = {}

local debug = function(text)
    if logLevelDebug then print("Debug: ", text) end
end


eventFrame:SetScript("OnEvent", function(self, event, ...)
    if not addon.moveMode and event == BAG_UPDATE_EVENT then
        local bagID = select(1, ...) -- Id of the bag in which a change occured
        for i=1, C_Container.GetContainerNumSlots(bagID) do
            local containerItemInfo = C_Container.GetContainerItemInfo(bagID, i)
            if containerItemInfo then
                local itemID = containerItemInfo["itemID"]
                --local is_whitelisted_item = aura_env.is_whitelisted_item(itemID)
                --if lootable or is_whitelisted_item then
                if addon.containerItemIsOpenable(containerItemInfo) or DEBUG then
                    
                    local texture = containerItemInfo["iconFileID"]
                    local itemName = C_Item.GetItemNameByID(itemID)
                    debug("Found openable " .. itemName)
                    --local is_lockbox = aura_env.is_locked_item(itemID)
                    --local is_ignored_item = aura_env.is_ignored_item(itemID)
                    
                    --if not is_lockbox and not is_ignored_item then
                    local macrotext = format("/use %s", itemName)
                    if not InCombatLockdown() then -- Cannot display Frame in combat
                        addon.updateContainerFrame(texture, itemName, macrotext)
                        addon.showContainerFrame()
                    else -- So display it when combat ends
                        local f = CreateFrame("frame")
                        f:RegisterEvent("PLAYER_REGEN_ENABLED")
                        f:SetScript("OnEvent", function(...) 
                            addon.updateContainerFrame(texture, itemName, macrotext)
                            addon.showContainerFrame()
                            f:UnRegisterEvent("PLAYER_REGEN_ENABLED")
                        end)
                    end
                    foundItem.bag_id = bagID
                    foundItem.slot = i
                    return
                    --end
                end
            end
        end
        -- Due to the BAG_UPDATE event firing twice, we have to make sure the second event doesn't override the first, 
        -- in case the first event finds an item and the second doesnt
        if foundItem.bag_id and foundItem.slot then
            if C_Container.GetContainerItemInfo(foundItem.bag_id, foundItem.slot) and
              not addon.containerItemIsOpenable(C_Container.GetContainerItemInfo(foundItem.bag_id, foundItem.slot)) then
                debug("hiding")
                addon.hideContainerFrame()
            end
        end
    end
end)