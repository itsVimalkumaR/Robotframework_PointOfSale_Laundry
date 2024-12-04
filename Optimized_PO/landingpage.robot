*** Settings ***
Library         SeleniumLibrary
Library         OperatingSystem
Library         DateTime
Library         String
Library         Collections
Library         RequestsLibrary
Library         BuiltIn
Resource        ../Optimized_PO/CommonWrapper.robot
Variables       ../utils/configReader.py

*** Keywords ***
login to the user application
    Launch the Browser
    Login to the application

Launch the Browser
    ${browser}=   call method    ${ObjconfigReader}   browser
    Open Browser  about:blank  ${browser}
    Maximize Browser Window
#    Set Window Size  ${1440}   ${900}

Navigate to login page of the pos application
    [Documentation]     Enter the Loginurl of the  POS Application
    Launch the Browser
    set selenium timeout    20 seconds
    set selenium implicit wait    20 seconds
    log to console    running POS Laundry...
    ${BaseURL}=   call method    ${ObjconfigReader}   Baseurl
    Run Keyword If    "${BaseURL}" == "https://127.0.0.1:5000"  
    ...    Run the backend local host url        # If we need to run localhost we must uncomment this line else we no need to uncomment
    ${Loginurl}=   call method    ${ObjconfigReader}   Loginurl
    go to  ${Loginurl}
    sleep    5
    Zoom Out the Page
    Capture the Screen    Login_Page

Login to the application
    set selenium timeout    20 seconds
    set selenium implicit wait    20 seconds
    log to console    running POS Laundry...
    ${BaseURL}=   call method    ${ObjconfigReader}   Baseurl
    Run Keyword If    "${BaseURL}" == "https://127.0.0.1:5000"
    ...    Run the backend local host url        # If we need to run localhost we must uncomment this line else we no need to uncomment
    ${Loginurl}=   call method    ${ObjconfigReader}   Loginurl
    go to  ${Loginurl}
    sleep    5
#    Zoom Out the Page
    sleep  5
    Verify the title of Login page
    click and input the value   ${locators_params['Login']}[Username_Txtbox]   ${testData_config['Login']}[username]
    click and input the value    ${locators_params['Login']}[Password_Txtbox]   ${testData_config['Login']}[password]
    wait until page contains  Login
    sleep    1
    Click Element Until Enabled    ${locators_params['Login']}[Login_Btn]
    sleep    15
    Capture the Screen    SignIn_Page
    Verify the title of Home page
    wait until element is visible  ${locators_params['Home']}[HomePage_Header]

Navigate to signup page of the pos application
    [Documentation]     Enter the Signurl of the  POS Application
    Launch the Browser
    set selenium timeout    20 seconds
    set selenium implicit wait    20 seconds
    log to console    running POS Laundry...
    ${BaseURL}=   call method    ${ObjconfigReader}   Baseurl
    Run Keyword If    "${BaseURL}" == "https://127.0.0.1:5000"
    ...    Run the backend local host url        # If we need to run localhost we must uncomment this line else we no need to uncomment
    ${Signurl}=   call method    ${ObjconfigReader}   Signurl
    go to  ${Signurl}
#    Zoom Out the Page
    sleep    5
    Capture the Screen    Signup_Page
    Verify the title of Signup page

close Toast Message
    click element    xpath=//button[contains(@class,'p-toast-icon-close')]

Close the browsers
    close all browsers

logout the Application
     wait until element is Visible  ${locators_params['Home']['Profile']}[Dropdown_Btn]
     Click Element Until Visible  ${locators_params['Home']['Profile']}[Dropdown_Btn]
     Capture the Screen    Logout_Button
     wait until element is Visible  ${locators_params['Home']['Profile']}[Logout_Btn]
     click element until visible   ${locators_params['Home']['Profile']}[Logout_Btn]
     Sleep    3s
     wait until element is Visible   ${locators_params['Login']}[Login_Btn]
     Element Should Be Disabled   ${locators_params['Login']}[Login_Btn]
     Capture the Screen    LogoutSuccessfully

Open New Tab
    [Documentation]    Open New Tab
    [Arguments]    ${URL}
    Execute Javascript   window.open('${URL}');    # Open a new tab using JavaScript
    Sleep    5s
    # Switch to the new tab
    @{handles}    Get Window Handles
    Switch Window    ${handles}[1]    # Switch to the new tab, assuming it's the second handle
    Capture The Screen    Demo

##############################################################################################################
#                    Open POS application via Localhost
##############################################################################################################
Run the backend local host url
    [Documentation]    Run the backend local host url
    ${BaseURL}=   call method    ${ObjconfigReader}   Baseurl
    go to  ${BaseURL}
    Wait Until Element Is Visible    ${locators_params['Common']['Localhost']['Backend_URL_Page']}[Advanced_Btn]
    Click Element Until Visible      ${locators_params['Common']['Localhost']['Backend_URL_Page']}[Advanced_Btn]
    Sleep    3s
    Wait Until Element Is Visible    ${locators_params['Common']['Localhost']['Backend_URL_Page']}[Proceed_Unsafe_LinkText]
    Click Element Until Visible      ${locators_params['Common']['Localhost']['Backend_URL_Page']}[Proceed_Unsafe_LinkText]
    Sleep    5s