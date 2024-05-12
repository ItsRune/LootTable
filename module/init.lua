--!strict
---@class LootTable

local LootTable = {}
local Class = {}
Class.__index = Class

--// Public Functions \--
function LootTable.new()
	local self = setmetatable({}, Class)

	self._data = {}

	return self
end

--// Private Functions \--
--[=[
    Adds a new rarity to the loot table with it's given rarity.
    @param rarityName string
    @param rarityWeight number
    @return ()

    @within LootTable
    @since 1.0.0
]=]
--
function Class:Add(rarityName: string, rarityWeight: number)
	self._data[rarityName] = rarityWeight
	self._totalWeight += rarityWeight
end

--[=[
    Removes a rarity from the loot table along with it's weight.
    @param rarityName string
    @return ()

    @within LootTable
    @since 1.0.0
]=]
--
function Class:Remove(rarityName: string)
	local currentWeight = self._data[rarityName]
	if not currentWeight then
		return
	end

	self._data[rarityName] = nil
	self._totalWeight -= currentWeight
end

--[=[
    Rolls the loot table, generating a random rarity.
    @return string

    @within LootTable
    @since 1.0.0
]=]
--
function Class:Roll()
	local currentWeight = 0
	local totalWeight = self:_getTotalWeight()
	local rand = Random.new():NextInteger(1, totalWeight)

	for rarityName: string, weight: number in self._data do
		currentWeight += weight
		if rand > currentWeight then
			continue
		end

		return rarityName
	end
end

--[=[
    Cleans up the metatable.
    @return ()

    @within LootTable
    @since 1.0.0
]=]
--
function Class:Destroy()
	table.clear(self)
	setmetatable(self, nil)
	self = nil
end

--// Return \--
return LootTable
