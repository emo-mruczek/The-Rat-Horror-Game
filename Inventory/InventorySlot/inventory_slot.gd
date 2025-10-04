extends Control
class_name InventorySlot

# So its copy can be instanced while splitting
@export var inventory_item_scene: PackedScene = preload("res://Inventory/InventorySlot/InventoryItem/InventoryItem.tscn")

@export var item: InventoryItem
@export var hint_item: InventoryItem = null

# hint_item SERVE TO RESTRICT A SLOT TO ONLY
# ACCEPT THE TYPE OF ITEM REPRESENTED BY THE hint_item


enum InventorySlotAction {
	SELECT, SPLIT, # FOR ITEM SELECTION
}


signal slot_input(which: InventorySlot, action: InventorySlotAction)
signal slot_hovered(which: InventorySlot, is_hovering: bool)



func _ready():
	add_to_group("inventory_slots")
