#!/bin/bash
NC='\033[0m'
RED='\033[1;38;5;196m'
GREEN='\033[1;38;5;040m'
ORANGE='\033[1;38;5;202m'
BLUE='\033[1;38;5;012m'
BLUE2='\033[1;38;5;032m'
PINK='\033[1;38;5;013m'
GRAY='\033[1;38;5;004m'
NEW='\033[1;38;5;154m'
YELLOW='\033[1;38;5;214m'
CG='\033[1;38;5;087m'
CP='\033[1;38;5;221m'
CPO='\033[1;38;5;205m'
CN='\033[1;38;5;247m'
CNC='\033[1;38;5;051m'

function banner(){
echo -e ${RED}"#####################################################################"
echo -e ${CP}"    _   _           _     ___        _           _                   #"                                                                       
echo -e ${CP}"   | | | | ___  ___| |_  |_ _|_ __  (_) ___  ___| |_ ___  _ __       # "                                                                     
echo -e ${CP}"   | |_| |/ _ \/ __| __|  | || '_ \ | |/ _ \/ __| __/ _ \| '__|      # "                                                                       
echo -e ${CP}"   |  _  | (_) \__ \ |_   | || | | || |  __/ (__| || (_) | |         # "                                                                       
echo -e ${CP}"   |_| |_|\___/|___/\__| |___|_| |_|/ |\___|\___|\__\___/|_|         # "                                                                    
echo -e ${CP}"                                  |__/                               # "  
echo -e ${BLUE2}"          A Framework for Host Header Injection                      # "     
echo -e ${YELLOW}"             https://facebook.com/unknownclay                        #"     
echo -e ${ORANGE}"             Coded By: Machine404                                    #"
echo -e ${BLUE}"             https://github.com/machine1337                          # "
echo -e ${RED}"#####################################################################"                                 
}


sleep 1
echo -e ${CP}"[+] Checking Internet Connectivity"
if [[ "$(ping -c 1 8.8.8.8 | grep '100% packet loss' )" != "" ]]; then
  echo "No Internet Connection"
  exit 1
  else
  echo "Internet is present"
  
fi

function inject_single(){
clear
banner
echo -e -n ${BLUE}"\n[+] Enter domain name (e.g https://target.com) : "
read domain
sleep 1
echo -e ${CNC}"\n[+] Searching For Host Header Injection"
file=$(curl -s -m5 -I $domain -H "X-Forwarded-Host: evil.com")
echo -n -e ${YELLOW}"\nURL: $i" >> output.txt
echo "$file" >> output.txt
if grep -q evil   <<<"$file"
  then
  echo -n -e ${RED}"URL: $domain  [Vulnerable]\n"
  rm output.txt
  else
  echo -n -e ${GREEN}" URL: $domain  [Not Vulnerable]"
   rm output.txt
 fi

}


function inject_urls(){
clear
banner
echo -n -e ${PINK}"\n[+]Enter target urls list (e.g https://target.com) : "
read urls
sleep 1
echo -e ${CNC}"\n[+] Searching For Host Header Injection"
for i in $(cat $urls); do
     file=$(curl -s -m5 -I  "{$i}" -H "X-Forwarded-Host: evil.com")  
    echo -n -e ${YELLOW}"URL: $i" >> output.txt
    echo "$file" >> output.txt
    if grep -q evil   <<<"$file"
  then
  echo  -e ${RED}"\nURL: $i  [Vulnerable]"${RED}
  cat output.txt | grep -e URL  -e  evil   >> vulnerable_urls.txt
  rm output.txt
  else
  echo -n -e ${GREEN}"\nURL: $i  [Not Vulnerable]\n"
   rm output.txt
 fi

done

}

menu(){
clear
banner
echo -e ${YELLOW}"\n[*] Which Type of Scan u want to Perform\n "
echo -e "  ${NC}[${CG}"1"${NC}]${CNC} Single domain Scan"
echo -e "  ${NC}[${CG}"2"${NC}]${CNC} List of domains"
echo -e "  ${NC}[${CG}"3"${NC}]${CNC} Exit"

echo -n -e ${YELLOW}"\n[+] Select: "
        read host_play
                if [ $host_play -eq 1 ]; then
                        inject_single
                elif [ $host_play -eq 2 ]; then
                        inject_urls
                elif [ $host_play -eq 3 ]; then
                      exit
                fi

}
menu
