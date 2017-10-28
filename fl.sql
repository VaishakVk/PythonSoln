Call a Python script from another script

There is a script named test1.py. 
It just has code that should execute when the script itself is run. 
There is another script which runs as a service. 
To call a script from anther script, use filename.function to be called after importing the file.

test1.py

def some_func():
    print 'in test 1, unproductive'

if __name__ == '__main__':
    # test1.py executed as script
    # do something
    some_func()

service.py

import test1

def service_func():
    print 'service func'

if __name__ == '__main__':
    # service.py executed as script
    # do something
    service_func()
    test1.some_func()
	
------
Lists vs Tuples - which is faster ?

There are several performance differences between tuples and lists when it comes to instantiation and retrieval of elements:

Tuples containing immutable entries can be optimized into constants by Python's peephole optimizer. Lists, on the other hand, get build-up from scratch:
>>> from dis import dis

>>> dis(compile("(10, 'abc')", '', 'eval'))
  1           0 LOAD_CONST               2 ((10, 'abc'))
              3 RETURN_VALUE   

>>> dis(compile("[10, 'abc']", '', 'eval'))
  1           0 LOAD_CONST               0 (10)
              3 LOAD_CONST               1 ('abc')
              6 BUILD_LIST               2
              9 RETURN_VALUE 
Internally, tuples are stored a little more efficiently than lists, and also tuples can be accessed slightly faster.

Here is how the tuple (10, 20) is stored:

typedef struct {
    Py_ssize_t ob_refcnt;
    struct _typeobject *ob_type;
    Py_ssize_t ob_size;
    PyObject *ob_item[2];     /* store a pointer to 10 and a pointer to 20 */
} PyTupleObject;
Here is how the list [10, 20] is stored:
PyObject arr[2];              /* store a pointer to 10 and a pointer to 20 */

typedef struct {
    Py_ssize_t ob_refcnt;
    struct _typeobject *ob_type;
    Py_ssize_t ob_size;
    PyObject **ob_item = arr; /* store a pointer to the two-pointer array */
    Py_ssize_t allocated;
} PyListObject;
Note that the tuple object incorporates the two data pointers directly while the list object has an additional layer of indirection to an external array holding the two data pointers.

--------
Remove \n from list element

This scenario occurs when we use Python to a read line from a .txt file and write the elements of the first line into a list. 
When we open the list, we might get the list to store data like this

['Name1', '7.3', '6.9', '6.6', '6.6', '6.1', '6.4', '7.3\n']

This is because each of the line in the file ends with a new line and this gets attached to the list.
To remove this we could simply use strip function without passing any parameters
The strip function removes all the whitespaces or other irrelevant characters.
Care should be taken to ensure that the last element in the list contains a value other than \n
If the last element is a \n and whitespaces, this might result in the deletion of both white space and the \n character

If you want to remove \n from the last element only, use this:

t[-1] = t[-1].strip()
If you want to remove \n from all the elements, use this:

t = map(lambda s: s.strip(), t)

--------
Last occurrence of an item in list

There is not a builtin function that returns the last occurrence of a string (like the reverse of index).
Iterate through the list, find the maximum value of the index.

max(loc for loc, val in enumerate(li) if val == 'a')

-------
Getting password input

Program to enter the password and, as you type, nothing is shown in the terminal window (the password is not shown).
Python has a library getpass which will not display the text as you type
This works on Linux, Windows and Mac

import getpass
password = getpass.getpass("Enter your Password:")
print(password)

-------
Concatenate str and int objects

The problem here is that the + operator has (at least) two different meanings in Python: 
for numeric types, it means "add the numbers together"
for sequence types, it means "concatenate the sequences":

Python doesn't implicitly convert objects from one type to another1 in order to make operations "make sense", because that would be confusing.
For instance, you might think that '3' + 5 should mean '35', but someone else might think it should mean 8 or even '8'
Because of this, one needs to do the conversion explicitly.

a = 123
print('Total: ' + str(a))

--------
Set the current working directory

OS library contains the function chdir - that allows you to change the working directory
To check the current working directory use getcwd

import os;
print os.getcwd() # Prints the working directory
To set the working directory:

os.chdir('c:\\Users\uname\desktop\python') # Provide the path here

-------
Select longest string from a list

Select the maximum 
mylist = ['123','123456','1234']
print max(mylist, key=len)

123456
