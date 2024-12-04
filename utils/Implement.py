import os
import random
import string
from datetime import datetime
from configparser import ConfigParser
import mysql.connector
import pyautogui
import pandas as pd


class BeforeRunUpdate():
    global SysDateTime

    def ConfigRead(self):
        print('test')
        global OutputXMLfile
        global DBUsername
        global DBPassword
        global DBhost
        global DBStage
        global DBDev
        global DBProd
        global Appenvironment
        global Appication
        global runStatusStart
        global runStatusEnd
        dir_path = os.path.dirname(os.path.realpath(__file__))
        config_file = os.path.join(dir_path, 'config.ini')
        config = ConfigParser()
        print(config.sections())
        config.read(config_file)
        DBUsername = config['MYSQl']['Mysql_UserName']
        print(DBUsername)
        DBPassword = config['MYSQl']['Mysql_Password']
        print(DBPassword)
        DBhost = config['MYSQl']['Mysql_Host']
        print(DBhost)
        DBStage = config['MYSQl']['Mysql_DataBaseName_Stage']
        print(DBStage)
        DBDev = config['MYSQl']['Mysql_DataBaseName_Dev']
        DBProd = config['MYSQl']['Mysql_DataBaseName_Prod']
        Appenvironment = config['ENVIRONMENT']['environment']
        Appication = config['APPLICATION']['Application']
        runStatusStart = config['MYSQl']['RunStatusStart']
        runStatusEnd = config['MYSQl']['RunStatusEnd']

    def startTimeInsert(self):
        objBfrRun.ConfigRead()
        SysDateTime = datetime.now().strftime('%Y-%m-%d_%H-%M-%S')
        Name = 'CSC'
        global cursor
        global conn
        print('DB Start to Connecet')
        print(DBUsername)
        print(DBPassword)
        print(DBhost)
        print(DBStage)
        port = 3306
        conn = mysql.connector.connect(user=DBUsername, password=DBPassword, port=port, host=DBhost, database=DBStage)
        print('DB Connected')
        cursor = conn.cursor()
        sql = """INSERT INTO test_reports (Name, start_date, run_status)
                  VALUES (%s,%s,%s)"""
        insert_blob_tuple = (Name, SysDateTime, runStatusStart)
        cursor.execute(sql, insert_blob_tuple)
        conn.commit()
        print('Data inserted')

    def endTimeUpdate(self):
        SysDateTime = datetime.now().strftime('%Y-%m-%d_%H-%M-%S')
        cursor = conn.cursor()
        selectQuery = "SELECT id FROM test_reports ORDER BY id DESC LIMIT 1"
        cursor.execute(selectQuery)
        myresult = cursor.fetchall()
        print(myresult[0][0])
        sql = "UPDATE test_reports SET end_date = %s,run_status = %s  WHERE id = %s"
        val = (SysDateTime, runStatusEnd, myresult[0][0])
        cursor.execute(sql, val)
        conn.commit()
        print('Data Updated')
        sql = "SELECT * FROM test_reports"
        cursor.execute(sql)
        myresult = cursor.fetchall()
        for x in myresult:
            print(x)

    def zoom_In(self):
        for i in range(0, 2):
            pyautogui.keyDown('ctrl')
            pyautogui.press('+')
            pyautogui.keyUp('ctrl')

    def zoom_Out(self):
        for i in range(0, 2):
            pyautogui.keyDown('ctrl')
            pyautogui.press('-')
            pyautogui.keyUp('ctrl')

    def generate_random_email(self):
        random_string = ''.join(random.choice(string.ascii_letters + string.digits) for _ in range(10))
        email = f"{random_string.lower()}@example.com"
        return email

    def saveToExcel_userData(self, username, password, business_name):
        try:
            # Define the new entry as a dictionary
            new_entry = {'Business Name': business_name, 'Username': username, 'Password': password}

            # Read the existing Excel file
            try:
                df = pd.read_excel('../utils/user_data.xlsx', engine='openpyxl')
            except FileNotFoundError:
                # If file does not exist, create an empty DataFrame with the same columns
                df = pd.DataFrame(columns=['Business Name', 'Username', 'Password'])

            # Append the new entry
            df = pd.concat([df, pd.DataFrame([new_entry])], ignore_index=True)

            # Save the updated DataFrame to the Excel file
            df.to_excel('../utils/user_data.xlsx', index=False, engine='openpyxl')
            success_msg = "New entry appended and Excel file updated successfully."
            print(success_msg)

            return success_msg

        except Exception as err:
            print(f'Other error occurred: {err}')
            return err

    def generate_random_string_without_splChar(self):
        random_string = ''.join(random.choice(string.ascii_letters) for _ in range(10))
        print("The original string is : " + random_string)
        res_first, res_second = random_string[:len(random_string) // 2], random_string[len(random_string) // 2:]
        username = res_first.upper() + res_second.lower()
        print(username)
        return username

    def generate_random_string_with_splChar(self):
        lower_case = "abcdefghijklmnopqrstuvwxyz"
        upper_case = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        number = "0123456789"
        symbols = "!@#$&*?"

        # Ensure at least one of each required character type
        password = [
            random.choice(lower_case),
            random.choice(upper_case),
            random.choice(number),
            random.choice(symbols)
        ]
        print("---> ", password)
        # Fill the rest of the password length with random characters from all sets
        while len(password) < 8:
            password.append(random.choice(lower_case + upper_case + number + symbols))
            print("<---> ", password)

        # Shuffle the list to make the password unpredictable
        random.shuffle(password)

        # Convert list to string
        password = "".join(password)
        print("Final password:", password)
        return password


objBfrRun = BeforeRunUpdate()
# objBfrRun.ConfigRead()
# objBfrRun.startTimeInsert()
# objBfrRun.endTimeUpdate()
# objBfrRun.zoom_In()
# objBfrRun.zoom_Out()
# objBfrRun.generate_random_email()
# objBfrRun.saveToExcel_userData()
# objBfrRun.generate_random_string_without_splChar()
# objBfrRun.generate_random_string_with_splChar()
