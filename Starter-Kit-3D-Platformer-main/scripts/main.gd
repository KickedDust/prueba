extends Node3D

var elapsed_time := 0.0

@onready var hud: Control = $HUD
@onready var sun: DirectionalLight3D = $Sun
@onready var environment: WorldEnvironment = $Environment

func _ready() -> void:
        if RenderingServer.get_current_rendering_method() == "gl_compatibility":
                sun.light_energy = 0.24
                sun.shadow_opacity = 0.85
                environment.environment.background_energy_multiplier = 0.25

func _process(delta: float) -> void:
        elapsed_time += delta
        hud.set_time(elapsed_time)
