#!/bin/python3
# https://www.hackerrank.com/challenges/stockmax
import sys

if __name__ == "__main__":
    t = int(input().strip())
    for a0 in range(t):
        n = int(input().strip())
        profit = 0
        strt = 0
        ind = 0
        a = list(map(int, input().strip().split(' ')))
        if sorted(a, reverse = True) != a:
            while(ind < n-1): 
                max_a = max(a[strt:])
                ind = a.index(max_a, strt)
                profit += sum(max_a - a[i] for i in range(strt, ind))
                strt = ind+1
        print(profit)
