function removeMemberFromPlayerParty(playerId, memberName)
    local player = Player(playerId)
    if not player then
        print("Player with ID " .. playerId .. " not found.")
        return
    end

    local party = player:getParty()
    if not party then
        print("Player party not found.")
        return
    end

    local memberToRemove = nil
    for _, member in pairs(party:getMembers()) do
        if member:getName() == memberName then
            memberToRemove = member
            break
        end
    end

    if memberToRemove then
        party:removeMember(memberToRemove)
        print("Member " .. memberName .. " removed from the party.")
    else
        print("Member " .. memberName .. " not found in the party.")
    end
end
