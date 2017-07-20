#!/bin/python3
# https://www.hackerrank.com/challenges/flatland-space-stations/problem
import sys


n,m = input().strip().split(' ')
n,m = [int(n),int(m)]
c =[0] + [int(c_temp) for c_temp in input().strip().split(' ')]
c = sorted(c)
l1 = int(max(c[i+1]-c[i] for i in range(len(c)-1))/2)
l2 = max(c[1],n-1-c[m])
print(max(l1,l2))
