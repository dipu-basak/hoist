# **hoist** - a Host Header Injection Scanner

A simple Bash script to detect **Host Header Injection (HHI)** vulnerabilities in web applications.  


---

##  Features
- Reads domains from a file (`domains.txt`)
- Tests each domain with a custom `Host` header
- Detects if the malicious host is reflected in the `Location` header
- Saves vulnerable domains to `vulnerable_hhi.txt`
- Color-coded output for easy readability:
  - 🟥 **VULNERABLE**
  - 🟩 **SAFE**
  - 🟨 Status messages

---

##  Usage
````
┌──(0xbasak㉿kali)-[~]

└─$ ./hoist.sh

     _           _     _
    | |         (_)   | |  
    | |__   ___  _ ___| |_ 
    | '_ \ / _ \| / __| __|
    | | | | (_) | \__ \ |_ 
    |_| |_|\___/|_|___/\__|  

                by 0xbasak

Usage: /usr/bin/hhi.sh domains.txt
````
## Installation
```bash
git clone https://github.com/dipu-basak/hoist.git
cd hoist
chmod +x hoist.sh
./hoist.sh domains.txt
```
Be sure to create the input file with one domain per line.

##  Disclaimer
This tool is intended for educational and ethical security research only.  
Do not use it against systems without proper authorization. Unauthorized testing may be illegal.

---

##  Author
Developed by **0xbasak**
