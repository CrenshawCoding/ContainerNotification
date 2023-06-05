local addonName, addon = ...

local slashHelpText = 'Available commands:\n/cn move: toggles frame movability.'
local movable = false

local function handler(msg, editBox)
    if msg == 'move' then
        movable = not movable
        if movable then
            addon.makeContainerFrameMovable(addon.lootFrame)
        else
            addon.makeContainerFrameUnmovable(addon.lootFrame)
        end
    else
        print(slashHelpText)
    end
end

-- Exports
_G['SLASH_' .. addonName .. 1] = '/cn'
_G['SLASH_' .. addonName .. 2] = '/containernotification'
_G.SlashCmdList[addonName] = handler