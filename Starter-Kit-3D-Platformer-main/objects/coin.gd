extends Area3D

@export var rotation_speed_degrees := 90.0
@export var bob_speed := 2.0
@export var bob_height := 0.25

var start_position := Vector3.ZERO
var collected := false
var time_passed := 0.0

func _ready() -> void:
        start_position = position

func _process(delta: float) -> void:
        if collected:
                return
        rotate_y(deg_to_rad(rotation_speed_degrees) * delta)
        time_passed += delta
        var offset := sin(time_passed * bob_speed) * bob_height
        position.y = start_position.y + offset

func _on_body_entered(body: Node) -> void:
        if collected:
                return
        if body.has_method("collect_coin"):
                collected = true
                body.collect_coin()
                queue_free()
