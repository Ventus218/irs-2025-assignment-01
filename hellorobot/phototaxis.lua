-- Put your global variables here

--[[ This function is executed every time you press the 'execute'
     button ]]
function init()
end



--[[ This function is executed at each time step
     It must contain the logic of your controller ]]
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



--[[ This function is executed every time you press the 'reset'
     button in the GUI. It is supposed to restore the state
     of the controller to whatever it was right after init() was
     called. The state of sensors and actuators is reset
     automatically by ARGoS. ]]
function reset()
	robot.wheels.set_velocity(0,0)
	n_steps = 0
end



--[[ This function is executed only once, when the robot is removed
     from the simulation ]]
function destroy()
   -- put your code here
end
