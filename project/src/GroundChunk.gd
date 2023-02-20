tool
extends Node2D

onready var terrain_texture: Texture = load("res://assets/terrain_01.png")
const POS_MODIFIER: int = 10

# TODO:
# Continuosly generate terrain details off camera with a 
# constant function that takes position as input

func _ready() -> void:
	var terrain_sprite = generate_terrain_sprite(terrain_texture)
	terrain_sprite.position = generate_terrain_pos(Vector2(0,0), get_sprite_size(terrain_sprite))
	add_child(terrain_sprite)

func generate_terrain_pos(position, sprite_size) -> Vector2:
    var terrain_pos: Vector2
    var chunk_size: Vector2 = Vector2(1024, 896)
    var pos_x = chunk_size.x / 128 #+ position + (sprite_size.x / 2) + POS_MODIFIER
    var pos_y = chunk_size.y / 128 #+ position + (sprite_size.y / 2) + POS_MODIFIER

    terrain_pos = Vector2(pos_x, pos_y)
    return terrain_pos

func generate_terrain_sprite(texture: Texture) -> Sprite:
	var terrain_sprite: Sprite = Sprite.new()
	terrain_sprite.texture = texture

	return terrain_sprite  

func get_sprite_size(sprite: Sprite) -> Vector2:
	var sprite_size: Vector2
	sprite_size = Vector2(sprite.texture.get_width(), sprite.texture.get_height())

	return sprite_size
