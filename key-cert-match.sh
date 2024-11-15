#!/bin/bash -eo pipefail
color_red() {
  echo -e "\033[31m${1}\033[0m"
}

color_green() {
  echo -e "\033[32m${1}\033[0m"
}

if [ $# -ne 2 ]; then
    echo "Usage: $0 <key> <cert>"
    echo
    exit 1
fi

if [ -f "$1" ]; then
    x=$(openssl rsa -modulus -noout -in $1 | openssl sha1)
else
    echo "$1 is not a file"
    exit 1
fi

if [ -f "$2" ]; then
    y=$(openssl x509 -modulus -noout -in $2 | openssl sha1)
else
    echo "$2 is not a file"
    exit 1
fi

echo " Key $x"
echo "Cert $y"

if [ "$x" == "$y" ]
    then
        color_green "✅ Key and Certificate match"
        exit 0
    else 
        color_red "🚫 Key and Certificate DO NOT match"
        exit 1
fi

exit 0
