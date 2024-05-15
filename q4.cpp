void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
    Player* player = g_game.getPlayerByName(recipient);
    bool playerCreated = false; // Flag to indicate if a new player object was created

    if (!player) {
        player = new Player(nullptr);
        if (!IOLoginData::loadPlayerByName(player, recipient)) {
            delete player; // Deallocate memory if loading fails
            return;
        }
        playerCreated = true;
    }

    Item* item = Item::CreateItem(itemId);
    if (!item) {
        if (playerCreated) {
            delete player; // Deallocate memory if item creation fails and a new player object was created
        }
        return;
    }

    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

    if (player->isOffline()) {
        IOLoginData::savePlayer(player);
    }

    // Deallocate memory if a new player object was created
    if (playerCreated) {
        delete player;
    }
}