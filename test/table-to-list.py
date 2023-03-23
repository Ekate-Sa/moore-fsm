#
# script to transform the table
#

import pandas as pd

def spec_print(left, right, main_one):
    if "xx" in left:
        print('{4b%s , 4b%s , 4b%s},' %(main_one, left.replace("xx","00") , right))
        print('{4b%s , 4b%s , 4b%s},' %(main_one, left.replace("xx","01") , right))
        print('{4b%s , 4b%s , 4b%s},' %(main_one, left.replace("xx","10") , right))
        print('{4b%s , 4b%s , 4b%s},' %(main_one, left.replace("xx","11") , right))
    else:
        print('{4b%s , 4b%s , 4b%s},' %(main_one, left.replace("x","0") , right))
        print('{4b%s , 4b%s , 4b%s},' %(main_one, left.replace("x","1") , right))


columns = []
data = []
with open('task.txt', 'r') as file:
    lines = file.readlines()
    index = 0
    cnt = 0
    for idx, line in enumerate(lines):
        arr = []
        if idx == 0:
            columns = line.split()
        else:
            arr = line.split()
            data.append(arr)
        #print(idx, arr)

        for idx, elem in enumerate(arr) :
            if idx == 0 :
                main_one = elem
            else :
                if (elem != "-"):
                    if "x" in elem:
                        spec_print(elem, columns[idx], main_one)
                        if "xx" in elem:
                            cnt = cnt+4
                        else:
                            cnt = cnt+2
                    else:
                        print('{4b%s , 4b%s , 4b%s},' %(main_one, elem, columns[idx] ))
                        cnt = cnt+1
        #print('localparam TRANS_NUM_%d = %d' %( (index-1), cnt) )
        index = index + 1
        print()
print('TRANS_NUM = %d' %(cnt))


values_dict = {column_name: [] for column_name in columns}

for idx, column_name in enumerate(columns):
    for arr in data:
        values_dict[column_name].append(arr[idx])
df = pd.DataFrame(values_dict)
