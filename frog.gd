extends CharacterBody2D

var SPEED = 50
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var chase = false
var player 
var sprite 

func _ready():
	sprite = get_node("AnimatedSprite2D")
	sprite.play("idle")
	player = get_node("../../Player/player")

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	if chase:
		if not sprite.animation == "death":
			sprite.play("jump")
		
		var direction = (player.position - self.position).normalized()
		if direction.x > 0:
			sprite.flip_h = true
		else:
			sprite.flip_h = false
		velocity.x = direction.x * SPEED
	else:
		if not sprite.animation == "death":
			sprite.play("idle")
		velocity.x = 0
	move_and_slide()
	
	
func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.name == "player":
		chase = true


func _on_player_detection_body_exited(body: Node2D) -> void:
	if body.name == "player":
		chase = false
		print("No longer chasing")


func _on_player_death_body_entered(body: Node2D) -> void:
	if body.name == "player" && ! sprite.animation == "death":
		print("Kill!")
		death()


func _on_player_collision_body_entered(body: Node2D) -> void:
	if body.name == "player" && ! sprite.animation == "death":
		Game.playerHP -= 1	
		self.death()
		print("Collided, but gained gold")
		
			
func death():
	Game.gold += 5
	chase = false
	sprite.play("death")
	await sprite.animation_finished
	self.queue_free()	
	Utils.saveGame()
