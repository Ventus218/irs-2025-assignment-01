
VELOCITY = 15

function init()
	reset()
end

function step()
-- ---------------------------- BEST SOLUTION UP TO NOW
	sens_l = robot.light[3].value
	sens_r = robot.light[22].value
	log("L: " .. sens_l)
	log("R: " .. sens_r)
	avg = (sens_l + sens_r) / 2
	diff = math.abs(sens_l - sens_r)
	correction = diff * 50
	if (sens_l >= sens_r) or ((sens_l == 0) and (sens_r == 0))  then
		robot.wheels.set_velocity(VELOCITY, VELOCITY + correction)
	else 
		robot.wheels.set_velocity(VELOCITY + correction, VELOCITY)
	end
	
-- ----------------------------

	-- sens1 = robot.light[1].value
	-- sens24 = robot.light[24].value

	-- left_velocity = 0
	-- right_velocity = 0
	-- if sens1 > sens24 then
	-- 	right_velocity = right_velocity + 1
	-- else 
	-- 	left_velocity = left_velocity + 1
	-- end
	-- robot.wheels.set_velocity(5 + left_velocity, 5 + right_velocity)

end

function reset()
	robot.wheels.set_velocity(0,0)
end

function destroy()
end
