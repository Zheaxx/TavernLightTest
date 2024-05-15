function printSmallGuildNames(memberCount)
    -- Prepare the SQL query using parameterized query
    local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < ?;"
    
    -- Execute the prepared statement with the parameterized value
    local resultId = db.storeQuery(selectGuildQuery, memberCount)
    
    -- Check if the query was successful
    if not resultId then
        print("Failed to execute guild query.")
        return
    end
    
    -- Loop through all the guild names and print them
    local guildNames = {}
    repeat
        local guildName = resultId.getDataString("name")
        table.insert(guildNames, guildName)
    until not resultId.next()
    
    -- Print the guild names
    if #guildNames > 0 then
        print("Guilds with less than " .. memberCount .. " members:")
        for _, name in ipairs(guildNames) do
            print("- " .. name)
        end
    else
        print("No guilds found with less than " .. memberCount .. " members.")
    end
end
