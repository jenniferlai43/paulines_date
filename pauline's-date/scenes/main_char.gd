extends CharacterBody2D

@onready var game_manager: Node = %game_manager
@onready var dialogue: CanvasLayer = %dialogue

const SPEED = 300.0
const JUMP_VELOCITY = -625.0

@onready var sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_sfx: AudioStreamPlayer = $jump_sfx

func _physics_process(delta: float) -> void:
	
	if (game_manager.is_cutscene || game_manager.dialogue_is_active):
		# Make sure pauline is idle during dialogue scenes.
		sprite_2d.animation = "pauline_idle"
	
	# If this is a cutscene, user is not allowed to click anything.
	if (game_manager.is_cutscene == true):
		return
	
	# If character is in dialogue, do allow clicking "next" on the text until
	# there is no more text to display.
	if (game_manager.dialogue_is_active == true):
		if Input.is_action_just_pressed("interact"):
			dialogue.display_next_text()
		return
	
	if (velocity.x > 1 || velocity.x < -1):
		sprite_2d.animation = "pauline_running"	
	else:
		sprite_2d.animation = "pauline_idle"
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		sprite_2d.animation = "pauline_jump"

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_sfx.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 10)

	move_and_slide()
	
	if velocity.x == 0:
		# Don't change direction
		return
	
	var is_left = velocity.x < 0
	sprite_2d.flip_h = is_left
