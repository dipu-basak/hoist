#!/bin/bash

# a simple bash script that detects Host Header Injection vulnerability 
# by 0xbasak
# This tool is intended for educational and ethical security research only.
# Do not use it against systems without proper authorization.

# banner
banner(){
echo "
     _           _     _
    | |         (_)   | |  
    | |__   ___  _ ___| |_ 
    | '_ \ / _ \| / __| __|
    | | | | (_) | \__ \ |_ 
    |_| |_|\___/|_|___/\__|  

                by 0xbasak
"
}

# Check if input file is provided
if [ -z "$1" ]; then
    # print the banner
    banner
    echo "Usage: $0 domains.txt"
    exit 1
fi

DOMAINS=$1
EVIL_HOST="evil.com"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' 

# print the banner
banner
echo -e "${YELLOW}[*] Starting Host Header Injection Scan on $DOMAINS...${NC}\n"

while read -r domain || [ -n "$domain" ]; do
    # Clean the domain string
    clean_domain=$(echo "$domain" | sed -e 's|^[^/]*//||' -e 's|/.*$||')

    echo -e "${YELLOW}------------------------------------------------------------${NC}"
    echo -e "${NC}[?] Testing: ${CYAN}$clean_domain${NC}"

    # Capture the full header response
    headers=$(curl -s -I -H "Host: $EVIL_HOST" "https://$clean_domain" -m 5)
    
    # Check for the injection in the Location header
    if echo "$headers" | grep -qi "Location: .*$EVIL_HOST"; then
        echo -e "${RED}[VULNERABLE]${NC} - Host Header Reflected in Redirect!"
        
        # Display the headers
        echo -e "${NC}--- Response Preview ---"
        echo "$headers" | grep -Ei "^HTTP|^Location|^Server|^X-Cache|^CF-Cache-Status" | sed 's/^/  /'
        echo -e "------------------------"
        
        # Save to file
        echo "$domain" >> vulnerable_hhi.txt
    else
        # show the status code for "Safe" domains
        status=$(echo "$headers" | grep "HTTP/" | awk '{print $2}')
        echo -e "${GREEN}[SAFE]${NC} (Status: ${status:-N/A})"
    fi

done < "$DOMAINS"

echo -e "\n${YELLOW}[*] Scan complete. Vulnerable domains saved to vulnerable_hhi.txt${NC}"
