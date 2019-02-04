1.  Write a subroutine which sends a GPIO port the necessary signals to demonstrate the Full Step Mode  
in both directions (clockwise or counterclockwise).  

2. Design a system that has two inputs from push buttons and provides a step to the  
stepper motor upon input. One button is to provide a step for clockwise rotation and the other is for   
counterclockwise rotation. You will use 4 buttons of the 4x4 Keypad Module introduced in Experiment-4.  
Draw the necessary connections between TM4C123G, L293D, 4x4 Keypad Module and stepper motor.  

3. According to hardware design in step-2, write a program that, in an inﬁnite loop, gives a step  
upon the release of one button and gives a step in the opposite direction upon the release of the other button.  
Assume that the other button is never pushed until the pressed button is released. The response of the   
motor should be after the button release. Be aware of bouncing inherent in the buttons.  

4. Design a system that has 4 inputs from push buttons to control a stepper motor.  
One button is for speeding up, one is for slowing down, the other two are for directions.   
Use 4 buttons of the 4x4 Keypad Module introduced in Lab 2. Draw the necessary   
connections between TM4C123G, L293D, 4x4 Keypad Module and stepper motor. 

![alt text](https://lh5.googleusercontent.com/05tE8FUinj5ea1NUmDa8RIn2YPiMHd9VdTx305nzQKMrjAiYD6diqdHYp8bGIR1VilyK4Jt0VUtgkhrCgIWIqSi-LnfQzKX3z-5Mmy0-)

5. Write a program that, in an inﬁnite loop, drives a stepper motor speed and direction  
of which can be controlled by external push buttons. Assume that the no button is ever  
pushed until a pressed button is released. The controls should be applied upon releasing   
the corresponding button. Be aware of bouncing inherent in the buttons.
