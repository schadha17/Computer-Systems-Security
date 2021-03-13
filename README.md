# Computer-Systems-Security-COMP4108

- DISCLAIMER: I do not promote plagarism or copying of the code
- This repository will involve writeups of the assignments for education and learning purposes 

<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#assignment-1">ASSIGNMENT 1</a>
      <ul>
        <li><a href="#part-a"> Part A - Basic Password Cracking</a></li>
      </ul>
    </li>
  </ol>
</details>


## ASSIGNMENT 1
### Part A - Basic Password Cracking
- Cracking password dumps of a linux system (hashes) with <b>John the Ripper</b>
- 3 files with different difficulty develop the ability to use modes such as single, wordlist, incremental etc. 

### Part B - Offline attack
- Developing a script to generate candidate passwords from <b> John </b> and using them to decrypt an AES 256 encrypted file using ```openssl``` command

### Part C - Online attack
- Creating ssh tunnel and local port forwarding to access a website hosted on hidden port inside VM
- Finding active usernames on the website using a <b> public dump of firestnames from Facebook </b> 
- Using an efficient wordlist (500 worst passwords) to crack password of an active account
- Makes use of a bash script, ```curl``` command and ```HTTP POST``` request

<br>

## ASSIGNMENT 2
### Part A - File System Permissions 
- Playing around with UID, GID and setting permission bits 
- Writing a bash function to find group name from a GID using the Linux group file
- Using ```find``` command with ```-exec``` paramer to execute the command after ```-exec``` for all files that match some defined rules

### Part B - Access Control Lists
- Using commands such as ```getfacl```, ```setfacl```, ```usermod``` to manipulate ACL for a directory structure

### Part C - Race Conditions
- Exploiting a  time of check versus time of use (ToCToU) vulnerability in order to gain root access to the VM 
- Exploiting a vulnurable application ```vuln_slow``` that has a delay between checking permissions of an output file and ```write``` system call
- Exploiting a vulnurable application ```vuln_fast``` that does not have a configurable sleep. This is done by executing exploit using an automated script in probabilistic fashion
- Utilizing ```strace``` and developing an understanding of ```setuid``` bit 

