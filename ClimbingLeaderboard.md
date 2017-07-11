# PythonSoln
#!/bin/python3

import sys


n = int(input().strip())
scores = [int(scores_temp) for scores_temp in input().strip().split(' ')]
m = int(input().strip())
alice = [int(alice_temp) for alice_temp in input().strip().split(' ')]
# your code goes here
a = [10000000000] + sorted(set(scores))[::-1] + [-1]
for i in range(len(alice)):
    strt = 0
    end = len(a)
    while(end - strt > 10):
        n = (end + strt)//2
        if a[strt] >= alice[i] >= a[n]:
           end = n
        else:
            strt = n
    for j in range(strt,end):
        if a[j] >= alice[i] >= a[j+1]:
            print(j+1)
            break
