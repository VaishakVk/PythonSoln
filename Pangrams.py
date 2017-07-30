# https://www.hackerrank.com/challenges/pangrams/problem
a = input().lower()
count = 1
a = list(sorted(a))
a = list(filter(lambda x:x!= ' ',a))
for i in range(len(a)-1):
    if a[i] != a[i+1]:
        count += 1
if count == 26:
    print ('pangram')
else:
    print('not pangram')
