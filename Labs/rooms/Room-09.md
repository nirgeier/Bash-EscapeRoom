---
password: "lessismore"
title_prefix: "🔢 "
summary: "Room 09 involves implementing an efficient sum calculation command, learning that 'less is more'."
---

**OPTIMIZE YOUR BASH CODE!**

---

# 🔢 Room 09

!!! danger "sudo Access"
    - You might need `sudo` access for some commands.
    - The sudo password is required for elevated privileges.
    - The sudo password is: `escape`.
    - Write it down, you will need it later.

---

## Objective: Implement an efficient sum calculation command

```markdown
To pass this room:
---------------------------------------------------------------------

- In this room we will create a new Linux shell command named `escape`.
- In order to pass this room you will need to implement the `escape` command efficiently.

- The `escape` command should do the following:

      escape <number>
          Calculate the sum of the numbers up to the given number.

          Usage:
              $ escape 10 
              (print out 55, [1+2+3+4+5+6+7+8+9+10=55])

- The twist: You must implement it efficiently using the mathematical formula.
- "Less is more" - optimize your code!

- Once you done execute the `getKey.sh`
  - The `getKey.sh` will test your command with few numbers.
  - Once the `getKey.sh` is happy with the results it will print out the password.
  
Good Luck !!!
```

---

  1. Write the `escape` command

    !!! warning ""

        - Create a new file named `escape` in `/usr/local/bin/` so it will be accessible system-wide.
        -  `/usr/local/bin/` is path which is accessible by all users.

  2. The content of the `escape` script should be an efficient formula calculation for: `sum = n*(n+1)/2`
  
  3. Test your command manually.
               
    !!! warning ""
    
        - Run `escape 10` and verify it outputs 55.
        - Run `escape 20` and verify it outputs 210.
        - Run `escape 100` and verify it outputs 5050.

  4. Run `getKey.sh` to get the password.
     
    !!! warning ""
    
        The script will test with random numbers and give the password if correct.

---

## **Useful Commands:**

| Command | Man Page                                                      | Description                       |
| ------- | ------------------------------------------------------------- | --------------------------------- |
| `sudo`  | 🔗 [`sudo`](https://man7.org/linux/man-pages/man8/sudo.8.html) | Execute a command as another user |
| `cp`    | 🔗 [`cp`](https://man7.org/linux/man-pages/man1/cp.1.html)     | Copy files and directories        |
| `bash`  | 🔗 [`bash`](https://man7.org/linux/man-pages/man1/bash.1.html) | GNU Bourne-Again SHell            |
| `for`   | 🔗 [`bash`](https://man7.org/linux/man-pages/man1/bash.1.html) | Loop command in bash              |
| `(( ))` | 🔗 [`bash`](https://man7.org/linux/man-pages/man1/bash.1.html) | Arithmetic evaluation in bash     |
| `$()`   | 🔗 [`bash`](https://man7.org/linux/man-pages/man1/bash.1.html) | Command substitution in bash      |

## **Mathematical Formula:**

- The sum of numbers from 1 to n is: `n × (n + 1) ÷ 2`
- This is much more efficient than using a loop, especially for large numbers.

## **Examples**

### Inefficient way using for loop and arithmetic

```bash
#!/bin/bash
function calculate_sum {
    sum=0
    for (( i=1; i<=$1; i++ ))
    do
        sum=$((sum + i))
    done
    echo $sum
}
calculate_sum 10  # Outputs: 55
```

### Efficient way using mathematical formula

```markdown
Well you don't expect me to write the answer for you, do you?
```

**GOOD LUCK!**

