*** Settings ***
Library     SeleniumLibrary
Resource    ../Optimized_PO/CommonWrapper.robot
Resource    ../TestScripts/Base.robot

*** Keywords ***
Verfiy that login page all the elements are visible
    [Documentation]     Verfiy that login page all the elements are visible
    Element Should Be Disabled    ${locators_params['Login']}[Login_Btn]
    @{LoginPage_elements}     Create List   ${locators_params['Login']}[GetsStarted_lblTxt]   ${locators_params['Login']}[Username_Icon]
    ...     ${locators_params['Login']}[Username_Placeholder]    ${locators_params['Login']}[Username_Txtbox]
    ...     ${locators_params['Login']}[Password_Icon]    ${locators_params['Login']}[Password_Placeholder]
    ...     ${locators_params['Login']}[Password_Txtbox]    ${locators_params['Login']}[Encryption_Icon]
    ...     ${locators_params['Login']}[Login_Btn]
    Wait Until Elements Are Visible     @{LoginPage_elements}

Validation of the login page the elements text
    [Documentation]     Validation of the login page the elements text
    @{LoginPage_elements}     Create List   ${locators_params['Login']}[GetsStarted_lblTxt]   ${locators_params['Login']}[Username_Placeholder]
    ...     ${locators_params['Login']}[Password_Placeholder]   ${locators_params['Login']}[Login_Btn]
    ${GetsStarted_lblTxt}=  Replace String  ${testData_config['Login']}[GetsStarted_lblTxt]  â€™  ’
    @{LoginPage_elements_LblTxt}     Create List   ${GetsStarted_lblTxt}   ${testData_config['Login']}[Username_LblTxt]
    ...     ${testData_config['Login']}[Password_LblTxt]   ${testData_config['Login']}[Login_Btn]
    Check all the get elements text are should be equal    ${LoginPage_elements}    ${LoginPage_elements_LblTxt}

Login with invalid username and valid password
    [Documentation]   This testcase will login with invalid username to the application
    ${index}    Generate Random String    2    0123456789
    ${invalid_username}  Set Variable    ${testData_config['Login']}[invalid_username]${index}
    Set Global Variable    ${invalid_username}
    click and input the value    ${locators_params['Login']}[Username_Txtbox]   ${invalid_username}
    click and input the value    ${locators_params['Login']}[Password_Txtbox]   ${testData_config['Login']}[password]
    Click Element Until Enabled   ${locators_params['Login']}[Login_Btn]
    Page should contain the element     ${testData_config['Toast_Messages']}[loggedIn_Failed_Msg]
    Capture the Screen    Invalid_Username_Msg

Login with valid username and invalid password
    [Documentation]   This testcase will login with valid username and invalid password to the application
    Press Keys    ${locators_params['Login']}[Username_Txtbox]   CTRL+a+BACKSPACE
    click and input the value    ${locators_params['Login']}[Username_Txtbox]   ${testData_config['Login']}[username]
    Press Keys    ${locators_params['Login']}[Password_Txtbox]   CTRL+a+BACKSPACE
    click and input the value    ${locators_params['Login']}[Password_Txtbox]   ${testData_config['Login']}[invalid_password]
    Click Element Until Enabled   ${locators_params['Login']}[Login_Btn]
    Page should contain the element     ${testData_config['Toast_Messages']}[loggedIn_Failed_Msg]
    Capture the Screen    Invalid_Password_Msg

Login with blank username and invalid passowrd
    [Documentation]    login to the POS application with blank username
    Press Keys    ${locators_params['Login']}[Username_Txtbox]   CTRL+a+BACKSPACE
    Press Keys    ${locators_params['Login']}[Password_Txtbox]   CTRL+a+BACKSPACE
    click and input the value    ${locators_params['Login']}[Password_Txtbox]   ${testData_config['Login']}[invalid_password]
    Element Should Be Disabled   ${locators_params['Login']}[Login_Btn]
    Capture the Screen    Blank_Username_Msg

Login with invalid username and blank password
    [Documentation]    login with valid username and blank password
    Press Keys    ${locators_params['Login']}[Username_Txtbox]   CTRL+a+BACKSPACE
    click and input the value    ${locators_params['Login']}[Username_Txtbox]   ${invalid_username}
    Press Keys    ${locators_params['Login']}[Password_Txtbox]       CTRL+a+BACKSPACE
    Element Should Be Disabled   ${locators_params['Login']}[Login_Btn]
    Capture the Screen    Blank_Password_Msg

Login with blank username and password
    [Documentation]    login to the POS application with blank username and password
    Press Keys    ${locators_params['Login']}[Username_Txtbox]    CTRL+a+BACKSPACE
    Press Keys    ${locators_params['Login']}[Password_Txtbox]    CTRL+a+BACKSPACE
    Element Should Be Disabled   ${locators_params['Login']}[Login_Btn]
    Capture the Screen    Blank_UsernamePassword_Msg

Login with invalid username and password
    [Documentation]     Verify the toast message when Login with invalid username and password
    click and input the value    ${locators_params['Login']}[Username_Txtbox]   ${invalid_username}
    click and input the value    ${locators_params['Login']}[Password_Txtbox]   ${testData_config['Login']}[invalid_password]
    Click Element Until Enabled  ${locators_params['Login']}[Login_Btn]
    Page should contain the element     ${testData_config['Toast_Messages']}[loggedIn_Failed_Msg]
    Capture the Screen    Invalid_UsernamePassword_Msg

verfiy the Encryption Icon is working properly
    [Documentation]     verfiy the Encryption Icon is working properly
    ${Encryption_value}      Get Text    ${locators_params['Login']}[Password_Txtbox]
    Click Element Until Enabled    ${locators_params['Login']}[Encryption_Icon]
    Wait Until Element Is Visible    ${locators_params['Login']}[Decryption_Icon]
    Capture the Screen   Encrypt_Decrypt

Login with valid username and password
    [Documentation]     Verify the successfull message popup
    Press Keys    ${locators_params['Login']}[Username_Txtbox]   CTRL+a+BACKSPACE
    click and input the value   ${locators_params['Login']}[Username_Txtbox]   ${testData_config['Login']}[username]
    Press Keys    ${locators_params['Login']}[Password_Txtbox]   CTRL+a+BACKSPACE
    click and input the value    ${locators_params['Login']}[Password_Txtbox]   ${testData_config['Login']}[password]
    wait until page contains  Login
    verfiy the Encryption Icon is working properly
    Element Should Be Enabled   ${locators_params['Login']}[Login_Btn]
    Click Element Until Enabled    ${locators_params['Login']}[Login_Btn]
    Page should contain the element     ${testData_config['Toast_Messages']}[loggedIn_Success_Msg]
    Capture the Screen    loggedIn_Success_Msg