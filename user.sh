echo -e "\e[36m>>>> configurging nodejs <<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[36m>>>> install nodejs <<<<\e[0m"
yum install nodejs -y

echo -e "\e[36m>>>> Add roboshop <<<<\e[0m"
useradd roboshop

echo -e "\e[36m>>>> Create application directory <<<<\e[0m"
mkdir /app

echo -e "\e[36m>>>> Create app content <<<<\e[0m"
curl -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip


echo -e "\e[36m>>>> unzip app content <<<<\e[0m"
unzip /tmp/user.zip

echo -e "\e[36m>>>> install nodejs dependencies <<<<\e[0m"
npm install

echo -e "\e[36m>>>> Create application directory <<<<\e[0m"
cp /root/roboshop-shell/user.service /etc/systemd/system/catalogue.service

echo -e "\e[36m>>>> restart service <<<<\e[0m"
systemctl daemon-reload
systemctl enable user
systemctl restart user

echo -e "\e[36m>>>> Copy mongo repo <<<<\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[36m>>>> install mongodb client <<<<\e[0m"
yum install mongodb-org-shell -y

echo -e "\e[36m>>>> install schema <<<<\e[0m"
mongo --host mongodb-dev.medevops.online </app/schema/user.js