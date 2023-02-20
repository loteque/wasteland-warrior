tool
extends Node2D

export var terrain_textures: Array

const CHUNK_SIZE = Vector2(1024, 896)
const SCREEN_SPACE_SIZE = Vector2(512, 448)
const POS_MODIFIER: int = 10
const NUM_TERRAIN_SPRITES = 10
# TODO:
# Continuosly generate terrain details off camera with a 
# constant function that takes position as input

func _ready() -> void:
    for i in NUM_TERRAIN_SPRITES:
        var terrain_sprite = generate_terrain_sprite(generate_sprite_texture(terrain_textures))
        terrain_sprite.position = generate_terrain_pos(Vector2(0,0), get_sprite_size(terrain_sprite))
        add_child(terrain_sprite)

func generate_terrain_pos(chunk_position, sprite_size) -> Vector2:
    var terrain_pos: Vector2
    var chunk_size: Vector2 = CHUNK_SIZE
    var pos_x = (chunk_size.x / 2) / (sprite_size.x / 2) + generate_random_number(-SCREEN_SPACE_SIZE.x, SCREEN_SPACE_SIZE.x)
    var pos_y = (chunk_size.y / 2) / (sprite_size.y / 2) + generate_random_number(-SCREEN_SPACE_SIZE.y, SCREEN_SPACE_SIZE.x)

    terrain_pos = Vector2(pos_x, pos_y)
    return terrain_pos

func generate_terrain_sprite(texture: Texture) -> Sprite:
	var terrain_sprite: Sprite = Sprite.new()
	terrain_sprite.texture = texture

	return terrain_sprite

func generate_sprite_texture(textures: Array) -> Texture:
    var rand_index = generate_random_number(0, textures.size() - 1)
    var tex = textures[rand_index]
    
    return tex

func get_sprite_size(sprite: Sprite) -> Vector2:
	var sprite_size: Vector2
	sprite_size = Vector2(sprite.texture.get_width(), sprite.texture.get_height())

	return sprite_size

func generate_random_number(minimum: int, maximum: int) -> int:
    var rand: int
    var rng = RandomNumberGenerator.new()
    rng.randomize()
    rand = rng.randi_range(minimum, maximum)
    
    return rand