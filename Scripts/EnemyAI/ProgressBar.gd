extends ProgressBar
@onready var enemy = $"../.."

func _ready():
	enemy.enemy_health_changes.connect(update)
	update()
	
func update():
	value = enemy.currentHealth * 100 / enemy.maxHealth
