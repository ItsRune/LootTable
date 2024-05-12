local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LootTable = require(ReplicatedStorage.LootTable)

local myLoot = LootTable.new()

-- name, loot rarity
myLoot:Add("Extremely Common", 400)
myLoot:Add("Common", 99)
myLoot:Add("Rare", 15)
myLoot:Add("Epic", 5)
myLoot:Add("Legendary", 1)

local rarityCounts = {}

for _ = 1, 10000 do
	local rolledRarity = myLoot:Roll()
	rarityCounts[rolledRarity] = (rarityCounts[rolledRarity] ~= nil) and rarityCounts[rolledRarity] + 1 or 1
end

warn(rarityCounts)
