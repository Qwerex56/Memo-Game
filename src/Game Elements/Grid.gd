extends Node
class_name Grid

const GRID_SIZE = 4;
export var top_left_position : Vector2;
export var offset : Vector2;
var tiles : Array = [];

const MAX_SHOWN_TILES = 2;
var tile_counter = 0;

var selected_tiles : Array= []

func _enter_tree():
	tiles = GenerateGrid();

func GenerateGrid():
	var grid : Array = [];
	for i in GRID_SIZE * GRID_SIZE:
		var tile_tscn : PackedScene = load("res://src/Game Elements/Tile.tscn");
		var tile : Tile = tile_tscn.instance();
		add_child(tile);
		grid.append(tile);
	
	for i in GRID_SIZE * GRID_SIZE:
		if i % 2 != 0:
			continue;
	
	randomize();
	grid.shuffle();
	
	var CELL_SIZE = 64;
	var i = 0;

	for y in GRID_SIZE:
		for x in GRID_SIZE:
			grid[i].global_position = Vector2(x, y) * CELL_SIZE + top_left_position - offset * (GRID_SIZE - 1);
			grid[i].global_position.x += offset.x * x;
			grid[i].global_position.y += offset.y * y;
			i += 1;	

	return grid;

func CompareTiles():
	if (selected_tiles.size() < 2):
		return false;
	pass

func _on_Tile_Show(tile : Tile):
	if tile_counter < 2:
		return;
	
	selected_tiles.append(tile);
	pass