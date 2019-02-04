1. Write a subroutine, CONVRT, that converts an m-digit decimal number represented by n bits (n < 32) in register R4 into such a format that the ASCII codes of the digits of its decimal equivalent would listed in the memory starting from the location address of which is stored in register R5. When printed using OutStr, the printed number is to contain no leading 0s, that is, exactly m digits should be printed for an m-digit decimal number. Before writing the subroutine, the corresponding pseudo-code or ﬂow chart is to be generated.
Some exemplar printings (righthand side) for the corresponding register contents (lefthand side) are provided below:   
R4: 0x7FFFFFFF --- 2147483647 (max. value possible)   
R4: 0x0000000A --- 10    
R4: 0x00000000 --- 0
  
2. Write a program that, in an inﬁnite loop, waits for a user prompt (any key to be pressed) and prints the decimal equivalent of the number stored in 4 bytes starting from the memory location NUM. Note that you may deﬁne NUM by using proper assembly directives. In this part, you are expected to use the subroutine you are written in Part-1. Explain which arguments should be passed and how.  
   
3. Write a program for decimal number guessing using binary search method. The number is to be an integer in the range (0,2n), i.e. 0 < number < 2n, where n < 32 and n is determined by a user-input. Then, the guessing phase is to be handled through a simple interface where the processor outputs its current guess in decimal base and calculate the next according to the user inputs, D standing for down, U standing for up, or C standing for correct. To fulﬁll the requirements given above, include the subroutine CONVRT from the Part-1 in your main program as well as a new subroutine UPBND that updates the search boundaries after each guess. Prior to writing the code itself, draw a ﬂowchart of the main algorithm leaving the subroutine parts as black boxes.  
  
4. Imagine you are in a fantastic realm where you are trapped in a fortress controlled by two evil creatures. Surprisingly enough, Vol’jin, the keeper of the fortress, the former of the two, is a little bit whimsy, he likes to play games with his hostages. Hence, he oﬀers you your freedom in exchange with your complicity, sort of a quid pro quo. He lends you a number of soulstones to be able to travel through portals and meanwhile do his dirty work. There are 4 portals that are created within the great hall of the fortress in which you can consume the soulstones upon passing through and return back to the great hall. Besides, within the great hall, there is a 5th portal, namely, the Dark Portal, that leads to the way out and it is guarded by Gul’dan. As is so often the case when Gul’dan, the latter and the more sinister of the two, is wroth by Vol’jin’s monkey business, he vents his anger on the hostages. He loathes the idea that those poor mortals would lay hands on his mighty soulstones. You had better not get caught red-handed, needless to say, with any soulstones left or he will make you suﬀer as much as you carry.  
  
Now that you are totally aware of the fact that each and every one of the claimed at the beginning are to be employed before facing Gul’dan, you search for the aforementioned portals. However, upon your reach at the portal, you notice that activation of each portal obeys a diﬀerent criterion.
  
Portal 1 : If the traveler has a number of soulstones larger than 99, this portal can be activated using 47 soulstones.  
Portal 2 : This one allows travelers holding an odd, larger than 50, number of soulstones provided that they use an amount that is equal to multiplication of the non-zero digits, in decimal base, they already have in hand to pass through.  
Portal 3 : Greedy by nature, this portal allows all travelers, except for the odd-numberbearers, to pass, by looting half of the soulstones.  
Portal 4 : If the number of soulstones remaining is a multiple of 7, then this portal is unlocked with the maximum number of soulstones possible, that is to be a multiple of 3.  
To make the long story short, you are expected to create a RECURSIVE function that returns the minimum number of soulstones where no further move is possible. Develop a ﬂowchart or pseudo-code of the algorithm and the corresponding assembly code itself and determine your fate, (wheter you will ﬂee or how much you will howl with pain), assuming that the number of soulstones retrieved at the beginning is a user-input. Please remember that the input is to be provided via Termite in decimal base and you are expected return the output via Termite in decimal base.  
The following examples are to illustrate what is meant by the aforementioned explanations.  
Ex: If you are given 147 soulstones, you may ﬂee with none (0 soulstones) since it is possible to spend them in a single step as such:  
147 ---- Portal 4 ---- 0 Input: 147, Output: 0  
Nevertheless, there is no possible way to spend all the soulstones if the initial is 100:   
100 ---- Portal 3 ---- 50  
50 ---- Portal 3 ---- 25  
OR 
100 ---- Portal 1 ---- 53 
53 ---- Portal 2 ---- 38  
38 ---- Portal 3 ---- 19 (min possible)
