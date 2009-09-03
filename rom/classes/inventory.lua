include("item.lua");


CInventory = class(
	function (self)
		self.BagSlot = {}
	end
)


function CInventory:getAmmunitionCount()
	return RoMScript("GetInventoryItemCount('player', 9);");
end

function CInventory:getMainHandDurability()
    local durability, durabilityMax = RoMScript("GetInventoryItemDurable('player', 15);");
	return durability/durabilityMax;
end

-- Parse from |Hitem:7efa5|h|cffffffff[Qufdsfdsickness I]|r|h
-- hmm, i whonder if we could get more information out of it than id, color and name.
function CInventory:parseItemLink(itemLink)
	if itemLink == "" then
		return;
 	end
	id = tonumber(string.sub(itemLink, 8, 12), 16);  -- Convert to decimal
	color = string.sub(itemLink, 19, 24);
	name = string.sub(itemLink, string.find(itemLink, '[\[]')+1, string.find(itemLink, '[\]]')-1);
	return id, color, name;
end

-- Update one slot, get item id, bagId, name, itemCount, color
function CInventory:updateBagSlot(slotNumber)
	local itemLink, bagId, icon, name, itemCount = RoMScript("GetBagItemLink(GetBagItemInfo("..slotNumber..")),GetBagItemInfo("..slotNumber..")");

	self.BagSlot[slotNumber] = CItem();
	
	if (itemLink ~= "") then
		local id, color = self:parseItemLink(itemLink);

		self.BagSlot[slotNumber].Id = id			     -- The real item id
		self.BagSlot[slotNumber].BagId = bagId;          -- GetBagItemLink and other RoM functins need this..
    	self.BagSlot[slotNumber].Name = name;
    	self.BagSlot[slotNumber].ItemCount = itemCount;  -- How many?
    	self.BagSlot[slotNumber].Color = color; 		 -- Rarity
	end
end

-- Make a full update
function CInventory:update()
	printf(language[1000]);  -- Updating

	for slotNumber = 1, 60, 1 do
		self:updateBagSlot(slotNumber);
		printf(".");
	end
	printf("\n");
end

function CInventory:itemTotalCount(itemNameOrId)
	totalCount = 0;
 	for slot,item in pairs(self.BagSlot) do
	    if item.Id == itemNameOrId or item.Name == itemNameOrId then
			totalCount = totalCount+item.ItemCount;
		end
	end
	return totalCount;
end

function CInventory:useItem(itemNameOrId)
 	for slot,item in pairs(self.BagSlot) do
     	if item.Id == ItemNameOrId or item.Name == itemNameOrId then
    		item:use();
		end
	end
end

-- Returns item name or false, takes in type, example: "Healing" or "Mana" or "Array"
function CInventory:bestAvailableConsumable(type)
 	local bestLevel = 0;
 	local bestItem = CItem();
 	for slot,item in pairs(self.BagSlot) do
		for num,consumable in pairs(database.consumables) do
		    if consumable.Type == type and consumable.Level <= player.Level then
		        if item.Id == consumable.Id then
		            if consumable.Level > bestLevel then
		                bestLevel = consumable.Level;
		                bestItem = item;
					end
		        end
			end
		end
	end
	return bestItem;
end

-- Returns item name or false, takes in type, example: "healing" or "mana" or "arraw"
-- quantity is how many of them do we need, for example, for potions its 99 or 198
-- but for arraws it might be 1 or 2
function CInventory:storeBuyConsumable(type, quantity)
 	local bestLevel = 0;
 	for storeSlot = 1, 20, 1 do
 	    local storeItemLink, icon, name, storeItemCost = RoMScript("GetStoreSellItemLink("..storeSlot.."),GetStoreSellItemInfo("..storeSlot..")");
 	    if storeItemLink == "" then
 	        break;
 	    end
 	    
 	    storeItemId, storeItemColor, storeItemName = self:parseItemLink(storeItemLink);
 		-- print(storeItemName);
 	    
		for num,consumable in pairs(database.consumables) do
		    if consumable.Type == type and consumable.Level <= player.Level then
		        if consumable.Id == storeItemId then
		            if consumable.Level > bestLevel then
		                bestLevel = consumable.Level;
		                bestItem = storeItemId;
		                bestItemSlot = storeSlot;
					end
		        end
			end
		end
	end

	if bestLevel == 0 then
	    return false;
 	end

 	
	if self:itemTotalCount(bestItem) < quantity then
	    numberToBuy = quantity - self:itemTotalCount(bestItem);
	    printf(language[1001]);  -- Shopping
	    for i = 1, numberToBuy, 1 do
	    	RoMScript("StoreBuyItem("..bestItemSlot..")");
	    	printf(".");
		end
		printf("\n");
	end
end

function CInventory:deleteItemInSlot(slot)
 	self.BagSlot[slot]:delete();
end



function CInventory:filter()

end

-- function CInfontroy:shopping..
-- shopping for potions, and ammunation

-- banking functions