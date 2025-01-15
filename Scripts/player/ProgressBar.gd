extends ProgressBar
@onready var player = $"../.."

func _ready():
	player.player_health_changes.connect(update)
	update()
	
func update():
	value = player.currentHealth * 100 / player.maxHealth
