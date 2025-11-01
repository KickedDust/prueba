extends CharacterBody3D

signal coin_collected

@export var view: Node3D
@export var movement_speed := 7.0
@export var jump_strength := 7.5

var coins := 0
var gravity_strength := ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta: float) -> void:
        var input_direction := Vector3.ZERO
        input_direction.x = Input.get_axis("move_left", "move_right")
        input_direction.z = Input.get_axis("move_forward", "move_back")

        if view:
                input_direction = input_direction.rotated(Vector3.UP, view.rotation.y)

        if input_direction.length() > 1.0:
                input_direction = input_direction.normalized()

        var horizontal_velocity := input_direction * movement_speed
        velocity.x = horizontal_velocity.x
        velocity.z = horizontal_velocity.z

        if not is_on_floor():
                velocity.y -= gravity_strength * delta
        elif velocity.y < 0.0:
                velocity.y = 0.0

        if is_on_floor() and Input.is_action_just_pressed("jump"):
                velocity.y = jump_strength

        move_and_slide()

        if horizontal_velocity.length() > 0.05:
                var target_angle := atan2(horizontal_velocity.x, horizontal_velocity.z)
                rotation.y = lerp_angle(rotation.y, target_angle, delta * 10.0)

        if global_position.y < -20.0:
                get_tree().reload_current_scene()

func collect_coin() -> void:
        coins += 1
        coin_collected.emit(coins)
