local _, addon = ...

-- List of items that require lockpicking:
local lockedItems = {
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

local whitelist = {
    205423, -- Shadowflame Residue Sack
    198609, -- Tailoring Examples
    193898, -- Umbral Bone Needle
    198977, -- Ohn'ahran Weave
    198964, -- Elementious Splitter
    198978, -- Stupidly Effective Stitchery
    193897, -- Reawakened Catalyst
    198963, -- Decaying Phlegm
    193899, -- Primalweave Spindle
}

-- Exports:
addon.lockedItems = lockedItems
addon.whitelist = whitelist