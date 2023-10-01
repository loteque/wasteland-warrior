extends Node2D

@onready var grid: TileMap = get_node("TileMap")

var tile_background: Resource = load("res://src/BackgroundChunk.tscn")
var camera_pos: Vector2

func _ready() -> void:
	Signals.connect("updated_camera_pos", Callable(self, "_on_updated_camera_pos"))

func _on_updated_camera_pos(updated_camera_pos) -> void:
	draw_chunks(updated_camera_pos)

func draw_chunks(updated_camera_pos) -> void:
	var tile_bg: Node2D
	var tiles = get_chunks(updated_camera_pos)
	for tile in tiles:
		var cell_source_id = grid.get_cell_source_id(0, Vector2i(tile.x, tile.y))
		if cell_source_id == -1:
			grid.set_cell(0, Vector2i(tile.x, tile.y), 0, Vector2i(0,0), 0)
			tile_bg = tile_background.instantiate()
			tile_bg.global_position = grid.map_to_local(tile)
			add_child(tile_bg)

func get_chunks(updated_camera_pos) -> Array:
	var tiles: Array = []
	var current_tile = grid.local_to_map(updated_camera_pos)
	tiles.push_back(Vector2(current_tile.x + 1, current_tile.y + 1))
	tiles.push_back(Vector2(current_tile.x - 1, current_tile.y + 1))
	tiles.push_back(Vector2(current_tile.x - 1, current_tile.y - 1))
	tiles.push_back(Vector2(current_tile.x + 1, current_tile.y - 1))
	tiles.push_back(Vector2(current_tile.x - 1, current_tile.y))
	tiles.push_back(Vector2(current_tile.x + 1, current_tile.y))
	tiles.push_back(Vector2(current_tile.x, current_tile.y - 1))
	tiles.push_back(Vector2(current_tile.x, current_tile.y + 1))
	return tiles
