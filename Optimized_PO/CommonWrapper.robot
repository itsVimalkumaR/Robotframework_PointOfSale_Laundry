*** Settings ***
Library         SeleniumLibrary
Library         OperatingSystem
Library         DateTime
Library         String
Library         Collections
Library         RequestsLibrary
Library         BuiltIn
Variables       ../utils/config_parser.py
Variables       ../utils/configReader.py
Variables       ../utils/Implement.py
Variables       ../utils/OptimizeAPI.py
Resource        ../TestScripts/Base.robot
Resource        ../Optimized_PO/ConfigParserKeywords.robot
Resource        ../Optimized_PO/API_Integration.robot
Resource        ../Optimized_PO/landingpage.robot

*** Variables ***
${short_timeout}=   5 seconds
${timeout} =    10.0 seconds
${long_timeout}=    90.0 seconds
${browser}=   firefox

*** Keywords ***
Initialize configuration parameters
    Set Root Directory
    Parsing locators information
    Parsing test data config
    ${Url}=   call method    ${ObjconfigReader}   environment
    Run keyword IF   '${Url}' == 'Web'   ConfigReader for login User
    Run keyword IF   '${Url}' == 'Web'   API Call for end_url
    Run keyword IF    '${Url}' == 'Web'    API Call for UserLogin

Initialize configuration parameters for Signup
    Set Root Directory
    Parsing locators information
    Parsing test data config
    ${Url}=   call method    ${ObjconfigReader}   environment
    Run keyword IF   '${Url}' == 'Web'   ConfigReader for login User
    Run keyword IF   '${Url}' == 'Web'   API Call for end_url

Log Report
    Log To Console  running Stage..

click and input the value
    [Documentation]     Click the element and enter the value on the element
    [Arguments]     ${locator}     ${inputvalue}
    Click Element Until Visible    ${locator}
    Sleep    ${short_timeout}
    Enter the Value Untill Visible    ${locator}    ${inputvalue}

Capture the Screen
    [Arguments]    ${ScreenName}
    Set Library Search Order  SeleniumLibrary
    sleep    1
    Capture Page Screenshot    ${ScreenName}.png

Click Element Until Enabled
    [Documentation]  Wait until element is enabled and then click element
    [Arguments]    ${locator}
    Set Library Search Order  SeleniumLibrary
    Wait Until Element Is Enabled  ${locator}
    click element  ${locator}

Click Element Until Visible
    [Documentation]  Wait until element is visible and then click element
    [Arguments]  ${locator}
    Set Library Search Order  SeleniumLibrary
    Wait Until Element Is Visible  ${locator}  timeout=${timeout}
    click element  ${locator}
    Sleep  1

Enter the Value Untill Visible
    [Documentation]  Wait until element is visible and then Enter the Value
    [Arguments]  ${locator}  ${TextValue}
    Set Library Search Order  SeleniumLibrary
    Wait Until Element Is Visible  ${locator}  timeout=${timeout}
    input text    ${locator}      ${TextValue}

Page should contain the element
    [Documentation]  wait until Page should contains element
    [Arguments]    ${TextValue}
    Set Library Search Order  SeleniumLibrary
    page should contain    ${TextValue}

Scroll To Element
     [Arguments]  ${locator}
     ${x}=        Get Horizontal Position  ${locator}
     ${y}=        Get Vertical Position    ${locator}
     Execute Javascript  window.scrollTo(${x}, ${y})

Wait Until Elements Are Visible
    [Documentation]  Wait Until Multiple Elements Are Visible
    [Arguments]  @{multi_element}
    Set Library Search Order  SeleniumLibrary
    FOR   ${locator}   IN    @{multi_element}
      Wait Until Element Is Visible  ${locator}     timeout=${timeout}
    END


Elements Should not Visible
    [Documentation]  Wait Until Multiple Elements Are not Visible
    [Arguments]  @{multi_element}
    Set Library Search Order  SeleniumLibrary
    FOR   ${locator}   IN    @{multi_element}
      Element Should Not Be Visible  ${locator}     timeout=${timeout}
    END

Wait Until Page Contain Elements
    [Documentation]  Wait Until Page Contain Elements
    [Arguments]  @{multi_element}
    Set Library Search Order  SeleniumLibrary
    FOR  ${element}  IN  @{multi_element}
      Wait Until Page Contains Element  ${element}  timeout=${timeout}
    END

Page Should Contain Multiple Text
    [Documentation]  Page should contain multiple text at the same time
    [Arguments]  @{multi_text}
    FOR  ${text}  IN  @{multi_text}
    wait until page contains  ${text}  60s
    END

Table Header Should Contain Mutiple Text
    [Documentation]  Table header should contain mutiple text at the same time
    [Arguments]  ${locator}  @{multi_text}
    FOR  ${text}  IN  @{multi_text}
      Table Header Should Contain  ${locator}  ${text}
    END

Page Should Contain Multiple Element
    [Documentation]  Page should contain multiple element at the same time
    [Arguments]  @{multi_element}
    FOR  ${element}  IN  @{multi_element}
      Page Should Contain Element  ${element}
    END

Click and clear element text
    [Documentation]  Wait until element is visible and click then clear element text
    [Arguments]  ${locator}
    Wait Until Page Contains Element  ${locator}  timeout=10s
    Click Element Until Visible  ${locator}
    Press Keys   ${locator}   CTRL+a+BACKSPACE
#    Press Keys   ${locator}   CTRL+a+DELETE
    Capture The Screen    Cleared_Textfield

Clear the Element Text
    [Documentation]  Wait until element is visible and then clear element text
    [Arguments]  ${locator}
    Set Library Search Order  SeleniumLibrary
    Wait Until Page Contains Element  ${locator}  timeout=20s
    Clear Element Text  ${locator}
    Capture The Screen    Cleared_Textfield

wait until page contains multiple text
    [Documentation]  Wait Until Page Contain  multiple text
    [Arguments]  @{multi_text}
    Set Library Search Order  SeleniumLibrary
    FOR  ${element}  IN  @{multi_text}
      Wait Until Page Contains  ${element}  timeout=${timeout}
    END

Wait Until Element Visible
    [Documentation]  Wait until the element is visible
    [Arguments]  ${locator}
    Set Library Search Order  SeleniumLibrary
    Wait Until Element Is Visible  ${locator}  timeout=${timeout}

Element Should not Visible
    [Documentation]  Wait Until Element Are not Visible
    [Arguments]  ${locator}
    Set Library Search Order  SeleniumLibrary
    Element Should Not Be Visible  ${locator}     timeout=${timeout}

Selected value should be
    [Arguments]  ${locator}  ${value}
    ${text}=   get text  ${locator}
    should be equal  ${text}   ${value}

Entered value should be
    [Arguments]   ${locator}  ${value}
    ${text}=  get element attribute  ${locator}   value
    should be equal   ${text}  ${value}

Page Should not Contain Multiple Element
    [Documentation]  Page should not contain multiple element at the same time
    [Arguments]  @{multi_element}
    FOR  ${element}  IN  @{multi_element}
    wait until page does not contain element  ${element}   60s
    END

Elements should be disabled
    [Documentation]  Elements should be disabled
    [Arguments]  @{multi_element}
    FOR  ${element}  IN  @{multi_element}
    element should be disabled  ${element}
    END

Page should not contain multiple text
    [Documentation]  Page should not contain multiple text at the same time
    [Arguments]  @{multi_txt}
    FOR  ${text}  IN  @{multi_txt}
    Page should not contain  ${text}
    END

To Reload the Current page
    reload page
    sleep   8

Wait until loader spinner disappears
    [Documentation]    waits until spinwheel disappears
    Run Keyword If     '''${browser}''' == 'chrome'  chrome browser loader
       ...    ELSE   firefox browser loader

chrome browser loader
     wait until page does not contain element   //div[@class='spinner-border text-primary']     3m

firefox browser loader
     wait until page does not contain element   //div[@class='spinner-border text-primary']     5m

Validate dropdown list
    [Arguments]  ${dropdownName}   ${dropdownlist}  ${dropdownElement}
    FOR  ${dropdownValue}  IN  @{dropdownlist}
    select from list by label  ${dropdownElement}  ${dropdownValue}
    END

JS click element
    [Documentation]  To click hidden element
    [Arguments]     ${element_xpath}
    # escape " characters of xpath
#    ${element_xpath}=       Replace String      ${element_xpath}        \"  \\\"
#    Execute JavaScript  document.evaluate("${element_xpath}", document, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null).snapshotItem(0).click();
    Assign id to element  ${element_xpath}  id=Chkbox
    Execute JavaScript    document.getElementById('Chkbox').click();
    Sleep    2s
    
find the data from the list
    [Arguments]    ${data}
    sleep    5
    execute javascript    window.scrollTo(0,document.body.scrollHeight)
    Scroll To Element     ${locators_params['Settings']}[ShowEntries]
    ${PagenationBtn_Status}  run keyword and return status  Wait Until Element Is Enabled     ${locators_params['Settings']}[Pagination_NextBtn]
    Log    ${PagenationBtn_Status}
    capture the screen   ListOfTableData
    ${Find_Data}  format string   ${locators_params['Settings']}[Category_ColumnValue]   value=${data}
    Show all the data from the table   All
    ${TotalCount}    get text    ${locators_params['Settings']}[ShowEntries]
    ${last_char}    Get Substring    ${TotalCount}    -1
    ${count}  convert to integer  ${last_char}
    ${result}    Set Variable    False
    FOR   ${index}    IN RANGE   1    ${count}
        ${Find_Data}  format string   ${locators_params['Settings']}[Category_ColumnValue]   value=${data}
        ${result}=  Run Keyword And Return Status    element should be visible    ${Find_Data}
        Run Keyword If   ${result} == True  get text  ${Find_Data}
#        Run Keyword If   ${result} == True  Exit For Loop
        ...    ELSE    Show all the data from the table   All
        Log    ${index}
    END
    RETURN   ${result}

Show all the data from the table
    [Documentation]  Show all the data from the table
    [Arguments]  ${option}
    ${CancelBtn_Status}  run keyword and return status  Page should contain the element  ${locators_params['Settings']}[Cancel_Btn]
    run keyword if  ${CancelBtn_Status} == True  click element until visible  ${locators_params['Settings']}[Cancel_Btn]
    Wait Until Element Is Visible    ${locators_params['Settings']}[RowsPerPage_DDOptions]
    @{Options}  get webelements  ${locators_params['Settings']}[RowsPerPage_DDOptions]
    ${Options_Count}  get element count  ${locators_params['Settings']}[RowsPerPage_DDOptions]
    FOR  ${i}  IN RANGE  1  ${Options_Count}
        Wait Until Element Visible   ${locators_params['Settings']}[RowsPerPage_DDArrow]
        sleep  3s
        ${Selected_Option}  format string   ${locators_params['Settings']}[RowsPerPage_DDOption]   value=${option}
        Click Element Until Visible   ${locators_params['Settings']}[RowsPerPage_DDArrow]
        Click Element Until Visible  ${Selected_Option}
        capture the screen  AllData
        ${All_OptionTxt}  get text  ${locators_params['Settings']}[AllOption_RowsPerPage_DDValue]
        exit for loop if  '${All_OptionTxt}' == '${option}'
    END
    Capture The Screen    ShowAll_Data

Navigate to the next page of the table
    ${status}  run keyword and return status  Elements should be disabled  ${locators_params['Settings']}[Pagination_NextBtn]
    run keyword if  ${status} == True   log  We can't click the Next button
    ...     ELSE  run keywords  element should be enabled  ${locators_params['Settings']}[Pagination_NextBtn]
    ...     AND   Click Element Until Visible   ${locators_params['Settings']}[Pagination_NextBtn]

Check all the get elements text are should be equal
    [Documentation]  Check all the get elements text are should be equal to the test data list
    [Arguments]   ${elements}  ${testdata}
    ${CountOf_elements}       Get Length   ${elements}
    FOR    ${i}    IN RANGE    0    ${CountOf_elements}
        ${GetTxt}  get text  ${elements}[${i}]
        Log    ${testdata}[${i}]
        should be equal  ${GetTxt}  ${testdata}[${i}]
    END

Check all the get elements text are should contain
    [Documentation]  Check all the get elements text are should be equal to the test data list
    [Arguments]   ${elements}  ${testdata}
    ${CountOf_elements}       Get Length   ${elements}
    FOR    ${i}    IN RANGE    0    ${CountOf_elements}
        ${GetTxt}  get text  ${elements}[${i}]
        Log    ${testdata}[${i}]
        should contain  ${GetTxt}  ${testdata}[${i}]
    END

Edit multiple value in the inputfields
    [Arguments]     ${locators}  ${Inputs}
    ${CountOf_TxtBox}       Get Length   ${locators}
    FOR    ${i}    IN RANGE    0    ${CountOf_TxtBox}
        Press Keys    ${locators}[${i}]   CTRL+a+BACKSPACE
        click and input the value    ${locators}[${i}]    ${Inputs}[${i}]
    END

Enter multiple value in the inputfields
    [Arguments]     ${locators}  ${Inputs}
    ${CountOf_TxtBox}       Get Length   ${locators}
    FOR    ${i}    IN RANGE    0    ${CountOf_TxtBox}
        click and input the value    ${locators}[${i}]    ${Inputs}[${i}]
    END

Get text and Ensure the Headers are Equal
    [Documentation]  Get the header text from UI and Match with Expected text(NOTE: Path should be Common for all elements)
    [Arguments]  ${locator}   @{list}
    ${Headers_count}=    get element count  ${locator}
    ${Headers_txt}=    get webelements  ${locator}
    FOR   ${Header_count}    IN RANGE   0    ${Headers_count}
        ${Element_UI}=   get from list    ${Headers_txt}   ${Header_count}
        ${Header_UI}=    get text    ${Element_UI}
        ${Expected}=  get from list   ${list}   ${Header_count}
        should be equal   ${Header_UI}   ${Expected}
        log   ${Header_UI}
        log   ${Expected}
    END

Clear all textboxes value
    [Documentation]     Click elemnts and Clear all textboxes value
    [Arguments]     @{elements}
    FOR    ${element}    IN    @{elements}
        Click and clear element text   ${element}
    END
    Capture the Screen    ClearAll

Select from dropdown list option by labels
    [Documentation]    Select from dropdown option by using Select From List By Label
    [Arguments]    ${DropDown_Elements}  ${DropDown_Values}
    ${CountOf_DD}       Get Length   ${DropDown_Elements}
    FOR    ${i}    IN RANGE    0    ${CountOf_DD}
        Click Element Until Visible    ${DropDown_Elements}[${i}]
        log  ${DropDown_Values}[${i}]
        Select From List By Label  ${DropDown_Elements}[${i}]  ${DropDown_Values}[${i}]
        Capture The Screen    Selected_DD_Option
    END
    
Select from dropdown list option
    [Documentation]    Select from dropdown option by using press key
    [Arguments]    ${DropdownOptions}   ${selectingValue}  ${DropDownBtn}
    Click Element Until Visible    ${DropDownBtn}
    ${elements}  Get Webelements    ${DropdownOptions}
    ${count}    Get Length    ${elements}
    FOR    ${i}    IN RANGE    0    ${count}
        ${text}  Get Text    ${elements}[${i}]
        Press Key  ${elements}[${i}]  ARROW_DOWN
        Run Keyword If   "${text}" == "${selectingValue}"   run keywords  Click Element Until Visible  ${elements}[${i}]
        ...  AND  Exit For Loop
    END
    Capture The Screen   ${selectingValue}_0
    
Check all elements of attribute value of textfields
    [Documentation]  Check all elements of attribute value of textfields
    [Arguments]  ${CountOf_TxtBoxes}   ${Elements}   ${InputData}
    FOR    ${i}  IN RANGE  1  ${CountOf_TxtBoxes}
        Entered value should be     ${Elements}[${i}]   ${InputData}[${i}]
    END

Element Status Should Be Disabled
    [Arguments]    ${element_text}
    Element Should Be Visible    //*[@value='${element_text}' and contains(@class, 'disabled')]

Element Status Should Be Enabled
    [Arguments]    ${element_text}
    Element Should Be Visible    //*[@value='${element_text}' and not(contains(@class, 'disabled'))]

Get elements by using format string keyword
    [Documentation]  Get elements by using format string keyword
    [Arguments]  ${Locators}    ${inputdata}
    ${CountOf_DD}       Get Length   ${Locators}
    @{Elements}     create list
    FOR    ${i}    IN RANGE    0    ${CountOf_DD}
        ${ele}  format string  ${Locators}[${i}]   value=${inputdata}[${i}]
        Append To List  ${Elements}  ${ele}
    END
    RETURN  ${Elements}

List comparision with element should contain the values
      [Arguments]    ${UIList}    ${APIList}
      FOR  ${item}  IN  @{UIList}
        should contain    ${APIList}    ${item}
      END

List comparision with element should not contain the values
      [Arguments]    ${UIList}    ${APIList}
      FOR  ${item}  IN  @{UIList}
        should not contain    ${APIList}    ${item}
      END

Click using javascript with XPath
    [Documentation]  Click using javascript with XPath
    [Arguments]  ${element}
    ${locator}    Get WebElement    ${element}
    Execute Javascript    arguments[0].click();     ARGUMENTS    ${locator}

Click element using Javascript with element by ID
    [Documentation]  Click element using Javascript with element by ID
    [Arguments]  ${Element_By_ID}
    Execute JavaScript    document.getElementById("${Element_By_ID}").onclick()

Click Element DOM with ClassName
    [Documentation]  Click Element DOM with ClassName
    [Arguments]  ${element}
    click element until visible  dom=document.getElementsByClassName(“${element}”)[0]

Click Element DOM with text
    [Documentation]  Click Element DOM with ClassName
    [Arguments]  ${element}
    click element until visible  dom:document.data:"${element}”

Generate Random Email
    [Documentation]  Generate Random Email
    ${DOMAIN}  set variable  example.com
    ${random_string}=    Generate Random String    10
    ${email}=    Set Variable    ${random_string}@${DOMAIN}
    Log    ${email}
    RETURN  ${email}

Double click the web element
    [Documentation]    Double click the web element
    [Arguments]  ${locator}
    Set Library Search Order  SeleniumLibrary
    Wait Until Element Is Visible  ${locator}  timeout=${timeout}
    Double Click Element  ${locator}
    Sleep  1s

Page should contain the checkbox element
    [Documentation]  wait until Page should contains checkbox element
    [Arguments]    ${checkbox_loc}
    Set Library Search Order  SeleniumLibrary
#    Wait Until Element Is Visible    ${checkbox_loc}
    Sleep    3s
    Page Should Contain Checkbox    ${checkbox_loc}

Checkbox element should not selected
    [Documentation]  wait until Page should contains checkbox element and should not be selected
    [Arguments]    ${checkbox_loc}
    Set Library Search Order  SeleniumLibrary
#    Checkbox Should Not Be Selected    ${checkbox_loc}
    Assign id to element  ${checkbox_loc}  id=Checkbox_Not_selected
    ${check_status}=    Execute JavaScript    return document.getElementById(${checkbox_loc}).checked;
    log    check_status:${check_status}
    Should Not Be True    ${check_status}

Checkbox element should selected
    [Documentation]  wait until Page should contains checkbox element and should be selected
    [Arguments]    ${checkbox_loc}
    Set Library Search Order  SeleniumLibrary
#    Checkbox Should Be Selected    ${checkbox_loc}
    Assign id to element  ${checkbox_loc}  id=Checkbox_selected
    ${check_status}=    Execute Javascript    return document.getElementById(${checkbox_loc}).checked;
    log    check_status:${check_status}
    Should Be True    ${check_status}

Select the checkbox element
    [Documentation]    Select the checkbox element
    [Arguments]    ${checkbox_id}
    Set Library Search Order  SeleniumLibrary
#    Wait Until Element Is Visible    ${checkbox_loc}
#    Select Checkbox    ${checkbox_loc}
    Assign id to element  ${checkbox_loc}  id=Checkbox_selecting
    ${check_status}=    Execute Javascript    return document.getElementById(${checkbox_id}).checked;
    log    check_status:${check_status}
    Run Keyword IF    ${check_status}==False    Clicking the checkbox  ${checkbox_id}  ${check_status}
    ...    ELSE     Clicking the checkbox  ${checkbox_id}  ${check_status}
     
Unselect the checkbox element
    [Documentation]    Select the checkbox element
    [Arguments]    ${checkbox_id}
    Set Library Search Order  SeleniumLibrary
#    Wait Until Element Is Visible    ${checkbox_loc}
#    Unselect Checkbox    ${checkbox_loc}
    Assign id to element  ${checkbox_loc}  id=Checkbox_Unselecting
    ${check_status}=    Execute Javascript    return document.getElementById(${checkbox_id}).checked;
    log    check_status:${check_status}
    Run Keyword IF    ${check_status}==True    Clicking the checkbox  ${checkbox_id}  ${check_status}

Clicking the checkbox
    [Documentation]    Clicking the checkbox by using javascript
    [Arguments]    ${checkbox_loc}  ${Old_checkStatus}
    js click element    ${checkbox_loc}
    Assign id to element  ${checkbox_loc}  id=CheckboxSelect
    ${New_checkStatus}=    Execute Javascript    return document.getElementById(${checkbox_loc}).checked;
    log    check_status:${New_checkStatus}
    Should Not Be Equal  ${New_checkStatus}   ${Old_checkStatus}
    Capture the Screen  Checkbox_Checked

Get text and Ensure the elements texts are Equal
    [Documentation]  Get The Text From The Element and Match with Expected text(NOTE: Path should be Common for all elements)
    [Arguments]  ${locator}   @{list}
    ${Headers_count}=    Get Element Count    ${locator}
    ${Headers_txt}=    Get Webelements    ${locator}
    FOR   ${Header_count}    IN RANGE   0    ${Headers_count}
        ${Element_UI}=   Get From List    ${Headers_txt}   ${Header_count}
        ${Header_UI}=    Get Text    ${Element_UI}
        ${Expected}=  Get From List    ${list}   ${Header_count}
        Should Contain    ${Header_UI}   ${Expected}
        Log    ${Header_UI}
        Log   ${Expected}
    END
    
Remove Unwanted Characters from the price value
    [Documentation]    Remove Unwanted Characters from the given string
    [Arguments]    ${element}
    ${colon_clean} =    Replace String    ${element}    :    ${SPACE}    # Remove the colon
    ${QAR_clean} =    Replace String    ${colon_clean}    QAR    ${SPACE}    # Remove QAR
    ${ele_clean} =    Strip String    ${QAR_clean}    # Remove leading/trailing spaces
    Log    ${ele_clean}
    RETURN    ${ele_clean}

######### Not Used ###########
Click The First Record From Filter
    [Arguments]  ${search_input}
    Execute Javascript  $('td:contains(${search_input})').first().click()
#    Wait Until Element Is Visible  ${subscriber.back_btn}

Broken links test
    [Arguments]    ${BASE_URL}
    ${element_list}=     get webelements     xpath=//a[@href]
    ${href_list}=  Evaluate  [item.get_attribute('href') for item in $element_list]
    Log    ${href_list}
    Create Session    testing    ${BASE_URL}
    FOR    ${element_href}    IN    @{href_list}
        ${uri}=    Remove String    ${element_href}    ${BASE_URL}
        ${contains_base_url}=    Evaluate     "${BASE_URL}" in "${element_href}"
        ${response}=    Run Keyword If    ${contains_base_url}    Get Request    testing    ${uri}
        Run Keyword If    ${contains_base_url}    Should Be Equal As Strings     ${response.status_code}    200
    END


Check the all images are broken or not in the screen
   ${img_count}=  Get Element Count  tag:img

   # get available image tags src and store in list
   @{img_src}=  Create List
   FOR  ${img}  IN RANGE  1  ${img_count}+1
       ${index}=  Convert To Integer  ${img}
       ${src}=  Get Element Attribute  (//img)[${index}]  src
       Append To List  ${img_src}  ${src}
   END
   # validate image status
   FOR  ${img}  IN  @{img_src}
       Create Session  broken_image  ${img}
       ${response}=  Get Request  broken_image  /
       Log  ${response}
       # Add you validation here like
       Should Be Equal As Strings  ${response.status_code}  200
   END


API Response Validation
     [Arguments]     ${APIMethod}     ${Responsecode}
     ${response}=   call method    ${API_POSLaundry}   ${APIMethod}
     log to console    ${response}
     should contain     '''${response}'''     ${Responsecode}
     RETURN    ${response}

Get Element Bgcolor Hex
    [Documentation]  Get the background color of the element
    [Arguments]  ${element}    ${ExpectedColor}
    ${web_element}=  Get Webelement  ${element}
    ${color_rgba}=  Call Method  ${web_element}  value_of_css_property  background-color
    ${index}=  Evaluate  "${color_rgba}".find("(")
    ${color_tuple}=  Evaluate  eval("${color_rgba}"[${index}:])
    ${color_hex}=  Evaluate  '#{:02x}{:02x}{:02x}'.format(*${color_tuple})
    should be equal    '${color_hex}'    ${ExpectedColor}
    RETURN  ${color_hex}

Get Element Color Hex
    [Documentation]  Get the color of the element
    [Arguments]  ${element}
    ${web_element}=  Get Webelement  ${element}
    ${color_rgba}=  Call Method  ${web_element}  value_of_css_property  color
    ${index}=  Evaluate  "${color_rgba}".find("(")
    ${color_tuple}=  Evaluate  eval("${color_rgba}"[${index}:])
    ${color_hex}=  Evaluate  '#{:02x}{:02x}{:02x}'.format(*${color_tuple})
    RETURN  ${color_hex}

Get the Text from the Element
    [Documentation]  wait until Text should be displayed
    [Arguments]    ${TextID}
    Set Library Search Order  SeleniumLibrary
    Wait Until Element Is Visible  ${TextID}  timeout=${timeout}
    ${TEXTData}=    get text    ${TextID}
    RETURN    ${TEXTData}

Get Table Data without API Call
    [Documentation]  Get the Table Data
    [Arguments]    ${Rowxpath}    ${columnxpath}
     @{Tablelist}=    Create List
     ${columns}=    get element count  ${Rowxpath}
       FOR    ${row}  IN RANGE  1  ${columns}
         ${data_table}=    Handle Table Data without API    ${row}     ${columnxpath}
         append to list    ${Tablelist}     ${data_table}
        END
     RETURN    ${data_table}

Handle Table Data without API
       [Arguments]    ${test_row}    ${columnxpath}
       @{Tablelist}=    Create List
       ${columns}=    get element count  ${columnxpath}
       FOR   ${column}    IN RANGE   1    ${columns}
         ${data_table}    get text   xpath=//tbody/tr[${test_row}]/td[${column}]
#         append to list    ${Tablelist}     ${data_table}
       log to console    ${data_table}
       END
       RETURN    ${Tablelist}

Get Table Data without API Call data with last cloumn
    [Documentation]  Get the Table Data
    [Arguments]    ${Rowxpath}    ${columnxpath}
     @{Tablelist}=    Create List
     ${columns}=    get element count  ${Rowxpath}
       FOR    ${row}  IN RANGE  1  ${columns}
         ${data_table}=    Handle Table Data without API data with last cloum   ${row}     ${columnxpath}
         append to list    ${Tablelist}     ${data_table}
        END
     RETURN    ${Tablelist}

Handle Table Data without API data with last cloum
       [Arguments]    ${test_row}    ${columnxpath}
       @{Tablelist}=    Create List
       ${columns}=    get element count  ${columnxpath}
       FOR   ${column}    IN RANGE   1    ${columns}+1
         ${data_table}    get text   xpath=//tbody/tr[${test_row}]/td[${column}]
         append to list    ${Tablelist}     ${data_table}
         ${row_data1}=    Evaluate   ${test_row}-${1}
         ${column_data1}=   Evaluate    ${column}-${1}
       log to console    ${data_table}
       END
       RETURN    ${Tablelist}


Get the Full Table data
    [Documentation]  Get the Table Data
    [Arguments]    ${Rowxpath}    ${columnxpath}    ${CMCconnectionObj}    ${methodname}
     @{Tablelist}=    Create List
     ${response}=   call method       ${CMCconnectionObj}    ${methodname}
     ${columns}=    get element count  ${Rowxpath}
       FOR    ${row}  IN RANGE  1  ${columns}+1
         ${data_table}=    Handle Table Data    ${row}     ${columnxpath}    ${response}
         append to list    ${Tablelist}     ${data_table}
        END
     RETURN    ${data_table}

Handle Table Data
       [Arguments]    ${test_row}    ${columnxpath}    ${response_Table_Data}
       @{Tablelist}=    Create List
       ${columns}=    get element count  ${columnxpath}
       FOR   ${column}    IN RANGE   1    ${columns}
         ${data_table}    get text   xpath=//tbody/tr[${test_row}]/td[${column}]
         append to list    ${Tablelist}     ${data_table}
         ${row_data1}=    Evaluate   ${test_row}-${1}
         ${column_data1}=   Evaluate    ${column}-${1}
#         ${ConvertAPI}=    convert to string    ${response_Table_Data}[1][${row_data1}] [${column_data1}]
#         should contain   ${ConvertAPI}  ${data_table}
       log to console    ${data_table}
       END
       RETURN    ${Tablelist}

Get Table Data without last column
    [Documentation]  Get the Table Data Content and last column has action buttons/graphs
    [Arguments]    ${Rowxpath}    ${columnxpath}   ${methodname}
     @{Tablelist}=    Create List
#     ${response}=   call method       ${API_POSLaundry}    ${methodname}
     ${columns}=    get element count  ${Rowxpath}
     FOR    ${row}  IN RANGE  1  ${columns}+1
         ${data_table}=    Handle Table Data    ${row}     ${columnxpath}    ${methodname}
         append to list    ${Tablelist}     ${data_table}
     END
     RETURN    ${Tablelist}

Get the Data from Bar Graph Widgets
        [Arguments]    ${DataXpath}    ${TipXpath}    ${methodname}
        ${Tooltip_defauld}=  Set Variable    0
        ${response}=   call method    ${API_POSLaundry}    ${methodname}
        @{Tooltip_List}=    Create List
        @{Get_tooltip}=   Get WebElements  ${DataXpath}
        ${sum}=   Set Variable    ${0}
        FOR  ${tooltiplocation}  IN   @{Get_tooltip}
        ${height_value}=   Get Element Attribute  ${tooltiplocation}    height
        ${height_value1}=    CONVERT TO INTEGER  ${height_value}
        Run Keyword If    ${height_value1} == 0      append to list    ${Tooltip_List}    ${Tooltip_defauld}
        ...    ELSE    ${Tooltip_defauld} =    Get the ToolTip Value of Bar Graph Widgets   ${tooltiplocation}    ${TipXpath}    ${response}    ${sum}
        ${sum} =    Evaluate  ${sum}+${1}
#        append to list    ${Tooltip_List}       ${Tooltip_defauld}
        END
        RETURN    ${Tooltip_List}

Get the ToolTip Value of Bar Graph Widgets
      [Arguments]    ${tooltiplocation}    ${ToolTipXpath}    ${response}    ${sum}
       ${ConvertAPI}=    convert to string   ${response}[1][${sum}]
       mouse over    ${tooltiplocation}
        ${TooltipText}=   get text    ${ToolTipXpath}
        should contain    ${TooltipText}    ${ConvertAPI}
       log to console   ${TooltipText}
       RETURN    ${TooltipText}

List comparision with Api List
      [Arguments]    ${UIList}    ${APIList}
      FOR  ${item}  IN  @{UIList}
        should contain    ${APIList}    ${item}
      END

Get the Data from circle widgets
        [Arguments]    ${ElementXpath}    ${ToolTipXpath}
        @{Tooltip_List}=    Create List
        @{Get_tooltip}=   Get WebElements  ${ElementXpath}
        ${sum}=   Set Variable    ${0}
        FOR  ${tooltiplocation}  IN   @{Get_tooltip}
         mouse over    ${tooltiplocation}
         ${TooltipText}=   get text    ${ToolTipXpath}
         append to list     ${Tooltip_List}     ${TooltipText}
        END
        RETURN     ${Tooltip_List}

Handle Alert Popup
         [Arguments]    ${AlertText}     ${YesButton}
         Wait Until Page Contains Element       ${YesButton}
         ${Alertmsg}=   get text    ${AlertText}
         click element    ${YesButton}

verify text inside Iframe
       [Documentation]  Check the Iframe Content
       [Arguments]    ${TextValue}
       current frame should contain    ${TextValue}

verify the content in Iframe from MainFrame
       [Documentation]  Check the content in Iframe from MainFrame
       [Arguments]    ${IframeId}    ${TextValue}
       frame should contain    ${IframeId}      ${TextValue}

Select the Iframe
       [Documentation]  Select the Iframe
       [Arguments]    ${Iframe_id}
       Select the Iframe    ${Iframe_id}

Switch to Main Frame
       [Documentation]  Back to Main Frame
       unselect frame

Element count should at least one
    [Documentation]  Element has at least one
    [Arguments]  ${locator}
    # wait for element loading
    Sleep  2
    ${locator_count}=  Get element count  ${locator}
    Should be true   ${locator_count} > 0
Move to last screen
    ${present}=    Run Keyword And Return Status    Element Should Be Visible     //*[text()='Last' and not(contains(@class, 'disabled'))]
    Run Keyword If    ${present}    click element    (//*[text()='Last'])[1]
                  ...  ELSE     log to console      First and Last buttons are disabled

Get table row index by text
    [Arguments]  ${table_css_locator}  ${text}
    # wait for table loading
    Sleep  2
    ${row_index}=  Execute Javascript
    ...  return ${table_css_locator}.find("td:contains(${text})").parent("tr").index()
    RETURN  ${row_index}

Check y_axis score num
    [Arguments]  ${y_axis_score}
    ${y_axis_score_num}=  Get Element Count  ${y_axis_score}
    log  y_axis_score_num:${y_axis_score_num}
    Should Be True  ${y_axis_score_num} > 1
    FOR  ${i}  IN RANGE  ${y_axis_score_num}
      ${scale_value}=  Get Text  (${y_axis_score})\[${i}+1\]
      log  ==scale_value:${scale_value}
      Should Not Contain  ${scale_value}  null
    END

Get Checkbox
    [Arguments]  ${locator}
    ${value}=  Run Keyword And Return Status  Checkbox Should Be Selected  ${locator}
    RETURN    ${value}

Set Checkbox
    [Arguments]  ${locator}  ${visible_locator}  ${value}
    ${original_value}=  Get Checkbox  ${locator}
    Run Keyword Unless  '${original_value}' == '${value}'  Click Element  ${visible_locator}
    log  original:${original_value}, set to:${value}

Modify Input Text
    [Arguments]  ${locator}  ${value}
    ${original_value}=  Get Text By Id  ${locator}
    log  original:${original_value}, set to:${value}
    Run Keyword Unless  '${original_value}' == '${value}'  Input Text  ${locator}  ${value}

Get Text By Id
    [Arguments]  ${element_id}
    ${value}=  Execute Javascript  return $("#${element_id}").val()
    RETURN  ${value}

Input Text By Id Should Be
    [Arguments]  ${id}  ${expected_text}
    ${actual_text}=  Get Text By Id  ${id}
    Should Be Equal  ${actual_text}  ${expected_text}

Should Be Equal As Boolean
    [Arguments]  ${var1}  ${var2}
    ${var1_bool_type}=  Evaluate  type(${var1}) is bool
    ${bool_var1}=  Run Keyword Unless  ${var1_bool_type}  Convert To Boolean  ${var1}
    ...  ELSE  Set Variable  ${var1}
    ${var2_bool_type}=  Evaluate  type(${var2}) is bool
    ${bool_var2}=  Run Keyword Unless  ${var2_bool_type}  Convert To Boolean  ${var2}
    ...  ELSE  Set Variable  ${var2}
    Should Be Equal  ${bool_var1}  ${bool_var2}

Should Be Integer
    [Arguments]  ${var}
    ${stripped}=  Strip String  ${var}
    ${is_int}=  Evaluate  isinstance(${stripped}, int)
    Should Be True  ${is_int}

Get Percentage Vaule
    [Arguments]  ${var}
    ${stripped}=  Strip String  ${var}
    ${percentage_value}=  Fetch From Left  ${stripped}  %
    RETURN  ${percentage_value}


Table Row Should Contain Element
    [Arguments]  ${table_css_locator}  ${row}  ${element_css}
    ${element_locator}=  Set Variable  dom:${table_css_locator}.find('tr').eq(${row}).find('${element_css}')
    Wait Until Element Is Visible  ${element_locator}
    RETURN  ${element_locator}

Get Column Index By Table Header
    [Arguments]  ${table_css_locator}  ${th}
    ${column_index}=  Execute Javascript  return ${table_css_locator}.find("th:contains(${th})").index()
    RETURN  ${column_index}

Get Table Cell By Jquery
    [Arguments]  ${table_css_locator}  ${row}  ${column}
    ${value}=  Execute Javascript  return ${table_css_locator}.find("tr:not(:has(th))").eq(${row}).find("td").eq(${column}).text()
    RETURN  ${value}

Get Uniq NumString
    ${time}    Get Current Date    result_format=timestamp
    ${time_stamp}    Convert Date    ${time}    epoch
    ${time_stamp2}    evaluate    int(round(${time_stamp} * 1000))
    ${value}    Set Variable    ${time_stamp2}
    RETURN  ${value}

Table Data Validation with drill down data
    [Documentation]  Get the Table Data
    [Arguments]    ${Rowxpath}    ${columnxpath}    ${methodname}    ${Table_ID}
        set selenium implicit wait    60 seconds
        set selenium timeout    60 seconds
        ${response}=   call method    ${API_POSLaundry}    ${methodname}
        sleep    5
        ${rows}=    get element count    ${Rowxpath}
        ${sum}=   Set Variable    ${0}
        FOR    ${row}  IN RANGE  1  ${rows}
        Handle Table drill down   ${row}    ${response}    ${columnxpath}    ${Table_ID}
        END

Handle Table drill down
#       [Arguments]    ${test_row}
       [Arguments]    ${test_row}    ${test_response_Retention_Table_Data}    ${columnxpath}    ${Table_ID}
       set selenium implicit wait    60 seconds
       set selenium timeout    60 seconds
       ${columns}=    get element count  ${columnxpath}
       FOR   ${column}    IN RANGE   1    ${columns}
       ${data_table}  get text   //*[@id='${Table_ID}']//tbody/tr[${test_row}]/td[${column}]
       log to console    ${data_table}
       ${row_data1}=    Evaluate   ${test_row}-${1}
       ${column_data1}=   Evaluate    ${column}-${1}
       log     ${test_response_Retention_Table_Data}[1][${row_data1}] [${column_data1}]
       ${ConvertAPI}=    convert to string    ${test_response_Retention_Table_Data}[1][${row_data1}] [${column_data1}]
       should contain   ${ConvertAPI}  ${data_table}
       END

Table Data Validation with drill down data limit
    [Documentation]  Get the Table Data
    [Arguments]    ${Rowxpath}    ${columnxpath}    ${methodname}    ${Table_ID}
    set selenium implicit wait    60 seconds
    set selenium timeout    60 seconds
    ${response}=   call method    ${API_POSLaundry}    ${methodname}
    sleep    5
    ${rows}=    get element count    ${Rowxpath}
    run keyword if  ${rows} >10     validateDatawhenGreater10       ${response}    ${columnxpath}    ${Table_ID}
    ...  ELSE    validateDatawhenless10       ${response}    ${columnxpath}    ${Table_ID}
#        ${sum}=   Set Variable    ${0}
#        FOR    ${row}  IN RANGE  1  ${rows}
#        Handle Table drill down limit   ${row}    ${response}    ${columnxpath}    ${Table_ID}
#        END

validateDatawhenGreater10
        [Arguments]      ${response}    ${columnxpath}    ${Table_ID}

        ${sum}=   Set Variable    ${0}
        FOR    ${row}  IN RANGE  1  10
        Handle Table drill down limit   ${row}    ${response}    ${columnxpath}    ${Table_ID}
        END

validateDatawhenless10
        [Arguments]      ${response}    ${columnxpath}    ${Table_ID}
        ${sum}=   Set Variable    ${0}
        FOR    ${row}  IN RANGE  1  ${rows}
        Handle Table drill down limit   ${row}    ${response}    ${columnxpath}    ${Table_ID}
        END


Handle Table drill down limit
#       [Arguments]    ${test_row}
       [Arguments]    ${test_row}    ${test_response_Retention_Table_Data}    ${columnxpath}    ${Table_ID}

       set selenium implicit wait    60 seconds
       set selenium timeout    60 seconds
       ${columns}=    get element count  ${columnxpath}
       FOR   ${column}    IN RANGE   1    ${columns}
       ${data_table}  get text   //*[@id='${Table_ID}']//tbody/tr[${test_row}]/td[${column}]
       log to console    ${data_table}
       ${row_data1}=    Evaluate   ${test_row}-${1}
       ${column_data1}=   Evaluate    ${column}-${1}
       log     ${test_response_Retention_Table_Data}[1][${row_data1}] [${column_data1}]
       ${ConvertAPI}=    convert to string    ${test_response_Retention_Table_Data}[1][${row_data1}] [${column_data1}]
       should contain   ${ConvertAPI}  ${data_table}
       END

Get Table Data from row using table id
    [Documentation]  Get the Table Data
    [Arguments]    ${Rowxpath}  ${tableId}
     @{Tablelist}=    Create List
     ${rows}=    get element count  ${Rowxpath}
     FOR    ${row}  IN RANGE  1  ${rows}
     ${data_table}    get text   xpath=${tableId}//tbody/tr[${row}]
     append to list    ${Tablelist}     ${data_table}
     log to console    ${data_table}
     END

reference to Set timepicker
  [Arguments]  ${hourUPBtn}  ${timeDAtaXpath}  ${hourDigits}
  FOR  ${count}  IN RANGE  1  12
  click element until enabled  ${hourUPBtn}
  ${text}=  get text  ${timeDAtaXpath}
  Exit For Loop IF  "${text}" == "${hourDigits}"
  END


Get tooltip data from the chart
        [Arguments]   ${chartName}   ${ElementXpath}    ${ToolTipXpath}
        @{Tooltip_List}=    Create List
        @{Bars}=   Get WebElements  ${ElementXpath}
        FOR  ${bar}  IN   @{Bars}
        mouse over    ${bar}
        ${TooltipText}=   get text    ${ToolTipXpath}
        append to list     ${Tooltip_List}     ${TooltipText}
        END
        RETURN     ${Tooltip_List}

Select value from filter
    [Arguments]  ${filter}  ${value}
    click element until visible  ${filter}
    click element until visible  //*[contains(@class,'scroll-host')]//*[contains(text(),'${value}')]
    element should contain  ${filter}  ${value}
    
Return Null If Empty
    [Arguments]    ${list_to_check}
    ${is_empty}=    Evaluate    len(${list_to_check}) == 0
    Run Keyword If    ${is_empty}    Return From Keyword    Null
    RETURN   ${list_to_check}

Test Empty List
    [Arguments]    ${empty_list}
#    ${empty_list}=    Create List
    ${result}=    Return Null If Empty    ${empty_list}
    Log    Result: ${result}
    RETURN    ${result}

Test Non-Empty List
    [Arguments]    ${non_empty_list}
#    ${non_empty_list}=    Create List    04412523    04415323
    ${result}=    Return Null If Empty    ${non_empty_list}
    Log    Result: ${result}