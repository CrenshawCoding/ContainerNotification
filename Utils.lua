local _, addon = ...

local tableContains = function(table, item)
    for _, value in ipairs(table) do
        if item == value then
            return true
        end
    end
    return false
end

local mergeTables = function(a, b)
    for _, value in ipairs(b) do
        table.insert(a, b)
    end
    return false
end



-- Exports:
addon.tableContains = tableContains
addon.mergeTables = mergeTables