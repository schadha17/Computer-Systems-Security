## Part A - File System Permissions

**Q1: Write a bash function to convert a GID to a group name using the Linux group file**

```bash
#!/bin/bash

gidSearch()
{
	cat /etc/group | grep -w $1 | cut -d : -f1
}
```

One would need to run ```source <script-name>.sh``` bring this script into the context of the current shell. 
Alternative would be to add “export PATH = $PATH:$pwd” in your bashrc so current parent shell can find the command gidSearch

Here is how the invocation looks like

```bash
comp4108@node00:$ gidSearch 100
users

comp4108@node00:$ gidSearch 45
sasl
```

**Q2 Write a command to change all the directories with permissions 777 in /A2/Haystack to have permissions 750 instead**

```
sudo find . -type d -perm 777 -exec chmod 750 {} \;
```

In the command above, ```\;``` is for escaping the ```;``` character so bash does not interpret it as a command delimeter

**Q3 Find all the binary files in /usr/bin with the setuid bit set.**

```find . -perm /4000```

000 refers to the regular permission bits and 4 refers to the setuid bit. / means find files with at least one bit set from 4000.

## Part B - Access Control Lists

/A2/Gotham has following directory tree: 

```
Gotham
|
|-- Arkham
|
|-- GothamPD
|
'-- WayneManor
    |
    |-- Batcave
    |
    '-- MasterBedroom
```

**1. Give the ACL for the top level Gotham directory** 
```diff 
- getfacl /A2/Gotham
``` 

**2. Use chmod to add rx permissions for the other category to Gotham and ALL its sub-directories.** 
**3. Use setfacl to add read and write permissions to Gotham, Arkham and GothamPD for the user jgordon**
**4. Use setfacl to add read, write, and execute permissions toWayneManor, Batcave and MasterBedroom for the user bwayne** 
**5. Use setfacl to remove the ACL entries on Arkham for the users skyle and ocobblepot** 
**6. Give the ACL for all subdirectories of Gotham.** 

```diff
- text in red
+ text in green
! text in orange
# text in gray
@@ text in purple (and bold)@@
```
## Part C - Race Conditions

