-- Define constants
local STORAGE_KEY = 1000
local RELEASE_DELAY_MS = 1000

-- Function to release player's storage
local function releaseStorage(player)
    if player and player:isPlayer() then
        player:setStorageValue(STORAGE_KEY, -1)
    else
        print("Invalid player or player object.")
    end
end

-- Event handler for player logout
function onLogout(player)
    if player:getStorageValue(STORAGE_KEY) == 1 then
        -- Release storage after a delay, but cancel any previous release events
        if player.releaseEvent then
            removeEvent(player.releaseEvent)
        end
        player.releaseEvent = addEvent(releaseStorage, RELEASE_DELAY_MS, player)
    end
    return true
end
