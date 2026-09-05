extends CharacterBody2D

var dashes = 4
@export_range(0, 4) var max_dashes = 1
static var gravity = 3
var can_jump = false
static var sword_buffer_time = 0.15
var sword_buffer_timer = 0
static var released_time = 0.08
var released_timer = 0
var can_move = true
var is_dashing = false
var health = 5
var max_health = 4
var current_dir = "Right"
static var knockback_forcee = 500
var knockback_vel_x: int
var knockback_vel_y: int
@export var invincible = false
var stop_moving = false
var can_get_hit
var enemies_in_me = 0
var enemy_attacking = null
var can_change_dash = true
var can_boost = true
static var ray_buffer_time = 0.05
var ray_buffer_timer = 0.0
var can_dash = true

var sword_dir: String = "side"
var wall_sliding = false
@onready var timer: Timer = $Timer
@onready var dashtimer: Timer = $dashtimer
@onready var ray: RayCast2D = $RayCast2D
@onready var ray2: RayCast2D = $RayCast2D2
@onready var sword: Area2D = $sword
@onready var sword_anim: AnimationPlayer = $sword/AnimationPlayer
@onready var sword_collider: CollisionShape2D = $sword/CollisionShape2D
@onready var sword_sprite: ColorRect = $sword/ColorRect
@onready var i_frames_anim: AnimationPlayer = $i_frames_anim
@onready var hurtbox: Area2D = $Area2D2
@onready var color_rect: ColorRect = $ColorRect
@onready var dashtimer_reset: Timer = $Dashtimer_reset
var current_drawing = ""
var term_vel = 350
@onready var state_machine: StateMachine = $StateMachine
@onready var idle_state: State = $StateMachine/Idle
@onready var move_state: State = $StateMachine/Move
@onready var dash_state: State = $StateMachine/Dash
@onready var wallslide_state: State = $StateMachine/Wallslide
@onready var jump_state: State = $StateMachine/Jump
@onready var fall_state: State = $StateMachine/Fall

signal switch_state(state: State)
signal hit(lower_health: bool)
@onready var swordray: RayCast2D = $sword/swordray
@onready var swordray_2: RayCast2D = $sword/swordray2

@export_enum("Idle", "Walking", "Dashing", "Running") var movement
@export_enum("Disabled", "All dir", "Reversed", "No pogo") var sword_modes
static var speed = 37000
static var dashspeed = 17500
var dashable = true
static var jump_buffer_time = 0.1
var jump_buffer_timer = 0
var lerp_movement = false
static var coyote_time = 0.1
var coyote_timer = 0
static var wall_slide_time = 0.07
var wall_slide_timer = 0
var can_hit = true
var is_pogoing = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#if Globals.player_pos != Vector2.ZERO:
	#	position = Globals.player_pos
	PlayerGlobals.number_of_dashes = dashes
	sword_collider.disabled = true
	sword_sprite.visible = false
	hurtbox.monitoring = true
	can_move = true

# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var dir = Input.get_axis("Left", "Right")
	if wall_sliding == false && can_move:
		if movement == "Idle":
			velocity.x = 0
		elif movement == "Walking":
			velocity.x = dir * speed * _delta
		elif movement == "Dashing":
			velocity.x = dashspeed * _delta
		if Input.is_action_pressed("Left") && !state_machine.active_state == dash_state && !Input.is_action_pressed("Right"):
			current_dir = "Left"
		if Input.is_action_pressed("Right") && !state_machine.active_state == dash_state && !Input.is_action_pressed("Left"):
			current_dir = "Right"
	#--------------------Change states--------------------------
	#region
	if state_machine.active_state == idle_state:
		if Input.get_axis("Left", "Right"):
			switch_state.emit(move_state)
		if Input.is_action_just_pressed("Jump"):
			switch_state.emit(jump_state)
		if Input.is_action_just_pressed("dash") && PlayerGlobals.dashes > 0 && dashable:
			switch_state.emit(dash_state)
	if state_machine.active_state == move_state:
		if !Input.get_axis("Left", "Right"):
			switch_state.emit(idle_state)
		if Input.is_action_just_pressed("Jump"):
			switch_state.emit(jump_state)
		if Input.is_action_just_pressed("dash") && PlayerGlobals.dashes > 0 && dashable:
			switch_state.emit(dash_state)
		if !is_on_floor():
			switch_state.emit(fall_state)
	if state_machine.active_state == jump_state:
		if Input.is_action_just_pressed("dash") && PlayerGlobals.dashes > 0 && dashable:
			switch_state.emit(dash_state)
		if velocity.y > 0:
			switch_state.emit(fall_state)
		if (ray.is_colliding() || ray2.is_colliding()) && jump_buffer_timer > 0:
			switch_state.emit(wallslide_state)
	if state_machine.active_state == fall_state:
		if Input.is_action_just_pressed("dash") && PlayerGlobals.dashes > 0 && dashable:
			switch_state.emit(dash_state)
		if is_on_floor():
			if !Input.get_axis("Left", "Right"):
				switch_state.emit(idle_state)
			else:
				switch_state.emit(move_state)
		if (ray.is_colliding() || ray2.is_colliding()):
			switch_state.emit(wallslide_state)
		if jump_buffer_timer > 0:
			if wall_slide_timer > 0:
				switch_state.emit(wallslide_state)
			else:
				switch_state.emit(jump_state)
		if velocity.y > 0:
			is_pogoing = false
	if state_machine.active_state == dash_state:
		if can_dash:
			if (ray.is_colliding() || ray2.is_colliding()):
				switch_state.emit(wallslide_state)
			if Input.get_axis("Left", "Right"):
				switch_state.emit(move_state)
			elif is_on_floor():
				switch_state.emit(idle_state)
			else:
				switch_state.emit(fall_state)
	if state_machine.active_state == wallslide_state:
		if Input.is_action_just_pressed("dash") && PlayerGlobals.dashes > 0 && dashable:
			switch_state.emit(dash_state)
		if is_on_floor():
			switch_state.emit(idle_state)
		if !jump_buffer_timer > 0:
			if Input.is_action_pressed("Left") && current_dir == "Right" && !Input.is_action_pressed("Right"):
				switch_state.emit(move_state)
			if Input.is_action_pressed("Right") && current_dir == "Left" && !Input.is_action_pressed("Left"):
				switch_state.emit(move_state)
			if !(ray.is_colliding() || ray2.is_colliding()):
				switch_state.emit(fall_state)
	#endregion
	if !Input.is_action_pressed("Jump") && velocity.y <= 0 && is_pogoing == false:
		velocity.y /= 1.02
	# ---------------------Attacking--------------------
	#region
	if Input.is_action_just_pressed("Attack"):
		sword_buffer_timer = sword_buffer_time
	
	if sword_modes == "Disabled":
		pass
	if sword_modes == "All dir":
		if sword_buffer_timer > 0 && !sword_anim.is_playing():
			if current_dir == "Left":
				if !sword_anim.is_playing():
					if !(ray.is_colliding() || ray2.is_colliding()) && wall_sliding == false:
						
						sword.scale.x = -1
					elif wall_sliding:
						sword.scale.x = 1
			if current_dir == "Right":
				if !sword_anim.is_playing():
					if !(ray.is_colliding() || ray2.is_colliding()):
						sword.scale.x = 1
					elif wall_sliding:
						sword.scale.x = -1
			if Input.is_action_pressed("Up") && wall_sliding == false && !Input.is_action_pressed("Down"):
				if (!ray.is_colliding() && !ray2.is_colliding()):
					sword_dir = "up"
					if !sword_anim.is_playing():
						if current_dir == "Left":
							
							sword.rotation_degrees = 90
						else:
							sword.rotation_degrees = -90
			elif Input.is_action_pressed("Down") && wall_sliding == false && !is_on_floor() && !Input.is_action_pressed("Up"):
				if (!ray.is_colliding() && !ray2.is_colliding()):
					if !sword_anim.is_playing():
						sword_dir = "down"
						if current_dir == "Left":
							sword.rotation_degrees = -90
						else:
							sword.rotation_degrees = 90
			else:
				sword_dir = "side"
				sword.rotation_degrees = 0
			sword_anim.play("Attack")
			sword_buffer_timer = 0
		if Input.is_action_pressed("Up") && !Input.is_action_pressed("Down"):
			if !sword_anim.is_playing():
				sword.rotation_degrees = -90
		elif Input.is_action_pressed("Down") && !Input.is_action_pressed("Up"):
			if !sword_anim.is_playing():
				sword.rotation_degrees = 90
		else:
			sword.rotation_degrees = 0
	
	if sword_modes == "Reversed":
		if sword_buffer_timer > 0 && !sword_anim.is_playing():
			if current_dir == "Left":
				sword.scale.x = 1
			if current_dir == "Right":
				sword.scale.x = -1
			sword_anim.play("Attack")
			sword_buffer_timer = 0
			sword.rotation_degrees = 0
	
	if sword_modes == "No pogo":
		if sword_buffer_timer > 0 && !sword_anim.is_playing():
			if current_dir == "Left":
				if !sword_anim.is_playing():
					if !(ray.is_colliding() || ray2.is_colliding()) && wall_sliding == false:
						
						sword.scale.x = -1
					elif wall_sliding:
						sword.scale.x = 1
			if current_dir == "Right":
				if !sword_anim.is_playing():
					if !(ray.is_colliding() || ray2.is_colliding()):
						sword.scale.x = 1
					elif wall_sliding:
						sword.scale.x = -1
			if Input.is_action_pressed("Up") && wall_sliding == false:
				if (!ray.is_colliding() && !ray2.is_colliding()):
					sword_dir = "up"
					if !sword_anim.is_playing():
						if current_dir == "Left":
							
							sword.rotation_degrees = 90
						else:
							sword.rotation_degrees = -90
			else:
				sword_dir = "side"
				sword.rotation_degrees = 0
			sword_anim.play("Attack")
			sword_buffer_timer = 0
		if Input.is_action_pressed("Up"):
			if !sword_anim.is_playing():
				sword.rotation_degrees = -90
		else:
			sword.rotation_degrees = 0
	if sword_buffer_timer > 0:
		sword_buffer_timer -= 1 * _delta
	
	if knockback_vel_x:
		velocity.x = knockback_vel_x
	if knockback_vel_y:
		velocity.y = knockback_vel_y
	
	#endregion
	# ----------------------Direction---------------------
	#region
	if current_dir == "Left":
		if !sword_anim.is_playing():
			if !(ray.is_colliding() || ray2.is_colliding()) && !wall_sliding:
				sword.scale.x = -1
			elif wall_sliding:
				
				sword.scale.x = 1
		ray.target_position.x = -6.15
		ray2.target_position.x = -6.15
	else:
		if !sword_anim.is_playing():
			if !(ray.is_colliding() || ray2.is_colliding()) && !wall_sliding:
				sword.scale.x = 1
			elif wall_sliding:
				
				sword.scale.x = -1
		ray.target_position.x = 6.15
		ray2.target_position.x = 6.15
	#endregion
	# ----------------------Wall Jumping---------------------
	#region

		#if velocity.y < 0 && jump_buffer_timer > 0 && !is_on_floor() && is_dashing == false:
		#	velocity.y = lerp(velocity.y, 0.0, 0.05)
#	if (ray.is_colliding() || ray2.is_colliding()) || ray_buffer_timer > 0:
#		if velocity.y > 0:
#			wall_sliding = true
#		
#		stop_moving = true
#		if Input.is_action_pressed("Up"):
#			term_vel = 70
#		elif Input.is_action_pressed("Down"):
#			term_vel = 250
#		else:
#			term_vel = 150
#		if jump_buffer_timer > 0 && !is_on_floor() && is_dashing == false:
#			
#			can_move = false
#			timer.start()
#			jump_buffer_timer = 0
#			coyote_timer = 0
#			velocity.y = 0
#			velocity.y = -truedashspeed
#			if current_dir == "Left":
#				if (ray.is_colliding() || ray2.is_colliding()):
#					velocity.x = 250
#					current_dir = "Right"
#				else:
#					velocity.x = -250
#			elif current_dir == "Right":
#				if (ray.is_colliding() || ray2.is_colliding()):
#					velocity.x = -250
#					current_dir = "Left"
#				else:
#					velocity.x = 250
		
		
#	else:
#		wall_sliding = false
#		term_vel = 500
#	if stop_moving == false:
#		velocity.x = lerp(velocity.x, 0.0, 0.05)
#		if velocity.y < 0 && jump_buffer_timer > 0 && !is_on_floor() && is_dashing == false:
#			velocity.y = lerp(velocity.y, 0.0, 0.05)
#	
#	if (ray.is_colliding() || ray2.is_colliding()):
#		ray_buffer_timer = ray_buffer_time
#	
#	if ray_buffer_timer > 0:
#		ray_buffer_timer -= 1 * _delta
	#endregion
	# ---------------------On floor stuff ---------------------
	#region
	if state_machine.active_state != dash_state:
		if !is_on_floor():
	#		if coyote_timer <= 0:
	#			pass
			if !velocity.y > term_vel:
				if is_dashing == false:
					velocity.y += gravity
			else:
				velocity.y = term_vel
		else:
			stop_moving = true
			if is_dashing == false:
				PlayerGlobals.dashes = PlayerGlobals.number_of_dashes
		
		max_dashes = PlayerGlobals.number_of_dashes
	
	#endregion
	# --------------------- Health/Damage ------------------------
	#region
	
	
	if enemy_attacking != null:
		
		#Engine.
		#if health > 0:
		if enemy_attacking.name == "Spikes":
			switch_state.emit(idle_state)
			position = PlayerGlobals.last_checkpoint
			velocity = Vector2.ZERO
			is_dashing = false
			i_frames_anim.play("i frames")
			invincible = true
			hit.emit(true)
			if can_hit == true:
				health -= 1
				can_hit = false
		else:
			if !invincible:
				hit.emit(true)
				var knockback_direction = Vector2(-1, 0.3)
				if enemy_attacking.position.x > position.x:
					knockback_direction.x = 1
					knockback_direction.y = 0.3
				get_knockback(knockback_direction, knockback_forcee)
				i_frames_anim.play("i frames")
				invincible = true
				if can_hit == true:
					health -= 1
					can_hit = false
	#endregion
	if Input.is_action_just_pressed("Jump"):
		jump_buffer_timer = jump_buffer_time
	if is_on_floor():
			coyote_timer = coyote_time
	if coyote_timer > 0:
		coyote_timer -= 1 * _delta
	if wall_slide_timer > 0:
		wall_slide_timer -= 1 * _delta
	if jump_buffer_timer > 0:
		jump_buffer_timer -= 1 * _delta
	move_and_slide()
	

func _on_timer_timeout() -> void:
	can_move = true
	stop_moving = false

func _on_area_2d_2_body_entered(_body: Node2D) -> void:
	enemies_in_me += 1
	enemy_attacking = _body
	can_hit = true

func _on_area_2d_2_body_exited(_body: Node2D) -> void:
	enemies_in_me -= 1
	
	enemy_attacking = null

func get_knockback(knockback_dir, knockback_force):
	knockback_vel_x = -(knockback_dir.x * knockback_force)
	knockback_vel_y = -(knockback_dir.y * knockback_force)
	
	await get_tree().create_timer(0.125).timeout
	stop_moving = false
	
	knockback_vel_x = 0
	knockback_vel_y = 0


func _on_sword_body_entered(_body: Node2D) -> void:
	if Input.is_action_pressed("Down") && PlayerGlobals.dashes > 0 && can_boost == true && !is_on_floor() && !(ray.is_colliding() || ray2.is_colliding()) && sword_dir == "down":
		if !_body.name == "betatileset":
			velocity.y = 0
			PlayerGlobals.dashes -= 1
			velocity.y -= 270
			can_boost = false
			is_pogoing = true
	if sword.scale.x == -1:
		if (!Input.is_action_pressed("Down") && !Input.is_action_pressed("Up")) && (swordray.is_colliding() || swordray_2.is_colliding()):
			knockback_vel_x = 1 * 100
			await get_tree().create_timer(0.1).timeout
			stop_moving = false
			knockback_vel_x = 0
	else:
		if (!Input.is_action_pressed("Down") && !Input.is_action_pressed("Up")) && (swordray.is_colliding() || swordray_2.is_colliding()):
			knockback_vel_x = -1 * 100
			await get_tree().create_timer(0.1).timeout
			stop_moving = false
			knockback_vel_x = 0

func _on_sword_body_exited(_body: Node2D) -> void:
	pass # Replace with function _body.


func _on_pogo_timer_timeout() -> void:
	can_boost = true

func _on_dashtimer_timeout() -> void:
	can_dash = true
	dashable = false
	dashtimer_reset.start()


func _on_dashtimer_reset_timeout() -> void:
	dashable = true

func heal(hearts):
	health += hearts
