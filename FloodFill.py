#https://www.hackerrank.com/challenges/connected-cell-in-a-grid/problem
def connected_cells(i,j):
    if (i<0 or j<0) or (i>=n or j>=m) or a[i][j] == -1 or a[i][j] == 0:
        return 0
    else:
        a[i][j] =-1
        return 1 + connected_cells(i-1,j) + connected_cells(i+1,j) + connected_cells(1,j-1) + connected_cells(i,j+1) + connected_cells(i-1,j-1) + connected_cells(i+1,j+1) + connected_cells(i-1,j+1) + connected_cells(i+1,j-1)
    
n = int(input())
m = int(input())
a = []
max_subarray = 0
for i in range(n):
    a.append(list(map(int,input().split())))
for i in range(n):
    for j in range(m):
        max_subarray = max(max_subarray, connected_cells(i,j))
print(max_subarray)
