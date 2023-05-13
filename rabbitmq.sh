echo -e "\e[36m>>>> setup erlang Repos <<<<\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash


echo -e "\e[36m>>>> setup rabbitmq repos <<<<\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash

echo -e "\e[36m>>>> install Erland & RabbitMQ  <<<<\e[0m"
yum install erland rabbitmq-server -y

echo -e "\e[36m>>>> Start Rabbitmq service <<<<\e[0m"
systemctl enable rabbitmq-server
systemctl restart rabbitmq-server

echo -e "\e[36m>>>> add application <<<<\e[0m"
rabbitmqctl add_user roboshop roboshop123
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"