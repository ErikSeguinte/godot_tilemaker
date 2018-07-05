tool
extends Sprite

enum type {
			NONE
			FULL,
			TOP_RIGHT,
			BOTTOM_RIGHT,
			BOTTOM_LEFT,
			TOP_LEFT,
			TOP,
			RIGHT,
			BOTTOM,
			LEFT,
			TOP_RIGHT_3,
			BOTTOM_RIGHT_3,
			BOTTOM_LEFT_3,
			TOP_LEFT_3,
			DIAG_TR,
			DIAG_BR
			DIAG_BL,
			DIAG_TL,
			BORDERS
	}

export var generate = false
export var tilesize = 32
export (type) var tile_type = type.FULL
export var borders = {
		"top": false,
		"right": false,
		"bottom": false,
		"left":false}
onready var new_owner
var Ed
var old_type = type.FULL

func _process(delta):
	if generate:
		generate = false
		old_type = tile_type
		if tile_type == type.NONE: #None type
			return

		if get_child_count() > 0: #Collision already exists.
			return
		get_new_owner()
		run()
	elif old_type != tile_type:
		old_type = tile_type
		if get_child_count() > 0: #Collision already exists.
			var children = get_children()
			for child in children:
				child.queue_free()
		get_new_owner()
		run()

func get_new_owner():
	Ed = EditorScript.new()
	new_owner = Ed.get_editor_interface().get_edited_scene_root()


func run():


	var staticbody = create_staticbody2d()
	add_child(staticbody)
	staticbody.set_owner(new_owner)



	var corner = {
		l = Vector2(0, 16),
		r = Vector2(32, 16),
		t = Vector2(16, 0),
		b = Vector2(16, 32)
	}
	corner["tr"] = Vector2(32, 0)
	corner["br"] = Vector2(32,32)
	corner["bl"] = Vector2(0, 32)
	corner["tl"] = Vector2(0, 0)
	corner["c"] = Vector2(16,16)

	var array = [
			corner["tr"],
			corner["br"],
			corner["bl"],
			corner["tl"]
			]

	match tile_type:
		type.FULL:
			array = [
					corner["tr"],
					corner["br"],
					corner["bl"],
					corner["tl"]
			]

		type.TOP_RIGHT:
			array = [
					corner["t"],
					corner["tr"],
					corner["r"],
					corner["c"],
			]

		type.BOTTOM_RIGHT:
			array = [
					corner["c"],
					corner["r"],
					corner["br"],
					corner["b"],

			]

		type.BOTTOM_LEFT:
			array = [
					corner["c"],
					corner["b"],
					corner["bl"],
					corner["l"],
					]

		type.TOP_LEFT:
			array = [
					corner["t"],
					corner["c"],
					corner["l"],
					corner["tl"],
					]

		type.TOP:
			array = [
					corner["tr"],
					corner["r"],
					corner["l"],
					corner["tl"],
					]

		type.RIGHT:
			array = [
					corner["t"],
					corner["tr"],
					corner["br"],
					corner["b"],
					]


		type.BOTTOM:
			array = [
					corner["r"],
					corner["br"],
					corner["bl"],
					corner["l"],
					]

		type.LEFT:
			array = [
					corner["t"],
					corner["b"],
					corner["bl"],
					corner["tl"],
					]

		type.TOP_RIGHT_3:
			array = [
					corner["tr"],
					corner["br"],
					corner["b"],
					corner["c"],
					corner["l"],
					corner["tl"],
					]

		type.BOTTOM_RIGHT_3:
			array = [
					corner["t"],
					corner["tr"],
					corner["br"],
					corner["bl"],
					corner["l"],
					corner["c"],
					]

		type.BOTTOM_LEFT_3:
			array = [
					corner["c"],
					corner["r"],
					corner["br"],
					corner["bl"],
					corner["tl"],
					corner["t"],
					]

		type.TOP_LEFT_3:

			array = [
					corner["c"],
					corner["b"],
					corner["bl"],
					corner["tl"],
					corner["tr"],
					corner["r"],
					]
		type.DIAG_TR:
			array = [
					corner["tr"],
					corner["br"],
					corner["tl"],
					]

		type.DIAG_BR:
			array = [
					corner["br"],
					corner["bl"],
					corner["tr"],
					]

		type.DIAG_BL:
			array = [
					corner["bl"],
					corner["tl"],
					corner["br"],
					]
		type.DIAG_TL:
			array = [
					corner["tl"],
					corner["tr"],
					corner["bl"],
					]

	var body = create_polygon(array)
	staticbody.add_child(body)
	body.set_owner(new_owner)


func create_polygon(array):
	var V_array = PoolVector2Array(array)
	var body = CollisionPolygon2D.new()
	body.polygon = V_array
	return body

func create_staticbody2d():
	var staticbody = StaticBody2D.new()
	return staticbody

func create_full_body():
	var rect = RectangleShape2D.new()
	rect.extents = Vector2(tilesize / 2.0, tilesize / 2.0)
	var body = CollisionShape2D.new()
	body.shape = rect

	return body

