---@class RPShopItem
---@field public Id number
---@field public Name string
---@field public Description string
local ShopItem = {}
ShopItem.__index= ShopItem

--- Initializes a new shop item
---@param name string
---@param price number
---@param description string
---@return RPShopItem
function ShopItem.Init(name, price, description)
  local newItem = {}
  setmetatable(newItem, ShopItem)

  newItem.Id = 0
  newItem.Name = name
  newItem.Price = price
  newItem.Description = description

  return newItem
end

---@class RPShop
---@field public Id number
---@field public Name string
---@field private Items RPShopItem[]
local Shop = {}
Shop.__index = Shop

--- Initial
---@param name string
---@param items RPShopItem[]
---@param purchaseSingleton fun(item: RPShopItem)
---@return RPShop
function Shop.Init(name, items, purchaseSingleton)
  local newShop = {}
  setmetatable(newShop, Shop)

  newShop.Id = 0
  newShop.Name = name
  newShop.Items = items
  newShop.PurchaseSingleton = purchaseSingleton

  return newShop
end

--- Get one item with its id
---@param id number
---@return RPShopItem | nil
function Shop:GetItem(id)
  for _, v in pairs(self.Items) do
    if v.Id == id then
      return v
    end
  end
  return nil
end

--- Gets all the items inside the shop
---@return RPShopItem[]
function Shop:GetItems()
  return self.Items
end

--- Fires the purchase singleton for all the items or item passed
---@param items number | number[]
function Shop:Purchase(items)

end