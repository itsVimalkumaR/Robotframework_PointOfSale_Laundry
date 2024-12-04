import os
import json
import csv
import time
import requests
import random
import urllib3
import pytz
import string
import importlib
from configparser import ConfigParser
from requests.auth import HTTPBasicAuth
from pymongo import MongoClient

urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)


class POS:

    def ConfigReader(self):
        # Base variables

        global base_url
        global setPassword_end_url
        global grant_type
        global content_type
        global Reg_Username
        global Reg_Name
        global Reg_BusinessName
        global Reg_DOB
        global Reg_PhoneNo
        global Reg_Address
        global Reg_Password
        global login_username
        global login_Password
        global response
        global login_username1
        global login_Password1
        global Reg_EmailId, Reg_State, Reg_Country, Reg_Pincode
        global MongoDB_URI, database_name, collection_name

        dir_path = os.path.dirname(os.path.realpath(__file__))
        config_file = os.path.join(dir_path, 'config.ini')
        config = ConfigParser()
        print("----> Hello", config.sections())
        config.read(config_file)
        print(config.sections())
        base_url = config['RESTAPI']['base_url']
        setPassword_end_url = config['USERS']['Log_URL']
        MongoDB_URI = config['DATABASE']['MongoDB_URI']
        database_name = config['DATABASE']['database_name']
        collection_name = config['DATABASE']['collection_name']
        grant_type = config['RESTAPI']['grant_type']
        content_type = config['CONTENT_TYPE']['content_type']
        Reg_Username = config['REGISTER_USERS']['username']
        Reg_Name = config['REGISTER_USERS']['name']
        Reg_BusinessName = config['REGISTER_USERS']['business_name']
        Reg_DOB = config['REGISTER_USERS']['date_of_birth']
        Reg_PhoneNo = config['REGISTER_USERS']['phone_number']
        Reg_Address = config['REGISTER_USERS']['address']
        Reg_Password = config['REGISTER_USERS']['password']
        Reg_EmailId = config['REGISTER_USERS']['email_id']
        Reg_State = config['REGISTER_USERS']['state']
        Reg_Country = config['REGISTER_USERS']['country']
        Reg_Pincode = config['REGISTER_USERS']['pincode']
        login_username = config['USERS']['username']
        login_Password = config['USERS']['password']
        login_username1 = config['USERS']['username1']
        login_Password1 = config['USERS']['password1']

    def end_url(self):
        try:
            global login_end_url
            global register_end_url
            global profile_end_URL
            global category_endURL
            global product_endURL
            global shopping_cart_endURL
            global customer_endURL
            global order_endURL
            global branch_endURL
            global get_user_end_URL
            global addUser_end_URL
            global SendEmail_end_URL
            global ShoppingCart_EndURL
            global setPassword_endURL

            dir_path = os.path.dirname(os.path.realpath(__file__))
            config_file = os.path.join(dir_path, 'configEndUrl.ini')
            config = ConfigParser()
            print(config.sections())
            config.read(config_file)
            print(config.sections())

            ### POST API End URL
            login_end_url = config['PostAPI_endURL']['login_endURL']
            register_end_url = config['PostAPI_endURL']['register_endURL']
            shopping_cart_endURL = config['PostAPI_endURL']['shopping_cart_endURL']
            addUser_end_URL = config['PostAPI_endURL']['addUser_endURL']
            SendEmail_end_URL = config['PostAPI_endURL']['SendEmail_endURL']

            ### GET API End URL
            profile_end_URL = config['GetAPI_endURL']['profile_endURL']
            category_endURL = config['GetAPI_endURL']['category_endURL']
            product_endURL = config['GetAPI_endURL']['product_endURL']
            customer_endURL = config['GetAPI_endURL']['customer_endURL']
            order_endURL = config['GetAPI_endURL']['order_endURL']
            branch_endURL = config['GetAPI_endURL']['branch_endURL']
            get_user_end_URL = config['GetAPI_endURL']['getuser_endURL']
            ShoppingCart_EndURL = config['GetAPI_endURL']['ShoppingCart_EndURL']

            ### PUT API End URL
            setPassword_endURL = config['PutAPI_endURL']['setPassword_endURL']


        except Exception as e:
            return ("Oops!", e.__class__, "occured")

    def post(self, end_url, user, password):
        try:
            Payload = {
                'user_name': user,
                'password': password
                # Add more key-value pairs as needed
            }
            url = base_url + end_url
            print(url)
            # Set verify=False if you're using a self-signed certificate for local testing
            response = requests.post(url, data=Payload, verify=False)
            print('response: ', response)
            return response
        except requests.exceptions.SSLError as ssl_err:
            print("SSL Error occurred:", ssl_err)
            return None
        except Exception as e:
            print("An error occurred:", e)
            return None

    def get(self, end_url):
        global response
        try:
            headers = {"Content-type": content_type
                       }
            url = base_url + end_url
            print(url)
            response = requests.get(url, headers=headers, verify=False)
            print('response: ', response)
            return (response)
        except requests.exceptions.SSLError as ssl_err:
            print("SSL Error occurred:", ssl_err)
            return None
        except Exception as e:
            print("An error occurred:", e)
            return None

    def post_AccessToken(self, end_url, user, password, Access_token):
        try:
            Payload = {
                'user_name': user,
                'password': password,
                'Content-type': content_type,
                'Authorization': Access_token
                # Add more key-value pairs as needed
            }
            url = base_url + end_url
            print(url)
            response = requests.post(url, data=Payload, verify=False)
            print('response: ', response)
            return (response)
        except requests.exceptions.SSLError as ssl_err:
            print("SSL Error occurred:", ssl_err)
            return None
        except Exception as e:
            print("An error occurred:", e)
            return None

    def get_AccessToken(self, end_url, Access_token):
        global response
        try:
            headers = {"Content-type": content_type,
                       "Authorization": Access_token
                       }
            url = base_url + end_url
            print("GET API URL:- ", url)
            response = requests.get(url, headers=headers, verify=False)
            print('response: ', response)
            return (response)
        except requests.exceptions.SSLError as ssl_err:
            print("SSL Error occurred:", ssl_err)
            return None
        except Exception as e:
            print("An error occurred:", e)
            return None

    def Reg_post(self, end_url, user_name, name, organization_name, email_id, date_of_birth,
                 phone_number, address, state, country, pincode, business_type, role):
        try:
            payload = {
                'user_name': user_name,
                'name': name,
                'organization_name': organization_name,
                'business_type': business_type,
                'date_of_birth': date_of_birth,
                'phone_number': phone_number,
                'address_line_1': address,
                'email_id': email_id,
                'state': state,
                'postal_code': pincode,
                'country': country,
                'role': role,
                'filename': ""
            }
            print("Payload ---> ", payload)
            url = base_url + end_url
            print("URL ---> ", url)
            # Use verify=False to bypass SSL verification (for local testing with self-signed certificates)
            response = requests.post(url, json=payload, verify=False)
            print('response: ', response)
            return (response)
        except requests.exceptions.SSLError as ssl_err:
            print("SSL Error occurred:", ssl_err)
            return None
        except Exception as e:
            print("An error occurred:", e)
            return None

    def Register_API(self, user_name, name, organization_name, email_id, date_of_birth, phone_number, address, state,
                     country, pincode, business_type, role):
        global response, res, ID, url, response_message
        ID, res, url, response_message = 'null', 'null', 'null', 'null'
        try:
            # Register API
            end_url = register_end_url
            existUser = self.RetrieveData_DB(user_name)
            print(" exist user ---> ", existUser)
            response = API_POSLaundry.Reg_post(end_url, user_name, name, organization_name, email_id, date_of_birth,
                                               phone_number, address, state, country, pincode, business_type, role)

            if response is None:
                print("Failed to get a valid response.")
                return None

            if response.status_code == 200:
                data = response.json()
                res = data.get('message', 'No message in response')
                ID = data.get('Id', 'No ID in response')
                print('Success response:', res)
                print('ID:', ID)

                # Assuming sendEmail_API is another function to send an email
                print(ID, email_id, name, user_name)
                email_response = API_POSLaundry.sendEmail_API(ID, email_id, name, user_name, setPassword_end_url)
                url = email_response[2]
                print("Set Password URL >>> ", url)

                set_password_response = self.SetPassword_PUT_API(ID)
                assert set_password_response.status_code == 200
                set_password_data = set_password_response.json()
                response_message = set_password_data.message

                return response.status_code, res, ID, email_id, name, url, user_name, response_message
            else:
                data = response.json()
                res = data.get('message', 'No message in response')
                print('Error response:', res)
                return response.status_code, res, ID, email_id, name, url, user_name

        except Exception as e:
            print("An error occurred:", e)
            return response.status_code, res, ID, email_id, name, url, user_name

    def LoginAPI(self):
        global response, Token
        try:
            # Login variables
            end_url = login_end_url
            print("End url: ", end_url, ", ", "Username: ", login_username1, ", ", "Password: ", login_Password1)
            response = API_POSLaundry.post(end_url, login_username1, login_Password1)

            if response is None:
                print("No valid response received.")
                return response
            assert response.status_code == 200
            data = response.json()
            print(data)
            Token = data['token']
            print('Access Token: ', Token)
            return response.status_code, Token

        except AssertionError:
            print("Login failed. Status code:", response.status_code)
        except Exception as e:
            print("An error occurred during login:", e)

    def getAPI_profile(self):
        global response
        try:
            # Login Profile GET API
            Accesstoken = API_POSLaundry.LoginAPI_CredentialsPass(login_username1, login_Password1)
            Access_token = Accesstoken[1]
            typeOfToken = 'Bearer'
            Authorize = typeOfToken + " " + Access_token
            end_url = profile_end_URL
            response = API_POSLaundry.get_AccessToken(end_url, Authorize)
            assert response.status_code == 200
            data = response.json()
            print('Response : ', data)
            organization_name = data['message']['organization_name']
            print('GETAPI_profile: ', organization_name)
            return response.status_code, organization_name

        except Exception as e:
            print(response.text)
            return response.status_code

    def getAPI_Category(self):
        global Categories, response, Categories_Status
        Categories = []
        Categories_Status = False
        try:
            # Login Category GET API
            Accesstoken = self.LoginAPI()
            Access_token = Accesstoken[1]
            typeOfToken = 'Bearer'
            Authorize = typeOfToken + " " + Access_token
            end_url = category_endURL
            response = self.get_AccessToken(end_url, Authorize)
            assert response.status_code == 200
            data = response.json()
            print('GETAPI_Category: ', data)
            if data['result']:
                li = data['result']
                for d in range(0, len(li)):
                    if 'CategoryName' in data['result'][d]:
                        Categories.append(data['result'][d]['CategoryName'])
                        Categories_Status = True
            print(response.status_code, Categories, Categories_Status)
            return response.status_code, Categories, Categories_Status

        except Exception as e:
            print(response.text)
            return response.status_code, Categories, Categories_Status

    def getAPI_Product(self):
        global Product_Name, response
        Product_Name = []
        Products_Status = False

        try:
            # Get the Access Token
            typeOfToken = 'Bearer'
            Accesstoken = self.LoginAPI()
            Access_token = Accesstoken[1]
            Authorize = typeOfToken + " " + Access_token

            # Get the Product API Response
            end_url = product_endURL
            response = self.get_AccessToken(end_url, Authorize)
            assert response.status_code == 200
            data = response.json()
            print('GETAPI_Products: ', data)

            if data['result']:
                li = data['result']
                print("Length Of the Response: ", len(li))
                for d in range(0, len(li)):
                    if 'ProductName' in data['result'][d]:
                        Product_Name.append(data['result'][d]['ProductName'])
                        Products_Status = True
            print(response.status_code, Product_Name, Products_Status)
            return response.status_code, Product_Name, Products_Status

        except Exception as e:
            print(f"An error occurred: {e}")
            return response.status_code, Product_Name, Products_Status

    def getAPI_Customer(self):
        # Customer GET API
        global name, PhoneNo, Email, name_Status, PhoneNo_Status, Email_Status, response
        name = []
        PhoneNo = []
        Email = []
        name_Status = False
        PhoneNo_Status = False
        Email_Status = False
        try:
            # Get the Access Token
            typeOfToken = 'Bearer'
            Accesstoken = API_POSLaundry.LoginAPI_CredentialsPass(login_username1, login_Password1)
            Access_token = Accesstoken[1]
            Authorize = typeOfToken + " " + Access_token

            end_url = customer_endURL
            response = API_POSLaundry.get_AccessToken(end_url, Authorize)
            assert response.status_code == 200
            data = response.json()
            print('Customer_Response: ', data)

            if data['result']:
                li = data['result']
                length = len(li)
                for d in range(0, length):
                    if data['result'][d]['Name']:
                        name.append(data['result'][d]['Name'])
                        name_Status = True
                    if data['result'][d]['phone_number']:
                        PhoneNo.append(data['result'][d]['phone_number'])
                        PhoneNo_Status = True
                    if data['result'][d]['Email']:
                        Email.append(data['result'][d]['Email'])
                        Email_Status = True
            print(response.status_code, name_Status, name, PhoneNo_Status, PhoneNo, Email, Email_Status)
            return response.status_code, name_Status, name, PhoneNo_Status, PhoneNo, Email, Email_Status

        except Exception as e:
            print('exception')
            print(response.status_code)
            return response.status_code, name_Status, name, PhoneNo_Status, PhoneNo, Email, Email_Status

    def getAPI_Order(self):
        # Order GET API
        global productName, response, Phone_No, OrderID, data, OrderResult, OrderID_Status
        global Confirm_OrderID, WaitingForDelivery_OrderID, InProcess_OrderID, Cancel_OrderID, Delivered_OrderID, NoRemainPrice_OrderID
        global Confirm_OrderID_CustomerName, WaitingForDelivery_OrderID_CustomerName, InProcess_OrderID_CustomerName, Cancel_OrderID_CustomerName, Delivered_OrderID_CustomerName
        productName, Phone_No, OrderID = [], [], []
        Confirm_OrderID, WaitingForDelivery_OrderID, InProcess_OrderID, Cancel_OrderID, Delivered_OrderID, NoRemainPrice_OrderID = [], [], [], [], [], []
        Confirm_OrderID_CustomerName, WaitingForDelivery_OrderID_CustomerName, InProcess_OrderID_CustomerName, Cancel_OrderID_CustomerName, Delivered_OrderID_CustomerName, NoRemainPrice_OrderID_CustomerName = [], [], [], [], [], []
        data = 'null'
        Product_Status, PhoneNum_Status, OrderID_Status = False, False, False
        CustomerName = 'N/A'
        try:
            # Get the Access Token
            typeOfToken = 'Bearer'
            # print(login_username1,login_Password1)
            Accesstoken = self.LoginAPI_CredentialsPass(login_username1, login_Password1)
            Access_token = Accesstoken[1]
            Authorize = typeOfToken + " " + Access_token

            end_url = order_endURL
            response = API_POSLaundry.get_AccessToken(end_url, Authorize)
            assert response.status_code == 200
            data = response.json()
            print('Response >> ', data)
            if data['result']:
                Product_Status = True
                PhoneNum_Status = True
                li = data['result']
                length = len(li)
                for d in range(0, length):
                    # Check if 'Products' is in the result and is not empty
                    if 'Products' in li[d] and li[d]['Products']:
                        # Extract the first product entry
                        product_entry = li[d]['Products']
                        for product in product_entry:
                            if 'productName' in product:
                                productName.append(product['productName'])

                            # Extract phone number if available
                            phone_number = li[d].get('CustomerPhoneNo', 'N/A')
                            Phone_No.append(phone_number)

                            orderid = li[d].get('Orderid', 'N/A')
                            OrderID.append(orderid)
                    else:
                        print(f"Missing 'Products' key or empty list in result index {d}")
                    if 'Confirm' == data['result'][d].get('OrderStatus', 'N/A'):
                        orderid = data['result'][d].get('Orderid', 'N/A')
                        Confirm_OrderID.append(orderid)
                        CustomerName = data['result'][d].get('CustomerName', 'N/A')
                        Confirm_OrderID_CustomerName.append(CustomerName)
                    elif 'WaitingForDelivery' == data['result'][d].get('OrderStatus', 'N/A'):
                        orderid = data['result'][d].get('Orderid', 'N/A')
                        WaitingForDelivery_OrderID.append(orderid)
                        CustomerName = data['result'][d].get('CustomerName', 'N/A')
                        WaitingForDelivery_OrderID_CustomerName.append(CustomerName)
                    elif 'InProcess' == data['result'][d].get('OrderStatus', 'N/A'):
                        orderid = data['result'][d].get('Orderid', 'N/A')
                        InProcess_OrderID.append(orderid)
                        CustomerName = data['result'][d].get('CustomerName', 'N/A')
                        InProcess_OrderID_CustomerName.append(CustomerName)
                    elif 'Cancel' == data['result'][d].get('OrderStatus', 'N/A'):
                        orderid = data['result'][d].get('Orderid', 'N/A')
                        Cancel_OrderID.append(orderid)
                        CustomerName = data['result'][d].get('CustomerName', 'N/A')
                        Cancel_OrderID_CustomerName.append(CustomerName)
                    elif 'Delivered' == data['result'][d].get('OrderStatus', 'N/A'):
                        orderid = data['result'][d].get('Orderid', 'N/A')
                        Delivered_OrderID.append(orderid)
                        CustomerName = data['result'][d].get('CustomerName', 'N/A')
                        Delivered_OrderID_CustomerName.append(CustomerName)
                    elif 'NoRemainPrice' == data['result'][d].get('OrderStatus', 'N/A'):
                        orderid = data['result'][d].get('Orderid', 'N/A')
                        NoRemainPrice_OrderID.append(orderid)
                        CustomerName = data['result'][d].get('CustomerName', 'N/A')
                        NoRemainPrice_OrderID_CustomerName.append(CustomerName)

                print("Confirm_OrderID : ", Confirm_OrderID, "\n", "InProcess_OrderID : ", InProcess_OrderID, "\n",
                      "WaitingForDelivery_OrderID : ", WaitingForDelivery_OrderID, "\n", "Cancel_OrderID : ",
                      Cancel_OrderID, "\n", "Delivered_OrderID : ", Delivered_OrderID)

                return response.status_code, productName, Phone_No, OrderID, Product_Status, PhoneNum_Status, OrderID_Status, \
                    Confirm_OrderID, InProcess_OrderID, WaitingForDelivery_OrderID, Cancel_OrderID, Delivered_OrderID, \
                    Confirm_OrderID_CustomerName, InProcess_OrderID_CustomerName, WaitingForDelivery_OrderID_CustomerName, Cancel_OrderID_CustomerName, Delivered_OrderID_CustomerName, \
                    NoRemainPrice_OrderID
            else:
                print('Order API not working')
        except Exception as e:
            print(f"Error in getAPI_Order: {e}")

    def getAPI_SingleOrder(self):
        global OrderStatus, order_id
        OrderStatus = []
        order_id = []
        try:
            # Get the Access Token
            typeOfToken = 'Bearer'
            Accesstoken = API_POSLaundry.LoginAPI_CredentialsPass(login_username1, login_Password1)
            Access_token = Accesstoken[1]
            Authorize = typeOfToken + " " + Access_token

            res = API_POSLaundry.getAPI_Order()
            data = res[3]
            OrderID_API = res[4]
            length = len(OrderID_API)
            for d in range(0, length):
                Id = data['result'][d]['_id']['$oid']
                endurl = order_endURL + "/" + Id
                print("Order ID API", endurl)
                response = API_POSLaundry.get_AccessToken(endurl, Authorize)
                assert response.status_code == 200
                data1 = response.json()
                print(response)
                print(data1)
                OrderStatus.append(data1['result'][0]['OrderStatus'])
                count = len(OrderStatus)
                print('count: ', count)
                if data1['result'][0]['OrderStatus'] == 'Cancel':
                    print("Hello World")
                    order_id.append(data['result'][d]['Orderid'])
                    print("order_id :- ", order_id)

            print("order_id :- ", order_id)
            return response.status_code, order_id
        except Exception as e:
            print(e)
            return response.status_code

    def LoginAPI_CredentialsPass(self, username1, Password1):
        global response
        try:
            # Login variables
            end_url = login_end_url
            print("Login Credentials:- ", username1, Password1)
            response = API_POSLaundry.post(end_url, username1, Password1)
            assert response.status_code == 200
            data = response.json()
            print(data)
            Token = data['token']
            print('Access Token: ', Token)
            return (response.status_code, Token)

        except Exception as e:
            print(response.text)
            return (response.status_code, Token)

    def getAPI_Branch(self):

        # Branch GET API
        try:
            global response
            global branches
            global CountOf_Branches
            branches = []
            CountOf_Branches = 0
            # Get the Access Token
            typeOfToken = 'Bearer'
            Accesstoken = API_POSLaundry.LoginAPI_CredentialsPass(login_username1, login_Password1)
            Access_token = Accesstoken[1]
            Authorize = typeOfToken + " " + Access_token

            end_url = branch_endURL
            print(end_url)
            response = API_POSLaundry.get_AccessToken(end_url, Authorize)
            assert response.status_code == 200
            data = response.json()
            print(data)
            for i in range(0, 10):
                branches.append(data['result'][i]['Branch_name'])
                # print("Branches List: ", branches)
                CountOf_Branches = len(branches)
                # print("Total Branches: ", CountOf_Branches)

            return response.status_code, CountOf_Branches, branches

        except Exception as e:
            return response.status_code, CountOf_Branches, branches

    def getAPI_User(self):
        try:
            # Get the Access Token
            typeOfToken = 'Bearer'
            Accesstoken = self.LoginAPI_CredentialsPass(login_username1, login_Password1)
            Access_token = Accesstoken[1]
            Authorize = typeOfToken + " " + Access_token

            end_url = get_user_end_URL
            print(end_url)
            response = self.get_AccessToken(end_url, Authorize)
            if response is None or response.status_code != 200:
                raise Exception(f"Failed to get users, status code: {response.status_code}")

            data = response.json()
            print("Response Data : ", data)

            UserNames, Emp_UserNames, PhoneNumbers, BusinessNames, BusinessTypes, Emails = [], [], [], [], [], []
            UserName_Status = Emp_UserNames_Status = PhoneNumbers_Status = BusinessNames_Status = BusinessTypes_Status = Emails_Status = False

            if 'result' in data:
                for user in data['result']:
                    username = user.get('user_name')
                    if username:
                        UserNames.append(username)
                        UserName_Status = True

                    name = user.get('name')
                    employee_name = user.get('employee_name')
                    if name or employee_name:
                        Emp_UserNames.extend([n for n in [name, employee_name] if n])  # Append only non-empty values
                        Emp_UserNames_Status = True

                    phone_number = user.get('phone_number')
                    if phone_number:
                        PhoneNumbers.append(phone_number)
                        PhoneNumbers_Status = True

                    organization_name = user.get('organization_name')
                    if organization_name:
                        BusinessNames.append(organization_name)
                        BusinessNames_Status = True

                    business_type = user.get('business_type')
                    if business_type:
                        BusinessTypes.append(business_type)
                        BusinessTypes_Status = True

                    email_id = user.get('email_id')
                    if email_id:
                        Emails.append(email_id)
                        Emails_Status = True

            print('Status :- ', UserName_Status, Emp_UserNames_Status, PhoneNumbers_Status, BusinessNames_Status,
                  BusinessTypes_Status, Emails_Status)
            print(response.status_code, UserNames, Emp_UserNames, PhoneNumbers, BusinessNames, BusinessTypes, Emails)
            return response.status_code, UserNames, Emp_UserNames, PhoneNumbers, BusinessNames, BusinessTypes, Emails

        except Exception as e:
            print(f"An error occurred: {e}")
            return response.status_code if response else 500, [], [], [], [], [], []

    def post_AddUser_AccessToken(self, end_url, Access_token, username):
        try:
            Payload = {
                'user_name': username,
                'employee_name': Reg_Username,
                'phone_number': Reg_PhoneNo,
                'email_id': 'skullvk1@gmail.com',
                'date_of_birth': Reg_DOB,
                'address': Reg_Address,
                'date_of_joined': Reg_DOB
                # Add more key-value pairs as needed
            }
            headers = {
                'Content-type': content_type,
                'Authorization': Access_token
            }
            url = base_url + end_url
            print(url)
            response = requests.post(url, json=Payload, headers=headers)
            print('response: ', response)
            return (response)

        except Exception as e:
            return ("Oops!", e.__class__, "occured")

    def addUser_POST_API(self):
        try:
            # Get the Access Token
            typeOfToken = 'Bearer'
            Accesstoken = API_POSLaundry.LoginAPI_CredentialsPass(login_username1, login_Password1)
            Access_token = Accesstoken[1]
            Authorize = typeOfToken + " " + Access_token

            end_url = addUser_end_URL
            print(end_url)
            random_number = random.randint(0, 100)
            username = Reg_Name + str(random_number)
            print('username --> ', username)
            response = API_POSLaundry.post_AddUser_AccessToken(end_url, Authorize, username)
            assert response.status_code == 200
            data = response.json()
            print(data)
            userID = data['Id']
            print("Id --> ", userID)

            return response.status_code, userID

        except Exception as e:
            return response.status_code

    def post_SendEemail(self, end_url, url, email, name, username):
        try:

            headers = {"Content-type": content_type
                       }
            Payload = {
                'receiver_email': email,
                'subject': "Set your new password",
                'welcome_message': name,
                'success_message': "Your account has been successfully created.",
                'response_message': "We got a request to set your POS Loundary Login password.",
                'description': "Your password will not be created if you ignore this message. If you didn't ask for a create password.",
                'setPassword_link': url,
                'user_name': username,
                'thank_message': "Thanks," + "\n" + "The iMetanic Team"
            }
            url = base_url + end_url
            print(url, Payload)
            print('Payload-->', Payload)
            response = requests.post(url, headers=headers, data=Payload)
            data = response.json()
            url = data['body']['setPassword_link']
            print('response: ', response)
            return response.status_code, url

        except Exception as e:
            return response.status_code

    def sendEmail_API(self, Id, email, name, username, setPassword_end_url):
        global response
        try:
            current_time = int(time.time() * 1000)  # Convert to milliseconds
            print('time:- ', current_time)
            url = setPassword_end_url + "imetanic/setpassword/" + str(Id) + "/" + str(current_time) + "/2580"
            print('set password link :- ', url)

            end_url = SendEmail_end_URL
            headers = {
                "Content-type": "application/json"
            }
            payload = {
                'receiver_email': email,
                'subject': "Set your new password",
                'welcome_message': name,
                'success_message': "Your account has been successfully created.",
                'res_message': "We got a request to set your POS Laundry Login password.",
                'description': "Your password will not be created if you ignore this message. If you didn't ask for a create password.",
                'setPassword_link': url,
                'user_name': username,
            }

            user_sendEmail_url = base_url + end_url  # Combine the base URL with the endpoint
            print(user_sendEmail_url)

            response = requests.post(user_sendEmail_url, headers=headers, json=payload, verify=False)
            print('send api status code : ', response.status_code)

            if response.status_code == 401:
                print('Error: Unauthorized. Response:', response.text)
                print(response.status_code, username, url)
                return response.status_code, username, url

            response.raise_for_status()  # Raise an error for other status codes
            data = response.json()
            print('Response Json Data', data)

            print(response.status_code, username, url)
            return response.status_code, username, url

        except requests.exceptions.HTTPError as http_err:
            print(f'HTTP error occurred: {http_err}')
            if response is not None:
                print('Response content:', response.text)
        except Exception as err:
            print(f'Other error occurred: {err}')

    def getAPI_ShoppingCart_EndURL(self):
        try:
            # Get the Access Token
            typeOfToken = 'Bearer'
            Accestoken = API_POSLaundry.LoginAPI()
            Access_token = Accestoken[1]
            Authorize = typeOfToken + " " + Access_token

            end_url = ShoppingCart_EndURL
            response = API_POSLaundry.get_AccessToken(end_url, Authorize)
            assert response.status_code == 200
            data = response.json()
            print(data)
            try:
                CartID_Status = True
                CartId = data['result'][0]['cartId']
                print('CartId:', CartId)
                print('CartID_Status:', CartID_Status)
                return (response.status_code, CartId, CartID_Status)
            except Exception as e:
                CartID_Status = False
                CartId = False
                print('CartID_Status:', CartID_Status)
                return (response.status_code, CartId, CartID_Status)

        except Exception as e:
            CartID_Status = False
            CartId = False
            print(response.status_code)
            return (response.status_code, CartId, CartID_Status)

    def put(self, end_url, password):
        try:
            Payload = {
                'password': password
                # Add more key-value pairs as needed
            }
            url = base_url + end_url
            print(url)
            # Set verify=False if you're using a self-signed certificate for local testing
            response = requests.post(url, data=Payload, verify=False)
            print('response: ', response)
            data = response.json()
            message = "data updated successfully"
            assert message == data.message
            return response
        except requests.exceptions.SSLError as ssl_err:
            print("SSL Error occurred:", ssl_err)
            return None
        except Exception as e:
            print("An error occurred:", e)
            return None

    def SetPassword_PUT_API(self, ID):
        try:
            end_url = setPassword_endURL + ID
            password = objBfrRun.generate_random_string_without_splChar()
            print("password : ", password)
            response = self.put(end_url, password)
            assert response.status_code == 200
            data = response.json()
            message = data.message
            print('message : ', message)
            return response
        except Exception as e:
            print("An error occurred:", e)
            return response

    def is_product_present(self, searchedProduct):
        global searched_ProductName, response
        searched_ProductName_Status = False
        searched_ProductName = 'No data'
        try:
            # Get the Access Token
            Accesstoken = self.LoginAPI()
            Access_token = Accesstoken[1]
            typeOfToken = 'Bearer'
            Authorize = typeOfToken + " " + Access_token

            # Get the Product API Response
            end_url = product_endURL
            response = self.get_AccessToken(end_url, Authorize)

            assert response.status_code == 200
            data = response.json()
            print('GETAPI_Products: ', data)
            print('Searched Product : ', searchedProduct)
            if data['result']:
                li = data['result']
                print("Length Of the Response: ", len(li))
                for d in range(0, len(li)):
                    if searchedProduct in data['result'][d]['ProductName']:
                        searched_ProductName = data['result'][d]['ProductName']
                        print(f"'{searchedProduct}' is present in '{searched_ProductName}'")
                        searched_ProductName_Status = True
                        break
                    else:
                        print(f"'{searchedProduct}' is NOT present in '{data['result'][d]['ProductName']}'")

            print(response.status_code, searched_ProductName_Status, searched_ProductName)
            return response.status_code, searched_ProductName_Status, searched_ProductName

        except Exception as e:
            print(f"An error occurred: {e}")
            return response.status_code, searched_ProductName_Status, searched_ProductName

    def RetrieveData_DB(self, user_name):
        try:
            # Step 1: Connect to MongoDB
            client = MongoClient(MongoDB_URI)  # Replace with your MongoDB URI

            # Step 2: Access the database and collection
            db = client[database_name]  # Replace with your database name
            collection = db[collection_name]  # Replace with your collection name

            # Step 3: Query the collection to get a document
            document = collection.find_one({"user_name": user_name})  # Replace with the desired user_name

            # Step 4: Retrieve the user_name from the document
            if document:
                user_name = document.get("user_name")
                print(user_name)
                return user_name  # Return the user_name
            else:
                print(None)
                return None  # Return None if the user is not found
        except Exception as e:
            print(f"An error occurred: {e}")
            return None  # Return None if there's an exception


API_POSLaundry = POS()

### Must Run the Mandatory Methods ###
# API_POSLaundry.ConfigReader()
# API_POSLaundry.end_url()

### POST API ###
# API_POSLaundry.Register_API()
# API_POSLaundry.LoginAPI()
# API_POSLaundry.addUser_POST_API()
# API_POSLaundry.sendEmail_API()
# API_POSLaundry.RetrieveData_DB()

### GET API ###
# API_POSLaundry.getAPI_profile()
# API_POSLaundry.getAPI_Category()
# API_POSLaundry.getAPI_Product()
# API_POSLaundry.getAPI_Customer()
# API_POSLaundry.getAPI_Order()
# API_POSLaundry.getAPI_Branch()
# API_POSLaundry.getAPI_User()
# API_POSLaundry.getAPI_SingleOrder()
# API_POSLaundry.getAPI_ShoppingCart_EndURL()
# API_POSLaundry.is_product_present()

### PUT API ###
# API_POSLaundry.SetPassword_PUT_API()
