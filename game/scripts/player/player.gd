extends CharacterBody2D;

@export var speed = 300;

var current_direction

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

var KEY_UP = false;
var KEY_DOWN = false;
var KEY_LEFT = false;
var KEY_RIGHT = false;

# used to map up/down/left/right to isometric compatible directions so we can just pass normal catesian coords for our diagonal movement
func cartesian_to_isometric(cartesian: Vector2):
	return Vector2(cartesian.x - cartesian.y, (cartesian.x + cartesian.y) / 2);

func _process(_delta: float) -> void:
	set_inputs();
	set_direction();
	move();


func set_direction():
	if KEY_UP:
		if KEY_LEFT:
			current_direction = DIRECTION.UP_LEFT;
		elif KEY_RIGHT:
			current_direction = DIRECTION.UP_RIGHT;
		else:
			current_direction = DIRECTION.UP;
	elif KEY_DOWN:
		if KEY_LEFT:
			current_direction = DIRECTION.DOWN_LEFT;
		elif KEY_RIGHT:
			current_direction = DIRECTION.DOWN_RIGHT;
		else:
			current_direction = DIRECTION.DOWN;
	elif KEY_LEFT:
		current_direction = DIRECTION.LEFT;
	elif KEY_RIGHT:
		current_direction = DIRECTION.RIGHT;
	else:
		current_direction = DIRECTION.IDLE;

func set_inputs():
	KEY_UP = Input.is_action_pressed("move_up");
	KEY_DOWN = Input.is_action_pressed("move_down");
	KEY_LEFT = Input.is_action_pressed("move_left");
	KEY_RIGHT = Input.is_action_pressed("move_right");

func move():
	match current_direction:
		DIRECTION.UP:
			self.velocity = Vector2(0, -speed);
			$AnimatedSprite2D.play("up");
		DIRECTION.UP_LEFT:
			self.velocity = cartesian_to_isometric(Vector2(-speed, 0));
			$AnimatedSprite2D.play("up_left");
		DIRECTION.UP_RIGHT:
			self.velocity = cartesian_to_isometric(Vector2(0, -speed));
			$AnimatedSprite2D.play("up_right");
		DIRECTION.DOWN:
			self.velocity = Vector2(0, speed);
			$AnimatedSprite2D.play("down");
		DIRECTION.DOWN_LEFT:
			self.velocity = cartesian_to_isometric(Vector2(0, speed));
			$AnimatedSprite2D.play("down_left");
		DIRECTION.DOWN_RIGHT:
			self.velocity = cartesian_to_isometric(Vector2(speed, 0));
			$AnimatedSprite2D.play("down_right");
		DIRECTION.LEFT:
			self.velocity = Vector2(1 * -speed, 0);
			$AnimatedSprite2D.play("left");
		DIRECTION.RIGHT:
			self.velocity = Vector2(-1 * -speed, 0);
			$AnimatedSprite2D.play("right");
		DIRECTION.IDLE:
			self.velocity = Vector2.ZERO;
			$AnimatedSprite2D.play("idle");

	move_and_slide();
