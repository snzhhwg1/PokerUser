-- Macho-compatible poker cheat script
local myCards = {}
local communityCards = {}
local flopRevealed = false

-- Listen for updates to player's cards
RegisterNetEvent('poker:client:updateMyCards', function(cards)
    myCards = cards
end)

-- Listen for updates to community cards
RegisterNetEvent('poker:client:updateCommunityCards', function(cards)
    communityCards = cards
    if #cards >= 3 then
        flopRevealed = true
    end
end)

-- Command to change player's cards to match the flop
RegisterCommand('matchFlop', function()
    if flopRevealed and #communityCards >= 3 then
        myCards[1] = communityCards[1]
        myCards[2] = communityCards[2]
        TriggerServerEvent('poker:server:forceSetMyCards', myCards)
        print('[Macho] Cards changed to match the flop.')
    else
        print('[Macho] Cannot change cards. Flop not revealed or incomplete.')
    end
end)

-- Optional keybind to activate
RegisterKeyMapping('matchFlop', 'Match your cards to the flop', 'keyboard', 'F7')
