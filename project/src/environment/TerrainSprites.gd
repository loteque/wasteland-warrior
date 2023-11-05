@tool
extends Node2D

@export var terrain_textures: Array
@export var NUM_TERRAIN_SPRITES: int = 15

var SCREEN_SPACE = get_viewport_rect().size
var HALF_SCREEN_SPACE = Vector2(SCREEN_SPACE.x / 2, SCREEN_SPACE.y / 2)
var QUART_SCREEN_SPACE = Vector2(SCREEN_SPACE.x / 4, SCREEN_SPACE.y / 4)
@onready var from_chunk_center_to_origin: Vector2 = Vector2(get_chunk_size().x / -2, get_chunk_size().y / -2)

func _ready() -> void:
	draw_terrain_sprites(NUM_TERRAIN_SPRITES)

func get_chunk_size():
	return Vector2(GlobalSettings.CHUNK_WIDTH, GlobalSettings.CHUNK_HEIGHT)

func get_half_chunk_size():
	var CHUNK_SIZE = get_chunk_size()
	return Vector2(CHUNK_SIZE.x / 2, CHUNK_SIZE.y / 2)

func draw_terrain_sprites(num_of_sprites) -> void:
	for i in num_of_sprites:
		var terrain_sprite = generate_terrain_sprite(generate_sprite_texture(terrain_textures))
		var random_pos = generate_random_position(get_chunk_size())
		terrain_sprite.position = translate_point(random_pos, from_chunk_center_to_origin)
		add_child(terrain_sprite)
	return

func generate_random_position(grid_size: Vector2) -> Vector2:
	var pos_x = generate_random_number(0, grid_size.x)
	var pos_y = generate_random_number(0, grid_size.y)
	var generated_position = Vector2(pos_x, pos_y)
	return generated_position

func translate_point(point: Vector2, translation: Vector2):
	return point + translation

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
