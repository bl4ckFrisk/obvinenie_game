extends CharacterBody2D

@export var speed = 500
@export var damage = 50

func _ready():
	$Anim/AnimatedSprite2D3.hide()

func get_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed('right'):
		velocity.x += 1
	if Input.is_action_pressed('left'):
		velocity.x -= 1
	if Input.is_action_pressed('down'):
		velocity.y += 1
	if Input.is_action_pressed('up'):
		velocity.y -= 1
	velocity = velocity.normalized() * speed
	
	if Input.is_action_pressed("down") or Input.is_action_pressed("up") or Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		$Anim/AnimatedSprite2D.play("truba_walk")
		$Anim/AnimatedSprite2D2.play("walk_legs")
	if Input.is_action_just_released("down") or Input.is_action_just_released("up") or Input.is_action_just_released("left") or Input.is_action_just_released("right"):
		$Anim/AnimatedSprite2D.stop()
		$Anim/AnimatedSprite2D2.stop()
		
	if Input.is_action_just_pressed("hit"):
		$Anim/AnimatedSprite2D.hide()
		$Anim/AnimatedSprite2D3.show()
		$Anim/AnimatedSprite2D3.play("truba_hit")
		if $Anim/AnimatedSprite2D3.frame == 0:
			$hit.play()
		
		
		var raycastObj = $Anim/AnimatedSprite2D3/RayCast2D.get_collider()
		if $Anim/AnimatedSprite2D3/RayCast2D.is_colliding() and raycastObj.has_signal("enemy"):
				raycastObj.health -= damage

func _physics_process(delta):
	get_input()
	move_and_slide()
	$Camera2D.rotation_degrees = position.x * 0.005

func _on_animated_sprite_2d_3_animation_finished():
	$Anim/AnimatedSprite2D3.hide()
	$Anim/AnimatedSprite2D.show()
