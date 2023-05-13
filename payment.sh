echo -e "\e[36m>>>> install python <<<<\e[0m"
yum install python36 gcc python3-devel -y

echo -e "\e[36m>>>> Add Application User <<<<\e[0m"
useradd roboshop

echo -e "\e[36m>>>> Create app Dir <<<<\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[36m>>>> download App Content <<<<\e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip

echo -e "\e[36m>>>> extra app content <<<<\e[0m"
cd /app
unzip /tmp/payment.zip

echo -e "\e[36m>>>> install dependencies <<<<\e[0m"
cd /app
pip3.6 install -r requirements.txt

echo -e "\e[36m>>>> copy systemd services <<<<\e[0m"
cp root/roboshop-shell/payment.service etc/systemd/system/payment.service

echo -e "\e[36m>>>> start payment services <<<<\e[0m"
systemctl daemon-reload
systemctl enable payment
systemctl start payment