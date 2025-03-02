
VELOCITY = 15
MAX_TURN_VELOCITY = 20

function init()
	reset()
end

function step()
	-- sensing light left and right
	sens_l = robot.light[1].value
	sens_r = robot.light[24].value

	-- want just the direction ignoring intensity
	min_light_detected = 0
	max_light_detected = 0
	for i=1,#robot.light do
		value = robot.light[i].value
		if max_light_detected < value then
			max_light_detected = value
		end
		if min_light_detected > value then
			min_light_detected = value
		end
	end
	sens_l = (sens_l - min_light_detected) / (max_light_detected - min_light_detected)
	sens_r = (sens_r - min_light_detected) / (max_light_detected - min_light_detected)

	log("L: " .. sens_l)
	log("R: " .. sens_r)

	-- compute correction, higher if direction is much wrong, lower if not
	avg = (sens_l + sens_r) / 2
	correction = (1 - avg) * MAX_TURN_VELOCITY

	-- apply correction
	if (sens_l == 0) and (sens_r == 0) then
		robot.wheels.set_velocity(VELOCITY, VELOCITY + MAX_TURN_VELOCITY)
	elseif sens_l > sens_r then
		robot.wheels.set_velocity(VELOCITY, VELOCITY + correction)
	else 
		robot.wheels.set_velocity(VELOCITY + correction, VELOCITY)
	end
end

function reset()
	robot.wheels.set_velocity(0,0)
end

function destroy()
end
