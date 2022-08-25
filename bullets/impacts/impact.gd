extends Node2D

# Bullet Impact Script

# How long the impact will be visible
# (values <= 0.0 means the impact will never be destroyed - not recomended)
@export var lifetime := 5.0

# Fade out time for a fade out effect when deleting the impact
# (values <= 0.0 means no fade out)
@export var fade_out_time := 0.0

func _ready():
	if lifetime > 0.0:
		var timer : Timer = $Timer
		timer.wait_time = lifetime
		timer.timeout.connect(self._destroy)
		timer.start()
	
func _destroy():
	if fade_out_time > 0.0:
		var tween := create_tween()
		tween.tween_property(self, "modulate", Color.TRANSPARENT, fade_out_time)
		tween.tween_callback(self.queue_free)
	else:
		queue_free()

