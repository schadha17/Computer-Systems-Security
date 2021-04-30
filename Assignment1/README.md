
## INSTRUCTIONS: 
files folder contains 
- Part A 
  - Password hash files: easy_dump, medium_dump, hard_dump
  - wordlists folder: GawkerPasswords.txt, SonyPasswords.txt, YahooVoicePasswords.txt, passwords.txt
- Part B
  - secret_file.aes256.txt
  - practice_file.aes256.MD5.txt
- Part C
  - facebook-firstnames.txt


## Part A-  Basic Password Cracking
We will use John along with [jumbo patch](http://openwall.info/wiki/john/patches). Every file, namely, easy_dump, medium_dump, hard_dump has 5 users you need to crack

To view passwords already cracked by JTR for a password dump file, one can run the following command 

```~/JohnTheRipper-unstable-jumbo/run/john --show easy_dump```

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




## Part B 

## Part C
