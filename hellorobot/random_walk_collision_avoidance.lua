-- Put your global variables here

VELOCITY = 20
START_TURNING_TRESHOLD = 0


--[[ This function is executed every time you press the 'execute'
     button ]]
function init()
	robot.wheels.set_velocity(0, 0)
end



--[[ This function is executed at each time step
     It must contain the logic of your controller ]]
function step()

	robot.wheels.set_velocity(VELOCITY, VELOCITY)

	-- use an even number
	avg_n = 6
	avg = 0
	for i=0, (avg_n / 2) - 1 do
		avg = avg + robot.proximity[1 + i].value 
		avg = avg + robot.proximity[24 - i].value
	end
	avg = avg / avg_n
	log(avg)

	if avg > START_TURNING_TRESHOLD then
		correction_coefficient = (avg - START_TURNING_TRESHOLD) / (0.15 - START_TURNING_TRESHOLD)
		correction = 40 * correction_coefficient
		left_v = VELOCITY - VELOCITY * correction_coefficient
		robot.wheels.set_velocity(left_v, VELOCITY + correction)
	end
end



--[[ This function is executed every time you press the 'reset'
     button in the GUI. It is supposed to restore the state
     of the controller to whatever it was right after init() was
     called. The state of sensors and actuators is reset
     automatically by ARGoS. ]]
function reset()
	robot.wheels.set_velocity(0, 0)
end



--[[ This function is executed only once, when the robot is removed
     from the simulation ]]
function destroy()
   -- put your code here
end
