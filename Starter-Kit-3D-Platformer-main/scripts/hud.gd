extends Control

@onready var coins_label: Label = %CoinsLabel
@onready var time_label: Label = %TimeLabel

func _ready() -> void:
        _update_coins(0)
        set_time(0.0)

func _on_coin_collected(coins: int) -> void:
        _update_coins(coins)

func set_time(seconds: float) -> void:
        time_label.text = "Tiempo: %.2f s" % seconds

func _update_coins(coins: int) -> void:
        coins_label.text = "Monedas: %d" % coins
