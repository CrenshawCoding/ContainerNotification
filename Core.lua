local addonName, addon = ...
local BAG_UPDATE_EVENT = "BAG_UPDATE"

local DEBUG = true

addon.lootFrame:RegisterEvent(BAG_UPDATE_EVENT)

addon.lootFrame:SetScript("OnEvent", function(self, event, ...)
    if not addon.moveMode and event == BAG_UPDATE_EVENT then
        local bag_id = select(1, ...) -- Id of the bag in which a change occured
        for i=1, C_Container.GetContainerNumSlots(bag_id) do
            local container_item_info = C_Container.GetContainerItemInfo(bag_id, i)
            if container_item_info then
                local lootable = container_item_info["hasLoot"]
                local itemID = container_item_info["itemID"]
                --local is_whitelisted_item = aura_env.is_whitelisted_item(itemID)
                --if lootable or is_whitelisted_item then
                if lootable or DEBUG then
                    local texture = container_item_info["iconFileID"]
                    local item_name = C_Item.GetItemNameByID(itemID)
                    
                    --local is_lockbox = aura_env.is_locked_item(itemID)
                    --local is_ignored_item = aura_env.is_ignored_item(itemID)
                    
                    --if not is_lockbox and not is_ignored_item then
                    local macrotext = format("/use %s", item_name)
                    addon.updateContainerFrame(texture, item_name, macrotext)
                    addon.showContainerFrame()
                    return
                    --end
                end
            end
        end
        addon.hideContainerFrame()
    end
end)