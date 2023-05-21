extends RigidBody2D

signal enemy
signal _death

var IsUsed = false

@export var health = 50
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	take_damage()

func take_damage():
	if IsUsed == false and health == 0:
		emit_signal("_death")
		IsUsed = true


func _on__death():
	$death.play()
	$Anim/AnimatedSprite2D.flip_h = 1
	$Anim/AnimatedSprite2D.play("dead")
	$GPUParticles2D.emitting = 1
	$CollisionShape2D.disabled = 1
	$"../../../AnimationPlayer".play("new_animation")
	$"../../../Player/Camera2D/AnimationPlayer".play("shake")
	$death.play()
	
