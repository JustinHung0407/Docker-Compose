docker run --name=mysql -d -p 33060:3306 -e MYSQL_ROOT_PASSWORD=9901 mysql/mysql-server:latest



<!-- If Host is not allowed to connect to this MySQL server -->
* mysql -u root -p
* use mysql;
* update user set host = '%' where user = 'root';
* FLUSH PRIVILEGES;