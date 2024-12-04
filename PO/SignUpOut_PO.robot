*** Settings ***
Library     SeleniumLibrary
Resource    ../Optimized_PO/CommonWrapper.robot
Resource    ../TestScripts/Base.robot

*** Keywords ***
Verify all the signup page elements are visible
    [Documentation]     Verify all the signup page elements are visible
#    Wait Until Element Is Visible   ${locators_params['Signup']}[Login_lnkTxt]
#    Click Element Until Visible    ${locators_params['Signup']}[Login_lnkTxt]
#    sleep   2
#    Go Back
#    Wait Until Element Is Visible   ${locators_params['Login']}[Login_Btn]
#    Go Back
    Wait Until Element Is Visible   ${locators_params['Signup']}[Signup_Btn]
    @{Signup_Elements}      Create List     ${locators_params['Login']}[GetsStarted_lblTxt]
    ...     ${locators_params['Signup']}[Username_Icon]  ${locators_params['Signup']}[Username_lblTxt]  ${locators_params['Signup']}[Username_TxtBox]
    ...     ${locators_params['Signup']}[Name_Icon]   ${locators_params['Signup']}[Name_lblTxt]  ${locators_params['Signup']}[Name_TxtBox]
    ...     ${locators_params['Signup']}[BusinessName_Icon]  ${locators_params['Signup']}[BusinessName_lblTxt]  ${locators_params['Signup']}[BusinessName_TxtBox]
    ...     ${locators_params['Signup']}[DateOfBirth_Icon]  ${locators_params['Signup']}[DateOfBirth_lblTxt]  ${locators_params['Signup']}[DateOfBirth_TxtBox]
    ...     ${locators_params['Signup']}[PhoneNo_Icon]  ${locators_params['Signup']}[PhoneNo_LblTxt]    ${locators_params['Signup']}[PhoneNo_TxtBox]
    ...     ${locators_params['Signup']}[Address_Icon]   ${locators_params['Signup']}[Address_lblTxt]  ${locators_params['Signup']}[Address_TxtBox]
    ...     ${locators_params['Signup']}[State_Icon]  ${locators_params['Signup']}[State_LblTxt]  ${locators_params['Signup']}[State_DropDownBtn]
    ...     ${locators_params['Signup']}[Country_Icon]  ${locators_params['Signup']}[Country_LblTxt]  ${locators_params['Signup']}[Country_DropDownBtn]
    ...     ${locators_params['Signup']}[PinCode_Icon]  ${locators_params['Signup']}[PinCode_LblTXt]  ${locators_params['Signup']}[PinCode_TxtBox]
    ...     ${locators_params['Signup']}[Signup_Btn]  ${locators_params['Signup']['BusinessTypes']}[Icon]  ${locators_params['Signup']['BusinessTypes']}[LblTxt]
    ...     ${locators_params['Signup']['BusinessTypes']}[Dropdown_Btn]
    Wait Until Elements Are Visible     @{Signup_Elements}
    Capture the Screen    Signup_Elements

Validation of the all signup page elements text
    [Documentation]     Validation of the all signup page elements text
    @{Signup_Elements}      Create List     ${locators_params['Login']}[GetsStarted_lblTxt]     ${locators_params['Signup']}[Username_lblTxt]  ${locators_params['Signup']}[Name_lblTxt]
    ...     ${locators_params['Signup']}[BusinessName_lblTxt]   ${locators_params['Signup']}[Email_LblTxt]  ${locators_params['Signup']}[DateOfBirth_lblTxt]
    ...     ${locators_params['Signup']}[PhoneNo_LblTxt]    ${locators_params['Signup']}[Address_lblTxt]
    ...     ${locators_params['Signup']}[State_LblTxt]  ${locators_params['Signup']}[Country_LblTxt]
    ...     ${locators_params['Signup']}[PinCode_LblTXt]  ${locators_params['Signup']}[Signup_Btn]  ${locators_params['Signup']['BusinessTypes']}[LblTxt]
    ${GetsStarted_lblTxt}=  Replace String  ${testData_config['Login']}[GetsStarted_lblTxt]  â€™  ’
    @{Signup_Elements_text}  Create List  ${GetsStarted_lblTxt}  ${testData_config['Signup']}[Username_lblTxt]
    ...     ${testData_config['Signup']}[Name_lblTxt]  ${testData_config['Signup']}[BusinessName_lblTxt]    ${testData_config['Signup']}[Email_LblTxt]
    ...     ${testData_config['Signup']}[DateOfBirth_lblTxt]  ${testData_config['Signup']}[PhoneNo_LblTxt]
    ...     ${testData_config['Signup']}[Address_lblTxt]  ${testData_config['Signup']}[State_LblTxt]  ${testData_config['Signup']}[Country_LblTxt]
    ...     ${testData_config['Signup']}[PinCode_LblTXt]   ${testData_config['Signup']}[Signup_Btn]  ${testData_config['Signup']['BusinessTypes']}[LblTxt]
    Check all the get elements text are should be equal    ${Signup_Elements}    ${Signup_Elements_text}

Check to make sure the registration button is deactivated when no information is entered
    [Documentation]     Check to make sure the registration button is deactivated when no information is entered
    Wait Until Element Is Visible    ${locators_params['Signup']}[Signup_Btn]
    Element Should Be Disabled    ${locators_params['Signup']}[Signup_Btn]

Check to see if the incorrect phone number entered in the phone number textbox displays the error message
    [Documentation]     Check to see if the incorrect phone number entered in the phone number textbox displays the error message.
    ${index}    Generate Random String    2    0123456789
    ${Username}  Set Variable    ${testData_config['Signup']}[Username]${index}
    @{SignUp_InputData}     create list  ${Username}   ${testData_config['Signup']}[Name]
    ...   ${testData_config['Signup']}[Business_Name]   ${testData_config['Signup']}[Email]  ${testData_config['Signup']}[DateOf_Birth]
    ...   ${testData_config['Signup']}[Invalid_PhoneNo]   ${testData_config['Signup']}[Address]
    ...   ${testData_config['Signup']}[PinCode] 
    @{Signup_Elements}      Create List     ${locators_params['Signup']}[Username_TxtBox]  ${locators_params['Signup']}[Name_TxtBox]
    ...     ${locators_params['Signup']}[BusinessName_TxtBox]   ${locators_params['Signup']}[Email_TxtBox]  ${locators_params['Signup']}[DateOfBirth_TxtBox]
    ...     ${locators_params['Signup']}[PhoneNo_TxtBox]  ${locators_params['Signup']}[Address_TxtBox]
    ...     ${locators_params['Signup']}[PinCode_TxtBox]
    ${CountOf_TxtBox}       Get Length   ${Signup_Elements}
    FOR    ${i}    IN RANGE    0    ${CountOf_TxtBox}
        click and input the value    ${Signup_Elements}[${i}]    ${SignUp_InputData}[${i}]
    END
    Click Element Until Visible    ${locators_params['Signup']['BusinessTypes']}[Dropdown_Btn]
    ${BusinessType_Options}  Get Webelements    ${locators_params['Signup']['BusinessTypes']}[Options]
    Click Element Until Visible    ${BusinessType_Options}[0]
    Capture The Screen    BusinessType_selected
    @{DropDown_Elements}  Create List        ${locators_params['Signup']}[Country_DropDownBtn]    ${locators_params['Signup']}[State_DropDownBtn]
    @{DropDown_Values}  Create List   ${testData_config['Signup']}[Country]    ${testData_config['Signup']}[State]
    Select from dropdown list option  ${locators_params['Signup']}[Country_Options]  ${testData_config['Signup']}[Country]   ${locators_params['Signup']}[Country_DropDownBtn]
    Select from dropdown list option  ${locators_params['Signup']}[State_Options]  ${testData_config['Signup']}[State]   ${locators_params['Signup']}[State_DropDownBtn]
    element should be disabled  ${locators_params['Signup']}[Signup_Btn]
    ${PhoneNo_ErrMsg}=   run keyword and return status   Wait Until Element Is Visible    ${locators_params['Signup']}[Invalid_PhoneNo_Msg]
    Run Keyword If    ${PhoneNo_ErrMsg} == True    Validate the invalid phone number message text
    ...  ELSE   Wait Until Element Is Visible    ${locators_params['Signup']}[Invalid_PhoneNo_Msg]
    Capture the Screen  Invaild_PhoneNumber_Msg

Throw data and get response to register api
    [Documentation]    Throw all the signup page input details
    [Arguments]    ${Username}  ${Name}  ${BusinessName}  ${EmailId}  ${DOB}  ${PhoneNumber}  ${Address}  ${State}  ${Country}  ${Pincode}  ${API_Response_Msg}
    ${BusinessType}  Set Variable    laundry
    ${role}  Set Variable    Super Admin
    @{data}  Create List    ${Username}  ${Name}  ${BusinessName}  ${EmailId}  ${DOB}  ${PhoneNumber}  ${Address}  ${State}  ${Country}  ${Pincode}  ${BusinessType}  ${role}  ${API_Response_Msg}
    ${response}    call method  ${API_POSLaundry}    Register_API  ${Username}  ${Name}  ${BusinessName}  ${EmailId}  ${DOB}  ${PhoneNumber}  ${Address}  ${State}  ${Country}  ${Pincode}  ${BusinessType}  ${role}
    log  ${response}
    Should Be Equal    ${API_Response_Msg}    ${response}[1]

Validate the invalid phone number message text
    [Documentation]     Validate the invalid phone number message
    ${UI_Invalid_PhoneNo_ErrMsg}    get text   ${locators_params['Signup']}[Invalid_PhoneNo_Msg]
    should be equal   ${UI_Invalid_PhoneNo_ErrMsg}      ${testData_config['Toast_Messages']}[Invalid_PhoneNo_Msg]
    sleep  3s
    ${Phone_Number}    Generate Random String    8    0123456789
    Click and clear element text    ${locators_params['Signup']}[PhoneNo_TxtBox]
    click and input the value    ${locators_params['Signup']}[PhoneNo_TxtBox]    ${Phone_Number}
    Page Should Not Contain    ${testData_config['Toast_Messages']}[Invalid_PhoneNo_Msg]

Make sure the error message appears when an incorrect password is entered
    [Documentation]     Make sure the error message appears when an incorrect password is entered
    Press Keys    ${locators_params['Signup']}[Password_TxtBox]   CTRL+a+BACKSPACE
    click and input the value    ${locators_params['Signup']}[Password_TxtBox]    ${testData_config['Signup']}[Invalid_Password]
    Click Element Until Visible    ${locators_params['Signup']}[Signup_Btn]
    ${Password_ErrMsg}=   run keyword and return status   Wait Until Element Is Visible   ${locators_params['Signup']}[Invalid_Password_Msg]
    Run Keyword If    ${Password_ErrMsg} == True    Validate the invalid password error message text
    ...    ELSE     Wait Until Element Is Visible   ${locators_params['Signup']}[Exist_Username_Msg]
    sleep  3s
    Capture the Screen  Invaild_Password_Msg

Validate the invalid password error message text
    [Documentation]  Validate the invalid password error message text
    ${UI_Invalid_Password_Msg}    get text   ${locators_params['Signup']}[Invalid_Password_Msg]
    should be equal   ${UI_Invalid_Password_Msg}      ${testData_config['Toast_Messages']}[Invalid_Password_Msg]
    Press Keys    ${locators_params['Signup']}[Password_TxtBox]   CTRL+a+BACKSPACE
    click and input the value    ${locators_params['Signup']}[Password_TxtBox]    ${testData_config['Signup']}[Password]
    Page Should Not Contain    ${testData_config['Toast_Messages']}[Invalid_Password_Msg]

Check if the error message appears after entering the existing username in the username textbox
    [Documentation]     Check if the error message appears after entering the existing username in the Username textbox
    ${response}  call method  ${API_POSLaundry}  getAPI_User
    log  ${response}
    ${Usernames}  Set Variable  ${response}[1]
    ${count}  Get Length    ${Usernames}
    ${index} =    Evaluate  ${count}-1
#    ${Exist_Username} =   Get From List   ${Usernames}   ${index}
    ${exist_Username}  Evaluate  "${Usernames}[${index}]"
    Log    ${exist_Username}
    Click and clear element text    ${locators_params['Signup']}[Username_TxtBox]
    click and input the value    ${locators_params['Signup']}[Username_TxtBox]    ${exist_Username}
    sleep  3s
    capture the screen  Exist_Username_ErrMsg1
    Click Element Until Visible    ${locators_params['Signup']}[Signup_Btn]
    Wait Until Element Is Visible   ${locators_params['Signup']}[Exist_Username_Msg]
    Validate the exist username error message text
    Wait Until Element Is Not Visible   ${locators_params['Signup']}[Exist_Username_Msg]
    sleep  3s
    ${Random_EmailID}   Generate Random Email
    Throw data and get response to register api  ${exist_Username}   ${testData_config['Signup']}[Name]
    ...   ${testData_config['Signup']}[Business_Name]   ${testData_config['Signup']}[Email]  ${testData_config['Signup']}[DateOf_Birth]
    ...   ${testData_config['Signup']}[Invalid_PhoneNo]   ${testData_config['Signup']}[Address]
    ...   ${testData_config['Signup']}[State]    ${testData_config['Signup']}[Country]
    ...   ${testData_config['Signup']}[PinCode]  ${testData_config['Toast_Messages']['API_Response_ErrMsg']}[UserName_Exist]
#    Throw data and get response to register api  ${exist_Username}   ${testData_config['Signup']}[Name]
#    ...   ${testData_config['Signup']}[Business_Name]   ${Random_EmailID}  ${testData_config['Signup']}[DateOf_Birth]
#    ...   ${testData_config['Signup']}[Phone_Number]   ${testData_config['Signup']}[Address]
#    ...   ${testData_config['Signup']}[State]    ${testData_config['Signup']}[Country]
#    ...   ${testData_config['Signup']}[PinCode]  ${testData_config['Toast_Messages']['API_Response_ErrMsg']}[UserName_Exist]
    Capture the Screen  Exist_Username_Msg2

Validate the exist username error message text
    [Documentation]     Validate the exist username error message
    ${UI_exist_Username_Msg}    get text   ${locators_params['Signup']}[Exist_Username_Msg]
    should be equal   ${UI_exist_Username_Msg}      ${testData_config['Toast_Messages']}[Exist_Username_Msg]
    Press Keys    ${locators_params['Signup']}[Username_TxtBox]   CTRL+a+BACKSPACE
    click and input the value    ${locators_params['Signup']}[Username_TxtBox]    ${testData_config['Signup']}[Username]
    Page Should Not Contain    ${testData_config['Toast_Messages']}[Exist_Username_Msg]

Check if the error message appears after entering the existing business name in the business name textbox
    [Documentation]    Check if the error message appears after entering the existing business name in the business name textbox
    Click and clear element text    ${locators_params['Signup']}[Username_TxtBox]
    Click and clear element text    ${locators_params['Signup']}[BusinessName_TxtBox]
    ${index}    Generate Random String    2    0123456789
    ${random_Username}  Generate random string without special character
    ${user_name}  Set Variable    ${random_Username}${index}
    ${Random_EmailID}   Generate Random Email
    click and input the value    ${locators_params['Signup']}[Username_TxtBox]    ${user_name}
    sleep  3s
    ${response}  call method  ${API_POSLaundry}  getAPI_User
    log  ${response}
    ${BusinessNames}  Set Variable  ${response}[4]
    ${count}  Get Length    ${BusinessNames}
    ${index} =    Evaluate  ${count}-1
#    ${Exist_BusinessName} =   Get From List   ${BusinessNames}   ${index}
    ${Exist_BusinessName}  Evaluate  "${BusinessNames}[${index}]"
    Log    ${Exist_BusinessName}
    click and input the value    ${locators_params['Signup']}[BusinessName_TxtBox]    ${Exist_BusinessName}
    capture the screen  Exist_BusinessName_Msg1
    Click Element Until Visible    ${locators_params['Signup']}[Signup_Btn]
    Throw data and get response to register api  ${user_name}   ${testData_config['Signup']}[Name]
    ...   ${Exist_BusinessName}   ${testData_config['Signup']}[Email]  ${testData_config['Signup']}[DateOf_Birth]
    ...   ${testData_config['Signup']}[Phone_Number]   ${testData_config['Signup']}[Address]
    ...   ${testData_config['Signup']}[State]    ${testData_config['Signup']}[Country]
    ...   ${testData_config['Signup']}[PinCode]  ${testData_config['Toast_Messages']['API_Response_ErrMsg']}[BusinessName_Exist]
    Wait Until Element Is Visible   ${locators_params['Signup']}[Exist_BusinessName_Msg]
    Validate the exist business name error message text
    Wait Until Element Is Not Visible   ${locators_params['Signup']}[Exist_BusinessName_Msg]
    sleep  3s
    Capture the Screen  Exist_BusinessName_Msg2
    RETURN    ${user_name}

Validate the exist business name error message text
    [Documentation]     Validate the exist business name error message text
    ${UI_exist_Username_Msg}    get text   ${locators_params['Signup']}[Exist_BusinessName_Msg]
    should be equal   ${UI_exist_Username_Msg}      ${testData_config['Toast_Messages']}[Exist_BusinessName_Msg]
    ${index}    Generate Random String    2    0123456789
    Sleep    3s
    ${Business_Name}    Set Variable    ${testData_config['Signup']}[Business_Name]${index}
    Press Keys    ${locators_params['Signup']}[BusinessName_TxtBox]   CTRL+a+BACKSPACE
    click and input the value    ${locators_params['Signup']}[BusinessName_TxtBox]    ${Business_Name}
    Page Should Not Contain    ${testData_config['Toast_Messages']}[Exist_BusinessName_Msg]

Check if the error message appears after entering the existing email address in the email address textbox
    [Documentation]    Check if the error message appears after entering the existing email address in the Username textbox
    [Arguments]    ${user_name}
    ${response}  call method  ${API_POSLaundry}  getAPI_User
    log  ${response}
    ${Emails}  Set Variable  ${response}[6]
    ${count}  Get Length    ${Emails}
    ${index} =    Evaluate  ${count}-1
#    ${Exist_Email} =   Get From List   ${BusinessNames}   ${index}
    ${Exist_Email}  Evaluate  "${Emails}[${index}]"
    Log    ${Exist_Email}
    ${Business_Name}  Generate random string without special character
    Click and clear element text    ${locators_params['Signup']}[BusinessName_TxtBox]
    Click and clear element text    ${locators_params['Signup']}[Email_TxtBox]
    capture the screen  Exist_Email
    sleep  2s
    click and input the value    ${locators_params['Signup']}[BusinessName_TxtBox]    ${Business_Name}
    Capture The Screen    Entered_business_name
    click and input the value    ${locators_params['Signup']}[Email_TxtBox]    ${Exist_Email}
    Capture The Screen    Entered_email
    Click Element Until Visible    ${locators_params['Signup']}[Signup_Btn]
    Sleep    5s
    capture the screen  Exist_EmailId_Msg1
    ${random_phoneNo}    Generate Random String    8    0123456789
    ${businessName_ExistMsg_Status}    run keyword and return status    Wait Until Element Is Visible    ${locators_params['Signup']}[Exist_BusinessName_Msg]
    Run Keyword If   '${businessName_ExistMsg_Status}' == 'True'    run keywords    Validate the exist business name error message text
    Throw data and get response to register api  ${user_name}   ${testData_config['Signup']}[Name]
    ...   ${Business_Name}+1   ${Exist_Email}  ${testData_config['Signup']}[DateOf_Birth]
    ...   ${random_phoneNo}   ${testData_config['Signup']}[Address]
    ...   ${testData_config['Signup']}[State]    ${testData_config['Signup']}[Country]
    ...   ${testData_config['Signup']}[PinCode]  ${testData_config['Toast_Messages']['API_Response_ErrMsg']}[EmailID_Exist]
    Sleep    5s
    Click Element Until Visible    ${locators_params['Signup']}[Signup_Btn]
    capture the screen  Exist_EmailId_Msg1
    Page Should Contain    Email already exists
    Wait Until Element Is Visible   ${locators_params['Signup']}[Exist_EmailId_Msg]
    ${Random_EmailID}   Generate Random Email
    Validate the exist email error message text    ${Random_EmailID}
    Wait Until Element Is Not Visible   ${locators_params['Signup']}[Exist_EmailId_Msg]
    sleep  3s
    Capture the Screen  Exist_EmailId_Msg2
    RETURN    ${Random_EmailID}

Validate the exist email error message text
    [Documentation]     Validate the exist email error message text
    [Arguments]    ${EmailID}
    ${UI_exist_Username_Msg}    get text   ${locators_params['Signup']}[Exist_EmailId_Msg]
    should be equal   ${UI_exist_Username_Msg}      ${testData_config['Toast_Messages']}[Exist_Email_Msg]
    Press Keys    ${locators_params['Signup']}[Email_TxtBox]   CTRL+a+BACKSPACE
    click and input the value    ${locators_params['Signup']}[Email_TxtBox]    ${EmailID}
    Page Should Not Contain    ${testData_config['Toast_Messages']}[Exist_Email_Msg]

Make sure the registration page's success message is visible
    [Documentation]     Verify the success message is visible in the signup page
    ${response}  call method  ${API_POSLaundry}  getAPI_User
    log  ${response}
    ${Usernames}  Set Variable  ${response}[1]
    ${count}  Get Length    ${Usernames}
    ${num} =    Evaluate  ${count}-1
    ${user_name}  Evaluate  "${Usernames}[${num}]"
    ${index}    Generate Random String    3    0123456789
    ${Username}  Set Variable    ${user_name}${index}
    ${Business_Name}  Set Variable    ${testData_config['Signup']}[Exist_BusinessName]${index}
    ${emailID}    Generate Random Email
    ${Phone_Number}    Generate Random String    8    0123456789
#    @{SignUp_InputData}     create list  ${Username}   ${testData_config['Signup']}[Name]
#    ...   ${testData_config['Signup']}[Business_Name]   ${Random_Email}  ${testData_config['Signup']}[DateOf_Birth]
#    ...   ${testData_config['Signup']}[Phone_Number]   ${testData_config['Signup']}[Address]
#    ...   ${testData_config['Signup']}[State]    ${testData_config['Signup']}[Country]
#    ...   ${testData_config['Signup']}[PinCode]
#    @{Signup_Elements}      Create List     ${locators_params['Signup']}[Username_TxtBox]  ${locators_params['Signup']}[Name_TxtBox]
#    ...     ${locators_params['Signup']}[BusinessName_TxtBox]   ${locators_params['Signup']}[Email_TxtBox]  ${locators_params['Signup']}[DateOfBirth_TxtBox]
#    ...     ${locators_params['Signup']}[PhoneNo_TxtBox]  ${locators_params['Signup']}[Address_TxtBox]
#    ...     ${locators_params['Signup']}[State_TxtBox]   ${locators_params['Signup']}[Country_TxtBox]
#    ...     ${locators_params['Signup']}[PinCode_TxtBox]
#    ${CountOf_TxtBox}       Get Length   ${Signup_Elements}
#    FOR    ${i}    IN RANGE    0    ${CountOf_TxtBox}
#        Press Keys    ${Signup_Elements}[${i}]   CTRL+a+BACKSPACE
#        click and input the value    ${Signup_Elements}[${i}]    ${SignUp_InputData}[${i}]
#    END
    Click Element Until Enabled    ${locators_params['Signup']}[Signup_Btn]
    ${Signup_SuccessMsg}=   run keyword and return status  Page Should Contain    ${testData_config['Toast_Messages']}[Signup_SuccessMsg]
    Run Keyword If    "${Signup_SuccessMsg}" == "True"    Log    Account created successfully
    ${PhoneNo_ErrMsg}=   run keyword and return status   Wait Until Element Is Visible    ${locators_params['Signup']}[Invalid_PhoneNo_Msg]
    Run Keyword If    ${PhoneNo_ErrMsg} == True    Run Keywords    Validate the invalid phone number message text
    ...    AND   Click Element Until Enabled    ${locators_params['Signup']}[Signup_Btn]
    ...    AND   Page Should Contain    ${testData_config['Toast_Messages']}[Signup_SuccessMsg]
    ${API_ID}    Throw data and get success response to register api  ${Username}   ${testData_config['Signup']}[Name]
    ...   ${Business_Name}  ${emailID}  ${testData_config['Signup']}[DateOf_Birth]
    ...   ${Phone_Number}   ${testData_config['Signup']}[Address]
    ...   ${testData_config['Signup']}[State]    ${testData_config['Signup']}[Country]
    ...   ${testData_config['Signup']}[PinCode]  ${testData_config['Toast_Messages']['API_Response_ErrMsg']}[Reg_SuccessMsg]
    sleep  3s
    Capture the Screen  SignUp_SuccessFull
    RETURN  ${API_ID}  ${Business_Name}

Throw data and get success response to register api
    [Documentation]    Throw data and get success response to register api
    [Arguments]    ${Username}  ${Name}  ${BusinessName}  ${EmailId}  ${DOB}  ${PhoneNumber}  ${Address}  ${State}  ${Country}  ${Pincode}  ${API_Response_Msg}
    ${BusinessType}  Set Variable    laundry
    ${role}  Set Variable    Super Admin
    @{data}  Create List    ${Username}  ${Name}  ${BusinessName}  ${EmailId}  ${DOB}  ${PhoneNumber}  ${Address}  ${State}  ${Country}  ${Pincode}  ${BusinessType}  ${role}  ${API_Response_Msg}
    ${response}    call method  ${API_POSLaundry}    Register_API  ${Username}  ${Name}  ${BusinessName}  ${EmailId}  ${DOB}  ${PhoneNumber}  ${Address}  ${State}  ${Country}  ${Pincode}  ${BusinessType}  ${role}
    log  ${response}
    Should Be Equal    ${API_Response_Msg}    ${response}[1]
    ${Id}    Set Variable    ${response}[2]
    ${email}    Set Variable    ${response}[3]
    ${name}    Set Variable    ${response}[4]
    ${username}    Set Variable    ${response}[6]
    ${setPassword_URL}    Set Variable    ${response}[5]
    @{post_data}   Create List    ${Id}  ${email}  ${name}  ${username}  ${setPassword_URL}
    RETURN  ${post_data}

Validate the set password page
    [Documentation]    Validate the set password page
    [Arguments]  ${API_postData}
    ${Id}    Set Variable    ${API_postData}[0]
    ${email}  Set Variable    ${API_postData}[1]
    ${name}  Set Variable    ${API_postData}[2]
    ${username}  Set Variable    ${API_postData}[3]
    ${setPassword_URL}    Set Variable    ${API_postData}[4]
#    ${DOB}  Set Variable    ${API_postData}[4]
#    ${PhoneNumber}  Set Variable    ${API_postData}[5]
#    ${Address}  Set Variable    ${API_postData}[6]
#    ${State}  Set Variable    ${API_postData}[7]
#    ${Country}  Set Variable    ${API_postData}[8]
#    ${Pincode}   Set Variable    ${API_postData}[9]
#    ${ID}  Set Variable    ${API_postData}[10]
#    ${i}    Generate Random String    2    0123456789
#    ${response}    Call Method    ${API_POSLaundry}   sendEmail_API   ${Username}+${i}  ${Name}  ${BusinessName}  ${EmailId}  ${DOB}  ${PhoneNumber}  ${Address}  ${State}  ${Country}  ${Pincode}   ${ID}
#    ${response}    Call Method    ${API_POSLaundry}   sendEmail_API   ${Id}  ${email}  ${name}  ${username}
#    Log   ${response}
#    Open New Tab    ${response}[0]
    Open New Tab    ${setPassword_URL}
    Verify all elements are visible in the set password page
    ${password}    Verify the encrypt icon and confirm button is working properly
    RETURN    ${username}  ${password}
   
Verify all elements are visible in the set password page
    [Documentation]    Verify all elements are visible in the set password page
    @{SetPassword_elements}    Create List    ${locators_params['SetPassword']}[HeaderTxt]
    ...    ${locators_params['SetPassword']}[Create_Password_LblTxt]  ${locators_params['SetPassword']}[Create_Password_TxtBox]
    ...    ${locators_params['SetPassword']}[Create_Password_EncryptIcon]  ${locators_params['SetPassword']}[Confirm_Password_LblTxt]
    ...    ${locators_params['SetPassword']}[Confirm_Password_TxtBox]  ${locators_params['SetPassword']}[Confirm_Password_EncryptIcon]
    ...    ${locators_params['SetPassword']}[Confirm_Btn]
    Wait Until Elements Are Visible    @{SetPassword_elements}
    Capture The Screen    SetPassword_Page

Validation all elements label texts in the set password page
    [Documentation]    Validation all elements label texts in the set password page
    @{SetPassword_elements}    Create List    ${locators_params['SetPassword']}[HeaderTxt]
    ...    ${locators_params['SetPassword']}[Create_Password_LblTxt]  ${locators_params['SetPassword']}[Confirm_Password_LblTxt]
    ...    ${locators_params['SetPassword']}[Confirm_Btn]
    @{SetPassword_labelTexts}  Create List    ${testData_config['SetPassword']}[HeaderTxt]
    ...    ${testData_config['SetPassword']}[Create_Password_LblTxt]  ${testData_config['SetPassword']}[Confirm_Password_LblTxt]
    ...    ${testData_config['SetPassword']}[Confirm_Btn]
    Check All The Get Elements Text Are Should Contain    ${SetPassword_elements}    ${SetPassword_labelTexts}

Verify the encrypt icon and confirm button is working properly
    [Documentation]    Verify the encrypt icon and confirm button is working properly
    ${password}    Generate random string with special character
    Log    ${password}
    Click And Input The Value    ${locators_params['SetPassword']}[Create_Password_TxtBox]  ${password}
    ${CreatePassword_EncryptIcon}  Get Element Attribute    ${locators_params['SetPassword']}[Create_Password_EncryptIcon]  data-testid
    Click Element Until Visible    ${locators_params['SetPassword']}[Create_Password_EncryptIcon]
    ${CreatePassword_EncryptIcon_Status}  Get Element Attribute    ${locators_params['SetPassword']}[Create_Password_EncryptIcon]  data-testid
    Should Not Be Equal    ${CreatePassword_EncryptIcon}  ${CreatePassword_EncryptIcon_Status}
    Click And Input The Value    ${locators_params['SetPassword']}[Confirm_Password_TxtBox]  ${password}
    ${CreatePassword_EncryptIcon}  Get Element Attribute    ${locators_params['SetPassword']}[Confirm_Password_EncryptIcon]  data-testid
    Click Element Until Visible    ${locators_params['SetPassword']}[Confirm_Password_EncryptIcon]
    ${CreatePassword_EncryptIcon_Status}  Get Element Attribute    ${locators_params['SetPassword']}[Confirm_Password_EncryptIcon]  data-testid
    Should Not Be Equal    ${CreatePassword_EncryptIcon}  ${CreatePassword_EncryptIcon_Status}
    Click Element Until Visible    ${locators_params['SetPassword']}[Confirm_Btn]
    Page Should Contain    ${testData_config['Toast_Messages']}[SetPassword_SuccessMsg]
    Capture The Screen    Set_Password_Page
    Sleep    5s
    Verify the title of Login page
    Sleep    3s
    Close All Browsers
    RETURN    ${password}

Verify that the business name is visible in the home page after signup
    [Documentation]     Verify that the business name is visible in the home page after signup
    [Arguments]  ${username}  ${password}  ${Business_Name}
    Navigate to login page of the pos application
    @{data}    Create List    ${Username}  ${password}  ${Business_Name}
    Save the new user login credential  ${Username}  ${password}  ${Business_Name}
    click and input the value   ${locators_params['Login']}[Username_Txtbox]   ${Username}
    click and input the value    ${locators_params['Login']}[Password_Txtbox]   ${password}
    Click Element Until Visible    ${locators_params['Login']}[Encryption_Icon]
    Capture The Screen    LoginToWay
    wait until element is visible  ${locators_params['Login']}[Login_Btn]
    Click Element Until Enabled    ${locators_params['Login']}[Login_Btn]
    Page should contain    ${testData_config['Toast_Messages']}[loggedIn_Success_Msg]
    Capture the Screen    loggedIn_Success_Msg
    Sleep    10s
    Set Selenium Implicit Wait    5s
    Set Selenium Timeout    5s
    Reload Page
    Wait Until Element Visible    ${locators_params['Home']}[HomePage_Header]
    ${Hamburger_menu}  Run Keyword And Return Status    Wait Until Element Is Visible    ${locators_params['Home']['Hamburger_MenuIcons']}[Hamburger_menu]
    Run Keyword If    ${Hamburger_menu} == True    Run Keywords    Click Element Until Visible    ${locators_params['Home']['Hamburger_MenuIcons']}[Hamburger_menu]
    ...    AND  Validate the business profile name is visible inside the Hamburger menu    ${Business_Name}
    ...    ELSE  Validate the business profile name is visible inside menu    ${Business_Name}
    Capture The Screen    MenuLists_BusinessName

Validate the business profile name is visible inside menu
    [Documentation]    Validate the business profile name is visible inside menu
    [Arguments]    ${Business_Name}
    ${businessName_Status}    Run Keyword And Return Status    Wait Until Element Is Visible   ${locators_params['Home']}[MenuLists_BusinessName]
    Run Keyword If    ${businessName_Status} == False    Click Element Until Visible    ${locators_params['Home']}[IconForward_Btn]
    Sleep    2s
    Wait Until Element Is Visible   ${locators_params['Home']}[MenuLists_BusinessName]
    ${UI_BusinessName}=  get text    ${locators_params['Home']}[MenuLists_BusinessName]
    should be equal   ${UI_BusinessName}    ${Business_Name}
    
Validate the business profile name is visible inside the Hamburger menu
    [Documentation]    Validate the business profile name is visible inside the Hamburger menu
    [Arguments]    ${Business_Name}
    ${businessName_Status}    Run Keyword And Return Status    Wait Until Element Is Visible   ${locators_params['Home']['Hamburger_MenuIcons']}[MenuLists_BusinessName]
    Run Keyword If    ${businessName_Status} == False    Click Element Until Visible    ${locators_params['Home']['Hamburger_MenuIcons']}[IconForward_Btn]
    Sleep    2s
    Wait Until Element Is Visible   ${locators_params['Home']['Hamburger_MenuIcons']}[MenuLists_BusinessName]
    ${UI_BusinessName}=  get text    ${locators_params['Home']['Hamburger_MenuIcons']}[MenuLists_BusinessName]
    should be equal   ${UI_BusinessName}    ${Business_Name}
    