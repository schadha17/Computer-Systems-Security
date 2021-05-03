## Part A - SSH Tunnels & Intercepting Proxy 

**1. Set up a SSH tunnel to forward port 80 on your VM to port 9999 on your local machine.**

**2. Set up a SSH tunnel to forward port 3000 on your VM to port 3000 on your local machine.**

I use a single command for both: 

```ssh -L 9999:localhost:80 -L 3000:localhost:3000 student@<IP>```

**3. Add an entry to your local machine's hosts file such that comp4108.ca is resolved to 127.0.0.1**

This was trivial. I added ```127.0.0.1 comp4108.ca``` to ```/etc/hosts``` on my host which is a MAC OS. 

**4. Configure Firefox on your local machine to use burp as a HTTP Proxy**

<img src="https://github.com/schadha17/Computer-Systems-Security-COMP4108/blob/main/Assignment4/images/proxy-settings" width="500" height="200">


## Part B - Web Security 101 

In this section we will exploit a vulnerability in the Damn Vulnerable Web Application (DVWA) (http://www.dvwa.co.uk/). It was written specifically to be used as a training tool to teach common web app vulnerabilities. 

It has two security modes ```LOW``` and ```MEDIUM``` security. Once we have the low security solution working, we will switch the security setting to medium and adapt our exploit so that it works reliably under the higher security setting. 

In ```LOW``` security mode DVWA attempts no exploit mitigation strategies. In ```MEDIUM``` setting DVWA will attempt to block the most straight forward attack vectors and you will have to work around the protections.

## Part C - Where's the BeEF? 



