
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
We will use John along with [jumbo patch](http://openwall.info/wiki/john/patches)

### Cracking easy_dump

The following command tells JTR to try “simple” mode, then the default wordlists containing likely passwords, and then “incremental” mode. In other words, JTR uses default modes. 

```~/JohnTheRipper-unstable-jumbo/run/john easy_dump```

NOTE: ~/JohnTheRipper-unstable-jumbo/run/john is a path to the executable 


## Part B 

## Part C
