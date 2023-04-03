#!/bin/sh

# Read xoa url
read -p "XOA url: " url
read -p "XOA user: " user
read -s -p "XOA password: " password

cp ./xoa.sh.tpl ./xoa.sh

sed -i '' -e "s/{xoa_url}/$url/" xoa.sh1
sed -i '' -e "s/{xoa_user}/$user/" xoa.sh1
sed -i '' -e "s/{xoa_password}/$password/" xoa.sh1

chmod +x xoa.sh