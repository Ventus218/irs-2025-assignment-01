-- Put your global variables here

-- States 
STATE_RANDOM_WALK = 0
STATE_OBSTACLE_RIGHT = 1
STATE_OBSTACLE_LEFT = 2

-- Sides
SIDE_LEFT = 0
SIDE_RIGHT = 1

-- Parameters
N_SENSORS = 3
VELOCITY = 20
TURN_VELOCITY = 5

-- Global vars
state = 0

function init()
	reset()
end

function step()
	if state == STATE_RANDOM_WALK then
		if obstacle_left(N_SENSORS) then
			state = STATE_OBSTACLE_LEFT
		elseif obstacle_right(N_SENSORS) then
			state = STATE_OBSTACLE_RIGHT
		else
			robot.wheels.set_velocity(VELOCITY, VELOCITY)
		end

	elseif state == STATE_OBSTACLE_LEFT then
		if obstacle_any_dir(N_SENSORS) then
			robot.wheels.set_velocity(TURN_VELOCITY, -TURN_VELOCITY)
		else 
			state = STATE_RANDOM_WALK
		end
		
	elseif state == STATE_OBSTACLE_RIGHT then
		if obstacle_any_dir(N_SENSORS) then
			robot.wheels.set_velocity( -TURN_VELOCITY, TURN_VELOCITY)	
		else 
			state = STATE_RANDOM_WALK
		end
	end

	log_state()
end

function obstacle(n_sensors, side)
	found_obstacle = false
	for i=0, n_sensors do
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

function obstacle_left(n_sensors)
	return obstacle(n_sensors, SIDE_LEFT)
end
function obstacle_right(n_sensors)
	return obstacle(n_sensors, SIDE_RIGHT)
end
function obstacle_any_dir(n_sensors)
	return obstacle_left(n_sensors) or obstacle_right(n_sensors)
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
	robot.wheels.set_velocity(0, 0)
end

function destroy()

end
