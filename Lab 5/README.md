##  Analog to Digital Converter

1.  Program the ATD conversion system on the board to convert the analog signal to a 12-bit number  
   between 0x000 and 0xFFF. The input will be taken from PE3. The output value should be stored in an   
   available register of your choice.
     
2.  Convert the above mentioned value to a BCD number with three digits (X.YZ) between   
    3.30 and 0.00. 3.30 is the maximum voltage value which can be get from the GPIO ports of the board.
      
3.  Output the converted value on termite if there is a change in the voltage reading that is   
    greater than 0.2 volts.
