#!/bin/bash

echo "======================================"
echo " CollegeDB SQL Assignment Autograding "
echo "======================================"

MYSQL_USER="root"
MYSQL_PASSWORD="password"


mysql -u $MYSQL_USER -p$MYSQL_PASSWORD < starter.sql


# Test Case 1: Check Database

DB_CHECK=$(mysql -u $MYSQL_USER -p$MYSQL_PASSWORD -N -e "SHOW DATABASES LIKE 'CollegeDB';")

if [ "$DB_CHECK" = "CollegeDB" ]
then
    echo "✓ Test Case 1 Passed : Database Created"
    MARK1=3
else
    echo "✗ Test Case 1 Failed : Database not created"
    MARK1=0
fi


# Test Case 2: Check Table

TABLE_CHECK=$(mysql -u $MYSQL_USER -p$MYSQL_PASSWORD -N -e "USE CollegeDB; SHOW TABLES LIKE 'Department';")


if [ "$TABLE_CHECK" = "Department" ]
then
    echo "✓ Test Case 2 Passed : Department Table Created"
    MARK2=4
else
    echo "✗ Test Case 2 Failed : Department Table not created"
    MARK2=0
fi


# Test Case 3: Check Primary Key

PK_CHECK=$(mysql -u $MYSQL_USER -p$MYSQL_PASSWORD -N -e "
USE CollegeDB;
SHOW KEYS FROM Department WHERE Key_name='PRIMARY';
")


if [ ! -z "$PK_CHECK" ]
then
    echo "✓ Test Case 3 Passed : Primary Key Exists"
    MARK3=2
else
    echo "✗ Test Case 3 Failed : Primary Key Missing"
    MARK3=0
fi


# Test Case 4: Check Columns

COLUMN_CHECK=$(mysql -u $MYSQL_USER -p$MYSQL_PASSWORD -N -e "
USE CollegeDB;
DESC Department;
")


if echo "$COLUMN_CHECK" | grep -q "DepartmentID" &&
echo "$COLUMN_CHECK" | grep -q "DepartmentName" &&
echo "$COLUMN_CHECK" | grep -q "HOD"
then
    echo "✓ Test Case 4 Passed : Columns Correct"
    MARK4=1
else
    echo "✗ Test Case 4 Failed : Column mismatch"
    MARK4=0
fi


TOTAL=$((MARK1+MARK2+MARK3+MARK4))


echo "======================================"
echo "Marks : $TOTAL / 10"
echo "======================================"
