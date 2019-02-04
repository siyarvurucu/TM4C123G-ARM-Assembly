##  Parallel Input/Output and Keyboard Interface

1. Write a subroutine, DELAY100, that causes approximately 100 msec delay upon calling.  
  
2. Write a program for a simple data transfer scheme. You are required to take inputs from push buttons and reﬂect the status of the buttons to the LEDs that are connected to the output port for approximately every 5 seconds. Namely, an input should be read for every 5 seconds and the status of that reading should remain at the output until the next reading. The status of a pressed button is 1 and the status of a released button is 0. You should use low nibble of Port B (B3 to B0) for inputs, and high nibble of Port B (B7 to B4) for outputs.  

3. Consider the interface of the 4x4 keypad. You are required to write a program that continuously detects which key is pressed and outputs the ID of the key through Termite Window after the key is released. The IDs can be sequential numbers. For instance, the ID of the key at row 1 and column 1 can be 0 and the key at row 4 and column 4 can be F (0:F total 16 IDs). You may assume that only one key is to be pressed at a time and no other key can be pressed before releasing a key. Your program should be robust to possible bouncing eﬀect during both pressing and releasing.
