Lab1_ECE382_Her
===============


Lab 1 for ECE 382, simple calculator program.

###Objective and Purpose
The objective and Purpose of this lab is to code a simple calculator using assembly language with various functions. The purpose is to practice higher-level if/then/else and looping constructs.

  Required Functionality:
  
    ADD_OP - add two numbers together
    
    SUB_OP - subtracts two numbers
    
    CLR_OP - clears value in accumulator  
    
    END_OP - Ends the program
  
  B Functionality:
  
    If result is above 255, only display 255.
    
    If result is below 0, only display 0.
  
  A Functionality:
  
    MUL_OP - implement multiplication, multiply two numbers together. 0(log(n))
  
###Implementation  

  Please Reference Pre-Lab assignment. (Turned into instructor)

###Code
Main:

![alt text](https://github.com/vipersfly23/CE3_Her/blob/master/Moore_Simulation.GIF?raw=true "simulation result")

  * R5 Points to the string of operations in ROM
  * R6 Is the accumulator
  * R7 Always stores the Operation
  * R8 Stores the second operator
  * R15 Stores the address for the results in RAM

R5 is incremented everytime, so it's going down the string and always points to the byte in-line. The pointer is the key to this code, and is the bread and butter of the simple calculator. 

Required Operations:

![alt text](https://github.com/vipersfly23/CE3_Her/blob/master/Moore_Simulation.GIF?raw=true "simulation result")

The reason R7 always stores the operation. Hence the value for each operation is compared to the value in R7. THe CLR_OP is checked before R8 is loaded with the second operator is because if the operation is a clear, then the next operator would need to be loaded into R6 and not R8 hence the sequence of the code.

ADD_OP:

- the two operators are simplied added together, stored into R6(accumulator). The program than checks to see if it is bigger than 255 or less than 0. It is then stored into a memory address, location is in R15. The code then checks for the next operation. 
 
SUB_OP:

- the second operator is subtracted from either the first operator or from the accmulator in R6. It is then stored into R6(accumulator). The program than checks to see if it is bigger than 255 or less than 0. It is then stored into a memory address, location is in R15. The code then checks for the next operation. 

CLR_OP:

- Essentially stores a value of 0 into the accumulator.

End_Op
- The ending operation was modified to compensate for invalide operations. Essentailly, if there isn't a valide operation, such as add, sub, clr, or mul, the program will automatically end. The value 0x55 is still included.

B-Funxtionality:

![alt text](https://github.com/vipersfly23/CE3_Her/blob/master/Moore_Simulation.GIF?raw=true "simulation result")

This is a simple check. It compares the value to 255, if it is greater, 255 is stored into R6. It then looks at the N flag, if there is a N flag, then the value is less than zero, and a 0 is stored in to R6.

A-Functionality

![alt text](https://github.com/vipersfly23/CE3_Her/blob/master/Moore_Simulation.GIF?raw=true "simulation result")

The multiplication operation was by far the most difficult part of this lab. I first conceptually thought about multiplication and broke it down into simple addition. The simple addition is 0(N), now applying simple division and multiplication, I realized I can multiply the first operator by two, and divide the second operator by two and the result will still be the same.

  Going through the code, the second operator is stored into R10 as well as R8. R10 is then AND with 0x0001, which will indicate if the operator is odd or even. if the value is odd, the value of R8 is later added to the accumulator and decremented, making it an even number. The next check is whether or not the multiplier is a zero, if so, 0 is stored into the accumulator. If not, the program checks to see if the multiplier is one, if so, multiplication is completed. If not, the accumulator is multiplied by two, and multiplier is divided by two (using Rotations). This process is repeated until multiplier is 1.

###Debugging/Testing

#####Methodology
  
    My methodology was divide and conquered. I knew that if I could solve the ADD_OP, I could easily solve for subtraction. I
    divided each task. My first goal was to simply have the operation work. I would test it with simple numbers. Once I
    accomplished the required functionality, i would work on the B-functionality, and simply added it to my already working
    required operations. I broke the mulitplication operation into multiple pieces. First was to be able to multiple a number
    by 2, second was multiplying it by an odd number. The third part was just putting the finishing touches on it, such as when
    the multiplier is 0. After completing this. By breaking everything downt o simple pieces, I had few issues. I would test it
    with values I knew the answer to, and used debugging to ensure everything was happening as it was suppose to be.
    
      There were times i had issues, but it was primarily from using the wrong code, conceptually I didn't have an issue with
      anyything. My simple calculator *PASSED ALL GIVEN TEST CASES*

#####Commit 1

  This commit was the work accomplished during class. the main set up, add operation, subtraction operation and clear operation was completed as presented. In the process of adding the B-functionality, which is checking for min_max.
  
#####Commit 2
  
    This commit it indication the addition of checking for min and max values. This was a simple addition and took little time.
    
#####Commit 3

  This commit shows the process of putting together the multiplication operation. which was simple, but not completed at the time.

#####Commit 4
  
    This commit is the final compilation of coding. Though additional information will be added, the simple calculator is workng now.
    
    *The rest of the commits are either for the README file, or me addiing additional information to make the code more clear.*


###Conclusions/Lessons Learend
