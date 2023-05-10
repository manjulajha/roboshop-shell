echo -e "\e[36m>>>> Configuring Nodejs repos <<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[36m>>>> install  Nodejs  <<<<\e[0m"
yum install nodejs -y

echo -e "\e[36m>>>> Add Application user  <<<<\e[0m"
useradd roboshop

echo -e "\e[36m>>>> Create application directory <<<<\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[36m>>>> Download the app content<<<<\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app

echo -e "\e[36m>>>> Unzip the App content <<<<\e[0m"
unzip /tmp/catalogue.zip

echo -e "\e[36m>>>> installing the dependencies <<<<\e[0m"
npm install

echo -e "\e[36m>>>> copying catalogue systemd  <<<<\e[0m"
cp catalogue.service /etc/systemd/system/catalogue.service

echo -e "\e[36m>>>> Restarting the services  <<<<\e[0m"
systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue

echo -e "\e[36m>>>> copying mongo repo  <<<<\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[36m>>>> mongodb client  <<<<\e[0m"
yum install mongodb-org-shell -y

echo -e "\e[36m>>>> load schema <<<<\e[0m"
mongo --host mongodb-dev.medevops.online </app/schema/catalogue.js
