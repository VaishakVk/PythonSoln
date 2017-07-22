
#https://www.hackerrank.com/challenges/manasa-and-stones/problem
for i in range(int(input())):
    n = int(input())
    a = [int(input()), int(input())]
    k = []
    for j in range(n):
        k.append(a[0]*j + a[1]*(n-j-1))
    print(*sorted(set(k)))
