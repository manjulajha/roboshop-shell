echo -e "\e[36m>>>> configuring nodejs <<<<\e[0m"
url -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[36m>>>> install nodejs <<<<\e[0m"
yum install nodejs -y

echo -e "\e[36m>>>> Add robo user <<<<\e[0m"
useradd roboshop

echo -e "\e[36m>>>> create application director <<<<\e[0m"
mkdir /app

echo -e "\e[36m>>>> download app content <<<<\e[0m"
curl -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip

echo -e "\e[36m>>>> unzip app content <<<<\e[0m"
unzip /tmp/cart.zip

echo -e "\e[36m>>>> install dependency <<<<\e[0m"
npm install

echo -e "\e[36m>>>> copy cart serviced <<<<\e[0m"
cp /root/roboshop-shell/cart.service /etc/systemd/system/cart.service


echo -e "\e[36m>>>> restart <<<<\e[0m"
systemctl daemon-reload
systemctl enable cart
systemctl restart cart


