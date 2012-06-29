@echo off
rem ---------------------------------------
rem MySQL create DB command
rem ---------------------------------------

mysql -u root -p < db_setup.sql

echo Database prepared.

