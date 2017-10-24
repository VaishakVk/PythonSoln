Default Parameter Values in Python

Python’s handling of default parameter values is one of a few things that tends to trip up most new Python programmers (but usually only once).

What causes the confusion is the behaviour you get when you use a “mutable” object as a default value; that is, a value that can be modified in place, like a list or a dictionary.

An example:

>>> def function(data=[]):
...     data.append(1)
...     return data
...
>>> function()
[1]
>>> function()
[1, 1]
>>> function()
[1, 1, 1]
As you can see, the list keeps getting longer and longer.

Why does this happen? #

Default parameter values are always evaluated when, and only when, the “def” statement they belong to is executed.
If you execute “def” multiple times, it’ll create a new function object (with freshly calculated default values) each time.
-------
Print without a new line or space

''' Unlike other Object oriented languages, Python adds a new line after every print. 
So every time a line is printed the cursor automatically moves to the next line.
This can be avoided by passing an additional parameter to the print statement.
By default, parameter 'end' is assigned to the value '\n' which is  a new line.
By changing this to '' we can avoid the new line.
Similarly if the requirement is to add a space after every print, pass the 'end' parameter as ' '
'''

for i in range(10):
	print(i, end = '')

------

Running Shell Commands from Python

''' Run function is recommended. 
It provides a very general, high-level API for the subprocess module. 
To capture the output of a program, pass the subprocess.PIPE flag to the stdout keyword argument. 
Then access the stdout attribute of the returned CompletedProcess object
'''

import subprocess
result = subprocess.run(['ls', '-l'], stdout=subprocess.PIPE)
result.stdout

-----

Schedule a Python program to run on startup

There are many methods to schedule a python program to run on startup.

One of the methods to schedule a program is through making an entry in registry Key.
Before proceeding, locate the path of the Python file that has to be scheduled.
Open Run
Search regedit
Navigate to HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run
This path will contain all the programs that will run on Windows startup.
Create a new string and enter the location of the Python script as value.

Restart system, now the Python program will run on startup.

--------
Sorting numbers using Python (around 10^5 data)

''' Python has an in built function sort that will sort all the elements in the list. 
However, this function will take very long time for lists containing very large number of data in the scale of 10^5.
For large data, the sorting function can be optimized to return the sorted list quickly.

Split the list based on the length of the digits.
For every unique length of data, create an entry in a dictionary and store the value in them. 
Now sort individually all the buckets and print it.

This reduces the burden of sorting all the elements in the list one at a time. 
'''

n = int(input().strip())
bucket = {}

# read all integers as strings, store them by length in the bucket
for _ in range(n):
    number = input().strip()
    length = len(number)
    if length not in bucket:
        bucket[length] = []
    bucket[length].append(number)
for i in sorted(bucket):
    for j in sorted(bucket[i]):
        print(j)
-------
Reading a big file and process it as chunks

'''Program to read a big file (of some GBs) and process them in chunks.
Basically create a loop with all data of the file
Call a function in the loop and define the chunk size 
Chunk size should be provided as bytes. 
As in the program, it is set as 1024 bytes.
For every loop, 1 kB of data will be processed. 
'''

def read_in_chunks(file_object, chunk_size=1024):
    """Function (generator) to read a file piece by piece.
    Default chunk size: 1k."""
    while True:
        data = file_object.read(chunk_size)
        if not data:
            break
        yield data


f = open('really_big_file.dat')
for piece in read_in_chunks(f):
    process_data(piece)
-------

Get the number of lines in a file

''' Program is very straightforward.
Load the file and loop it for each line
Each iteration will correspond to one line.
Number of iterations will be the number of lines.
Counter starts from 0. Hence we add 1 to the final total to get the actual number of lines.
'''

def file_len(fname):
    with open(fname) as f:
        for i, l in enumerate(f):
            pass
    return i + 1
	
file_len('big_file.csv')

-------
Print '{' braces and also use format on a string

'''General syntax for format 
print("Sammy has {} balloons.".format(5)) 
This will return - Sammy has 5 balloons.
The curly braces will be replaced with value present in the format LOVs

Now to print '{' also as a part, add '{{'.
This will make sure that only the inner braces will be replaced 
'''
x = " {{ Hello }} {0} "
print x.format(42)

-------
List all files in a directory with a particular extension

'''Program to list all the files in a directory with particular extension.
'os' library contains listdir which can be used to list all the directories under a particular directory
endswith function can be used to check if the file has the particular extension.
'''

import os
for file in os.listdir("/mydir"):
    if file.endswith(".txt"):
        print(os.path.join("/mydir", file))
		
--------
Send email with an attachment using Python

'''Program to send email along with attachment
Import smtplib for the actual sending function
Import the email modules required such as application, multipart and text
Multipart contains the links to add From ,To, Date, Subject 
Attachment can be made using msg.attach
'''

import smtplib
from os.path import basename
from email.mime.application import MIMEApplication
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.utils import COMMASPACE, formatdate


def send_mail(send_from, send_to, subject, text, files=None,
              server="127.0.0.1"):

    msg = MIMEMultipart()
    msg['From'] = send_from
    msg['To'] = COMMASPACE.join(send_to)
    msg['Date'] = formatdate(localtime=True)
    msg['Subject'] = subject

    msg.attach(MIMEText(text))

    for f in files or []:
        with open(f, "rb") as fil:
            part = MIMEApplication(
                fil.read(),
                Name=basename(f)
            )
        # After the file is closed
        part['Content-Disposition'] = 'attachment; filename="%s"' % basename(f)
        msg.attach(part)


    smtp = smtplib.SMTP(server)
    smtp.sendmail(send_from, send_to, msg.as_string())
    smtp.close()
	
--------
Create random OTPs with a combination of letters and numbers

''' As expected, random function will be used to generate a random series
Create a variable containing all the numbers and letters.
Use random library on this to generate the OTP.
The length of the OTP can also be controlled
'''

import string
import random

def id_generator(size=6, chars=string.ascii_uppercase + string.digits):
    return ''.join(random.choice(chars) for _ in range(size))
	
-------
Pad Zeroes to String (Methods across all versions)

'''zfill will be used for padding zeroes to the string
For number, format function can be used to pad zeroes
'''

n = 4
>>> print '%03d' % n
004
>>> print format(n, '03') # python >= 2.6
004
>>> print '{0:03d}'.format(n)  # python >= 2.6
004
>>> print '{foo:03d}'.format(foo=n)  # python >= 2.6
004
>>> print('{:03d}'.format(n))  # python >= 2.7 + python3
004
>>> print('{0:03d}'.format(n))  # python 3
004
>>> print(f'{n:03}') # python >= 3.6
004

--------
Split string with multiple delimiters

'''Split function is generally used to split a string to multiple pieces based on a delimitier.
eg. 
x = 'Hi,how are you'
k = x.split(',')
print(k)

This will generate a list with 2 values Hi and how are you

However, to split a function based on multiple delimiters, split function cant be used
Luckily, Python has this built-in 're' library. 
Pass the regex pattern as parameter
'''

a='Beautiful, is; better*than\nugly'
import re
print(re.split('; |, |\*|\n',a))
--------
Read only the specific line of file in Python

''' Program to read specific line of a file. 
Loop through the each line of the file.
Once the specific line is reached, process the line. 
Quite straightforward.
Counter starts from 0. Hence we subtract 1 to get the exact line.
'''

fp = open("file")
for i, line in enumerate(fp):
    if i == 25:
        # 26th line
		process()
    elif i == 29:
        # 30th line
		process()
    elif i > 29:
        break
fp.close()

-------
Executing a string containing Python code

''' Exec function can be used to run Python commands
Pass the command as parameter to exec function
If result of an expression(2 + 2) is required, then use eval function
'''

mycode = 'print ("hello world")'
exec(mycode)

------
Check file size in Python

''' Program to return file size using Python
'os' library contains the function stat that contains relevant details to the file passed.
Retrieve the size by using st_size attribute.
This will return the size in bytes.
'''

import os
statinfo = os.stat('somefile.txt')
print(statinfo.st_size)

------
Convert files to JPG

''' Program to convert files to JPEG
This is a simple program that splits the file name and the extension separately. 
Then the required extension is added to the file name and the image is saved. 
Image library contains the necessary functions to process images. 
'''

import os, sys
import Image

for infile in sys.argv[1:]: # sys.argv[1:] contains all the file whose extensions have to be saved.  
    f, e = os.path.splitext(infile)
    outfile = f + ".jpg"
    if infile != outfile:
        try:
            Image.open(infile).save(outfile)
        except IOError:
            print "cannot convert", infile

-------
Version of Python script

This information is available in the sys.version string in the sys module:

>>> import sys
Human readable:

>>> print (sys.version) #parentheses necessary in python 3.       
2.5.2 (r252:60911, Jul 31 2008, 17:28:52) 
[GCC 4.2.3 (Ubuntu 4.2.3-2ubuntu7)]
For further processing:

>>> sys.version_info
(2, 5, 2, 'final', 0)
# or
>>> sys.hexversion
34014192

To ensure a script runs with a minimal version requirement of the Python interpreter add this to your code:

assert sys.version_info >= (2,5)
This compares major and minor version information. Add micro (=0, 1, etc) and even releaselevel (='alpha','final', etc) to the tuple as you like

--------
Element wise addition of two lists

'''Consider 2 lists
list1=[1, 2, 3]
list2=[4, 5, 6]

Element wise addition is adding first element of list 1 with first element of second list, addition of second element of first list with second element of second list.
Final result 
[5,7,9]
'''
Use map with operator.add:

>>> from operator import add
>>> map(add, list1, list2)
[5, 7, 9]
or zip with a list comprehension:

>>> [sum(x) for x in zip(list1, list2)]
[5, 7, 9]

------
All files and directories under a path

''' Program to list all directories and files under them
os.walk() function will get all the files and the directories placed under a path.
It has the attributes root, dirs (lists the directories), files(lists the files) which ca be used to locate the file and print them.
'''

import os
for root, dirs, files in os.walk("."):
    for name in files:
        print(os.path.join(root, name))
    for name in dirs:
        print(os.path.join(root, name))
------
