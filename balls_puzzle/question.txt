There are K bags of cricket balls, where each bag can have variable numbers of balls in each bag. There are N number of school level players (N < K). Distribute bags of balls to players such that
    a) each player gets exactly 1 bag.
    b) suppose k1,k2,…kn are the bags which are chosen to be randomly and
	distributed serially based on sorted number of balls in them (|kn|-|k1|)
	must be minimum. When |Ki| is the number of balls for ith student

**|Kn| denotes the number of balls in nth student.


Insturction : You need to find the time complexity of your program. The complexity cannot increase beyond O(KlogK). 

You have to take the input from the input.txt file, put in the same folder (Inputs taken from the keyboard will be condsidered as WRONG). The first line of the input.txt file contains the number of bags. The next line shows the content of each bag. The third line displays the number of players. The output of the program MUST be stored in a file named 'output.txt', which will be in the same folder. The output should be comma separated as prescribed in the output.txt sample file.

The answer to the question will be considered as COMPLETE only when you fulfil the above condition. Your code will be crosschecked with our various inputs and it must satisfy all those.

Examples: Say, there are 6 bags of cricket balls where k1=9, k2=5,k3=2,
k4=4,k5= 11, k6=10. Now, let there are N=3 numbers of players and your task is
to distribute the bags of balls to each of the players in some sorted manner
such that the difference between the number of balls received by the last player
and first players should be minimum. 

So, here the answer should be 9,10,11; because the difference of 11-9=2, which
is the least in this case. On the other hand, if I choose, 2,4,5; then it
would be (5-2 = 3), which is greater than 2. 

