local addonName, addon = ...
local eventFrame = _G.CreateFrame('frame')
local BAG_UPDATE_EVENT = "BAG_UPDATE"

local DEBUG = true

local frame = CreateFrame("Button", nil, UIParent, "SecureActionButtonTemplate")
frame:SetPoint("CENTER")
frame:SetSize(64, 64)

frame:RegisterForClicks("LeftButtonDown", "LeftButtonUp")
frame:SetAttribute("type", "macro")

frame.tex = frame:CreateTexture()
frame.tex:SetAllPoints(frame)
frame:Hide()

frame:RegisterEvent(BAG_UPDATE_EVENT)

frame:SetScript("OnEvent", function(self, event, ...)
    if event == BAG_UPDATE_EVENT then
        local bag_id = select(1, ...)
        print("Entering Bag:", bag_id)
        for i=1, C_Container.GetContainerNumSlots(bag_id) do
            
            local container_item_info = C_Container.GetContainerItemInfo(bag_id, i)
            if container_item_info then 
                print("Found info")
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
                    local macrotext = format("/s use %s", item_name)
                        frame:SetAttribute("macrotext", macrotext)
                        frame:SetNormalTexture(texture)
                    frame:Show()
                        
                        return true
                    --end
                end
            end
        end
    end
end)