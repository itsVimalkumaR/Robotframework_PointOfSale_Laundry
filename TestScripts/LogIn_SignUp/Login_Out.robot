*** Settings ***
Documentation    Login to Point of Sale application
Library          SeleniumLibrary
Suite Setup      Run Keywords   Initialize configuration parameters
Suite Teardown   Close the browsers
Resource         ../../TestScripts/Base.robot


*** Test Cases ***
Validation of the login page elements
    [Tags]    Login  Regression
    Navigate to login page of the pos application
    Verfiy that login page all the elements are visible
    Validation of the login page the elements text

Validation of the toast messages
    [Tags]    Login  ToastMessage  Regression
    Login with invalid username and valid password
    Login with valid username and invalid password
    Login with invalid username and blank password
    Login with blank username and invalid passowrd
    Login with blank username and password
    Login with invalid username and password
    Login with valid username and password
    logout the Application