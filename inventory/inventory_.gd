extends Resource
class_name QuiverInventory

# This is a class that defines an Inventory
# It is a resource, so you can share it beetwen your player character and your UI for example


# Defines an item stack
# Each item stored in the inventory is in a stack
class ItemStack:
	var item: QuiverItem
	var quantity: int
	
	var name: String:
		get:
			return item.name
	
	
	func _init(item:QuiverItem, quantity:int):
		self.item = item
		self.quantity = quantity
	
	func is_full()->bool:
		if !item.stackable:
			return quantity == 1
		if item.stack_size <= 0:
			return false
		return quantity >= item.stack_size
	
	func add(amount)->int:
		if is_full():
			return amount
		
		var amount_left = 0
		
		quantity += amount
		
		if !item.stackable or item.stack_size > 0:
			var stack_size = item.stack_size
			if !item.stackable:
				stack_size = 1
			if quantity > stack_size:
				quantity = item.stack_size
				amount_left = quantity - item.stack_size
		
		return amount_left 
	func remove(amount)->int:
		quantity -= amount
		amount = 0
		if quantity < 0:
			amount += -quantity
		return amount


# The maximum size of the inventory (in stacks)
@export var max_size := 10


# The inventory is an array of ItemStack
var inventory: Array[ItemStack] = []

# This Dictionnary helps to keep how much of each item is currently in the inventory
var item_counts := {}

# A signal emited when an item count is changed
signal item_changed(item)


# A function to get all the stacks corresponding to the given item
# item can be a string (the item name) or the item itself
func search_item_stacks(item): #->Array[ItemStack]: err: https://github.com/godotengine/godot/issues/60218
	var item_stacks: Array[ItemStack] = []
	var item_name: String
	if item is QuiverItem:
		item_name = item.name
	elif item is String:
		item_name = item
	else:
		printerr("search_item (Inventory.gd) item argument is not valid")
	
	for i in range(inventory.size()):
		var item_stack = inventory[i]
		if item_stack.name == item_name:
			item_stacks.append(item_stack)
	
	return item_stacks


# Returns how many of an item there is in the inventory
# item can be a String (the item name) or the item itself
func get_item_amount(item):
	var item_name: String
	if item is QuiverItem:
		item_name = item.name
	elif item is String:
		item_name = item
	return 0 if not item_counts.has(item_name) else item_counts[item_name]


# Add an item to the inventory
# Will return false if the inventory doens't have enough capacity to add the given quantity of the given item
func add_item(item: QuiverItem, quantity:=1)->bool:
	var room_left = _room_left_for_item(item)
	if room_left == -1 or room_left-quantity >= 0:
		# We can add items
		if item_counts.has(item.name):
			item_counts[item.name] += quantity
		else:
			item_counts[item.name] = quantity
		
		var stacks = search_item_stacks(item)
		for stack in stacks:
			quantity = stack.add(quantity)
		
		while quantity > 0:
			var stack = ItemStack.new(item, 0)
			quantity = stack.add(quantity)
			inventory.append(stack)
		
		
		item_changed.emit(item)
		return true
	else:
		# There was not enough room
		return false


# Remove an item from the inventory
# Set the amount to -1 to remove all
func remove_item(item, amount:=1):
	var max_amount = get_item_amount(item)
	if amount > max_amount:
		amount = max_amount
	if amount == -1:
		amount = max_amount
	
	var item_stacks = search_item_stacks(item)
	
	if item is String:
		item = item_stacks[0].item
	
	item_counts[item.name] -= amount
	
	while amount > 0:
		var stack = item_stacks.pop_back()
		amount = stack.remove(amount)
	
	item_changed.emit(item)


# Use a certain item if it is in the inventory
# If amount is too much, it will use all available items
# Set the amount to -1 to use all
func use_item(user: QuiverCharacter, item, amount:=1):
	var max_amount = get_item_amount(item)
	if amount > max_amount:
		amount = max_amount
	if amount == -1:
		amount = max_amount
	
	
	var item_stacks = search_item_stacks(item)
	
	if item_stacks.size()==0:
		return
	
	if item is String:
		item = item_stacks[0].item
	
	item_counts[item.name] -= amount

	for _i in range(amount):
		item.use(user)

	while amount > 0:
		var stack = item_stacks.pop_back()
		amount = stack.remove(amount)
	
	
	item_changed.emit(item)


# Compute how much of an item we can add to the inventory
# Returns -1 if we can add an infinity of times the item
func _room_left_for_item(item: QuiverItem)->int:
	var room_left = 0
	
	if !item.stackable:
		return max_size - inventory.size()
	else:
		if item.stack_size <= 0:
			if max_size - inventory.size() > 0 or search_item_stacks(item).size() > 0:
				return -1
			else:
				return 0
		
		var stacks = search_item_stacks(item)
		for stack in stacks:
			room_left += item.stack_size - stack.quantity
		
		room_left += (max_size - inventory.size())*item.stack_size
		
		return room_left
