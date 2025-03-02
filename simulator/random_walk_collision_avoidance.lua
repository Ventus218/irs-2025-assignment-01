-- Put your global variables here

-- States 
STATE_RANDOM_WALK = 0
STATE_OBSTACLE_RIGHT = 1
STATE_OBSTACLE_LEFT = 2

STATE_RANDOM_WALK_TURNING = 0
STATE_RANDOM_WALK_GOING_STRAIGHT = 1

-- Sides
SIDE_LEFT = 0
SIDE_RIGHT = 1

-- Parameters
N_SENSORS = 3
VELOCITY = 20
TURN_VELOCITY = 5
GO_STRAIGHT_SECONDS = 5
TURN_RIGHT_SECONDS = 1

-- Global vars
state = STATE_RANDOM_WALK
random_walk_inner_state = STATE_RANDOM_WALK_GOING_STRAIGHT
time_passed_since_started_turning = 0
time_passed_since_started_going_straight = 0

function init()
	reset()
end

function step()
	if state == STATE_RANDOM_WALK then
		if obstacle_left() then
			state = STATE_OBSTACLE_LEFT
			stop()
		elseif obstacle_right() then
			state = STATE_OBSTACLE_RIGHT
			stop()
		else
			move_randomly()
		end

	elseif state == STATE_OBSTACLE_LEFT then
		if obstacle_any_dir() then
			robot.wheels.set_velocity(TURN_VELOCITY, -TURN_VELOCITY)
		else 
			stop()
			state = STATE_RANDOM_WALK
			random_walk_state_entry()
		end
		
	elseif state == STATE_OBSTACLE_RIGHT then
		if obstacle_any_dir() then
			robot.wheels.set_velocity( -TURN_VELOCITY, TURN_VELOCITY)	
		else 
			stop()
			state = STATE_RANDOM_WALK
			random_walk_state_entry()
		end
	end

	log_state()
end

function stop() 
	robot.wheels.set_velocity(0, 0)
end

function random_walk_state_entry()
	random_walk_inner_state = STATE_RANDOM_WALK_GOING_STRAIGHT
	time_passed_since_started_turning = 0
	time_passed_since_started_going_straight = 0
end

function move_randomly()
	if random_walk_inner_state == STATE_RANDOM_WALK_GOING_STRAIGHT then
		time_passed_since_started_going_straight = time_passed_since_started_going_straight + 1
		if (time_passed_since_started_going_straight / 10) > GO_STRAIGHT_SECONDS then
			time_passed_since_started_going_straight = 0
			random_walk_inner_state = STATE_RANDOM_WALK_TURNING
			stop()
		else
			robot.wheels.set_velocity(VELOCITY, VELOCITY)
		end
	else
		time_passed_since_started_turning = time_passed_since_started_turning + 1
		if (time_passed_since_started_turning / 10) > TURN_RIGHT_SECONDS then
			time_passed_since_started_turning = 0
			random_walk_inner_state = STATE_RANDOM_WALK_GOING_STRAIGHT
			stop()
		else
			robot.wheels.set_velocity(TURN_VELOCITY, -TURN_VELOCITY)
		end
	end
end

function obstacle(side)
	found_obstacle = false
	for i=0, N_SENSORS do
		index = -1
		if side == SIDE_LEFT then
			index = 1 + i
		else 
			index = 24 - i
		end
		if robot.proximity[index].value > 0 then
			found_obstacle = true
		end
	end
	return found_obstacle
end

function obstacle_left()
	return obstacle(SIDE_LEFT)
end
function obstacle_right()
	return obstacle(SIDE_RIGHT)
end
function obstacle_any_dir()
	return obstacle_left() or obstacle_right()
end

function log_state()
	if state == STATE_RANDOM_WALK then
		log("STATE_RANDOM_WALK")
	elseif state == STATE_OBSTACLE_LEFT then
		log("STATE_OBSTACLE_LEFT")
	elseif state == STATE_OBSTACLE_RIGHT then
		log("STATE_OBSTACLE_RIGHT")
	end
end

function reset()
	state = STATE_RANDOM_WALK
	random_walk_inner_state = STATE_RANDOM_WALK_GOING_STRAIGHT
	time_passed_since_started_turning = 0
	time_passed_since_started_going_straight = 0
	robot.wheels.set_velocity(0, 0)
end

function destroy()

end
