* Welcome to Room 12 of the Bash Escape Room!

!!! danger "sudo Access"
    - You might need `sudo` access for some commands.
    - The sudo password is required for elevated privileges.
    - The sudo password is: `escape`.
    - Write it down, you will need it later.

---

## Objective: Write a bash script using loops and arrays to process numbers and find the password.

```markdown
- Congratulations! You have reached room 12!!

To pass this room:
---------------------------------------------------------------------

- In this room, we focus on bash loops and arrays.
- You need to write a bash script that processes a list of numbers using loops and arrays.

Tasks:
------

1. Examine the 'numbers.txt' file in this folder (contains one number per line).
2. Write a bash script named 'process_numbers.sh' that:
   - Reads the numbers into an array.
   - Uses a loop to iterate through the array.
   - Sums all even numbers.
   - Counts all odd numbers.
   - Outputs the password as: sum_of_evens_count_of_odds (e.g., 42_5)

3. Run your script to get the password for the next room.

Good Luck!!!
```

## Steps to Solve:

1. **Examine the data file**
   
   !!! tip
       - Use `cat numbers.txt` to view the numbers.

2. **Write the script**
   
   !!! info
       - Read into array: `mapfile -t numbers < numbers.txt` or `numbers=($(cat numbers.txt))`
       - Use `for` loop: `for num in "${numbers[@]}"; do ... done`
       - Check even/odd: `if [ $((num % 2)) -eq 0 ]; then ... else ... fi`
       - Sum evens, count odds.

3. **Run and get password**
   
   !!! success
       - Execute `./process_numbers.sh`
       - Calculate: evens (12,18,24,16,20) sum=90, odds (7,3,9,5,11) count=5, password=90_5

## **Useful Commands:**

| Command   | Man Page                                                                                         | Description           |
| --------- | ------------------------------------------------------------------------------------------------ | --------------------- |
| `for`     | 🔗 [Bash Loops](https://www.gnu.org/software/bash/manual/bash.html#Looping-Constructs)            | Loop over items       |
| `if`      | 🔗 [Bash Conditionals](https://www.gnu.org/software/bash/manual/bash.html#Conditional-Constructs) | Conditional execution |
| `mapfile` | 🔗 [mapfile](https://man7.org/linux/man-pages/man1/mapfile.1p.html)                               | Read lines into array |
| `(( ))`   | 🔗 [Arithmetic](https://www.gnu.org/software/bash/manual/bash.html#Arithmetic-Expansion)          | Arithmetic operations |

**GOOD LUCK!**
