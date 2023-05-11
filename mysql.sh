echo -e "\e[36m>>>> disable mysql <<<<\e[0m"
dnf module disable mysql -y

echo -e "\e[36m>>>> copy mysql repo file <<<<\e[0m"
cp /root/roboshop-shell/mysql.repo /etc/yum.repos.d/mysql.repo

echo -e "\e[36m>>>> install mysql <<<<\e[0m"
yum install mysql-community-server -y

echo -e "\e[36m>>>> restart <<<<\e[0m"
systemctl enable mysqld
systemctl restart mysqld

echo -e "\e[36m>>>> reset mysql <<<<\e[0m"
mysql_secure_installation --set-root-pass RoboShop@1
