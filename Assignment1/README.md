
## INSTRUCTIONS: 
files folder contains 
- Part A 

- Part B
  - secret_file.aes256.txt
  - practice_file.aes256.MD5.txt
- Part C
  - facebook-firstnames.txt


## Part A-  BASIC PASSWORD CRACKING

Check the files folder inside this directory. It should contain, 

  - Password hash files: easy_dump, medium_dump, hard_dump
  - wordlists folder: GawkerPasswords.txt, SonyPasswords.txt, YahooVoicePasswords.txt, passwords.txt

We will use John along with [jumbo patch](http://openwall.info/wiki/john/patches). Every file, namely, easy_dump, medium_dump, hard_dump has 5 users you need to crack

To view passwords already cracked by JTR for a password dump file, one can run the following command: ```~/JohnTheRipper-unstable-jumbo/run/john --show easy_dump```

### Cracking easy_dump

The following command tells JTR to try “simple” mode, then the default wordlists containing likely passwords, and then “incremental” mode. In other words, JTR uses default modes. 

```~/JohnTheRipper-unstable-jumbo/run/john easy_dump```

NOTE: ~/JohnTheRipper-unstable-jumbo/run/john is a path to the executable 

### Cracking medium_dump

The wordlist mode allows JTR to use thousands of passwords and generate their hashes to compare them to the hashes inside the file
```~/JohnTheRipper-unstable-jumbo/run/john --wordlist=/home/student/wordlists/YahooVoicePasswords.txt medium_dump```

I was able to crack only one user with YahooVoicePassowrds. Therefore, I used another wordlist RockYouPasswords.txt. This wordlist is not present in this repo because of size but I believe one can use /usr/share/wordlists/rockyou.txt.gz in Linux. 

Through this command, I was able to crack rest of the users 

```~/JohnTheRipper-unstable-jumbo/run/john --wordlist=/home/student/wordlists/RockYouPasswords.txt medium_dump```

### Cracking hard_dump

This one occupied most of my time. To crack hard users, we will use wordlists with "mangling rules" provided by JTR. 

```~/JohnTheRipper-unstable-jumbo/run/john --rules --wordlist=/home/student/wordlists/YahooVoicePasswords.txt hard_dump```
```~/JohnTheRipper-unstable-jumbo/run/john --rules --wordlist=/home/student/wordlists/RockYouPasswords.txt hard_dump```

However, I was only able to find 4 users with this. For the 5th user, I used ```--rules:single```. This is a hybrid of mangling rules with simple mode. It turned out that 5th user password was in a wordlist but it was flipped. 


<br> 

## Part B - OFFLINE ATTACK 

Hacker encrypted the file: secret_file.aes256.txt
- It was encrypted using AES 256 using the openssl command line tool.
- The encrypted file is BASE64 encoded.
- The hacker thought that since passwords were insecure, they would first hash their encryption password using md5 to make it "more random" and harder to guess.
- The MD5 hash of the hacker's password was used as the password given to openssl for the AES encryption.
- The contents of the file are Lorem Ipsum in ascii text.

```
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



## Part C
