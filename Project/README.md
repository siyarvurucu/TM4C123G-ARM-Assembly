# Battleship Game Console

A platform to play a diﬀerent version of the famous ”Battleship” game. Player turn-based strategy   
game controlled with two joysticks and two push buttons and played on a mobile phone screen.

The game is played in two stages: The ships are deployed in the ﬁrst stage and they are tried  
to be destroyed with mines in the second stage.

### Deployment

  The ﬁrst player (P1) takes the turn. Moves the cursor on the empty screen using two joysticks, one for  
up-down and the other for left-right movement. When he decides on a good spot, he places the ﬁrst ship  
by pressing Button-1. Then he places three other ships on the screen one after the other, in a similar  
way. He is just about to give the turn to his enemy. However, P1 played a little trick: The ships that  
he placed are not all battleships, some of them carry civilians indeed. He did this just by pressing the  
other button (Button-2) while placing the ships. He overlooks at the screen for the last time to see how  
he placed the 4 ships and presses a button to clear the screen. The ships are cleared from the screen   
and the user is prompted that it is P2’s turn now.

### Attack  

The second player (P2) takes the turn. The screen is blank. P2 concentrates himself on the screen and   
as soon as he presses a button the screen is all revealed. He is able to see the location of all 4 enemy   
ships now! Not only that, he can also see which are battleships and which are civilian ships, since they  
are diﬀerent in shape.
However, this sneak peek only lasts for about half a second. After 0.5 seconds, the screen is cleared   
back again. Now P2 has the control and he has to place the mines on the screen to hit the enemy battleships.  
Similar to what P1 did, his task is to move the cursor using the joysticks and place the mines using a button.  
However, there are the following challenges:  

• P2 could see the positions of the ships for only a short period, and now he has to rely on his memory to place the mines. • It is not acceptable to hit civilian ships.  
• The placement of the mines has to be done in 20 seconds. P2 can see how much time is left from the clock that counts down on the upper right corner of the screen.  

After 20 seconds is passed, the game engine checks the positions of ships with the position of mines.   
If the mines could successfully hit all the battleships without hurting any civilian ships then P2 wins the game,  
celebrated with a victory announcement on the screen. Otherwise game is over for P2, which is declared with a  
humiliating message from the enemy.  

After the game ends, it starts back from the deployment phase for a new game.  

![alt text](https://github.com/srvrc/TM4C123G-ARM-Assembly/blob/master/Project/capture1.JPG)  
                                  Hardware  
                                  
![alt text](https://github.com/srvrc/TM4C123G-ARM-Assembly/blob/master/Project/Capture2.JPG)  
                                  Screen
