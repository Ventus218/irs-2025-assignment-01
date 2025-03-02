
function init()
	reset()
end

function step()
-- ---------------------------- BEST SOLUTION UP TO NOW
	sens1 = robot.light[1].value
	sens24 = robot.light[24].value
	log("01: " .. sens1)
	log("24: " .. sens24)
	avg = (sens1 + sens24) / 2
	correction = (1 - avg) * 5
	right_velocity = 0
	left_velocity = 0
	if sens1 > sens24 then
		right_velocity = right_velocity + correction
	else 
		left_velocity = left_velocity + correction
	end
	robot.wheels.set_velocity(5 + left_velocity, 5 + right_velocity)
	
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
