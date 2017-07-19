for _ in range(int(input())):
    s = input()
    grt = False
    for i in range(len(s)-1)[::-1]:
        if s[i] < s[i+1]:
            grt = True
            index = i
            break 
    if grt == False:
        print('no answer')
    else:
        for i in range(index+1,len(s))[::-1]:
            if s[i] > s[index]:
                lis = list(s)
                lis[i],lis[index] = lis[index],lis[i]
                print("".join(lis[:index+1] + lis[index+1:][::-1]))
                break

     
   
