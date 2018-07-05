tool
extends Node2D


export (StreamTexture) var IMAGE = load("res://tiles/mountains.png")
export (Script) var SCRIPT = load("res://scripts/Collision_adder.gd")
export var generate = false
export (int) var TILESIZE = 32

var new_owner

func _process(delta):
	if generate:
		run()
		generate = false

func run():
	var Ed = EditorScript.new()
	new_owner = Ed.get_editor_interface().get_edited_scene_root()

	var size = get_texture_size()

	for y in range(size[1]):
		for x in range(size[0]):
			var new_node = create_sprite(x * 32, y * 32)
			add_child(new_node)
			new_node.set_owner(new_owner)


func create_sprite(x, y):
	var new_node = Sprite.new()
	new_node.texture = IMAGE
	new_node.centered = false
	new_node.region_enabled = true
	new_node.region_rect = Rect2(x, y, 32, 32)
	new_node.position = Vector2(x,y)
	new_node.set_script(SCRIPT)
	return new_node

func get_texture_size():
	# Gets numbers of Rows and Columns
	var height = IMAGE.get_height() / 32
	var width = IMAGE.get_width() / 32

	return [width, height]

