@tool
extends Node2D

@export var terrain_textures: Array
@export var NUM_TERRAIN_SPRITES: int = 15

const CHUNK_SIZE = Vector2(1024, 896)
const HALF_CHUNK_SIZE = Vector2(CHUNK_SIZE.x / 2, CHUNK_SIZE.y / 2)
const QUART_CHUNK_SIZE = Vector2(CHUNK_SIZE.x / 4, CHUNK_SIZE.y / 4)

var SCREEN_SPACE = get_viewport_rect().size
var HALF_SCREEN_SPACE = Vector2(SCREEN_SPACE.x / 2, SCREEN_SPACE.y / 2)
var QUART_SCREEN_SPACE = Vector2(SCREEN_SPACE.x / 4, SCREEN_SPACE.y / 4)

func _ready() -> void:
	draw_terrain_sprites(NUM_TERRAIN_SPRITES)

func draw_terrain_sprites(num_of_sprites) -> void:
	for i in num_of_sprites:
		var terrain_sprite = generate_terrain_sprite(generate_sprite_texture(terrain_textures))
		terrain_sprite.position = generate_draw_space_pos(CHUNK_SIZE, HALF_CHUNK_SIZE)
		add_child(terrain_sprite)

func generate_draw_space_pos(draw_space, half_draw_space) -> Vector2:
	var terrain_pos: Vector2
	var pos_x = (draw_space.x / 2) + generate_random_number(-half_draw_space.x, half_draw_space.x) 
	var pos_y = (draw_space.y / 2) + generate_random_number(-half_draw_space.y, half_draw_space.y)

	terrain_pos = Vector2(pos_x, pos_y)
	return terrain_pos

func generate_terrain_sprite(texture: Texture2D) -> Sprite2D:
	var terrain_sprite: Sprite2D = Sprite2D.new()
	terrain_sprite.texture = texture

	return terrain_sprite

func generate_sprite_texture(textures: Array) -> Texture2D:
	var rand_index = generate_random_number(0, textures.size() - 1)
	var tex = textures[rand_index]
	
	return tex

func get_sprite_size(sprite: Sprite2D) -> Vector2:
	var sprite_size: Vector2
	sprite_size = Vector2(sprite.texture.get_width(), sprite.texture.get_height())

	return sprite_size

func generate_random_number(minimum: int, maximum: int) -> int:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var rand = rng.randi_range(minimum, maximum)
	
	return rand
