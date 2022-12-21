extends Node
class_name Grid

signal EndGame(hasWon)
signal PairConnected()

export var GRID_SIZE = 4
export var CELL_SIZE : int = 64
export var top_left_position : Vector2
export var offset : Vector2
export var tile_colors : PoolColorArray = [];
var tiles : Array = []

const MAX_SHOWN_TILES = 2
var tile_counter = 0

var selected_tiles : Array= []

func _enter_tree():
	tiles = GenerateGrid()

func GenerateGrid():
	var grid : Array = []
	for i in GRID_SIZE * GRID_SIZE:
		var tile_tscn : PackedScene = load("res://src/Game Elements/Tile.tscn")
		var tile : Tile = tile_tscn.instance()
		add_child(tile)
		grid.append(tile)
	
	for i in GRID_SIZE * GRID_SIZE:
		print("res://src/textures/tile/front-img" + str(i % (GRID_SIZE * 2)))
		grid[i].modulate = Color(0.1 * (i % GRID_SIZE * 2), 0.1 * (i % GRID_SIZE * 2), 0.1 * (i % GRID_SIZE * 2))
		grid[i].connect("Show_Tile", self, "_on_Tile_Show")
		# var tile_texture = load("res://src/textures/tile/front-img" + i % (GRID_SIZE * 2))
		# grid[i].get_node("FrontImage").texture = tile_texture;
		continue
	
	randomize()
	grid.shuffle()
	
	var i = 0

	for y in GRID_SIZE:
		for x in GRID_SIZE:
			grid[i].global_position = Vector2(x, y) * CELL_SIZE + top_left_position
			grid[i].global_position.x += offset.x * x
			grid[i].global_position.y += offset.y * y
			i += 1;

	return grid

func CompareTiles():
	if selected_tiles.size() < 2:
		return
	
	print("2 tiles selected")
	yield(get_tree().create_timer(1), "timeout")
	
	if selected_tiles[0].get_node("FrontImage").texture != selected_tiles[1].get_node("FrontImage").texture:
		selected_tiles[0].HideTile()
		selected_tiles[1].HideTile()
		tile_counter = 0
		print("Wrong Tile end")
		return

	selected_tiles[0].queue_free()
	selected_tiles[1].queue_free()
	
	tiles.erase(selected_tiles[0])
	tiles.erase(selected_tiles[1])

	selected_tiles = []
	tile_counter = 0

	emit_signal("PairConnected", GRID_SIZE * 2 - ((tiles.size() / 2) % (GRID_SIZE * 2)))

	if tiles.empty():
		emit_signal("EndGame", true)
	pass

func _on_Tile_Show(tile : Tile):
	if tile_counter >= 2:
		return
	
	selected_tiles.append(tile);
	tile_counter += 1
	CompareTiles()
	pass

func ClearGrid():
	tile_counter = 0
	selected_tiles = []
	for tile in tiles:
		tile.queue_free()
	pass

func _on_TimeLeft_timeout():
	emit_signal("EndGame", false)
	pass