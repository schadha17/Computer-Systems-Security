## Part A - SSH Tunnels & Intercepting Proxy 

**1. Set up a SSH tunnel to forward port 80 on your VM to port 9999 on your local machine.**

**2. Set up a SSH tunnel to forward port 3000 on your VM to port 3000 on your local machine.**

I use a single command for both: 

```ssh -L 9999:localhost:80 -L 3000:localhost:3000 student@<IP>```

**3. Add an entry to your local machine's hosts file such that comp4108.ca is resolved to 127.0.0.1**

This was trivial. I added ```127.0.0.1 comp4108.ca``` to ```/etc/hosts``` on my host which is a MAC OS. 

**4. Configure Firefox on your local machine to use burp as a HTTP Proxy**

[proxy-sc](images/proxy-settings)

## Part B - Web Security 101 

## Part C - Where's the BeEF? 



