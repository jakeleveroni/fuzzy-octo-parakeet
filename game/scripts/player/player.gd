extends CharacterBody2D;

@export var speed = 300;
@export var run_modifier = 2.5;

var current_direction

# TODO: remove, only used for testing with interaction areas
var original_color: Color;

enum DIRECTION {
	UP,
	UP_LEFT,
	UP_RIGHT,
	DOWN,
	DOWN_LEFT,
	DOWN_RIGHT,
	LEFT,
	RIGHT,
	IDLE
};

var IS_KEY_UP = false;
var IS_KEY_DOWN = false;
var IS_KEY_LEFT = false;
var IS_KEY_RIGHT = false;
var IS_RUNNING = false;

# used to map up/down/left/right to isometric compatible directions so we can just pass normal catesian coords for our diagonal movement
func cartesian_to_isometric(cartesian: Vector2):
	return Vector2(cartesian.x - cartesian.y, (cartesian.x + cartesian.y) / 2);

func _ready():
	# add to group "player" which is the group name that interaction tiles will check for	
	add_to_group("player");
	
	# TODO: remove, only used for testing interaction areas
	original_color = $AnimatedSprite2D.modulate;

func _process(_delta: float) -> void:
	set_input_state();
	set_direction();
	move();


func set_direction():
	if IS_KEY_UP:
		if IS_KEY_LEFT:
			current_direction = DIRECTION.UP_LEFT;
		elif IS_KEY_RIGHT:
			current_direction = DIRECTION.UP_RIGHT;
		else:
			current_direction = DIRECTION.UP;
	elif IS_KEY_DOWN:
		if IS_KEY_LEFT:
			current_direction = DIRECTION.DOWN_LEFT;
		elif IS_KEY_RIGHT:
			current_direction = DIRECTION.DOWN_RIGHT;
		else:
			current_direction = DIRECTION.DOWN;
	elif IS_KEY_LEFT:
		current_direction = DIRECTION.LEFT;
	elif IS_KEY_RIGHT:
		current_direction = DIRECTION.RIGHT;
	else:
		current_direction = DIRECTION.IDLE;

func set_input_state():
	IS_KEY_UP = Input.is_action_pressed("move_up");
	IS_KEY_DOWN = Input.is_action_pressed("move_down");
	IS_KEY_LEFT = Input.is_action_pressed("move_left");
	IS_KEY_RIGHT = Input.is_action_pressed("move_right");
	IS_RUNNING = Input.is_action_pressed("run");

func move():
	var calculated_speed = speed;
	if IS_RUNNING:
		calculated_speed = speed * run_modifier;
		$AnimatedSprite2D.speed_scale = 2;
	else:
		$AnimatedSprite2D.speed_scale = 1;
		
	match current_direction:
		DIRECTION.UP:
			self.velocity = Vector2(0, -calculated_speed);
			$AnimatedSprite2D.play("up");
		DIRECTION.UP_LEFT:
			self.velocity = cartesian_to_isometric(Vector2(-calculated_speed, 0));
			$AnimatedSprite2D.play("up_left");
		DIRECTION.UP_RIGHT:
			self.velocity = cartesian_to_isometric(Vector2(0, -calculated_speed));
			$AnimatedSprite2D.play("up_right");
		DIRECTION.DOWN:
			self.velocity = Vector2(0, calculated_speed);
			$AnimatedSprite2D.play("down");
		DIRECTION.DOWN_LEFT:
			self.velocity = cartesian_to_isometric(Vector2(0, calculated_speed));
			$AnimatedSprite2D.play("down_left");
		DIRECTION.DOWN_RIGHT:
			self.velocity = cartesian_to_isometric(Vector2(calculated_speed, 0));
			$AnimatedSprite2D.play("down_right");
		DIRECTION.LEFT:
			self.velocity = Vector2(1 * -calculated_speed, 0);
			$AnimatedSprite2D.play("left");
		DIRECTION.RIGHT:
			self.velocity = Vector2(-1 * -calculated_speed, 0);
			$AnimatedSprite2D.play("right");
		DIRECTION.IDLE:
			self.velocity = Vector2.ZERO;
			$AnimatedSprite2D.play("idle");

	move_and_slide();
	
func enter_interaction_area():
	$AnimatedSprite2D.modulate = Color.CRIMSON;
	
func exit_interaction_area():
	$AnimatedSprite2D.modulate = original_color;
