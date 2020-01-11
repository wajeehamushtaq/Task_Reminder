# Task_Reminder
# Project title: “Task Reminder”

# Description:
In Task Reminder, user add all the specific task he wants to do in the next 7 days. Then on each day the person will remind himself the task he want to do on that day by giving date as input to Task_Reminder so that important task will not missed.

# Technology
Assembly Language

# Methodology:

In this project, User will ask to add all the tasks he wants to do in the next few days with the dates. By using create file function we create new file and write the user data into the file by calling write to file function. When user wants to do task on specific day, so he input date into program, then stored data of user will store in an array by reading it from file using read from file function. We will search it for user what task to do on that day by given date using any searching algorithm like binary search, linear search etc. And display the task to do on that date by creating display function.

**Poject consist of following menus:**

* Add Task
* Find Task
* Set Reminder
* Exit programme

## Add Task
This function user will add task for one week into the file along with date and "#" at the end of each day task to separate different tasks. It stores data in file into the following format:
```
10-2-2019,Maths,Engslish,Urdu#  10-3-2019,COAL,DSA,PSP#  10-4-2020,PPSD,CAL,PF#  10-5-2019,English,MATHS,BIO#  10-6-2019,ISl,PAK,URDU#  10-7-2019,DLD,DMATHS#  10-8-2019,COAL,DSA,COAL#  
```

## Find Task
In this function user will take date from user to remind tasks for specific day and then this reminder search tasks by date and ouptput all the tasks which is to be done on that day
```
When user enter 10-4-2019
This will output
PPSD,CAL,PF
```
## Set Timer
In this menu user will be asked to set reminder so that this task reminder will output tasks at specific time which is to be completed. 
## Limitation of this funcion is that it take time for seconds.
```
if user set reminder for 5 seconds then it will output after 5 seconds
Complete the following task : PPSD,CAL,PF
```
## Exit program
if use want to exit then by pressing this option the programme will exit 


# Contributors

1) Anamta Khan
2) Mehru Nisa Saleem
3) Wajeeha Mushtaq
