@echo off
echo Running import...
mysql -uroot -p -h<SERVER_IP_ADDRESS> -P3306 epsosportal_db < epsosportal_db.sql
echo Done!