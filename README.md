
## What and Why ?
This is a test build I coded for a better understanding of the processes and calculations behind 3D projection mapping and rotaions around X, Y and Z axes for another embeded project and a probable 3D renderer i will build in the future.

I uploaded this because I wanted to keep a reference for the furture projects.

Check out the code it you want to ;)

P.S. Don't judge the code, i did not structure anything in a very proper manner and there might be reuntant code and variables

## Preview

![The GUI interface](https://github.com/user-attachments/assets/62b2abea-270c-4534-a76d-557fed6d58ab)
*The GUI interface*

## What is Processing?

[Processing](https://processing.org)  is an open-source programming language and development environment designed for creative coding. Built on [Java](https://www.java.com/en/), it simplifies syntax and workflow to enable rapid prototyping of visual applications, animations, and interactive projects. Processing abstracts Java's complexity, providing built-in methods for graphics, input handling, and multimedia. With cross-platform support and an active community, it’s ideal for developers looking to experiment with visual programming and computational design.



## Dependencies
Only one deppendency that is the Processing development platform, comes with the Processing IDE and the java executable.

Download Processing from [here](https://processing.org/download).


## Keyboard Inputs and Controls
There are some keyboard inputs to control the rotation of the cube on screen :-

- W/w : Rotates the cube along the X-axis in the negative direction
- S/s : Rotates the cube along the X-axis in the positive direction
- D/d : Rotates the cube along the Y-axis in the negative direction
- A/a : Rotates the cube along the Y-axis in the positive direction
- Q/q : Rotates the cube along the Z-axis in the negative direction
- E/e : Rotates the cube along the Z-axis in the positive direction
- R/r : Resets the rotation angles of all the axes to zero
- T/t : Toggles auto rotation on and off
- Space bar : Toggles auto rotation on and off

On sreen number box inputs (scroll or drag on top to control) :-

- X_Axis_Rotation_Multiplier : Sets the rotation rate/modifier for X-axis (in degrees)
- Y_Axis_Rotation_Multiplier : Sets the rotation rate/modifier for Y-axis (in degrees)
- Z_Axis_Rotation_Multiplier : Sets the rotation rate/modifier for Z-axis (in degrees)
- Rotation_Delay: Sets the delay between each rotation/ticks (in milliseconds)

### Note
Rotation modifier is the amount of rotation applied along an axis to the cube after each tick (rotation delay)
