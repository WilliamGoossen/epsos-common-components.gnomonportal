create database epsosportal_db;
create user 'epsos'@'localhost' identified by 'changeit';
grant all on epsosportal_db.* to 'epsos'@'%' identified by 'changeit' with grant option;