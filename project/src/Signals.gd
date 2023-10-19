extends Node

signal updated_camera_pos
signal sound_fx(name)
signal projectile_shot()
signal player_hit()
signal mob_hit()
signal debug_ui_toggled(is_active: bool)
signal menu_closed()
signal cap_collected()
signal xp_updated(value: int)
signal player_died()
signal leveled_up(new_level, xp_count, xp_until_next_level)
