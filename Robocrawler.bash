#!/bin/bash

echo "Spirobot: The Robot.txt spider!"
echo "Input url(www.example.com) or ip address"
echo -ne " >> "
read URL
echo ''
curl -H "User-Agent: *" -s "https://"$URL"/robots.txt" |grep ":" | cut -d "/" -f 2-  > curl_res.txt;
chmod 775 curl_res.txt;
echo "Got robots.txt file!"

echo "Working..."
input="./curl_res.txt"
while IFS= read -r line
do
    curl -o /dev/null --silent --head --write-out "%{http_code} https://$URL/$line\n" "https://$URL/$line" >> response_codes.txt;
done < "$input"

cat response_codes.txt | grep -v "404";
rm response_codes.txt; rm curl_res.txt;
