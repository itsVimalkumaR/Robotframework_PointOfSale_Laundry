*** Settings ***
Library     SeleniumLibrary
Library     RequestsLibrary
Library     Collections
Resource    ../Optimized_PO/CommonWrapper.robot
Resource    ../TestScripts/Base.robot

*** Keywords ***
Navigate to orders page
    [Documentation]  Navigate to orders page
    ${Hamburger_menu}  Run Keyword And Return Status    Wait Until Element Is Visible    ${locators_params['Home']['Hamburger_MenuIcons']}[Hamburger_menu]
    Run Keyword If    ${Hamburger_menu} == True    Run Keywords    Navigate to orders page from Hamburger menu list
    ...    ELSE   Navigate to orders page menu list
    
Navigate to orders page from Hamburger menu list
    [Documentation]    Navigate to orders page from Hamburger menu list
    Click Element Until Visible    ${locators_params['Home']['Hamburger_MenuIcons']}[Hamburger_menu]
    Wait Until Element Is Visible    ${locators_params['Home']['Hamburger_MenuIcons']}[Orders_Icon]
    Click Element Until Visible    ${locators_params['Home']['Hamburger_MenuIcons']}[Orders_Icon]
    Verify The Title Of Orders Page

Navigate to orders page menu list
    [Documentation]    Navigate to orders page menu list
    Wait Until Element Is Visible    ${locators_params['Home']}[Orders_Icon]
    Click Element Until Visible  ${locators_params['Home']}[Orders_Icon]
    Wait Until Element Is Visible  ${locators_params['Orders']}[Table]
    Verify The Title Of Orders Page

verify the order page elements are visible
    [Documentation]  verify the order page elements are visible
    @{Orders_elements}  create list  ${locators_params['Orders']}[HeaderTxt]  ${locators_params['Orders']}[Table]
    ...     ${locators_params['Orders']}[ImportBtn]    ${locators_params['Orders']['ChooseAnOption']}[LblTxt]    ${locators_params['Orders']['ChooseAnOption']}[Dropdown]
    ...     ${locators_params['Orders']['ChooseExportFile']}[LblTxt]    ${locators_params['Orders']['ChooseExportFile']}[Dropdown_Btn]
    ...     ${locators_params['Orders']}[Search_TxtBox_LblTxt]    ${locators_params['Orders']}[Search_textBox]
    ...     ${locators_params['Orders']}[SNo_ColumnHeaderTxt]  ${locators_params['Orders']}[Name_ColumnHeaderTxt]
    ...     ${locators_params['Orders']}[PhoneNo_ColumnHeaderTxt]    ${locators_params['Orders']}[OrderID_ColumnHeaderTxt]
    ...     ${locators_params['Orders']}[OrderStatus_ColumnHeaderTxt]  ${locators_params['Orders']}[Actions_ColumnHeaderTxt]
    ...     ${locators_params['Orders']}[RowsPerPage_lblTxt]  ${locators_params['Orders']}[RowsPerPage_DDArrow]
    ...     ${locators_params['Orders']}[ShowEntries]  ${locators_params['Orders']}[Pagination_PreviousBtn]
    ...     ${locators_params['Orders']}[Pagination_NextBtn]
    wait until elements are visible  @{Orders_elements}
    Capture The Screen    OrdersPage
    ${NoData_status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${locators_params['Orders']}[NoDataAvailable_text]
    Run Keyword If    ${NoData_status}    Validate the no data available text
    
Validate the no data available text
    [Documentation]    Validate the no data available text
    Wait Until Element Is Visible    ${locators_params['Orders']}[NoDataAvailable_text]
    ${label_text}    Get Text    ${locators_params['Orders']}[NoDataAvailable_text]
    Should Be Equal    ${label_text}    ${testData_config['Nodata']}[NoData_AvailableMsg]

validate the orders page elements texts
    [Documentation]    validate the orders page elements texts
    Validate the orders page table column texts
    @{elements}  create list  ${locators_params['Orders']}[ImportBtn]  ${locators_params['Orders']['ChooseAnOption']}[LblTxt]  ${locators_params['Orders']['ChooseExportFile']}[LblTxt]
    @{Label_texts}  create list  ${testData_config['Orders']}[ImportBtn]  ${testData_config['Orders']['ChooseAnOption']}[LblTxt]  ${testData_config['Orders']['ChooseExportFile']}[LblTxt]
    Check all the get elements text are should be equal   ${elements}  ${Label_texts}
    capture the screen  OrdersTable

Validate the orders page table column texts
    [Documentation]    Validate the orders page table column texts
    @{OrdersColumn_lblTexts}  create list  ${testData_config['Orders']}[SNo_ColumnHeaderTxt]  ${testData_config['Orders']}[Name_ColumnHeaderTxt]
    ...     ${testData_config['Orders']}[PhoneNo_ColumnHeaderTxt]  ${testData_config['Orders']}[OrderID_ColumnHeaderTxt]
#    ...     ${testData_config['Orders']}[DeliveryDate_ColumnHeaderTxt]      # regarding no need the delivery date
    ...     ${testData_config['Orders']}[OrderStatus_ColumnHeaderTxt]    ${testData_config['Orders']}[Actions_ColumnHeaderTxt]
    Get text and Ensure the Headers are Equal  ${locators_params['Orders']}[Multiple_ColumnHeaders]  @{OrdersColumn_lblTexts}

verify the choose an option filter field
    [Documentation]    verify the choose an option filter field
    Wait Until Element Is Visible    ${locators_params['Orders']['ChooseAnOption']}[LblTxt]
    ${Ui_ChooseAnOption_labeltext}    Get Text    ${locators_params['Orders']['ChooseAnOption']}[LblTxt]
    Should Be Equal    ${Ui_ChooseAnOption_labeltext}    ${testData_config['Orders']['ChooseAnOption']}[LblTxt]
    Wait Until Element Is Visible    ${locators_params['Orders']['ChooseAnOption']}[Dropdown]
    Click Element Until Visible    ${locators_params['Orders']['ChooseAnOption']}[Dropdown]
    @{ChooseAnOptionDD_Opts}    Create List    ${locators_params['Orders']['ChooseAnOption']}[Today_Opt]
    ...    ${locators_params['Orders']['ChooseAnOption']}[Yesterday_Opt]    ${locators_params['Orders']['ChooseAnOption']}[LastWeek_Opt]
    ...    ${locators_params['Orders']['ChooseAnOption']}[LastMonth_Opt]    ${locators_params['Orders']['ChooseAnOption']}[Last_180days_Opt]
    ...    ${locators_params['Orders']['ChooseAnOption']}[CustomizeDate_Opt]
    Wait Until Elements Are Visible    @{ChooseAnOptionDD_Opts}
    @{ChooseAnOptionDD_OptsText}    Create List    ${testData_config['Orders']['ChooseAnOption']}[Today_Opt]
    ...    ${testData_config['Orders']['ChooseAnOption']}[Yesterday_Opt]    ${testData_config['Orders']['ChooseAnOption']}[LastWeek_Opt]
    ...    ${testData_config['Orders']['ChooseAnOption']}[LastMonth_Opt]    ${testData_config['Orders']['ChooseAnOption']}[Last_180days_Opt]
    ...    ${testData_config['Orders']['ChooseAnOption']}[CustomizeDate_Opt]
    Check All The Get Elements Text Are Should Be Equal    ${ChooseAnOptionDD_Opts}    ${ChooseAnOptionDD_OptsText}
    Capture The Screen    Choose_An_Options
    Click Element Until Visible    ${locators_params['Orders']['ChooseAnOption']}[Dropdown]

validate all the view order buttons are visible
    [Documentation]  validate all the view order buttons are visible
    @{Options}  get webelements  ${locators_params['Settings']}[RowsPerPage_DDOptions]
    ${Options_Count}  get element count  ${locators_params['Settings']}[RowsPerPage_DDOptions]
    FOR  ${i}  IN RANGE  1  ${Options_Count}
        Wait Until Element Visible   ${locators_params['Settings']}[RowsPerPage_DDArrow]
        sleep  3s
        ${Selected_Option}  format string   ${locators_params['Settings']}[RowsPerPage_DDOption]   value=All
        Click Element Until Visible   ${locators_params['Settings']}[RowsPerPage_DDArrow]
        Click Element Until Visible  ${Selected_Option}
        capture the screen  AllData
        ${All_OptionTxt}  get text  ${locators_params['Settings']}[AllOption_RowsPerPage_DDValue]
        exit for loop if  '${All_OptionTxt}' == 'All'
    END
    ${ViewOrderBtns_Count}  Get Element Count  ${locators_params['Orders']}[Actions_ColumnBtns]
    ${UI_CountTxt}  get text  ${locators_params['Settings']}[ShowEntries]
    ${last_char}    Get Substring    ${UI_CountTxt}    -2
    ${count}  convert to integer  ${last_char}
    should be equal  ${count}  ${ViewOrderBtns_Count}

filter the orders table data
    [Documentation]    filter the orders table data
    Wait Until Element Is Visible    ${locators_params['Orders']['ChooseAnOption']}[Dropdown]
    Click Element Until Visible    ${locators_params['Orders']['ChooseAnOption']}[Dropdown]
    Wait Until Element Is Visible    ${locators_params['Orders']['ChooseAnOption']}[Last_180days_Opt]
    Click Element Until Visible    ${locators_params['Orders']['ChooseAnOption']}[Last_180days_Opt]
    sleep    5s
    Capture The Screen    Last_180days_Opt_Selected

verify the order details page elements are visible
    [Documentation]  verify the order details page elements are visible
    ${response}  call method  ${API_POSLaundry}   getAPI_Order
    log  ${response}
    ${Phone_Numbers}    set variable  ${response}[2]
    ${Orders_ID}    set variable  ${response}[3]
    ${CustomerName}    set variable  ${response}[12]
    ${count}    Get Length    ${Orders_ID}
    Run Keyword If    ${response}[6] == True    Run Keywords    Validate the order details page  ${count}  ${Orders_ID}    ${CustomerName}
    ...    AND   validate the order status dropdown
    ...    ELSE   Page Should Contain    No data available

Validate the order details page
    [Documentation]    Validate the order details page
    [Arguments]    ${count}    ${Orders_ID}    ${CustomerName}
    FOR    ${i}   IN RANGE    0   ${count}
        ${index} =    Evaluate  ${i}+3
        Run Keyword If    "${Orders_ID}[${i}]" == "N/A"  Run Keywords    Navigate to order details page  ${Orders_ID}[${index}]
        ...    AND   Exit For Loop
        ...    ELSE    Run Keywords    Navigate to order details page  ${Orders_ID}[${i}]
        ...    AND   Exit For Loop
    END
    ${ViewOrder_Btn}  format string  ${locators_params['Orders']}[ViewOrderBtn]   value=${Orders_ID}[0]
    ${status}    Run Keyword And Return Status    wait until element is visible  ${ViewOrder_Btn}
    Run Keyword If    ${status} == True  Run Keywords    filter the orders table data
    ...    AND  Show all the data from the table   All
    ...    AND  click element until visible  ${ViewOrder_Btn}
    wait until element is visible  ${locators_params['Orders']['ViewOrders']}[HeaderTxt]
    capture the screen  View_Orders_Details
    Validate all elements are visible in order details page
    Validate all elements texts in order details page

Validate the order status dropdown options
    [Documentation]    Validate the order status dropdown options
    [Arguments]    ${options}    ${count}
    FOR  ${i}  IN RANGE    0  ${count}
        Click Element Until Visible      ${locators_params['Orders']['ViewOrders']}[OrderStatus_DropDownBtn]
        ${text}    Get Text    ${options}[${i}]
        Run Keyword If   "${text}" == "${testData_config['Orders']['ViewOrders']['OrderStatus_Dropdown_Options']}['Confirm_LblTxt']"   Log   Confirm status
        Run Keyword If   "${text}" == "${testData_config['Orders']['ViewOrders']['OrderStatus_Dropdown_Options']}['InProcess_LblTxt']"   Log   In process status
        Run Keyword If   "${text}" == "${testData_config['Orders']['ViewOrders']['OrderStatus_Dropdown_Options']}[WaitingForDelivery_LblTxt]"   Log   Waiting for delivery status
        Run Keyword If   Evaluate  "${text} != ${testData_config['Orders']['ViewOrders']['OrderStatus_Dropdown_Options']}['Confirm_LblTxt'] and ${text} != ${testData_config['Orders']['ViewOrders']['OrderStatus_Dropdown_Options']}['InProcess_LblTxt'] and ${text} != ${testData_config['Orders']['ViewOrders']['OrderStatus_Dropdown_Options']}[WaitingForDelivery_LblTxt]"  Log   Your Order status is not present
        Sleep    2s
        Click Element Until Visible      ${locators_params['Orders']['ViewOrders']}[OrderStatus_DropDownBtn]
    END
    
validate the order status dropdown
    [Documentation]    validate the order status dropdown
#    Validate the order status dropdown options
    Wait Until Element Is Visible    ${locators_params['Orders']['ViewOrders']}[OrderStatus_DropDownBtn]
    ${options}  Get Webelements    ${locators_params['Orders']['ViewOrders']}[OrderStatus_DropDownOpts]
#    ${opts}  Get Element Count    ${options}
    ${opts_count}  Get Length    ${options}
#    Validate the order status dropdown options    ${options}    ${opts_count}
    FOR  ${i}  IN RANGE    0  ${opts_count}
        Click Element Until Visible      ${locators_params['Orders']['ViewOrders']}[OrderStatus_DropDownBtn]
        ${text}    Get Text    ${options}[${i}]
        Run Keyword If   "${text}" == "${testData_config['Orders']['ViewOrders']['OrderStatus_Dropdown_Options']['Confirm_LblTxt']}"   Log   Confirm status
        Run Keyword If   "${text}" == "${testData_config['Orders']['ViewOrders']['OrderStatus_Dropdown_Options']['InProcess_LblTxt']}"   Log   In process status
        Run Keyword If   "${text}" == "${testData_config['Orders']['ViewOrders']['OrderStatus_Dropdown_Options']['WaitingForDelivery_LblTxt']}"   Log   Waiting for delivery status
        Log   YOUR ORDER STATUS IS : ${text}
        Sleep    2s
        Click Element Until Visible      ${locators_params['Orders']['ViewOrders']}[OrderStatus_DropDownBtn]
    END
    Capture The Screen    OrderStatus_DD
    
Validate all elements are visible in confirm order details page
    [Documentation]    Validate all elements are visible in confirm order details page
    [Arguments]    ${Confirm_OrderIDs}    ${Confirm_PaymentModes}
    ${count}    Get Length    ${Confirm_OrderIDs}
    FOR    ${i}   IN RANGE    0   ${count}
        ${index} =    Evaluate  ${i}+1
        Run Keyword If    "${Confirm_OrderIDs}[${i}]" == "N/A"  Run Keywords    Navigate to order details page  ${Confirm_OrderIDs}[${index}]
        ...    AND   Exit For Loop
        ...    ELSE    Run Keywords    Navigate to order details page  ${Confirm_OrderIDs}[${i}]
        ...    AND   Exit For Loop
    END
    Validate all elements are visible in order details page
    Validate all elements texts in order details page

Navigate to order details page
    [Documentation]    Navigate to order details page
    [Arguments]    ${OrderID}
    ${ViewOrder_Btn}  format string  ${locators_params['Orders']}[ViewOrderBtn]   value=${OrderID}
    ${status}    Run Keyword And Return Status    wait until element is visible  ${ViewOrder_Btn}
    Capture The Screen    ViewOrder_Button_Status
    Run Keyword If    ${status} == False  filter the orders table data
    Sleep    2s
    ${options}  Get Webelements    ${locators_params['Orders']['ViewOrders']}[OrderStatus_DropDownOpts]
    ${opts_count}  Get Length    ${options}
    Validate the order status dropdown options    ${options}    ${opts_count}
#    Show all the data from the table   All
#    Wait Until Element Is Visible    ${ViewOrder_Btn}
    Click And Input The Value    ${locators_params['Orders']}[Search_textBox]    ${OrderID}
    Wait Until Element Is Visible    ${ViewOrder_Btn}
    Capture The Screen    OrderSearch_is_Working
    click element until visible  ${ViewOrder_Btn}
    wait until element is visible  ${locators_params['Orders']['ViewOrders']}[HeaderTxt]
    capture the screen  View_Orders_Details

Validate all elements are visible in order details page
    [Documentation]    Validate all elements are visible in order details page
    @{OrderDetails_Elements}  Create List    ${locators_params['Orders']['ViewOrders']}[tableHeaders_Txt]  ${locators_params['Orders']['ViewOrders']}[PriceDetails_LblTxts]  
    ...    ${locators_params['Orders']['ViewOrders']}[OrderID_LblTxt]    ${locators_params['Orders']['ViewOrders']}[Name_LblTxt]    ${locators_params['Orders']['ViewOrders']}[OrderStatus_LblTxt]
    ...    ${locators_params['Orders']['ViewOrders']}[PrintReceipt_Btn]   ${locators_params['Orders']['ViewOrders']}[Cancel_Btn]
    Wait Until Elements Are Visible    @{OrderDetails_Elements}

Validate all elements texts in order details page
    [Documentation]    Validate all elements texts in order details page
    @{TableHeader_Texts}    Create List    ${testData_config['Orders']['ViewOrders']['Table']}[SNo_ColumnHeaderTxt]  ${testData_config['Orders']['ViewOrders']['Table']}[ProductName_ColumnHeaderTxt]
    ...    ${testData_config['Orders']['ViewOrders']['Table']}[Amount_ColumnHeaderTxt]  ${testData_config['Orders']['ViewOrders']['Table']}[TotalQuantity_ColumnHeaderTxt]
    ...    ${testData_config['Orders']['ViewOrders']['Table']}[Total_ColumnHeaderTxt]
    Get text and Ensure the Headers are Equal  ${locators_params['Orders']['ViewOrders']}[tableHeaders_Txt]   @{TableHeader_Texts}
    @{Label_texts}    Create List    ${testData_config['Orders']['ViewOrders']['OrderDetails_Section']}[SubTotal_LblTxt]  ${testData_config['Orders']['ViewOrders']['OrderDetails_Section']}[Discount_LblTxt]
    ...    ${testData_config['Orders']['ViewOrders']['OrderDetails_Section']}[ReceivedAmount_LblTxt]  ${testData_config['Orders']['ViewOrders']['OrderDetails_Section']}[RemainingBalance_LblTxt]
    ...    ${testData_config['Orders']['ViewOrders']['OrderDetails_Section']}[OutstandingBalance_LblTxt]    ${testData_config['Orders']['ViewOrders']['OrderDetails_Section']}[PaymentMode_LblTxt]
    ...    ${testData_config['Orders']['ViewOrders']['OrderDetails_Section']}[OrderDate_LblTxt]    ${testData_config['Orders']['ViewOrders']['OrderDetails_Section']}[OrderTime_LblTxt]
    Get text and Ensure the elements texts are Equal  ${locators_params['Orders']['ViewOrders']}[PriceDetails_LblTxts]    @{Label_texts}
    @{OrderDetailsSection_Elements}  Create List    ${locators_params['Orders']['ViewOrders']}[OrderID_LblTxt]
    ...    ${locators_params['Orders']['ViewOrders']}[Name_LblTxt]    ${locators_params['Orders']['ViewOrders']}[OrderStatus_LblTxt]  ${locators_params['Orders']['ViewOrders']}[PaymentMethods_LblTxt]
    ...    ${locators_params['Orders']['ViewOrders']}[PrintReceipt_Btn]    ${locators_params['Orders']['ViewOrders']}[Cancel_Btn]
    @{OrderDetailsSection_LabelTexts}  Create List    ${testData_config['Orders']['ViewOrders']['OrderDetails_Section']}[OrderID_LblTxt]
    ...    ${testData_config['Orders']['ViewOrders']['OrderDetails_Section']}[Name_LblTxt]    ${testData_config['Orders']['ViewOrders']['OrderDetails_Section']}[OrderStatus_LblTxt]  ${testData_config['Orders']['ViewOrders']['OrderDetails_Section']}[PaymentMethods_LblTxt]
    ...    ${testData_config['Orders']['ViewOrders']['OrderDetails_Section']}[PrintReceipt_Btn]    ${testData_config['Orders']['ViewOrders']['OrderDetails_Section']}[Cancel_Btn]
    Check all the get elements text are should contain  ${OrderDetailsSection_Elements}  ${OrderDetailsSection_LabelTexts}

Validate all elements are visible in cancel order details page
    [Documentation]    Verify and validate the order details page for cancelled order
    [Arguments]    ${Cancel_OrderIDs}
    ${ViewOrder_Btn}  format string  ${locators_params['Orders']}[ViewOrderBtn]   value=${Cancel_OrderIDs}[0]
    ${status}    Run Keyword And Return Status    wait until element is visible  ${ViewOrder_Btn}
    Run Keyword If    ${status} == False  filter the orders table data
    Sleep    2s
    Show all the data from the table   All
    click element until visible  ${ViewOrder_Btn}
    wait until element is visible  ${locators_params['Orders']['ViewOrders']}[HeaderTxt]
    capture the screen  View_Orders_Details
    @{OrderDetails_Elements}  Create List    ${locators_params['Orders']['ViewOrders']}[tableHeaders_Txt]  ${locators_params['Orders']['ViewOrders']}[OrderID_LblTxt]
    ...    ${locators_params['Orders']['ViewOrders']}[Name_LblTxt]  ${locators_params['Orders']['ViewOrders']}[PriceDetails_LblTxts]
    ...    ${locators_params['Orders']['ViewOrders']}[PaymentMethod_Type]  ${locators_params['Orders']['ViewOrders']}[OrderStatus_LblTxt]
    ...    ${locators_params['Orders']['ViewOrders']}[OrderStatus_DropDownBtn]  ${locators_params['Orders']['ViewOrders']}[Cancel_Btn]
    ...    ${locators_params['Orders']['ViewOrders']}[PrintReceipt_Btn]
    Wait Until Elements Are Visible    @{OrderDetails_Elements}

#### Orders Status is 'Confirm' ####
verify the order details page elements are visible if the order status is Confirm
    [Documentation]    The order details page elements are visible if the order status is Confirm validation
    ${response}  call method  ${API_POSLaundry}   getAPI_Order
    log  ${response}
    ${Confirm_OrderIDs}    set variable  ${response}[7]
    ${Confirm_OrderID_CustomerName}    set variable  ${response}[12]
    ${count}    Get Length    ${Confirm_OrderIDs}
    Run Keyword If    ${Confirm_OrderIDs} != []    Run Keywords    Validate the order details page if order status is confirm or in-process  ${count}  ${Confirm_OrderIDs}    ${Confirm_OrderID_CustomerName}[0]
    ...    AND   validate the order status dropdown
    ...    ELSE   New order creating process
    Verify the title of Order details page
    Page Should Contain    ${testData_config['Orders']['ViewOrders']['OrderStatus_Dropdown_Options']}[Confirm_LblTxt]
    Validate all elements are visible in order details page
    Validate all elements texts in order details page if the order status is Confirm or in-process

Validate all elements texts in order details page if the order status is Confirm or in-process
    [Documentation]    Validate all elements texts in order details page if the order status is Confirm or in-process
    Verify the order details page table
    Verify the order details elements
    @{OrderDetailsSection_Elements}  Create List    ${locators_params['Orders']['ViewOrders']}[OrderID_LblTxt]
    ...    ${locators_params['Orders']['ViewOrders']}[Name_LblTxt]    ${locators_params['Orders']['ViewOrders']}[OrderStatus_LblTxt]
    ...    ${locators_params['Orders']['ViewOrders']}[PrintReceipt_Btn]    ${locators_params['Orders']['ViewOrders']}[Cancel_Btn]
    @{OrderDetailsSection_LabelTexts}  Create List    ${testData_config['Orders']['ViewOrders']['OrderDetails_Section']}[OrderID_LblTxt]
    ...    ${testData_config['Orders']['ViewOrders']['OrderDetails_Section']}[Name_LblTxt]    ${testData_config['Orders']['ViewOrders']['OrderDetails_Section']}[OrderStatus_LblTxt]
    ...    ${testData_config['Orders']['ViewOrders']['OrderDetails_Section']}[PrintReceipt_Btn]    ${testData_config['Orders']['ViewOrders']['OrderDetails_Section']}[Cancel_Btn]
    Check all the get elements text are should contain  ${OrderDetailsSection_Elements}  ${OrderDetailsSection_LabelTexts}

Verify the order details page table
    [Documentation]    Verify the order details page table
    @{TableHeader_Texts}    Create List    ${testData_config['Orders']['ViewOrders']['Table']}[SNo_ColumnHeaderTxt]  ${testData_config['Orders']['ViewOrders']['Table']}[ProductName_ColumnHeaderTxt]
    ...    ${testData_config['Orders']['ViewOrders']['Table']}[Amount_ColumnHeaderTxt]  ${testData_config['Orders']['ViewOrders']['Table']}[TotalQuantity_ColumnHeaderTxt]
    ...    ${testData_config['Orders']['ViewOrders']['Table']}[Total_ColumnHeaderTxt]
    Get text and Ensure the Headers are Equal  ${locators_params['Orders']['ViewOrders']}[tableHeaders_Txt]   @{TableHeader_Texts}

Verify the order details elements
    [Documentation]    Verify the order details elements
    @{Label_texts}    Create List    ${testData_config['Orders']['ViewOrders']['OrderDetails_Section']}[SubTotal_LblTxt]  ${testData_config['Orders']['ViewOrders']['OrderDetails_Section']}[Discount_LblTxt]
    ...    ${testData_config['Orders']['ViewOrders']['OrderDetails_Section']}[ReceivedAmount_LblTxt]  ${testData_config['Orders']['ViewOrders']['OrderDetails_Section']}[RemainingBalance_LblTxt]
    ...    ${testData_config['Orders']['ViewOrders']['OrderDetails_Section']}[OutstandingBalance_LblTxt]    ${testData_config['Orders']['ViewOrders']['OrderDetails_Section']}[PaymentMode_LblTxt]
    ...    ${testData_config['Orders']['ViewOrders']['OrderDetails_Section']}[OrderDate_LblTxt]    ${testData_config['Orders']['ViewOrders']['OrderDetails_Section']}[OrderTime_LblTxt]
    Get text and Ensure the elements texts are Equal  ${locators_params['Orders']['ViewOrders']}[PriceDetails_LblTxts]    @{Label_texts}

Validate the order details page if order status is confirm or in-process
    [Documentation]    Validate the order details page if order status is confirm or in-process
    [Arguments]    ${count}    ${Orders_ID}    ${CustomerName}
    FOR    ${i}   IN RANGE    0   ${count}
        ${index} =    Evaluate  ${i}+3
        Run Keyword If    "${Orders_ID}[${i}]" == "N/A"  Run Keywords    Navigate to order details page  ${Orders_ID}[${index}]
        ...    AND   Exit For Loop
        ...    ELSE    Run Keywords    Navigate to order details page  ${Orders_ID}[${i}]
        ...    AND   Exit For Loop
    END
    ${ViewOrder_Btn}  format string  ${locators_params['Orders']}[ViewOrderBtn]   value=${Orders_ID}[0]
    ${status}    Run Keyword And Return Status    wait until element is visible  ${ViewOrder_Btn}
    Run Keyword If    ${status} == True  Run Keywords    filter the orders table data
    ...    AND  Show all the data from the table   All
    ...    AND  click element until visible  ${ViewOrder_Btn}
    wait until element is visible  ${locators_params['Orders']['ViewOrders']}[HeaderTxt]
    capture the screen  View_Orders_Details

#### Order status is In-Process ###
verify the order details page elements are visible if the order status is in-process
    [Documentation]    verify the order details page elements are visible if the order status is in-process
    Go Back
    Verify The Title Of Orders Page
    ${response}  call method  ${API_POSLaundry}   getAPI_Order
    log  ${response}
    ${Confirm_OrderIDs}    set variable  ${response}[7]
    ${Confirm_OrderID_CustomerName}    set variable  ${response}[12]
    ${InProcess_OrderIDs}    set variable  ${response}[8]
    ${InProcess_OrderID_CustomerName}    set variable  ${response}[13]
    ${ConfirmID_count}    Get Length    ${Confirm_OrderIDs}
    ${InProcessID_count}    Get Length    ${InProcess_OrderIDs}
    ${InProcess_OrderIDs_Status}    Test Empty List    ${InProcess_OrderIDs}
    ${status}    Run Keyword And Return Status    Should Be Equal    ${InProcess_OrderIDs_Status}    Null
    Run Keyword If    ${status} == False    Run Keywords    Validate the order details page if order status is confirm or in-process  ${InProcessID_count}  ${InProcess_OrderIDs}    ${InProcess_OrderID_CustomerName}[0]
    ...    AND   validate the order status dropdown
    ...    ELSE   Validate the order details page if order status is confirm or in-process  ${ConfirmID_count}  ${Confirm_OrderIDs}    ${Confirm_OrderID_CustomerName}[0]
    Verify the title of Order details page
    Page Should Contain    ${testData_config['Orders']['ViewOrders']['OrderStatus_Dropdown_Options']}[InProcess_LblTxt]
    Validate all elements are visible in order details page
    Validate all elements texts in order details page if the order status is Confirm or in-process

#### Order status is Waiting For Delivery ###
verify the order details page elements are visible if the order status is waiting for delivery
    [Documentation]    verify the order details page elements are visible if the order status is waiting for delivery
    Go Back
    Verify The Title Of Orders Page
    ${response}  call method  ${API_POSLaundry}   getAPI_Order
    log  ${response}
    ${Confirm_OrderIDs}    set variable  ${response}[7]
    ${Confirm_OrderID_CustomerNames}    set variable  ${response}[12]
    ${count}    Get Length    ${Confirm_OrderIDs}
    ${WaitingForDelivery_OrderIDs}    set variable  ${response}[9]
    ${WaitingForDelivery_OrderID_CustomerName}    set variable  ${response}[14]
    ${count}    Get Length    ${WaitingForDelivery_OrderIDs}
    Run Keyword If    ${WaitingForDelivery_OrderIDs} != []    Run Keywords    Validate the waiting for delivery order details page  ${count}  ${WaitingForDelivery_OrderIDs}    ${WaitingForDelivery_OrderID_CustomerName}[0]
#    Run Keyword If    ${WaitingForDelivery_OrderIDs} != []    Run Keywords    Validate the order details page if order status is waiting for delivery  ${count}  ${WaitingForDelivery_OrderIDs}    ${WaitingForDelivery_OrderID_CustomerName}[0]
    ...    AND   validate the order status dropdown
    ...    ELSE  Validate the changed order status to waiting for delivery    ${Confirm_OrderIDs}    ${Confirm_OrderID_CustomerNames}
##    ...    ELSE  Navigate to confirm order and changed to waiting for delivery    ${Confirm_OrderIDs}    ${Confirm_OrderID_CustomerNames}
##        Change the order status    ${testData_config['Orders']['ViewOrders']['OrderStatus_Dropdown_Options']}[WaitingForDelivery_LblTxt]
##    ...    ${count}    ${Confirm_OrderIDs}    ${Confirm_OrderID_CustomerName}[0]
#    Verify the title of Order details page
#    Page Should Contain    ${testData_config['Orders']['ViewOrders']['OrderStatus_Dropdown_Options']}[WaitingForDelivery_LblTxt]
##    ${response}  call method  ${API_POSLaundry}   getAPI_Order
##    log  ${response}
##    ${New_WaitingForDelivery_OrderIDs}    set variable  ${response}[9]
##    ${New_WaitingForDelivery_OrderID_CustomerName}    set variable  ${response}[14]
##    ${New_count}    Get Length    ${WaitingForDelivery_OrderIDs}
##    Run Keyword If    ${New_WaitingForDelivery_OrderIDs} != []    Run Keywords
##    ...    Validate the order details page if order status is waiting for delivery  ${New_count}  ${New_WaitingForDelivery_OrderIDs}    ${New_WaitingForDelivery_OrderID_CustomerName}[0]
#    Validate all elements are visible in order details page
#    Validate all elements texts in order details page if the order status is waiting for delivery
#    Validate payment methods all elements texts in order details page if the order status is waiting for delivery
#    ...    ${testData_config['Orders']['ViewOrders']['PaymentMethods']}[BuyOnCredit_RadioBtn_LblTxt]
#    ...    ${testData_config['Orders']['ViewOrders']['PaymentMethods']}[Card_RadioBtn_LblTxt]
#    ...    ${testData_config['Orders']['ViewOrders']['PaymentMethods']}[Cash_RadioBtn_LblTxt]
#    ...    ${New_WaitingForDelivery_OrderID_CustomerName}[0]

Validate the waiting for delivery order details page
    [Documentation]    Validate the waiting for delivery order details page
    [Arguments]    ${count}  ${WaitingForDelivery_OrderIDs}    ${WaitingForDelivery_OrderID_CustomerName}
    Validate the order details page if order status is waiting for delivery  ${count}  ${WaitingForDelivery_OrderIDs}    ${WaitingForDelivery_OrderID_CustomerName}
    validate the order status dropdown
    Verify the title of Order details page
    Page Should Contain    ${testData_config['Orders']['ViewOrders']['OrderStatus_Dropdown_Options']}[WaitingForDelivery_LblTxt]
#    ${response}  call method  ${API_POSLaundry}   getAPI_Order
#    log  ${response}
#    ${New_WaitingForDelivery_OrderIDs}    set variable  ${response}[9]
#    ${New_WaitingForDelivery_OrderID_CustomerName}    set variable  ${response}[14]
#    ${New_count}    Get Length    ${WaitingForDelivery_OrderIDs}
#    Run Keyword If    ${New_WaitingForDelivery_OrderIDs} != []    Run Keywords
#    ...    Validate the order details page if order status is waiting for delivery  ${New_count}  ${New_WaitingForDelivery_OrderIDs}    ${New_WaitingForDelivery_OrderID_CustomerName}[0]
    Validate all elements are visible in order details page
    Validate all elements texts in order details page if the order status is waiting for delivery
    Validate payment methods all elements texts in order details page if the order status is waiting for delivery
    ...    ${testData_config['Orders']['ViewOrders']['PaymentMethods']}[BuyOnCredit_RadioBtn_LblTxt]
    ...    ${testData_config['Orders']['ViewOrders']['PaymentMethods']}[Card_RadioBtn_LblTxt]
    ...    ${testData_config['Orders']['ViewOrders']['PaymentMethods']}[Cash_RadioBtn_LblTxt]
    ...    ${New_WaitingForDelivery_OrderID_CustomerName}[0]

Validate the changed order status to waiting for delivery
    [Documentation]    Validate the changed order status to waiting for delivery
    [Arguments]    ${Confirm_OrderIDs}    ${Confirm_OrderID_CustomerNames}
    Navigate to confirm order and changed to waiting for delivery    ${Confirm_OrderIDs}    ${Confirm_OrderID_CustomerNames}
    Verify the title of Order details page
    Page Should Contain    ${testData_config['Orders']['ViewOrders']['OrderStatus_Dropdown_Options']}[WaitingForDelivery_LblTxt]
#    ${response}  call method  ${API_POSLaundry}   getAPI_Order
#    log  ${response}
#    ${New_WaitingForDelivery_OrderIDs}    set variable  ${response}[9]
#    ${New_WaitingForDelivery_OrderID_CustomerName}    set variable  ${response}[14]
#    ${New_count}    Get Length    ${WaitingForDelivery_OrderIDs}
#    Run Keyword If    ${New_WaitingForDelivery_OrderIDs} != []    Run Keywords
#    ...    Validate the order details page if order status is waiting for delivery  ${New_count}  ${New_WaitingForDelivery_OrderIDs}    ${New_WaitingForDelivery_OrderID_CustomerName}[0]
    Validate all elements are visible in order details page
    Validate all elements texts in order details page if the order status is waiting for delivery
    Validate payment methods all elements texts in order details page if the order status is waiting for delivery
    ...    ${testData_config['Orders']['ViewOrders']['PaymentMethods']}[BuyOnCredit_RadioBtn_LblTxt]
    ...    ${testData_config['Orders']['ViewOrders']['PaymentMethods']}[Card_RadioBtn_LblTxt]
    ...    ${testData_config['Orders']['ViewOrders']['PaymentMethods']}[Cash_RadioBtn_LblTxt]
    ...    ${Confirm_OrderID_CustomerNames}[0]

Navigate to confirm order and changed to waiting for delivery
    [Documentation]    Navigate to confirm order and changed to waiting for delivery
    [Arguments]    ${Confirm_OrderIDs}    ${Confirm_OrderID_CustomerNames}
    ${count}    Get Length    ${Confirm_OrderIDs}
    FOR    ${i}   IN RANGE    0   ${count}
        ${index} =    Evaluate  ${i}+1
        Run Keyword If    "${Confirm_OrderIDs}[${i}]" == "N/A"  Run Keywords    Navigate to order details page  ${Confirm_OrderIDs}[${index}]
        ...    AND   Exit For Loop
        ...    ELSE    Run Keywords    Navigate to order details page  ${Confirm_OrderIDs}[${i}]
        ...    AND   Exit For Loop
    END
    Wait Until Element Is Visible    ${locators_params['Orders']['ViewOrders']}[OrderStatus_DropDownBtn]
    ${options}  Get Webelements    ${locators_params['Orders']['ViewOrders']}[OrderStatus_DropDownOpts]
    ${opts_count}  Get Length    ${options}
    FOR  ${i}  IN RANGE    0  ${opts_count}
        Click Element Until Visible      ${locators_params['Orders']['ViewOrders']}[OrderStatus_DropDownBtn]
        ${text}    Get Text    ${options}[${i}]
        Run Keyword If   "${text}" == "${testData_config['Orders']['ViewOrders']['OrderStatus_Dropdown_Options']}[WaitingForDelivery_LblTxt]"
        ...    Click Element Until Visible    ${options}[${i}]
        Log   YOUR ORDER STATUS IS : ${text}
        Sleep    2s
    END

Validate payment methods all elements texts in order details page if the order status is waiting for delivery
    [Documentation]    Validate payment methods all elements texts in order details page if the order status is waiting for delivery
    [Arguments]  ${BuyOnCredit}   ${CreditCard}   ${Cash}    ${CustomerName}
    @{PaymentMethods}  create list  ${locators_params['Orders']['ViewOrders']['PaymentMethods']}[BuyOnCredit_RadioBtn_LblTxt]
#    ...     ${locators_params['Orders']['ViewOrders']['PaymentMethods']}[Card_RadioBtn_LblTxt]   
    ...    ${locators_params['Orders']['ViewOrders']['PaymentMethods']}[Cash_RadioBtn_LblTxt]
    @{PaymentMethods_lblTxt}=    create list
    ${CountOfElements}=    Get Length    ${PaymentMethods}
    FOR    ${i}  IN RANGE    0     ${CountOfElements}
        ${LblTxt}=    get text    ${PaymentMethods}[${i}]
        append to list    ${PaymentMethods_lblTxt}    ${LblTxt}
    END
    log  ${PaymentMethods_lblTxt}
    FOR  ${PaymentMode}  IN  @{PaymentMethods_lblTxt}
        run keyword if  '${PaymentMode}' == '${BuyOnCredit}'   Run Keywords    Click Element Until Visible    ${locators_params['Orders']['ViewOrders']['PaymentMethods']}[BuyOnCredit_RadioBtn]
        ...    AND     Click Element Until Visible    ${locators_params['Orders']['ViewOrders']['PaymentMethods']}[Complete_Btn]
        ...    AND     Validate the order details buy on credit payment summary popup  ${BuyOnCredit}  ${CustomerName}
#        ...    ELSE IF  '${PaymentMode}' == '${CreditCard}'   Run Keywords    Click Element Until Visible    ${locators_params['Orders']['ViewOrders']['PaymentMethods']}[Card_RadioBtn]
#        ...    AND     Click Element Until Visible    ${locators_params['Orders']['ViewOrders']['PaymentMethods']}[Complete_Btn]
#        ...    AND     Validate the order details card payment summary popup  ${PhoneNumbers}[${PhNo_Index}]
        ...    ELSE IF  '${PaymentMode}' == '${Cash}'   Run Keywords    Click Element Until Visible    ${locators_params['Orders']['ViewOrders']['PaymentMethods']}[Cash_RadioBtn]
        ...    AND     Click Element Until Visible    ${locators_params['Orders']['ViewOrders']['PaymentMethods']}[Complete_Btn]
        ...    AND     Validate the order details cash payment summary popup  ${Cash}  ${CustomerName}
    END

Verify the waiting for delivery order's order details elements
    [Documentation]    Verify the waiting for delivery order's order details elements
    @{OrderDetailsSection_Elements}  Create List    ${locators_params['Orders']['ViewOrders']}[OrderID_LblTxt]
    ...    ${locators_params['Orders']['ViewOrders']}[Name_LblTxt]    ${locators_params['Orders']['ViewOrders']}[OrderStatus_LblTxt]
    ...    ${locators_params['Orders']['ViewOrders']['PaymentMethods']}[LblTxt]    ${locators_params['Orders']['ViewOrders']['PaymentMethods']}[BuyOnCredit_RadioBtn]
    ...    ${locators_params['Orders']['ViewOrders']['PaymentMethods']}[BuyOnCredit_RadioBtn_LblTxt]    ${locators_params['Orders']['ViewOrders']['PaymentMethods']}[Card_RadioBtn]
    ...    ${locators_params['Orders']['ViewOrders']['PaymentMethods']}[Card_RadioBtn_LblTxt]    ${locators_params['Orders']['ViewOrders']['PaymentMethods']}[Cash_RadioBtn]
    ...    ${locators_params['Orders']['ViewOrders']['PaymentMethods']}[Cash_RadioBtn_LblTxt]    ${locators_params['Orders']['ViewOrders']['PaymentMethods']}[Complete_Btn]
    ...    ${locators_params['Orders']['ViewOrders']}[PrintReceipt_Btn]    ${locators_params['Orders']['ViewOrders']}[Cancel_Btn]
    Wait Until Elements Are Visible    @{OrderDetailsSection_Elements}
    Capture The Screen    Waiting_For_Delivery

Verify the waiting for delivery order's order details elements label text
    [Documentation]    Verify the waiting for delivery order's order details elements label text
    @{OrderDetailsSection_Elements}  Create List    ${locators_params['Orders']['ViewOrders']}[OrderID_LblTxt]
    ...    ${locators_params['Orders']['ViewOrders']}[Name_LblTxt]    ${locators_params['Orders']['ViewOrders']}[OrderStatus_LblTxt]
    ...    ${locators_params['Orders']['ViewOrders']['PaymentMethods']}[LblTxt]  ${locators_params['Orders']['ViewOrders']['PaymentMethods']}[BuyOnCredit_RadioBtn_LblTxt]
    ...    ${locators_params['Orders']['ViewOrders']['PaymentMethods']}[Card_RadioBtn_LblTxt]   ${locators_params['Orders']['ViewOrders']['PaymentMethods']}[Cash_RadioBtn_LblTxt]
    ...    ${locators_params['Orders']['ViewOrders']}[PrintReceipt_Btn]    ${locators_params['Orders']['ViewOrders']}[Cancel_Btn]
    @{OrderDetailsSection_LabelTexts}  Create List    ${testData_config['Orders']['ViewOrders']['OrderDetails_Section']}[OrderID_LblTxt]
    ...    ${testData_config['Orders']['ViewOrders']['OrderDetails_Section']}[Name_LblTxt]    ${testData_config['Orders']['ViewOrders']['OrderDetails_Section']}[OrderStatus_LblTxt]
    ...    ${testData_config['Orders']['ViewOrders']['PaymentMethods']}[LblTxt]  ${testData_config['Orders']['ViewOrders']['PaymentMethods']}[BuyOnCredit_RadioBtn_LblTxt]
    ...    ${testData_config['Orders']['ViewOrders']['PaymentMethods']}[Card_RadioBtn_LblTxt]   ${testData_config['Orders']['ViewOrders']['PaymentMethods']}[Cash_RadioBtn_LblTxt]
    ...    ${testData_config['Orders']['ViewOrders']['OrderDetails_Section']}[PrintReceipt_Btn]    ${testData_config['Orders']['ViewOrders']['OrderDetails_Section']}[Cancel_Btn]
    Check all the get elements text are should contain  ${OrderDetailsSection_Elements}  ${OrderDetailsSection_LabelTexts}
    
Validate all elements texts in order details page if the order status is waiting for delivery
    [Documentation]    Validate all elements texts in order details page if the order status is waiting for delivery
    Verify the order details page table
    Verify the waiting for delivery order's order details elements
    Verify the waiting for delivery order's order details elements label text

Validate the order details page if order status is waiting for delivery
    [Documentation]    Validate the order details page if order status is waiting for delivery
    [Arguments]    ${count}    ${Orders_ID}    ${CustomerName}
    FOR    ${i}   IN RANGE    0   ${count}
        ${index} =    Evaluate  ${i}+3
        Run Keyword If    "${Orders_ID}[${i}]" == "N/A"  Run Keywords    Navigate to order details page  ${Orders_ID}[${index}]
        ...    AND   Exit For Loop
        ...    ELSE    Run Keywords    Navigate to order details page  ${Orders_ID}[${i}]
        ...    AND   Exit For Loop
    END
    ${ViewOrder_Btn}  format string  ${locators_params['Orders']}[ViewOrderBtn]   value=${Orders_ID}[0]
    ${status}    Run Keyword And Return Status    wait until element is visible  ${ViewOrder_Btn}
    Run Keyword If    ${status} == True  Run Keywords    filter the orders table data
    ...    AND  Show all the data from the table   All
    ...    AND  click element until visible  ${ViewOrder_Btn}
    wait until element is visible  ${locators_params['Orders']['ViewOrders']}[HeaderTxt]
    capture the screen  View_Orders_Details

   ### BUY ON CREDIT ###
Validate the order details buy on credit payment summary popup
    [Documentation]    Validate the order details buy on credit payment summary popup
    [Arguments]    ${BuyOnCredit}  ${CustomerName}
    ${CustomerName_loc}  Format String    ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[CustomerName]  value=${CustomerName}
    Wait Until Element Is Visible    ${CustomerName_loc}
    ${date} =	Get Current Date
    sleep  5s
    @{BuyOnCredit_PaymentSummary_elements}  create list  ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[BackArrow_Btn]
    ...    ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[CloseIcon]
    ...    ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[HeaderTxt]
    ...    ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[Customer_logo]
    ...    ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[SelectedCustomer_lblTxt]
    ...    ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[PaymentMethod_lblTxt]
    ...    ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[PaymentMethodOf_BuyOnCredit_text]
    ...    ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[CustomerName_lblTxt]
    ...    ${CustomerName_loc}
    ...    ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[OrderDate_lblTxt]
    ...    ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[OrderTime_lblTxt]
    ...    ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[OutstandingBalance_LblTxt]
    ...    ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[OutstandingBalance_CashImg]
    ...    ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[OutstandingBalance_Value]
    ...    ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[OrderPrice_lblTxt]
    ...    ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[OrderPrice_CashImg]
    ...    ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[OrderPrice_Value]
    ...    ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[Discount_lblTxt]
    ...    ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[Discount_CashImg]
    ...    ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[Discount_Value]
    ...    ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[FinalPrice_lblTxt]
    ...    ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[FinalPrice_CashImg]
    ...    ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[FinalPrice_Value]
    ...    ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[Total_lblTxt]
    ...    ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[Total_CashImg]
    ...    ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[Total_Value]
    ...    ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[Cancel_Btn]
    ...    ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[Complete_Btn]
    Wait Until Elements Are Visible    @{BuyOnCredit_PaymentSummary_elements}
    capture the screen  Orders_BuyOnCredit_PaymentSummary_elements
    Validate the order details buy on credit payment summary popup elements texts
    Validate the buy on credit payment summary popup back button function
    sleep  5s
    Validate the order details buy on credit payment summary cancel button
    Validate the order details buy on credit payment summary complete button
    Verify that all elements are visible in the order success popup

validate the order details buy on credit payment summary popup elements texts
    [Documentation]    validate the order details buy on credit payment summary popup elements texts
    @{BuyOnCredit_PaymentummaryElements}  create list  ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[HeaderTxt]
    ...     ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[SelectedCustomer_lblTxt]
    ...     ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[PaymentMethod_lblTxt]
    ...     ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[PaymentMethodOf_BuyOnCredit_text]
    ...     ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[CustomerName_lblTxt]
    ...     ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[OrderDate_lblTxt]
    ...     ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[OrderTime_lblTxt]
    ...     ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[OutstandingBalance_LblTxt]
    ...     ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[OutstandingBalance_Value]
    ...     ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[OrderPrice_lblTxt]
    ...     ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[OrderPrice_Value]
    ...     ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[Discount_lblTxt]
    ...     ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[Discount_Value]
    ...     ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[FinalPrice_lblTxt]
    ...     ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[FinalPrice_Value]
    ...     ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[Total_lblTxt]
    ...     ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[Total_Value]
    ...     ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[Cancel_Btn]
    ...     ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[Complete_Btn]
    @{BuyOnCredit_PaymentummaryLblTxt}  create list  ${testData_config['Orders']['ViewOrders']['PaymentMethods']['PaymentSummary']}[HeaderTxt]
    ...     ${testData_config['Orders']['ViewOrders']['PaymentMethods']['PaymentSummary']}[SelectedCustomer_lblTxt]
    ...     ${testData_config['Orders']['ViewOrders']['PaymentMethods']['PaymentSummary']}[PaymentMethod_lblTxt]
    ...     ${testData_config['Orders']['ViewOrders']['PaymentMethods']['PaymentSummary']}[BuyOnCredit_OfPayment_LblTxt]
    ...     ${testData_config['Orders']['ViewOrders']['PaymentMethods']['PaymentSummary']}[CustomerName_lblTxt]
    ...     ${testData_config['Orders']['ViewOrders']['PaymentMethods']['PaymentSummary']}[OrderDate_lblTxt]
    ...     ${testData_config['Orders']['ViewOrders']['PaymentMethods']['PaymentSummary']}[OrderTime_lblTxt]
    ...     ${testData_config['Orders']['ViewOrders']['PaymentMethods']['PaymentSummary']}[OutstandingBalance_LblTxt]
    ...     ${testData_config['Orders']['ViewOrders']['PaymentMethods']['PaymentSummary']}[AmountType]
    ...     ${testData_config['Orders']['ViewOrders']['PaymentMethods']['PaymentSummary']}[OrderPrice_LblTxt]
    ...     ${testData_config['Orders']['ViewOrders']['PaymentMethods']['PaymentSummary']}[AmountType]
    ...     ${testData_config['Orders']['ViewOrders']['PaymentMethods']['PaymentSummary']}[Discount_lblTxt]
    ...     ${testData_config['Orders']['ViewOrders']['PaymentMethods']['PaymentSummary']}[AmountType]
    ...     ${testData_config['Orders']['ViewOrders']['PaymentMethods']['PaymentSummary']}[FinalPrice_lblTxt]
    ...     ${testData_config['Orders']['ViewOrders']['PaymentMethods']['PaymentSummary']}[AmountType]
    ...     ${testData_config['Orders']['ViewOrders']['PaymentMethods']['PaymentSummary']}[Total_lblTxt]
    ...     ${testData_config['Orders']['ViewOrders']['PaymentMethods']['PaymentSummary']}[AmountType]
    ...     ${testData_config['Orders']['ViewOrders']['PaymentMethods']['PaymentSummary']}[Cancel_Btn]
    ...     ${testData_config['Orders']['ViewOrders']['PaymentMethods']['PaymentSummary']}[Complete_Btn]
    Check all the get elements text are should contain     ${BuyOnCredit_PaymentummaryElements}  ${BuyOnCredit_PaymentummaryLblTxt}
    
Validate the buy on credit payment summary popup back button function
    [Documentation]    Validate the buy on credit payment summary popup back button function
    Wait Until Element Is Visible  ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[BackArrow_Btn]
    Click Element Until Visible    ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[BackArrow_Btn]
    Wait Until Element Is Visible  ${locators_params['Orders']['ViewOrders']['PaymentMethods']}[BuyOnCredit_RadioBtn]
    Capture The Screen    BuyOnCreditPaymentSummary_BackBtn
    Wait Until Element Is Visible  ${locators_params['Orders']['ViewOrders']['PaymentMethods']}[BuyOnCredit_RadioBtn]
    Click Element Until Visible    ${locators_params['Orders']['ViewOrders']['PaymentMethods']}[BuyOnCredit_RadioBtn]
    Click Element Until Visible    ${locators_params['Orders']['ViewOrders']['PaymentMethods']}[Complete_Btn]
    Wait Until Element Is Visible  ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[BackArrow_Btn]
    
Validate the order details buy on credit payment summary cancel button
    [Documentation]    Validate the order details buy on credit payment summary cancel button
    Wait Until Element Is Visible  ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[Cancel_Btn]
    Click Element Until Visible    ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[Cancel_Btn]
    Wait Until Element Is Visible  ${locators_params['Orders']['ViewOrders']['PaymentMethods']}[BuyOnCredit_RadioBtn]
    Capture The Screen    BuyOnCreditPaymentSummary_CancelBtn
    Click Element Until Visible    ${locators_params['Orders']['ViewOrders']['PaymentMethods']}[BuyOnCredit_RadioBtn]
    Click Element Until Visible    ${locators_params['Orders']['ViewOrders']['PaymentMethods']}[Complete_Btn]
    Wait Until Element Is Visible  ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[Cancel_Btn]
    
Validate the order details buy on credit payment summary complete button
    [Documentation]    Validate the order details buy on credit payment summary complete button
    Wait Until Element Is Visible  ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[Complete_Btn]
    Click Element Until Visible    ${locators_params['Orders']['ViewOrders']['PaymentMethods']['BuyOnCredit_PaymentSummary']}[Complete_Btn]
    Capture The Screen    BuyOnCreditPaymentSummary_CancelBtn
    Wait Until Element Is Visible  ${locators_params['Orders']['ViewOrders']['PaymentMethods']['PaymentSuccess_Popup']}[Img]

Verify that all elements are visible in the order success popup
    [Documentation]    Verify that all elements are visible in the order success popup
    wait until element is visible  ${locators_params['Orders']['ViewOrders']['PaymentMethods']['PaymentSuccess_Popup']}[Img]
    @{SuccessPopup_elements}  create list   ${locators_params['Orders']['ViewOrders']['PaymentMethods']['PaymentSuccess_Popup']}[Msg_lblTxt]
#    ...     ${locators_params['Orders']['ViewOrders']['PaymentMethods']['PaymentSuccess_Popup']}[PrintReceipt_Btn]        # Regarding this button is hidden for dev
    ...     ${locators_params['Orders']['ViewOrders']['PaymentMethods']['PaymentSuccess_Popup']}[SendMail_Btn]
    ...     ${locators_params['Orders']['ViewOrders']['PaymentMethods']['PaymentSuccess_Popup']}[SendMsg_Btn]
    ...     ${locators_params['Orders']['ViewOrders']['PaymentMethods']['PaymentSuccess_Popup']}[Done_Btn]
    wait until elements are visible  @{SuccessPopup_elements}
    capture the screen  PaymentSuccessPopup
    @{PaymentSuccessPopup_lblTxt}   create list  ${testData_config['Orders']['ViewOrders']['PaymentMethods']['PaymentSuccess_Popup']}[SuccessMsg_lblTxt]
#    ...     ${testData_config['Orders']['ViewOrders']['PaymentMethods']['PaymentSuccess_Popup']}[PrintReceipt_BtnTxt]        # Regarding this button is hidden for dev
    ...     ${testData_config['Orders']['ViewOrders']['PaymentMethods']['PaymentSuccess_Popup']}[SendMail_Btn]
    ...     ${testData_config['Orders']['ViewOrders']['PaymentMethods']['PaymentSuccess_Popup']}[SendMsg_Btn]
    ...     ${testData_config['Orders']['ViewOrders']['PaymentMethods']['PaymentSuccess_Popup']}[Done_Btn]
    Check all the get elements text are should be equal  ${SuccessPopup_elements}  ${PaymentSuccessPopup_lblTxt}
#    Verify the order success popup print receipt button is working        # Regarding this button is hidden for dev
    Verify the order success popup send email button is working
    Verify the order success popup send message button is working
    Verify the order success popup done button is working

Verify the order success popup print receipt button is working
    [Documentation]  Verify the order success popup print receipt button is working
    Wait Until Element Is Visible  ${locators_params['Orders']['ViewOrders']['PaymentMethods']['PaymentSuccess_Popup']}[PrintReceipt_Btn]
    Click Element Until Visible    ${locators_params['Orders']['ViewOrders']['PaymentMethods']['PaymentSuccess_Popup']}[PrintReceipt_Btn]
    Wait Until Element Is Visible  ${locators_params['Orders']['ViewOrders']['PaymentMethods']['PaymentSuccess_Popup']}[PrintReceipt_Btn]

Verify the order success popup send email button is working
    [Documentation]    Verify the order success popup send email button is working
    Wait Until Element Is Visible  ${locators_params['Orders']['ViewOrders']['PaymentMethods']['PaymentSuccess_Popup']}[SendMail_Btn]
    ${sendMail_label_text}    Get Text    ${locators_params['Orders']['ViewOrders']['PaymentMethods']['PaymentSuccess_Popup']}[SendMail_Btn]
    Should Be Equal    ${sendMail_label_text}    ${testData_config['Orders']['ViewOrders']['PaymentMethods']['PaymentSuccess_Popup']}[SendMail_Btn]
    Capture The Screen    Send_Email_Button
    Click Element Until Visible    ${locators_params['Orders']['ViewOrders']['PaymentMethods']['PaymentSuccess_Popup']}[SendMail_Btn]
    Capture The Screen    Send_Email_Button_Success1
    Page Should Contain    ${testData_config['Toast_Messages']}[SendEmail_Waiting_ResponseMsg]
    Capture The Screen    Send_Email_Button_Success2
    Sleep    2s
#    Page Should Contain    ${testData_config['Toast_Messages']}[SendEmail_SuccessMsg]
    Capture The Screen    Send_Email_Button_Success2
    Sleep    1s
    Wait Until Element Is Not Visible  ${locators_params['Orders']['ViewOrders']['PaymentMethods']['PaymentSuccess_Popup']}[SendMail_Btn]

Verify the order success popup send message button is working
    [Documentation]    Verify the order success popup send message button is working
#    verify the order details page elements are visible
    Navigate To Orders Page
    Verify The Title Of Orders Page
    ${response}  call method  ${API_POSLaundry}   getAPI_Order
    log  ${response}
    ${Confirm_OrderIDs}    set variable  ${response}[7]
    ${Confirm_OrderID_CustomerNames}    set variable  ${response}[12]
    ${count}    Get Length    ${Confirm_OrderIDs}
    ${WaitingForDelivery_OrderIDs}    set variable  ${response}[9]
    ${WaitingForDelivery_OrderID_CustomerName}    set variable  ${response}[14]
    ${count}    Get Length    ${WaitingForDelivery_OrderIDs}
    Run Keyword If    ${WaitingForDelivery_OrderIDs} != []    Run Keywords    Validate the waiting for delivery order details page  ${count}  ${WaitingForDelivery_OrderIDs}    ${WaitingForDelivery_OrderID_CustomerName}[0]
    ...    AND   validate the order status dropdown
    ...    ELSE  Validate the changed order status to waiting for delivery    ${Confirm_OrderIDs}    ${Confirm_OrderID_CustomerNames}
        #######################
    wait until element is visible  ${locators_params['Orders']['ViewOrders']['PaymentMethods']['PaymentSuccess_Popup']}[Img]
    @{SuccessPopup_elements}  create list   ${locators_params['Orders']['ViewOrders']['PaymentMethods']['PaymentSuccess_Popup']}[Msg_lblTxt]
#    ...     ${locators_params['Orders']['ViewOrders']['PaymentMethods']['PaymentSuccess_Popup']}[PrintReceipt_Btn]        # Regarding this button is hidden for dev
    ...     ${locators_params['Orders']['ViewOrders']['PaymentMethods']['PaymentSuccess_Popup']}[SendMail_Btn]
    ...     ${locators_params['Orders']['ViewOrders']['PaymentMethods']['PaymentSuccess_Popup']}[SendMsg_Btn]
    ...     ${locators_params['Orders']['ViewOrders']['PaymentMethods']['PaymentSuccess_Popup']}[Done_Btn]
    wait until elements are visible  @{SuccessPopup_elements}
    capture the screen  PaymentSuccessPopup
    @{PaymentSuccessPopup_lblTxt}   create list  ${testData_config['Orders']['ViewOrders']['PaymentMethods']['PaymentSuccess_Popup']}[SuccessMsg_lblTxt]
#    ...     ${testData_config['Orders']['ViewOrders']['PaymentMethods']['PaymentSuccess_Popup']}[PrintReceipt_BtnTxt]        # Regarding this button is hidden for dev
    ...     ${testData_config['Orders']['ViewOrders']['PaymentMethods']['PaymentSuccess_Popup']}[SendMail_Btn]
    ...     ${testData_config['Orders']['ViewOrders']['PaymentMethods']['PaymentSuccess_Popup']}[SendMsg_Btn]
    ...     ${testData_config['Orders']['ViewOrders']['PaymentMethods']['PaymentSuccess_Popup']}[Done_Btn]
    Check all the get elements text are should be equal  ${SuccessPopup_elements}  ${PaymentSuccessPopup_lblTxt}
                ##############
    Wait Until Element Is Visible  ${locators_params['Orders']['ViewOrders']['PaymentMethods']['PaymentSuccess_Popup']}[SendMsg_Btn]
    ${send_Message_label_text}    Get Text    ${locators_params['Orders']['ViewOrders']['PaymentMethods']['PaymentSuccess_Popup']}[SendMsg_Btn]
    Should Be Equal    ${send_Message_label_text}    ${testData_config['Orders']['ViewOrders']['PaymentMethods']['PaymentSuccess_Popup']}[SendMsg_Btn]
    Capture The Screen    Send_Message_Button
    Click Element Until Visible    ${locators_params['Orders']['ViewOrders']['PaymentMethods']['PaymentSuccess_Popup']}[SendMsg_Btn]

Verify the order success popup done button is working
    [Documentation]    Verify the order success popup done button is working
    Verify The Title Of Orders Page
    ${response}  call method  ${API_POSLaundry}   getAPI_Order
    log  ${response}
    ${Confirm_OrderIDs}    set variable  ${response}[7]
    ${Confirm_OrderID_CustomerNames}    set variable  ${response}[12]
    ${count}    Get Length    ${Confirm_OrderIDs}
    ${WaitingForDelivery_OrderIDs}    set variable  ${response}[9]
    ${WaitingForDelivery_OrderID_CustomerName}    set variable  ${response}[14]
    ${count}    Get Length    ${WaitingForDelivery_OrderIDs}
    Run Keyword If    ${WaitingForDelivery_OrderIDs} != []    Run Keywords    Validate the waiting for delivery order details page  ${count}  ${WaitingForDelivery_OrderIDs}    ${WaitingForDelivery_OrderID_CustomerName}[0]
    ...    AND   validate the order status dropdown
    ...    ELSE  Validate the changed order status to waiting for delivery    ${Confirm_OrderIDs}    ${Confirm_OrderID_CustomerNames}
        #######################
    wait until element is visible  ${locators_params['Orders']['ViewOrders']['PaymentMethods']['PaymentSuccess_Popup']}[Img]
    @{SuccessPopup_elements}  create list   ${locators_params['Orders']['ViewOrders']['PaymentMethods']['PaymentSuccess_Popup']}[Msg_lblTxt]
#    ...     ${locators_params['Orders']['ViewOrders']['PaymentMethods']['PaymentSuccess_Popup']}[PrintReceipt_Btn]        # Regarding this button is hidden for dev
    ...     ${locators_params['Orders']['ViewOrders']['PaymentMethods']['PaymentSuccess_Popup']}[SendMail_Btn]
    ...     ${locators_params['Orders']['ViewOrders']['PaymentMethods']['PaymentSuccess_Popup']}[SendMsg_Btn]
    ...     ${locators_params['Orders']['ViewOrders']['PaymentMethods']['PaymentSuccess_Popup']}[Done_Btn]
    wait until elements are visible  @{SuccessPopup_elements}
    capture the screen  PaymentSuccessPopup
    @{PaymentSuccessPopup_lblTxt}   create list  ${testData_config['Orders']['ViewOrders']['PaymentMethods']['PaymentSuccess_Popup']}[SuccessMsg_lblTxt]
#    ...     ${testData_config['Orders']['ViewOrders']['PaymentMethods']['PaymentSuccess_Popup']}[PrintReceipt_BtnTxt]        # Regarding this button is hidden for dev
    ...     ${testData_config['Orders']['ViewOrders']['PaymentMethods']['PaymentSuccess_Popup']}[SendMail_Btn]
    ...     ${testData_config['Orders']['ViewOrders']['PaymentMethods']['PaymentSuccess_Popup']}[SendMsg_Btn]
    ...     ${testData_config['Orders']['ViewOrders']['PaymentMethods']['PaymentSuccess_Popup']}[Done_Btn]
    Check all the get elements text are should be equal  ${SuccessPopup_elements}  ${PaymentSuccessPopup_lblTxt}
                ##############
    Wait Until Element Is Visible  ${locators_params['Orders']['ViewOrders']['PaymentMethods']['PaymentSuccess_Popup']}[Done_Btn]
    ${send_Message_label_text}    Get Text    ${locators_params['Orders']['ViewOrders']['PaymentMethods']['PaymentSuccess_Popup']}[Done_Btn]
    Should Be Equal    ${send_Message_label_text}    ${testData_config['Orders']['ViewOrders']['PaymentMethods']['PaymentSuccess_Popup']}[Done_Btn]
    Capture The Screen    Send_Message_Button
    Click Element Until Visible    ${locators_params['Orders']['ViewOrders']['PaymentMethods']['PaymentSuccess_Popup']}[Done_Btn]

### New Order creating Process ###
New order creating process
    [Documentation]    New order creating process
    ${Category_Btn}    format string  ${locators_params['Home']['Category_Section']}[Categories_Fields]     value=1
    Verify the product button in category section   ${Category_Btn}
    Verify and validate the discount field
    Click Element Until Enabled   ${locators_params['Home']['Order_Summary']}[Checkout_Btn]
    page should contain  ${testData_config['Toast_Messages']}[ProductAdded_SuccessMsg]
    page should not contain  ${testData_config['Toast_Messages']}[WithoutSelect_productMsg]
    wait until element is visible  ${locators_params['Home']['SelectCustomer_Popup']}[AddCustomer_Btn]
  
    ${response}  Call Method    ${API_POSLaundry}    getAPI_Customer
    ${PhoneNumbers}    Set Variable    ${response}[4]
    ${PhNo_count}    Get Length    ${PhoneNumbers}
    ${PhNo_Index}    Evaluate    ${PhNo_count}-1
    ${Names}    Set Variable    ${response}[2]
    ${count}  Get Length    ${Names}
    ${index} =    Evaluate  ${count}-1
    ${name} =   Evaluate  "${Names}[${index}]"
    ${Added_NewCustomer}  format string  ${locators_params['Home']['SelectCustomer_Popup']}[AddedCustomer_loc]   value=${PhoneNumbers}[${PhNo_Index}]
    wait until element is visible  ${Added_NewCustomer}
    Click Element Until Visible  ${Added_NewCustomer}
    Capture The Screen    ProductPopup
    
    Verify the customer ledger popup confirm button
    @{PaymentMethods}  create list  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']}[BuyOnCredit_LblTxt]
#    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']}[CreditCard_LblTxt]
#    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']}[Cash_LblTxt]
    @{PaymentMethods_lblTxt}=    create list
    ${CountOfElements}=    Get Length    ${PaymentMethods}
    FOR    ${i}  IN RANGE    0     ${CountOfElements}
        ${LblTxt}=    get text    ${PaymentMethods}[${i}]
        append to list    ${PaymentMethods_lblTxt}    ${LblTxt}
    END
    Navigate to choose payment method popup    ${PhoneNumbers}[${PhNo_Index}]    ${name}    @{PaymentMethods_lblTxt}
    
Navigate to choose payment method popup
    [Documentation]    Navigate to choose payment method popup
    [Arguments]    ${Phone_number}    ${name}    @{PaymentMethods_lblTxt}
    @{PaymentMethods_lblTxt}=    create list
    FOR  ${PaymentMode}  IN  @{PaymentMethods_lblTxt}
        run keyword if  '${PaymentMode}' == 'Buy on credit'   Chosen payment mode was buy on credit    ${Phone_number}    ${name}
#        ...  ELSE IF  '${PaymentMode}' == '${CreditCard}'   Validation of the credit card mode  ${Phone_number}
#        ...  ELSE IF  '${PaymentMode}' == '${Cash}'   Validation of the cash mode  ${Phone_number}
    END

Chosen payment mode was buy on credit
    [Documentation]    Chosen payment mode was buy on credit
    [Arguments]    ${Phone_number}    ${name}
    ${CustomerName_loc}  Format String    ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[CustomerName]  value=${name}
    Click Element Until Visible  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']}[BuyOnCredit_Img]
    Wait Until Element Visible    ${CustomerName_loc}
    Validate the buy on credit payment summary complete button
    wait until element is visible  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSuccess_Popup']}[Img]
    wait until element is visible  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSuccess_Popup']}[Done_Btn]
    click element until enabled  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSuccess_Popup']}[Done_Btn]
    page should contain  ${testData_config['Toast_Messages']}[OrderTaken_Msg]
    Capture the screen  DoneMsg
    
Change the order status
    [Documentation]    Change the order status
    [Arguments]    ${expected_OrderStatus}   ${count}  ${InProcess_OrderIDs}    ${InProcess_OrderID_CustomerName}
    ${Hamburger_menu}  Run Keyword And Return Status    Wait Until Element Is Visible    ${locators_params['Home']['Hamburger_MenuIcons']}[Hamburger_menu]
    Run Keyword If    ${Hamburger_menu} == True    Run Keywords    Navigate to Home page from Hamburger menu list
    ...    ELSE   Navigate to Home page menu list
    ${OrderStatus_DD_Status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${locators_params['Orders']['ViewOrders']}[OrderStatus_DropDownBtn]
    Run Keyword If    ${OrderStatus_DD_Status} == False    
    ...    Run Keywords    Validate the order details page if order status is confirm or in-process  ${count}  ${InProcess_OrderIDs}    ${InProcess_OrderID_CustomerName}
    ...    AND     Order status in-process to waiting for delivery
    Wait Until Element Is Visible    ${locators_params['Orders']['ViewOrders']}[OrderStatus_DropDownBtn]
    ${options}  Get Webelements    ${locators_params['Orders']['ViewOrders']}[OrderStatus_DropDownOpts]
    ${opts_count}  Get Length    ${options}
    FOR  ${i}  IN RANGE    0  ${opts_count}
        Click Element Until Visible      ${locators_params['Orders']['ViewOrders']}[OrderStatus_DropDownBtn]
        ${text}    Get Text    ${options}[${i}]
        Run Keyword If   "${text}" == "${expected_OrderStatus}"   Click Element Until Visible    ${options}[${i}]
        Log   YOUR EXPECTED ORDER STATUS IS : ${text}
        Sleep    2s
    END
    Capture The Screen    OrderStatus_DD

Order status in-process to waiting for delivery
    [Documentation]    Order status in-process to waiting for delivery
    ${options}  Get Webelements    ${locators_params['Orders']['ViewOrders']}[OrderStatus_DropDownOpts]
    ${opts_count}  Get Length    ${options}
    FOR  ${i}  IN RANGE    0  ${opts_count}
        Click Element Until Visible      ${locators_params['Orders']['ViewOrders']}[OrderStatus_DropDownBtn]
        ${text}    Get Text    ${options}[${i}]
        Run Keyword If   "${text}" == "${testData_config['Orders']['ViewOrders']['OrderStatus_Dropdown_Options']}[WaitingForDelivery_LblTxt]"
        ...    Click Element Until Visible    ${options}[${i}]
        Exit For Loop If    "${text}" == "${testData_config['Orders']['ViewOrders']['OrderStatus_Dropdown_Options']}[WaitingForDelivery_LblTxt]"
        Sleep    2s
        Click Element Until Visible      ${locators_params['Orders']['ViewOrders']}[OrderStatus_DropDownBtn]
    END
    Capture The Screen    Changed_OrderStatus_DD
    
Navigate to Home page from Hamburger menu list
    [Documentation]    Navigate to Home page from Hamburger menu list
    Click Element Until Visible    ${locators_params['Home']['Hamburger_MenuIcons']}[Hamburger_menu]
    Wait Until Element Is Visible    ${locators_params['Home']['Hamburger_MenuIcons']}[Home_Icon]
    Click Element Until Visible    ${locators_params['Home']['Hamburger_MenuIcons']}[Home_Icon]
    Verify The Title Of Home Page

Navigate to Home page menu list
    [Documentation]    Navigate to Home page menu list
    Wait Until Element Is Visible    ${locators_params['Home']}[Home_Icon]
    Click Element Until Visible  ${locators_params['Home']}[Home_Icon]
    Verify The Title Of Home Page