import boto3
from datetime import datetime

foldername = "AT_POSLoundary" + datetime.now().strftime('%Y-%m-%d_%H-%M-%S')
s3 = boto3.client('s3')
file_name1 = foldername + '/' + 'report.html'
file_name2 = foldername + '/' + 'log.html'
bucket_name = "occ-ui-automation-results"
directory_name = foldername  #it's name of your folders
s3.put_object(Bucket=bucket_name, Key=(directory_name + '/'))
s3.upload_file('report.html', bucket_name, file_name1, ExtraArgs={'ACL': 'public-read'})
s3.upload_file('log.html', bucket_name, file_name2, ExtraArgs={'ACL': 'public-read'})
Sysadmin_LogUrl = f'https://{"pos-ui-automation-results"}.s3.amazonaws.com/{foldername}/log.html'
print(Sysadmin_LogUrl)
Sysadmin_ReportUrl = f'https://{"pos-ui-automation-results"}.s3.amazonaws.com/{foldername}/report.html'
print(Sysadmin_ReportUrl)
