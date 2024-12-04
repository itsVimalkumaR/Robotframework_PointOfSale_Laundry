import xml.etree.ElementTree as ET
import os
from datetime import datetime
import pathlib
import shutil
from configparser import ConfigParser
import mysql.connector
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.base import MIMEBase
from email import encoders
import os
import ntpath
class outputdata():
    global foldername
    foldername = datetime.now().strftime('%Y-%m-%d_%H-%M-%S')
    def movefiles(self):
      global OutputXMLfile
      global DBUsername
      global DBPassword
      global DBhost
      global DBStage
      global DBDev
      global DBProd
      global Appication
      global srcfile_reporthtml
      global srcfile_loghtml
      dir_path = os.path.dirname(os.path.realpath(__file__))
      config_file = os.path.join(dir_path, 'config.ini')
      config = ConfigParser()
      print(config.sections())
      config.read(config_file)
      # LatestReport = 'C:/OCC-Automation/SHAD/Report/'+foldername
      # BackupReport = 'C:/OCC-Backup/SHAD/' + foldername
      # AdminReport = 'C:/wamp64/www/automation_reports_server/uploads/' + foldername
      # srcfile_reporthtml = r"C:\Users\gopi\Documents\GitHub-22.4\CSC-Robotframework-22.4\Results\report.html"
      # srcfile_loghtml = r"C:\Users\gopi\Documents\GitHub-22.4\CSC-Robotframework-21.4\Results\log.html"
      # OutputXMLfile = r"C:\Users\gopi\Documents\GitHub-22.4\CSC-Robotframework-21.4\Results\output.xml"
      srcfile_reporthtml = r"D:\Results\report.html"
      srcfile_loghtml = r"D:\Results\log.html"
      OutputXMLfile = r"D:\Results\output.xml"
      DBUsername = 'elite'
      DBPassword = 'Elite@123'
      DBhost = '13.233.140.177'
      DBStage = 'web_test_reports_stage'
      DBDev = 'web_test_reports_dev'
      DBProd = 'web_test_reports'
      Appication = 'CSC'
      # file = pathlib.Path(LatestReport)
      # if file.exists():
      #   print("File exist")
      # else:
      #   os.mkdir(LatestReport)
      # print(LatestReport)
      # shutil.copy(srcfile_reporthtml, LatestReport)
      # shutil.copy(srcfile_loghtml, LatestReport)
      #
      # file = pathlib.Path(BackupReport)
      # if file.exists():
      #   print("File exist")
      # else:
      #   os.mkdir(BackupReport)
      # print(BackupReport)
      # shutil.copy(srcfile_reporthtml, BackupReport)
      # shutil.copy(srcfile_loghtml, BackupReport)
      #
      # file = pathlib.Path(AdminReport)
      # if file.exists():
      #   print("File exist")
      # else:
      #   os.mkdir(AdminReport)
      # print(AdminReport)
      # shutil.copy(srcfile_reporthtml, AdminReport)
      # shutil.copy(srcfile_loghtml, AdminReport)

    def testcases(self):
        global Pass
        global Fail
        global total
        data_file = OutputXMLfile
        # data_file = os.path.abspath('output.xml')
        tree = ET.parse(data_file)
        root = tree.getroot()
        for i in root.iter("stat"):
              Pass = i.attrib['pass']
              Fail = i.attrib['fail']
        print(Pass, Fail)
        total =int(Pass) + int(Fail)
        print(total)
        return (Pass)
    def duration(self):
        import datetime
        global Finalstarttime
        global FinalEndtime
        global FinalDurationtime
        data_file = OutputXMLfile
        # data_file = os.path.abspath('output.xml')
        tree = ET.parse(data_file)
        root = tree.getroot()
        for i in root.iter("status"):
         starttime = i.attrib['starttime']
         endtime = i.attrib['endtime']
        print(starttime, endtime)
        date_time_obj_1 = datetime.datetime.strptime(starttime, '%Y%m%d %H:%M:%S.%f')
        # dt_object = datetime.fromtimestamp(date_time_obj_1 / 1000)
        # print(dt_object)
        Starttime=str(date_time_obj_1).split('.')
        Finalstarttime=Starttime[0]
        print(Finalstarttime)
        date_time_obj_2 = datetime.datetime.strptime(endtime, '%Y%m%d %H:%M:%S.%f')
        Endtime = str(date_time_obj_2).split('.')
        FinalEndtime = Endtime[0]
        print(FinalEndtime)
        elapsed = date_time_obj_2 - date_time_obj_1
        Duration = str(elapsed).split('.')
        FinalDurationtime = Duration[0]
        print(FinalDurationtime)
        return (FinalDurationtime)
    def application(self):
        global Name
        global BROWSER
        global Environmenttext
        # data_file = os.path.abspath('output.xml')
        data_file = OutputXMLfile
        tree = ET.parse(data_file)
        root = tree.getroot()
        geoNode = root.findall('.//msg')
        for message in geoNode:
            if message.text.startswith('Opening browser'):
                geoNode1 = message.text
                print('*\t', message.text)
                spllit = geoNode1.split("'")
                BROWSER = spllit[1]
        print(BROWSER)
        argnode = root.findall('.//arg')
        for message in argnode:
            if message.text.startswith('running'):
                argnode1 = message.text
                print('*\t', message.text)
                spllit = argnode1[8:]
                spllit1 = spllit.split(".")
                Environmenttext = spllit1[0]
        print(Environmenttext)
        # Environmenttext = 'Stage'
        # print(Environmenttext)
        Name = Appication
        return (Environmenttext)

    def S3bucketupload(self):
        import boto3
        from datetime import datetime
        global Sysadmin_LogUrl
        global Sysadmin_ReportUrl
        foldername = "Automation" + datetime.now().strftime('%Y-%m-%d_%H-%M-%S')
        s3 = boto3.client('s3')
        file_name1 = foldername + '/' + 'report.html'
        file_name = foldername + '/' + 'log.html'
        bucket_name = "occ-ui-automation-results"
        directory_name = foldername  # it's name of your folders
        s3.put_object(Bucket=bucket_name, Key=(directory_name + '/'))
        s3.upload_file(srcfile_loghtml, bucket_name, file_name, ExtraArgs={'ACL': 'public-read'})
        Sysadmin_LogUrl = 'https://'+bucket_name+'.s3.us-west-2.amazonaws.com/'+foldername+'/log.html'
        print(Sysadmin_LogUrl)

    def imageapi(self):
        import requests
        import os
        global Report_url
        # file = os.path.abspath("report.html")
        # file1 = os.path.abspath("log.html")
        # url = "http://calixweb.elitecorpusa.in/automation_reports_server/upload.php"
        # files = {'report_file': open(file, 'r',encoding='utf-8'),
        #          'log_file': open(file1, 'r',encoding='utf-8')}
        # headers = {
        #     'enctype': "multiform/form-data"
        # }
        # response = requests.request("POST", url, files=files, headers=headers)
        # print(response.text)
        # data = response.json()
        Report_url = Sysadmin_LogUrl
        print(Report_url)

    def SendEmail(self):
        fromaddr = "calixcloud.automation@gmail.com"
        # conn = mysql.connector.connect(
        #     user=DBUsername, password=DBPassword, port=3306, host=DBhost, database=DBStage)
        # cursor = conn.cursor(dictionary=True)
        # sql_select_Query = "select * from user_subscriptions"
        # # MySQLCursorDict creates a cursor that returns rows as dictionaries
        # cursor.execute(sql_select_Query)
        # records = cursor.fetchall()
        # email = []
        # for row in records:
        #     SHADData = row["shad"]
        #     print(SHADData)
        #     if SHADData == 1:
        #         email.append(row["email"])
        #     else:
        #         print("No Need")
        # print(email)
        # toaddr = email
        # toaddr = ["rajamohammed@elitecorpusa.com"]
        toaddr = ["rajamohammed@elitecorpusa.com", "mahendravengalam.ind@gmail.com"]
        #toaddr = "mahendra.ndra99@gmail.com"
        # instance of MIMEMultipart
        msg = MIMEMultipart()

        # storing the senders email address
        msg['From'] = fromaddr

        # storing the receivers email address
        msg['To'] = ','.join(toaddr)

        # storing the subject
        msg['Subject'] = "SHAD Test Automation Stage Report - "+datetime.now().strftime('%d/%m/%Y')

        # string to store the body of the mail
        body = "Please find the SHAD test automation stage report attached with this email."

        # attach the body with the msg instance
        msg.attach(MIMEText(body, 'plain'))
        html_message = '<a href="'+Sysadmin_LogUrl+'">click here to visit report</a>'
        msg.attach(MIMEText(html_message,'html'))
        # open the file to be sent
        # filename = srcfile_reporthtml
        # filename1 = srcfile_loghtml
        # files = [filename, filename1]
        # for file in files:
        #     attachment = open(file, "rb")
        #     # instance of MIMEBase and named as p
        #     p = MIMEBase('application', 'octet-stream')
        #
        #     # To change the payload into encoded form
        #     p.set_payload((attachment).read())
        #
        #     # encode into base64
        #     encoders.encode_base64(p)
        #
        #     p.add_header('Content-Disposition', "attachment; filename= %s" % ntpath.basename(file))
        #
        #     # attach the instance 'p' to instance 'msg'
        #     msg.attach(p)

        # creates SMTP session
        s = smtplib.SMTP('smtp.gmail.com', 587)

        # start TLS for security
        s.starttls()
        # Authentication
        s.login(fromaddr, "elite@123")
        # Converts the Multipart msg into a string
        text = msg.as_string()
        # sending the mail
        s.sendmail(fromaddr, toaddr, text)
        # terminating the session
        s.quit()
    def mysql(self):
        if Environmenttext == "Dev":

            conn = mysql.connector.connect(
                user=DBUsername, password=DBPassword, port=3306, host=DBhost, database=DBDev)
            cursor = conn.cursor()

            selectQuery = "SELECT id FROM test_reports ORDER BY id DESC LIMIT 1"
            cursor.execute(selectQuery)
            myresult = cursor.fetchall()
            print(myresult[0][0])
            sql = "UPDATE test_reports SET name = %s,duration = %s,total_cases = %s, pass = %s, fail = %s,report_file = %s, browser_name = %s  WHERE id = %s"
            val = (Name, FinalDurationtime, total, Pass, Fail, Report_url, BROWSER, myresult[0][0])
            cursor.execute(sql, val)
            conn.commit()
        elif Environmenttext == "Prod":
            conn = mysql.connector.connect(
                user=DBUsername, password=DBPassword, port=3306, host=DBhost, database=DBProd)
            cursor = conn.cursor()
            selectQuery = "SELECT id FROM test_reports ORDER BY id DESC LIMIT 1"
            cursor.execute(selectQuery)
            myresult = cursor.fetchall()
            print(myresult[0][0])
            sql = "UPDATE test_reports SET name = %s,duration = %s,total_cases = %s, pass = %s, fail = %s,report_file = %s, browser_name = %s  WHERE id = %s"
            val = (Name, FinalDurationtime, total, Pass, Fail, Report_url, BROWSER, myresult[0][0])
            cursor.execute(sql, val)
            conn.commit()
        else:
            conn = mysql.connector.connect(
                user= DBUsername, password= DBPassword,port=3306, host= DBhost, database= DBStage)
            cursor = conn.cursor()
            selectQuery = "SELECT id FROM test_reports ORDER BY id DESC LIMIT 1"
            cursor.execute(selectQuery)
            myresult = cursor.fetchall()
            print(myresult[0][0])
            runStatusEnd = 'Completed'
            sql = "UPDATE test_reports SET name = %s,start_date = %s, end_date = %s,duration = %s,total_cases = %s, pass = %s, fail = %s,report_file = %s, browser_name = %s,run_status = %s   WHERE id = %s"
            val = (Name,Finalstarttime,FinalEndtime, FinalDurationtime,total, Pass, Fail, Report_url, BROWSER,runStatusEnd, myresult[0][0])
            cursor.execute(sql, val)
            # Creating a cursor object using the cursor() method
            # cursor = conn.cursor()
            # sql = """INSERT INTO test_reports (name, start_date, end_date, duration, total_cases, pass, fail, report_file, browser_name)
            #                VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s)"""
            # insert_blob_tuple = (
            # Name, Finalstarttime, FinalEndtime, FinalDurationtime, total, Pass, Fail, Report_url, BROWSER)
            # cursor.execute(sql, insert_blob_tuple)
            conn.commit()

    def mysql_allFunctions(self):
        readxmlfile.movefiles()
        readxmlfile.testcases()
        readxmlfile.duration()
        readxmlfile.application()
        readxmlfile.S3bucketupload()
        readxmlfile.imageapi()
        # readxmlfile.SendEmail()
        readxmlfile.mysql()

readxmlfile = outputdata()
readxmlfile.mysql_allFunctions()