-- This file is responsible for generating the LootFrame

local _, addon = ...

local DEFAULT_TEXTURE = 134400
local MOVING_TEXT = "Moving"
local FONT = "Fonts\\FRIZQT__.TTF"

-- Frame Setup:
local containerFrame = CreateFrame("Button", "ContainerNotificationLootFrame", UIParent, "SecureActionButtonTemplate")
containerFrame:SetPoint("CENTER")
containerFrame:SetSize(64, 64)
containerFrame:RegisterForClicks("LeftButtonDown", "LeftButtonUp")
containerFrame:SetAttribute("type", "macro")
containerFrame:Hide()

-- Frame Texture:
local containerFrameTexture = containerFrame:CreateTexture(nil, "ARTWORK")
containerFrameTexture:SetTexture(DEFAULT_TEXTURE)
containerFrameTexture:SetAllPoints()

-- Frame Text:
local containerFrameText = containerFrame:CreateFontString(nil, "ARTWORK")
containerFrameText:SetFont(FONT, 18, "OUTLINE")
containerFrameText:SetPoint("CENTER", 0, 0)

-- Functions for modifiying the Frame:
local updateTexture = function(tex)
    containerFrameTexture:SetTexture(tex)
end

local updateText = function(text)
    containerFrameText:SetText(text)
end

local updateMacroText = function(macrotext)
    containerFrame:SetAttribute("macrotext", macrotext)
end

local showContainerFrame = function ()
    containerFrame:Show()
end

local hideContainerFrame = function ()
    containerFrame:Hide()
end

local updateContainerFrame = function (texture, text, macrotext)
    updateTexture(texture)
    updateText(text)
    updateMacroText(macrotext)
end

local makeContainerFrameMovable = function()
    addon.moveMode = true
    containerFrame:Show()
    containerFrame:SetMovable(true)
    containerFrame:SetScript("OnMouseDown", function(self, button)
        self:StartMoving()
    end)
    containerFrame:SetScript("OnMouseUp", function(self, button)
        self:StopMovingOrSizing()
    end)
    updateTexture(DEFAULT_TEXTURE)
    containerFrameText:SetText(MOVING_TEXT)
    containerFrame:Disable()
end

local makeContainerFrameUnmovable = function()
    addon.moveMode = false
    containerFrame:SetMovable(false)
    containerFrame:SetScript("OnMouseDown", nil)
    containerFrame:SetScript("OnMouseUp", nil)
    containerFrame:Enable()
    containerFrameText:SetText(nil)
    containerFrame:Hide()
end

-- Exports:
addon.makeContainerFrameMovable = makeContainerFrameMovable
addon.makeContainerFrameUnmovable = makeContainerFrameUnmovable
addon.moveMode = false
addon.showContainerFrame = showContainerFrame
addon.hideContainerFrame = hideContainerFrame
addon.updateContainerFrame = updateContainerFrame