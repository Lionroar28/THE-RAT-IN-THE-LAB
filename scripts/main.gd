extends Node2D
@onready var scorelabel: Label = $pointHUD/scorecanvas/scorelabel

var score: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_setup_level()
	print("hi")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _setup_level() -> void:
	
	var pumpkins = $level1.get_node_or_null("pumpkins")
	if pumpkins:
		for pumpkin in pumpkins.get_children():
			if not pumpkin.collected.is_connected(_on_player_died):
				pumpkin.collected.connect(increase_score)
	
	var enemies = $level1.get_node_or_null("enemies")
	if enemies:
		for enemy in enemies.get_children():
			if not enemy.player_died.is_connected(_on_player_died):
				enemy.player_died.connect(_on_player_died)


func _on_player_died(body):
	body.die()

func increase_score() -> void:
	score += 1
	scorelabel.text = "SCORE: %s" % score
