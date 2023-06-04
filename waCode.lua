function()
    for i=0, 4 do 
        for j=1, C_Container.GetContainerNumSlots(i) do
            local container_item_info = C_Container.GetContainerItemInfo(i,j)
            if container_item_info then 
                local lootable = container_item_info["hasLoot"]
                local itemID = container_item_info["itemID"]
                local is_whitelisted_item = aura_env.is_whitelisted_item(itemID)
                if lootable or is_whitelisted_item then
                    local texture = container_item_info["iconFileID"]
                    
                    aura_env.item_name = C_Item.GetItemNameByID(itemID)
                    aura_env.item_texture = texture
                    
                    local is_lockbox = aura_env.is_locked_item(itemID)
                    local is_ignored_item = aura_env.is_ignored_item(itemID)
                    
                    if not is_lockbox and not is_ignored_item then
                        local macrotext = format("/use %s", aura_env.item_name)
                        aura_env.clickableFrame:SetAttribute("macrotext", macrotext)
                        aura_env.clickableFrame:SetNormalTexture(texture)
                        return true
                    end
                end
            end
        end
    end
    return false
end

function()
    for i=0, 4 do 
        for j=1, C_Container.GetContainerNumSlots(i) do
            local container_item_info = C_Container.GetContainerItemInfo(i,j)
            if container_item_info then
                local itemID = container_item_info["itemID"]
                local is_ignored_item = aura_env.is_ignored_item(itemID)
                local is_whitelisted_item = aura_env.is_whitelisted_item(itemID)
                local is_locked_item = aura_env.is_locked_item(itemID)
                local lootable = container_item_info["hasLoot"]
                if (lootable or is_whitelisted_item) and not is_ignored_item and not is_locked_item then
                    return false
                end
            end
        end
    end
    return true
end

function()
    local name = aura_env.item_name
    if not name then return name end
    --[[
    if strlen(name) > 10 then
        return strsub(name, 0, 10) .. "..."
    else
        return name
    end
]]--
    -- This returns a new_name, which is the old name but the whitespaces are replaced
    -- with line breaks when the line is too long
    local new_name = ""
    local line_counter = 0
    for i=0, strlen(name) do
        local cur_char = strsub(name, i, i)
        if cur_char == "\n" then
            line_counter = 0
        elseif cur_char == " " then
            if line_counter > 10 then
                line_counter = 0
                new_name = new_name.."\n"
            else
                new_name = new_name..cur_char
            end
        else 
            new_name = new_name..cur_char
            line_counter = line_counter + 1
        end
    end
    return new_name
end

if not aura_env.clickableFrame then
    local r = aura_env.region
    aura_env.clickableFrame = CreateFrame("Button", "container_button", r, "SecureActionButtonTemplate")  
end

aura_env.clickableFrame:SetAllPoints()
aura_env.clickableFrame:RegisterForClicks("LeftButtonDown", "LeftButtonUp")
aura_env.clickableFrame:SetAttribute("type", "macro")

aura_env.lockbox_spell = nil
local _, class = UnitClass("player")
local _,_, race = UnitRace("player")
if class == "ROGUE" then
    aura_env.lockbox_spell = 1804 --Pick Lock
elseif race == 37 then --Mechagnome
    aura_env.lockbox_spell = 312890 -- Skeleton Pinkie
end


-- List of items that require lockpicking:
aura_env.locked_items = {
    180522, --phaedrum-lockbox
    180532, --oxxein-lockbox
    180533, --solenium-lockbox
    179311, --synvir-lockbox
    169475, --barnacled-lockbox
    43624, --titanium-lockbox
    45986, --tiny-titanium-lockbox
    31952, --khorium-lockbox
    88567, --ghost-iron-lockbox
    68729, --elementium-lockbox
    4636, --strong-iron-lockbox
    121331, --leystone-lockbox
    4637, --steel-lockbox
    5760, --eternium-lockbox
    116920, --true-steel-lockbox
    4633, --heavy-bronze-lockbox
    4638, --reinforced-steel-lockbox
    5759, --thorium-lockbox
    4634, --iron-lockbox
    43622, --froststeel-lockbox
    186161, --stygian-lockbox
    5758, --mithril-lockbox
    4632, --ornate-bronze-lockbox
    -- custom stuff:
    187351, --Stygic Cluster
    198657 -- forgotten-jewelry-box
    
}

local function trim(s)
    return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end

if aura_env.config["ignored_items"] then
    local ignored_items_raw = {strsplit(',', aura_env.config["ignored_items"])}
    if not aura_env.ignored_items then
        aura_env.ignored_items = {}
    end
    for _, item_id in ipairs(ignored_items_raw) do
        local trimmed_id = trim(item_id)
        table.insert(aura_env.ignored_items, tonumber(trimmed_id))
    end
end

if aura_env.config["whitelisted_items"] then
    local whitelisted_items_raw = {strsplit(',', aura_env.config["whitelisted_items"])}
    if not aura_env.whitelisted_items then
        aura_env.whitelisted_items = {}
    end
    for _, item_id in ipairs(whitelisted_items_raw) do
        local trimmed_id = trim(item_id)
        table.insert(aura_env.whitelisted_items, tonumber(trimmed_id))
    end
end 

aura_env.is_ignored_item = function(itemID) 
    for _, value in ipairs(aura_env.ignored_items) do
        if itemID == value then
            return true
        end
    end
    return false
end

aura_env.is_whitelisted_item = function(itemID) 
    for _, value in ipairs(aura_env.whitelisted_items) do
        if itemID == value then
            return true
        end
    end
    return false
end

aura_env.is_locked_item = function(itemID)
    -- Is it a lockbox? (e.g. Mithril Lockbox)
    for _, value in ipairs(aura_env.locked_items) do
        if itemID == value then
            return true
        end
    end
    return false
end


