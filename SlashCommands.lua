local addonName, addon = ...

local slashHelpText = 'Available commands:\n/cn move: toggles frame movability.'
local movable = false

local function handler(msg, editBox)
    if InCombatLockdown() then
        print("In combat, cannot execute command")
        return
    end
    if msg == 'move' then
        movable = not movable
        if movable then
            addon.makeContainerFrameMovable()
        else
            addon.makeContainerFrameUnmovable()
        end
    else
        print(slashHelpText)
    end
end

-- Exports
_G['SLASH_' .. addonName .. 1] = '/cn'
_G['SLASH_' .. addonName .. 2] = '/containernotification'
_G.SlashCmdList[addonName] = handler