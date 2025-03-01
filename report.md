# Report

## 1. Phototaxis

## 2. Random walk with collision avoidance

### General idea
The robot moves randomly until he detects an obstacle on his front-right or front-left side.

When an obstacle is detected the robot stops moving and starts turning to the opposite side until there's no more obstacles on either sides, and goes back to the random moving behavior.

### Formalization
Here is the state diagram of the controller:
![Random walk with collision avoidance state diagram](./random_walk_collision_avoidance.png)

### Why stops moving

### Why stops turning when there are no obstacle on either sides

### Multiple robots?

### Sensors noise?
