*** Settings ***
Documentation    Signup to Point of Sale application
Library          SeleniumLibrary
Suite Setup      Run Keywords   Initialize configuration parameters for Signup
...              AND  Navigate to signup page of the pos application
Suite Teardown   Close the browsers
Resource         ../../TestScripts/Base.robot

*** Test Cases ***
Validation of the Signup page
    [Documentation]     Verify and validation of the signup page elements
    [Tags]  Signup  Regression
    Verify all the signup page elements are visible
    Validation of the all signup page elements text
    Check to make sure the registration button is deactivated when no information is entered
    Check to see if the incorrect phone number entered in the phone number textbox displays the error message
#    Make sure the error message appears when an incorrect password is entered   (Regarding - Removed the Password input field in UI)
    Check if the error message appears after entering the existing username in the username textbox
    ${user_name}    Check if the error message appears after entering the existing business name in the business name textbox
    Check if the error message appears after entering the existing email address in the email address textbox    ${user_name}
    ${API_postData}  ${Business_Name}  Make sure the registration page's success message is visible
    ${username}  ${password}  Validate the set password page    ${API_postData}
    Verify that the business name is visible in the home page after signup  ${username}  ${password}  ${Business_Name}