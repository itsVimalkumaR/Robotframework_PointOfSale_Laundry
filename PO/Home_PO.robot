*** Settings ***
Library     SeleniumLibrary
Resource    ../Optimized_PO/CommonWrapper.robot
Resource    ../TestScripts/Base.robot

*** Keywords ***
Validate the home page elements
    [Documentation]  Validate the home page elements
    ${response}    Call Method    ${API_POSLaundry}    getAPI_profile
    ${organization_name}    Set Variable    ${response}[1]
    ${Hamburger_menu}  Run Keyword And Return Status    Wait Until Element Is Visible    ${locators_params['Home']['Hamburger_MenuIcons']}[Hamburger_menu]
    Run Keyword If    ${Hamburger_menu} == True    Run Keywords    Click Element Until Visible    ${locators_params['Home']['Hamburger_MenuIcons']}[Hamburger_menu]
    ...    AND   Validate all the Hamburger menu bar elements    ${organization_name}
    ...    ELSE   Validate all the menu bar elements    ${organization_name}
    @{HomePage_Elements}    create list  ${locators_params['Home']}[HomePage_Header]    ${locators_params['Home']['Profile']}[Dropdown_Btn]
    ...     ${locators_params['Home']['Order_Summary']}[NewOrder_Btn]  ${locators_params['Home']['Order_Summary']}[Checkout_Btn]
    Wait Until Elements Are Visible  @{HomePage_Elements}

Validate all the menu bar elements
    [Documentation]    Validate all the menu bar elements
    [Arguments]    ${organization_name}
    @{menu_lists}    Create List    ${locators_params['Home']}[BusinessProfile_Logo]   ${locators_params['Home']}[MenuLists_BusinessName]    ${locators_params['Home']}[Home_Icon]
    ...     ${locators_params['Home']}[DashBoard_Icon]    ${locators_params['Home']}[Orders_Icon]
    ...     ${locators_params['Home']}[Ledger_Icon]    ${locators_params['Home']}[Settings_Icon]
    ...     ${locators_params['Home']}[IconBackward_Btn]
    Wait Until Elements Are Visible  @{menu_lists}
    Capture The Screen    menu_lists
    Validate the menu bar elements label texts    ${organization_name}

Validate all the Hamburger menu bar elements
    [Documentation]    Validate all the Hamburger menu bar elements
    [Arguments]    ${organization_name}
    @{menu_lists}    Create List    ${locators_params['Home']['Hamburger_MenuIcons']}[BusinessProfile_Logo]   ${locators_params['Home']['Hamburger_MenuIcons']}[MenuLists_BusinessName]    ${locators_params['Home']['Hamburger_MenuIcons']}[Home_Icon]
    ...     ${locators_params['Home']['Hamburger_MenuIcons']}[DashBoard_Icon]    ${locators_params['Home']['Hamburger_MenuIcons']}[Orders_Icon]
    ...     ${locators_params['Home']['Hamburger_MenuIcons']}[Ledger_Icon]    ${locators_params['Home']['Hamburger_MenuIcons']}[Settings_Icon]
#    ...     ${locators_params['Home']['Hamburger_MenuIcons']}[IconForward_Btn]
    Wait Until Elements Are Visible  @{menu_lists}
    Capture The Screen    menu_lists
    Validate the Hamburger menu bar elements label texts    ${organization_name}

Validate the Hamburger menu bar elements label texts
    [Documentation]    Validate the Hamburger menu bar elements label texts
    [Arguments]    ${organization_name}
    @{menuLists_labelTexts_elements}    Create List    ${locators_params['Home']['Hamburger_MenuIcons']}[MenuLists_BusinessName]    ${locators_params['Home']['Hamburger_MenuIcons']}[HomeIcon_LblTxt]
    ...     ${locators_params['Home']['Hamburger_MenuIcons']}[DashBoardIcon_LblTxt]    ${locators_params['Home']['Hamburger_MenuIcons']}[OrdersIcon_LblTxt]
    ...     ${locators_params['Home']['Hamburger_MenuIcons']}[LedgerIcon_LblTxt]    ${locators_params['Home']['Hamburger_MenuIcons']}[SettingsIcon_LblTxt]
    @{menu_lists_label_texts}    Create List    ${organization_name}    ${testData_config['Home']}[HomeIcon_LblTxt]
    ...     ${testData_config['Home']}[DashBoardIcon_LblTxt]    ${testData_config['Home']}[OrdersIcon_LblTxt]
    ...     ${testData_config['Home']}[LedgerIcon_LblTxt]    ${testData_config['Home']}[SettingsIcon_LblTxt]
    Check All The Get Elements Text Are Should Be Equal    ${menuLists_labelTexts_elements}  ${menu_lists_label_texts}

Validate the menu bar elements label texts
    [Documentation]    Validate the menu bar elements label texts
    [Arguments]    ${organization_name}
    @{menuLists_labelTexts_elements}    Create List    ${locators_params['Home']}[MenuLists_BusinessName]    ${locators_params['Home']}[HomeIcon_LblTxt]
    ...     ${locators_params['Home']}[DashBoardIcon_LblTxt]    ${locators_params['Home']}[OrdersIcon_LblTxt]
    ...     ${locators_params['Home']}[LedgerIcon_LblTxt]    ${locators_params['Home']}[SettingsIcon_LblTxt]
    @{menu_lists_label_texts}    Create List    ${organization_name}    ${testData_config['Home']}[HomeIcon_LblTxt]
    ...     ${testData_config['Home']}[DashBoardIcon_LblTxt]    ${testData_config['Home']}[OrdersIcon_LblTxt]
    ...     ${testData_config['Home']}[LedgerIcon_LblTxt]    ${testData_config['Home']}[SettingsIcon_LblTxt]
    Check All The Get Elements Text Are Should Be Equal    ${menuLists_labelTexts_elements}  ${menu_lists_label_texts}
    
validation of the home category name
    [Documentation]  validation of the home category name
    ${response}  call method  ${API_POSLaundry}  getAPI_Category
    log  ${response}
    ${Product_response}  call method  ${API_POSLaundry}  getAPI_Product
    log  ${Product_response}
    @{products}    Convert To List    ${Product_response}
    ${Categories_Btn}  format string  ${locators_params['Home']['Category_Section']}[CategoryField]     value=1
    @{UI_Categories_Btns}       get webelements  ${locators_params['Home']['Category_Section']}[Categories_Fields]
    FOR  ${Categories_Btn}  IN  @{UI_Categories_Btns}
        ${Categories_BtnTxt}    get text    ${Categories_Btn}
        run keyword if  "${response}[2]" == "False"  Log  Category Name is not visible
        ...   ELSE  wait until element is visible  ${Categories_Btn}
        Click Element Until Visible    ${Categories_Btn}
        run keyword if  "${products}[2]" == "False"  Log  Product Name is not visible
        ...  Else  wait until element is visible  ${locators_params['Home']['Product_Section']}[ProductBtn]
    END

Verify that all the elements of category section are visible
    [Documentation]  Verify that all the elements of category section are visible
    wait until element is visible  ${locators_params['Home']['Category_Section']}[CategorySection_HeaderTxt]
    ${UI_CategoryHeader_lblTx}  get text  ${locators_params['Home']['Category_Section']}[CategorySection_HeaderTxt]
    should be equal  ${UI_CategoryHeader_lblTx}  ${testData_config['Home']['Category_Section']}[CategorySection_HeaderTxt]
    ${response}  call method  ${API_POSLaundry}  getAPI_Category
    log  ${response}
    ${Categories_Btn}  format string  ${locators_params['Home']['Category_Section']}[CategoryField]     value=1
    run keyword if  "${response}[1]" == "No Data"   wait until element is not visible  ${Categories_Btn}
    ...     ELSE    validation of the home category name

Verify that all the elements of order summary section are visible
    [Documentation]  Verify that all the elements of order summary section are visible
    @{OrderSummary_Elements}    create list  ${locators_params['Home']['Order_Summary']}[OrderSection_HeaderTxt]
    ...    ${locators_params['Home']['Order_Summary']}[SubTotal_lblTxt]  ${locators_params['Home']['Order_Summary']}[SubTotal_Value]
    ...    ${locators_params['Home']['Order_Summary']}[TotalQuantity_lblTxt]  ${locators_params['Home']['Order_Summary']}[TotalQuantity_Value]
    ...    ${locators_params['Home']['Order_Summary']}[Discount_LblTxt]  ${locators_params['Home']['Order_Summary']}[Discount_TxtBox]
    ...    ${locators_params['Home']['Order_Summary']}[Total_lblTxt]  ${locators_params['Home']['Order_Summary']}[Total_Value]
    Page Should Contain Multiple Element  @{OrderSummary_Elements}
    wait until element is visible  ${locators_params['Home']['Order_Summary']}[NewOrder_Btn]
    wait until element is visible  ${locators_params['Home']['Order_Summary']}[Checkout_Btn]
    capture the screen  HomePage_OrderSummary_Section
    Validation of the order summary section elements label texts

Validation of the order summary section elements label texts
    [Documentation]  Validation of the order summary section elements label texts
    @{OrderSummary_Elements}    create list  ${locators_params['Home']['Order_Summary']}[OrderScetion_HeaderTxt]
    ...    ${locators_params['Home']['Order_Summary']}[SubTotal_lblTxt]   ${locators_params['Home']['Order_Summary']}[TotalQuantity_lblTxt]
    ...    ${locators_params['Home']['Order_Summary']}[Discount_LblTxt]  ${locators_params['Home']['Order_Summary']}[Total_lblTxt]
    @{OrderSummary_TestData}    create list  ${testData_config['Home']['Order_Summary']}[OrderSection_HeaderTxt]
    ...     ${testData_config['Home']['Order_Summary']}[SubTotal_lblTxt]   ${testData_config['Home']['Order_Summary']}[TotalQuantity_lblTxt]
    ...     ${testData_config['Home']['Order_Summary']}[Discount_lblTxt]   ${testData_config['Home']['Order_Summary']}[Total_lblTxt]
    ${CountOf_elements}       Get Length   ${OrderSummary_Elements}
    FOR    ${i}    IN RANGE    0    ${CountOf_elements}
        ${lblTxt}   get text  ${OrderSummary_Elements}[${i}]
        should be equal  ${lblTxt}    ${OrderSummary_TestData}[${i}]
    END

### Products Status
Validate the products status
    [Documentation]    Validate the products status
    ${response}  Call Method    ${API_POSLaundry}    getAPI_Product
    ${Products_Status}    Set Variable    ${response}[2]
    Run Keyword If  ${Products_Status} == True   Verify and validate the Select Customer Popup

Verify and validate the Select Customer Popup
    [Documentation]    Verify and validate the Select Customer Popup
    ### Select Category Section
    Verify the all elements are visible in the select customer
    ### Enter Customer Details Popup
    Verify the Add customer button and Popup
    Verify the cancel button is working properly in the customer details popup
    Verify the user able to add new customer in the customer details popup  ${locators_params['Home']['SelectCustomer_Popup']}[AddCustomer_Btn]
    Verify the added customer is visible in the settings - customer page

    ### Customer Ledger Popup
    Verify customer ledger popup all elements are visible
    Verify the customer ledger popup cancel button
    Verify the customer ledger popup confirm button

    ### Product Details Popup
#    Navigate to the product details popup with select anyone customer    (No need to execute this keyword regrading ledger popup inserted)
    Verify the product details popup elements are visible
    Verify the back arrow button is working
    Verify the order confirm button is working

    ### Choose Payment Method Popup
    Verify that all elements are visible in the choose payment method popup
    Validate that all the payment method type  ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']}[BuyOnCredit_LblTxt]
    ...     ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']}[CreditCard_LblTxt]
    ...     ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']}[Cash_LblTxt]

### Select Category Section
Verify the all elements are visible in the select customer
    [Documentation]  Verify the all elements are visible in the select customer
    validation of the category section of elements
    Click Element Until Enabled   ${locators_params['Home']['Order_Summary']}[Checkout_Btn]
    page should contain  ${testData_config['Toast_Messages']}[ProductAdded_SuccessMsg]
    page should not contain  ${testData_config['Toast_Messages']}[WithoutSelect_productMsg]
    wait until element is visible  ${locators_params['Home']['SelectCustomer_Popup']}[AddCustomer_Btn]
    @{SelectCustomer_elements}  create list  ${locators_params['Home']['SelectCustomer_Popup']}[Header_Txt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']}[AddProduct_Btn]  ${locators_params['Home']['SelectCustomer_Popup']}[AddCustomer_Btn]
    ...     ${locators_params['Home']['SelectCustomer_Popup']}[SearchTxtBox_LblTxt]    ${locators_params['Home']['SelectCustomer_Popup']}[Search_TxtBox]
    ...     ${locators_params['Home']['SelectCustomer_Popup']}[Note_LblTx]  ${locators_params['Home']['SelectCustomer_Popup']}[CloseIcon]
    ...     ${locators_params['Home']['SelectCustomer_Popup']}[AddProduct_Btn]
    Wait Until Elements Are Visible     @{SelectCustomer_elements}
    Capture the screen  Select_Customer_Popup
    @{UI_SelectCustomerPopup_LabelTexts}  Create List    ${locators_params['Home']['SelectCustomer_Popup']}[Header_Txt]    
    ...    ${locators_params['Home']['SelectCustomer_Popup']}[AddProduct_Btn]
    ...    ${locators_params['Home']['SelectCustomer_Popup']}[AddCustomer_Btn]
    ...    ${locators_params['Home']['SelectCustomer_Popup']}[SearchTxtBox_LblTxt]
    ...    ${locators_params['Home']['SelectCustomer_Popup']}[Note_LblTx]
    @{SelectCustomerPopup_Texts}    Create List  ${testData_config['Home']['SelectCustomer_Popup']}[Header_Txt]
    ...    ${testData_config['Home']['SelectCustomer_Popup']}[AddProduct_Btn]
    ...    ${testData_config['Home']['SelectCustomer_Popup']}[AddCustomer_Btn]
    ...    ${testData_config['Home']['SelectCustomer_Popup']}[SearchTxtBox_LblTxt]
    ...    ${testData_config['Home']['SelectCustomer_Popup']}[Note_LblTx]
    Check All The Get Elements Text Are Should Be Equal    ${UI_SelectCustomerPopup_LabelTexts}    ${SelectCustomerPopup_Texts}

verify the exist customer
    [Documentation]  verify the exist customer
    ${response}  Call Method    ${API_POSLaundry}    getAPI_Customer
    Log    ${response}
    @{data}  Check the phone numbers are available in customer    ${response}
    ${phoneNo}  Set Variable    ${data}[0]
    ${BackIcon_status}  run keyword and return status  wait until element is visible  ${locators_params['Home']['SelectCustomer_Popup']['Product_Details']}[Back_Btn]
    run keyword if  ${BackIcon_status} == True   Click Element Until Visible  ${locators_params['Home']['SelectCustomer_Popup']['Product_Details']}[Back_Btn]
    sleep  2s
    ${CloseIcon_status}  run keyword and return status  wait until element is visible  ${locators_params['Home']['SelectCustomer_Popup']}[CloseIcon]
    run keyword if  ${CloseIcon_status} == True   Click Element Until Visible  ${locators_params['Home']['SelectCustomer_Popup']}[CloseIcon]
    sleep  2s
    ${CancelBtn_status}  run keyword and return status  wait until element is visible  ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[Cancel_Btn]
    run keyword if  ${CancelBtn_status} == True  run keywords  Click Element Until Enabled  ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[Cancel_Btn]
    ...     AND  Click Element Until Visible  ${locators_params['Home']['SelectCustomer_Popup']}[CloseIcon]
    sleep  2s
    ${CancelBtn_status}  run keyword and return status  wait until element is visible  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[Cancel_Btn]
    run keyword if  ${CancelBtn_status} == True   Click Element Until Visible  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[Cancel_Btn]
    ...     ELSE   To Reload the Current page
    sleep  2s
    capture the screen  Exist
    sleep  2s
    ${response}  Call Method    ${API_POSLaundry}    getAPI_Customer
    @{data}  Check the phone numbers are available in customer    ${response}
    ${phone_number}  Set Variable    ${data}[0]
#    ${count}    Get Length    ${phone_number}
    ${menu_status}    run keyword and return status  Wait Until Element Is Visible    ${locators _params['Home']}[Settings_Icon]
    run keyword if  ${menu_status} == False    Run Keywords    View the menu bar icons list
    ...    AND     Click Element Until Visible    ${locators_params['Home']['Hamburger_MenuIcons']}[Settings_Icon]
    ...    ELSE    Click Element Until Visible  ${locators _params['Home']}[Settings_Icon]
    Click Element Until Visible  ${locators_params['Settings']['Customer']}[Customer_TabBtn]
#    FOR    ${i}    IN RANGE   ${count}-1   ${count}
        click and input the value    ${locators_params['Settings']['Customer']}[Search_PhoneNo_TxtBox]    ${phone_number}
        ${Searched_Customer}  format string  ${locators_params['Settings']['Customer']}[Searched_PhoneNo]   value=${phone_number}
        ${SearchedCustomer_DeleteBtn}  format string  ${locators_params['Settings']['Customer']}[SearchedCustomer_DeleteBtn]   value=${phone_number}
        ${StatusOf_ExistCustomer}  run keyword and return status  wait until element is visible  ${Searched_Customer}
        run keyword if  '${StatusOf_ExistCustomer}' == 'True'   Delete the customer  ${SearchedCustomer_DeleteBtn}     ${phone_number}    ${Searched_Customer}
        ...   ELSE  wait until element is not visible  ${Searched_Customer}
        sleep  3s
        click and input the value    ${locators_params['Settings']['Customer']}[Search_PhoneNo_TxtBox]    ${phone_number}
        wait until element is not visible  ${Searched_Customer}
        capture the screen   Deleted_Customer_00
        Click And Clear Element Text    ${locators_params['Settings']['Customer']}[Search_PhoneNo_TxtBox]
#    END

View the menu bar icons list
    [Documentation]    View the menu bar icons list
    ${response}    Call Method    ${API_POSLaundry}    getAPI_profile
    ${organization_name}    Set Variable    ${response}[1]
    ${Hamburger_menu}  Run Keyword And Return Status    Wait Until Element Is Visible    ${locators_params['Home']['Hamburger_MenuIcons']}[Hamburger_menu]
    Run Keyword If    ${Hamburger_menu} == True    Run Keywords    Click Element Until Visible    ${locators_params['Home']['Hamburger_MenuIcons']}[Hamburger_menu]
    ...    AND   Validate all the Hamburger menu bar elements    ${organization_name}
    ...    ELSE   Validate all the menu bar elements    ${organization_name}
    Capture The Screen    menu_lists

Check the phone numbers are available in customer
    [Arguments]    ${response}
    @{data}    Create List
    ${PhoneNo_Status}    Set Variable    ${response}[3]
    ${PhoneNumbers}    Set Variable    ${response}[4]
    ${random_phone_no}    Generate Random String    8    0123456789
    Run Keyword If    "${PhoneNo_Status}" == "True"    Append To List    ${data}    ${PhoneNumbers}[0]
    ...    ELSE   Append To List    ${data}    ${random_phone_no}
    ${name_Status}    Set Variable    ${response}[1]
    ${names}    Set Variable    ${response}[2]
    ${random_name}  Generate random string without special character
    Run Keyword If    "${name_Status}" == "True"    Append To List    ${data}    ${names}[0]
    ...    ELSE   Append To List    ${data}    ${random_name}
    RETURN    @{data}

Validate the exist customers
    [Documentation]    Validate the exist customers
    [Arguments]  ${phone_number}  ${name}
    ${Added_NewCustomer}  format string  ${locators_params['Home']['SelectCustomer_Popup']}[AddedCustomer_loc]   value=${phone_number}
    ${existCustomer_status}  run keyword and return status  wait until element is visible  ${Added_NewCustomer}
    run keyword if  ${existCustomer_status} == True   run keywords  verify the exist customer
    ...     AND     Navigate to the select customer popup
    ...     ELSE  log  The Exist Customer is not present in the list

Verify the Add customer button and Popup
    [Documentation]  Verify the Add customer button and Popup
    ${response}  Call Method    ${API_POSLaundry}    getAPI_Customer
    @{data}  Check the phone numbers are available in customer    ${response}
    ${phone_number}  Set Variable    ${data}[0]
    ${names}  Set Variable    ${data}[1]
    ${count}    get length  ${phone_number}
    run keyword if  ${count} > 1    Validate the exist customers    ${phone_number}  ${names}
    ...     ELSE    log    No Exist customers is not available
    wait until element is visible  ${locators_params['Home']['SelectCustomer_Popup']}[AddCustomer_Btn]
    Click Element Until Enabled  ${locators_params['Home']['SelectCustomer_Popup']}[AddCustomer_Btn]
    @{CustomerDetails_elements}  create list  ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[Header_LblTxt]
    ...   ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[Name_lblTxt]  ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[Name_TxtBox]
    ...   ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[PhoneNo_lblTxt]  ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[PhoneNo_TxtBox]
    ...   ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[Email_lblTxt]  ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[Email_TxtBox]
    ...   ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']['Address']}[Address_lblTxt]  ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']['Address']}[Street_Village_LblTxt]
    ...   ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']['Address']}[Street_Village_TxtBox]  ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']['Address']}[District_State_LblTxt]
    ...   ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']['Address']}[District_State_TxtBox]  ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']['Address']}[Pincode_Zipcode_LblTxt]
    ...   ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']['Address']}[Pincode_Zipcode_TxtBox]    ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[Cancel_Btn]
    ...   ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[AddCustomer_Btn]
    Wait Until Elements Are Visible     @{CustomerDetails_elements}
    Capture the screen  Add_Customer_Popup_Visible
    Validate the add customer popup elements texts

Validate the add customer popup elements texts
    [Documentation]  Validate the add customer popup elements texts
    @{Elements}  create list  ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[Header_LblTxt]
    ...   ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[Name_lblTxt]
    ...   ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[PhoneNo_lblTxt]
    ...   ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[Email_lblTxt]
    ...   ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']['Address']}[Address_lblTxt]  
    ...   ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']['Address']}[Street_Village_LblTxt]
    ...   ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']['Address']}[District_State_LblTxt]
    ...   ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']['Address']}[Pincode_Zipcode_LblTxt]
    ...   ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[Cancel_Btn]
    ...   ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[AddCustomer_Btn]
    @{LabelTxts}  create list  ${testData_config['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[Header_LblTxt]
    ...  ${testData_config['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[Name_lblTxt]
    ...  ${testData_config['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[PhoneNo_lblTxt]
    ...  ${testData_config['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[Email_lblTxt]
    ...  ${testData_config['Home']['SelectCustomer_Popup']['AddCustomer_Popup']['Address']}[Address_lblTxt]
    ...  ${testData_config['Home']['SelectCustomer_Popup']['AddCustomer_Popup']['Address']}[Street_Village_LblTxt]
    ...  ${testData_config['Home']['SelectCustomer_Popup']['AddCustomer_Popup']['Address']}[District_State_LblTxt]
    ...  ${testData_config['Home']['SelectCustomer_Popup']['AddCustomer_Popup']['Address']}[Pincode_Zipcode_LblTxt]
    ...  ${testData_config['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[Cancel_Btn]
    ...  ${testData_config['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[AddCustomer_Btn]
    Check all the get elements text are should be equal  ${Elements}  ${LabelTxts}

Verify the cancel button is working properly in the customer details popup
    [Documentation]  Verify the cancel button is working properly in the customer details popup
    Click Element Until Enabled    ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[Cancel_Btn]
    @{CustomerDetails_elements}  create list  ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[Header_LblTxt]
    ...   ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[Name_lblTxt]  ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[Name_TxtBox]
    ...   ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[PhoneNo_lblTxt]  ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[PhoneNo_TxtBox]
    ...   ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[Email_lblTxt]  ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[Email_TxtBox]
    ...   ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']['Address']}[Address_lblTxt]  ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']['Address']}[Street_Village_LblTxt]
    ...   ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']['Address']}[Street_Village_TxtBox]  ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']['Address']}[District_State_LblTxt]
    ...   ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']['Address']}[District_State_TxtBox]  ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']['Address']}[Pincode_Zipcode_LblTxt]
    ...   ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']['Address']}[Pincode_Zipcode_TxtBox]    ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[Cancel_Btn]
    ...   ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[AddCustomer_Btn]
    Elements Should not Visible  @{CustomerDetails_elements}
    Capture the screen  AddCustomer_Popup_NotVisible

Verify the user able to add new customer in the customer details popup
    [Documentation]  Verify the user able to add new customer in the customer details popup
    [Arguments]    ${AddCustomer_Btn}
    ${name}  Verify the special characters are not allowed in name toast message is appeared
    ${email}    Verify the phone number already exists error message is appeared
    Verify the email already exists error message is appeared    ${email}
    wait until element is not visible  ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[Email_ExistMsg]
    Click Element Until Enabled  ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[AddCustomer_Btn]
    page should contain  ${testData_config['Toast_Messages']}[CustomerAdded_SuccessMsg]
    Wait Until Element Is Visible    ${AddCustomer_Btn}
    capture the screen  Added_NewCustomer
    ${Added_NewCustomer}  format string  ${locators_params['Home']['SelectCustomer_Popup']}[AddedCustomer_loc]   value=${name}
    wait until element is visible  ${Added_NewCustomer}
    
Verify the special characters are not allowed in name toast message is appeared
    wait until element is visible  ${locators_params['Home']['SelectCustomer_Popup']}[AddCustomer_Btn]
    Click Element Until Enabled  ${locators_params['Home']['SelectCustomer_Popup']}[AddCustomer_Btn]
    Capture The Screen    Select Customer Popup
    ${response}  Call Method    ${API_POSLaundry}    getAPI_Customer
    @{data}  Check the customers details are available    ${response}
    ${phoneNo}  Set Variable    ${data}[0]
    ${email}  Set Variable    ${data}[1]
    ${random_string}=    Generate random string with special character
    ${name}  Set Variable    ${testData_config['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[Name]${random_string}
    @{Input_Elements}  create list  ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[Name_TxtBox]
    ...   ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[PhoneNo_TxtBox]
    ...   ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[Email_TxtBox]
    ...   ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']['Address']}[Street_Village_TxtBox]
    ...   ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']['Address']}[District_State_TxtBox]
    ...   ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']['Address']}[Pincode_Zipcode_TxtBox]
    @{Input_Values}  create list  ${name}  ${phoneNo}  ${email}
    ...  ${testData_config['Home']['SelectCustomer_Popup']['AddCustomer_Popup']['Address']}[Street_Village_InputValue]
    ...  ${testData_config['Home']['SelectCustomer_Popup']['AddCustomer_Popup']['Address']}[District_State_InputValue]
    ...  ${testData_config['Home']['SelectCustomer_Popup']['AddCustomer_Popup']['Address']}[Pincode_Zipcode_InputValue]
    Enter multiple value in the inputfields   ${Input_Elements}  ${Input_Values}
    Click Element Until Enabled  ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[AddCustomer_Btn]
    Page Should Contain    ${testData_config['Toast_Messages']}[SpecialCharNotAllow_ErrMsg]
    Sleep    5s
    Click And Clear Element Text    ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[Name_TxtBox]
    ${random_name}  Generate random string without special character
    Click And Input The Value    ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[Name_TxtBox]    ${random_name}
#    Click Element Until Enabled  ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[AddCustomer_Btn]
    capture the screen  Added_NewCustomer
    RETURN    ${random_name}

Check the customers details are available
    [Arguments]    ${response}
    @{data}    Create List    
    ${PhoneNo_Status}    Set Variable    ${response}[3]
    ${PhoneNumbers}    Set Variable    ${response}[4]
    ${random_phone_no}    Generate Random String    8    0123456789
    Run Keyword If    "${PhoneNo_Status}" == "True"    Append To List    ${data}    ${PhoneNumbers}[0]
    ...    ELSE   Append To List    ${data}    ${random_phone_no}
    ${Email_Status}    Set Variable    ${response}[6]
    ${Emails}    Set Variable    ${response}[5]
    ${random_email}    Generate Random Email
    Run Keyword If    "${Email_Status}" == "True"    Append To List    ${data}    ${Emails}[0]
    ...    ELSE   Append To List    ${data}    ${random_email}
    ${Emails_Status}    Set Variable    ${response}[3]
    ${Emails}    Set Variable    ${response}[4]
    ${random_name}    Generate random string with special character
    Run Keyword If    "${Emails_Status}" == "True"    Append To List    ${data}    ${Emails}[0]
    ...    ELSE   Append To List    ${data}    ${random_name}
    RETURN    @{data}
    
Verify the phone number already exists error message is appeared
    [Documentation]    Verify the phone number already exists error message is appeared
    ${response}  Call Method    ${API_POSLaundry}    getAPI_Customer
    @{data}  Check the customers details are available    ${response}
    ${phoneNo}  Set Variable    ${data}[0]
    ${email}  Set Variable    ${data}[1]
    ${name}    Set Variable    ${data}[2]
    ${add_customer_popup}    Run Keyword And Return Status    wait until element is visible  ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[Header_LblTxt]
    Run Keyword If    ${add_customer_popup} == False    Navigate To The enter customer details Popup    ${name}  ${phoneNo}  ${email}
    Click Element Until Enabled  ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[AddCustomer_Btn]
    wait until element is visible  ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[PhoneNo_ExistMsg]
    ${Random_PhoneNo}    Generate Random String    8    0123456789
    Validate the exist phone no error message  ${Random_PhoneNo}
    wait until element is not visible  ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[PhoneNo_ExistMsg]
    Click Element Until Enabled  ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[AddCustomer_Btn]
    Capture The Screen    Exist_PhoneNum_ErrMsg_Status
    RETURN    ${email}
    
Navigate To The enter customer details Popup
    [Documentation]    Navigate To The enter customer details Popup
    [Arguments]    ${name}  ${phoneNo}  ${email}
    wait until element is visible  ${locators_params['Home']['SelectCustomer_Popup']}[AddCustomer_Btn]
    Click Element Until Enabled  ${locators_params['Home']['SelectCustomer_Popup']}[AddCustomer_Btn]
    @{Input_Elements}  create list  ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[Name_TxtBox]
    ...   ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[PhoneNo_TxtBox]
    ...   ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[Email_TxtBox]
    @{Input_Values}  create list  ${name}  ${phoneNo}  ${email}
    Enter multiple value in the inputfields   ${Input_Elements}  ${Input_Values}

Validate the exist phone no error message
    [Documentation]  Validate the exist phone no error message
    [Arguments]    ${Random_PhoneNo} 
    ${exist_phoneNoMsg}  get text  ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[PhoneNo_ExistMsg]
    should be equal  ${testData_config['Toast_Messages']}[ExistPhoneNo_ErrMsg]  ${exist_phoneNoMsg}
    Click and clear element text    ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[PhoneNo_TxtBox]
    click and input the value   ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[PhoneNo_TxtBox]  ${Random_PhoneNo}
    Capture The Screen    Edit_PhoneNumTxtbox

Verify the email already exists error message is appeared
    [Documentation]    Verify the email already exists error message is appeared
    [Arguments]    ${exist_email}
    ${response}  Call Method    ${API_POSLaundry}    getAPI_Customer
    @{data}  Check the customers details are available    ${response}
    ${phoneNo}  Set Variable    ${data}[0]
    ${email}  Set Variable    ${data}[1]
    ${name}    Set Variable    ${data}[2]
    Should Be Equal    ${exist_email}    ${email}
    ${Status}    Run Keyword And Return Status    wait until element is visible  ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[Email_ExistMsg]
    Run Keyword If    ${Status} == False  Navigate to the Add customer popup    ${exist_email}
    Validate the exist email error message
    Capture The Screen    Exist_EmailID_ErrMsg_Status

Navigate to the Add customer popup
    [Documentation]    Navigate to the Add customer popup
    [Arguments]    ${email}
    wait until element is visible  ${locators_params['Home']['SelectCustomer_Popup']}[AddCustomer_Btn]
    Click Element Until Enabled  ${locators_params['Home']['SelectCustomer_Popup']}[AddCustomer_Btn]
    ${email}    Generate Random Email
    ${random_string}=    Generate random string with special character
    ${name}  Set Variable    ${testData_config['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[Name]${random_string}
    @{Input_Elements}  create list  ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[Name_TxtBox]
    ...   ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[PhoneNo_TxtBox]
    ...   ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[Email_TxtBox]
    ...   ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']['Address']}[Street_Village_TxtBox]
    ...   ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']['Address']}[District_State_TxtBox]
    ...   ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']['Address']}[Pincode_Zipcode_TxtBox]
    @{Input_Values}  create list  ${name}
    ...  ${testData_config['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[PhoneNo]
    ...  ${testData_config['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[Email]
    ...  ${testData_config['Home']['SelectCustomer_Popup']['AddCustomer_Popup']['Address']}[Street_Village_InputValue]
    ...  ${testData_config['Home']['SelectCustomer_Popup']['AddCustomer_Popup']['Address']}[District_State_InputValue]
    ...  ${testData_config['Home']['SelectCustomer_Popup']['AddCustomer_Popup']['Address']}[Pincode_Zipcode_InputValue]
    Enter multiple value in the inputfields   ${Input_Elements}  ${Input_Values}
    Click Element Until Enabled  ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[AddCustomer_Btn]

Validate the exist email error message
    [Documentation]  Validate the exist email error message
    ${exist_EmailMsg}  get text  ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[Email_ExistMsg]
#    should be equal  ${testData_config['Toast_Messages']}[Exist_Email_Msg]  ${exist_EmailMsg}
    ${email_ID}    Generate Random Email ID
    Click and clear element text    ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[Email_TxtBox]
    click and input the value   ${locators_params['Home']['SelectCustomer_Popup']['AddCustomer_Popup']}[Email_TxtBox]  ${email_ID}
    Capture The Screen    Edit_PhoneNumTxtbox

Verify the added customer is visible in the settings - customer page
    [Documentation]  Verify the added customer is visible in the settings - customer page
    ${CloseIcon_status}  run keyword and return status  wait until element is visible  ${locators_params['Home']['SelectCustomer_Popup']}[CloseIcon]
    run keyword if  ${CloseIcon_status} == True   Click Element Until Visible  ${locators_params['Home']['SelectCustomer_Popup']}[CloseIcon]
    capture the screen  Exist
    sleep  2s
    ${Hamburger_menu}  Run Keyword And Return Status    Wait Until Element Is Visible    ${locators_params['Home']['Hamburger_MenuIcons']}[Hamburger_menu]
    Run Keyword If    ${Hamburger_menu} == True    Run Keywords    Navigate to Settings page from Hamburger menu list
    ...    ELSE   Navigate to Settings page menu list
    Click Element Until Visible  ${locators_params['Settings']['Customer']}[Customer_TabBtn]
    ${response}  Call Method    ${API_POSLaundry}    getAPI_Customer
    ${Phonenumbers}    Set Variable    ${response}[4]
    click and input the value    ${locators_params['Settings']['Customer']}[Search_PhoneNo_TxtBox]    ${Phonenumbers}[1]
    ${Searched_Customer}  format string  ${locators_params['Settings']['Customer']}[Searched_PhoneNo]   value=${Phonenumbers}[1]
    wait until element is visible  ${Searched_Customer}
    capture the screen  AddedCustomer_Visible_InSettings

### Product Details Popup
Verify the product details popup elements are visible
    [Documentation]  Verify the product details popup elements are visible
    ${response}  Call Method    ${API_POSLaundry}    getAPI_Customer
    ${names}    Set Variable    ${response}[2]
    ${phoneNumbers}    Set Variable    ${response}[4]
    @{ProductDetails_elements}  create list  ${locators_params['Home']['SelectCustomer_Popup']['Product_Details']}[Back_Btn]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Product_Details']}[HeaderTxt]     ${locators_params['Home']['SelectCustomer_Popup']['Product_Details']}[CustomerName_lblTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Product_Details']}[PhoneNumber_lblTxt]     ${locators_params['Home']['SelectCustomer_Popup']['Product_Details']}[Table_loc]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Product_Details']}[TotalAmount_lblTxt]     ${locators_params['Home']['SelectCustomer_Popup']['Product_Details']}[OrderConfirm_Btn]
    wait until elements are visible  @{ProductDetails_elements}
    @{Product_Details_elements}  create list     ${locators_params['Home']['SelectCustomer_Popup']['Product_Details']}[HeaderTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Product_Details']}[CustomerName_lblTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Product_Details']}[PhoneNumber_lblTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Product_Details']}[TotalAmount_lblTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Product_Details']}[OrderConfirm_Btn]
    @{ProductDetails_Txts}  create list  ${testData_config['Home']['SelectCustomer_Popup']['Product_Details']}[HeaderTxt]
    ...     ${testData_config['Home']['SelectCustomer_Popup']['Product_Details']}[CustomerName_lblTxt]
    ...     ${testData_config['Home']['SelectCustomer_Popup']['Product_Details']}[PhoneNumber_lblTxt]
    ...     ${testData_config['Home']['SelectCustomer_Popup']['Product_Details']}[TotalAmount_lblTxt]
    ...     ${testData_config['Home']['SelectCustomer_Popup']['Product_Details']}[OrderConfirm_Btn]
    Check all the get elements text are should contain  ${Product_Details_elements}  ${ProductDetails_Txts}
#    ${UI_CustomerName}  get text  ${locators_params['Home']['SelectCustomer_Popup']['Product_Details']}[CustomerName_value]
#    should contain  ${UI_CustomerName}  ${names}[1]
#    ${UI_PhoneNumber}  get text  ${locators_params['Home']['SelectCustomer_Popup']['Product_Details']}[PhoneNumber_value]
#    should contain  ${UI_PhoneNumber}    ${phoneNumbers}[1]
    capture the screen  ProductDetails_Popup

Verify the back arrow button is working
    [Documentation]  Verify the back arrow button is working
    wait until element is visible  ${locators_params['Home']['SelectCustomer_Popup']['Product_Details']}[Back_Btn]
    Click Element Until Visible  ${locators_params['Home']['SelectCustomer_Popup']['Product_Details']}[Back_Btn]
    wait until element is visible  ${locators_params['Home']['SelectCustomer_Popup']}[AddCustomer_Btn]
    ${response}  Call Method    ${API_POSLaundry}    getAPI_Customer
    ${customerNames}  Set Variable    ${response}[2]
    ${count}  Get Length    ${customerNames}
    ${index} =    Evaluate  ${count}-1
    ${Customer_name} =   Evaluate  "${customerNames}[${index}]"
    ${Added_NewCustomer}  format string  ${locators_params['Home']['SelectCustomer_Popup']}[AddedCustomer_loc]   value=${Customer_name}
    wait until element is visible  ${Added_NewCustomer}
    Click Element Until Visible  ${Added_NewCustomer}
    Wait Until Element Is Visible    ${locators_params['Home']['SelectCustomer_Popup']['CustomerLedger_Popup']}[Confirm_Btn]
    Click Element Until Enabled    ${locators_params['Home']['SelectCustomer_Popup']['CustomerLedger_Popup']}[Confirm_Btn]

Verify the order confirm button is working
    [Documentation]  Verify the order confirm button is working
    wait until element is visible  ${locators_params['Home']['SelectCustomer_Popup']['Product_Details']}[OrderConfirm_Btn]
    Click Element Until Visible  ${locators_params['Home']['SelectCustomer_Popup']['Product_Details']}[OrderConfirm_Btn]
    wait until element is visible  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']}[HeaderTxt]

Verify that all elements are visible in the choose payment method popup
    [Documentation]  Verify that all elements are visible in the choose payment method popup
    @{ChoosePaymentMethod_elements}  create list  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']}[HeaderTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']}[BuyOnCredit_Img]  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']}[BuyOnCredit_LblTxt]
#    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']}[CreditCard_Img]   ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']}[CreditCard_LblTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']}[Cash_Img]   ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']}[Cash_LblTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']}[CloseIcon]
    wait until elements are visible  @{ChoosePaymentMethod_elements}
    capture the screen  ChoosePaymentMethodPopup
    @{Elements_PaymentTypes}  create list  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']}[HeaderTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']}[BuyOnCredit_LblTxt]
#    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']}[CreditCard_LblTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']}[Cash_LblTxt]
    @{PaymentMethods_lblTxts}  create list  ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']}[HeaderTxt]
    ...     ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']}[BuyOnCredit_LblTxt]
#    ...     ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']}[CreditCard_LblTxt]
    ...     ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']}[Cash_LblTxt]
    Check all the get elements text are should be equal  ${Elements_PaymentTypes}  ${PaymentMethods_lblTxts}

### Choose Payment Method
Validate that all the payment method type
    [Documentation]  Validate that all the payment method type
    [Arguments]  ${BuyOnCredit}   ${CreditCard}   ${Cash}
    ${response}  Call Method    ${API_POSLaundry}    getAPI_Customer
    ${PhoneNumbers}    Set Variable    ${response}[4]
    ${PhNo_count}    Get Length    ${PhoneNumbers}
    ${PhNo_Index}    Evaluate    ${PhNo_count}-1
    ${Names}    Set Variable    ${response}[2]
    ${count}  Get Length    ${Names}
    ${index} =    Evaluate  ${count}-1
    ${name} =   Evaluate  "${Names}[${index}]"
    @{PaymentMethods}  create list  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']}[BuyOnCredit_LblTxt]
#    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']}[CreditCard_LblTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']}[Cash_LblTxt]
    @{PaymentMethods_lblTxt}=    create list
    ${CountOfElements}=    Get Length    ${PaymentMethods}
    FOR    ${i}  IN RANGE    0     ${CountOfElements}
        ${LblTxt}=    get text    ${PaymentMethods}[${i}]
        append to list    ${PaymentMethods_lblTxt}    ${LblTxt}
    END
    log  ${PaymentMethods_lblTxt}
    FOR  ${PaymentMode}  IN  @{PaymentMethods_lblTxt}
        run keyword if  '${PaymentMode}' == '${BuyOnCredit}'   Validation of the buy on credit mode  ${PhoneNumbers}[${PhNo_Index}]  ${name}
#        ...  ELSE IF  '${PaymentMode}' == '${CreditCard}'   Validation of the credit card mode  ${PhoneNumbers}[${PhNo_Index}]
        ...  ELSE IF  '${PaymentMode}' == '${Cash}'   Validation of the cash mode  ${PhoneNumbers}[${PhNo_Index}]  ${name}
    END

        ### Buy On Credit
Validation of the buy on credit mode
    [Documentation]  Validation of the buy on credit mode
    [Arguments]  ${PhoneNumber}  ${name}
    ${CustomerName_loc}  Format String    ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[CustomerName]  value=${name}
    Click Element Until Visible  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']}[BuyOnCredit_Img]
    ${date} =	Get Current Date
    sleep  5s
    @{BuyOnCredit_PaymentSummary_elements}  create list  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[BackArrow_Btn]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[CloseIcon]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[HeaderTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[Add_Product_Btn]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[Customer_logo]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[SelectedCustomer_lblTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[PaymentMethod_lblTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[PaymentMethodOf_BuyOnCredit_text]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[CustomerName_lblTxt]
    ...     ${CustomerName_loc}
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[OrderDate_lblTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[OrderTime_lblTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[OutstandingBalance_LblTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[OutstandingBalance_CashImg]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[OutstandingBalance_Value]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[OrderPrice_lblTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[OrderPrice_CashImg]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[OrderPrice_Value]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[Discount_lblTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[Discount_CashImg]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[Discount_Value]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[FinalAmount_lblTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[FinalAmount_CashImg]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[FinalAmount_Value]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[Total_lblTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[Total_CashImg]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[Total_Value]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[Cancel_Btn]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[Complete_Btn]
    wait until elements are visible  @{BuyOnCredit_PaymentSummary_elements}
    capture the screen  BuyOnCredit_Paymentummary_elements
    validate the buy on credit payment summary elements texts
    Click Element Until Visible  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[BackArrow_Btn]
    wait until element is visible  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']}[BuyOnCredit_Img]
    Click Element Until Visible  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']}[BuyOnCredit_Img]
    sleep  5s
    Validate the buy on credit payment summary cancel button
    Navigate to the product details popup with select anyone customer    ${PhoneNumber}
    Verify the customer ledger popup confirm button
    Verify the order confirm button is working
    Click Element Until Visible  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']}[BuyOnCredit_Img]
    sleep  2s
    Validate the buy on credit payment summary complete button
    Verify that all elements are visible in the success popup  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']}[BuyOnCredit_Img]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[Complete_Btn]    ${PhoneNumber}

validate the buy on credit payment summary elements texts
    [Documentation]  validate the buy on credit payment summary elements texts
    @{BuyOnCredit_PaymentummaryElements}  create list  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[HeaderTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[Add_Product_Btn]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[SelectedCustomer_lblTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[PaymentMethod_lblTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[PaymentMethodOf_BuyOnCredit_text]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[CustomerName_lblTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[OrderDate_lblTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[OrderTime_lblTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[OutstandingBalance_LblTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[OutstandingBalance_Value]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[OrderPrice_lblTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[OrderPrice_Value]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[Discount_lblTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[Discount_Value]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[FinalAmount_lblTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[FinalAmount_Value]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[Total_lblTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[Total_Value]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[Cancel_Btn]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[Complete_Btn]
    @{BuyOnCredit_PaymentummaryLblTxt}  create list  ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSummary']}[HeaderTxt]
    ...     ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSummary']}[Add_Product_Btn]
    ...     ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSummary']}[SelectedCustomer_lblTxt]
    ...     ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSummary']}[PaymentMethod_lblTxt]
    ...     ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSummary']}[BuyOnCredit_OfPayment_LblTxt]
    ...     ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSummary']}[CustomerName_lblTxt]
    ...     ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSummary']}[OrderDate_lblTxt]
    ...     ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSummary']}[OrderTime_lblTxt]
    ...     ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSummary']}[OutstandingBalance_LblTxt]
    ...     ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSummary']}[AmountType]
    ...     ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSummary']}[OrderAmount_LblTxt]
    ...     ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSummary']}[AmountType]
    ...     ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSummary']}[Discount_lblTxt]
    ...     ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSummary']}[AmountType]
    ...     ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSummary']}[FinalAmount_lblTxt]
    ...     ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSummary']}[AmountType]
    ...     ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSummary']}[Total_lblTxt]
    ...     ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSummary']}[AmountType]
    ...     ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSummary']}[Cancel_Btn]
    ...     ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSummary']}[Complete_Btn]
    Check all the get elements text are should contain     ${BuyOnCredit_PaymentummaryElements}  ${BuyOnCredit_PaymentummaryLblTxt}

Validate the buy on credit payment summary cancel button
    [Documentation]  Validate the buy on credit payment summary cancel button
    wait until element is visible  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[Cancel_Btn]
    Click Element Until Visible  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[Cancel_Btn]
    sleep  2s
    wait until element is visible  ${locators_params['Home']['Order_Summary']}[Checkout_Btn]

Validate the buy on credit payment summary complete button
    [Documentation]  Validate the buy on credit payment summary complete button
    wait until element is visible  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[Complete_Btn]
    Click Element Until Visible  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['BuyOnCredit_PaymentSummary']}[Complete_Btn]
    sleep  5s
#    wait until element is visible  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSuccess_Popup']}[PrintReceipt_Btn]        # Regarding this button is hidden for dev

    ### Credit Card
Validation of the credit card mode
    [Documentation]  Validation of the credit card mode
    [Arguments]  ${PhoneNumber}
    Navigate to the product details popup with select anyone customer    ${PhoneNumber}
    Verify the customer ledger popup confirm button
    Verify the order confirm button is working
    Click Element Until Visible  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']}[CreditCard_Img]
    sleep  5s
    @{CreditCard_Paymentummary_elements}  create list  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CreditCard_PaymentSummary']}[Pay_Btn]
    wait until elements are visible  @{CreditCard_Paymentummary_elements}
    capture the screen  CreditCard_Paymentummary_elements
    To Reload the Current page

        ######## Below line command regrading Not delovep the credit card section  ########
#    validate the buy on credit card payment summary elements texts
#    Click Element Until Visible  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CreditCard_PaymentSummary']}[BackArrow_Btn]
#    wait until element is visible  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']}[CreditCard_Img]
#    Click Element Until Visible  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']}[CreditCard_Img]
#    sleep  5s
#    Validate the credit card payment summary cancel button
#    Navigate to the product details popup with select anyone customer
#    Verify the customer ledger popup confirm button
#    Verify the order confirm button is working
#    Click Element Until Visible  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']}[CreditCard_Img]
#    sleep  2s
#    Validate the credit card payment summary complete button
#    Verify that all elements are visible in the success popup  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']}[CreditCard_Img]

    #### Cash Method
Validation of the cash mode
    [Documentation]  Validation of the cash mode
    [Arguments]  ${PhoneNumber}  ${name}
    ${CustomerName_loc}  Format String    ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[CustomerName]  value=${name}
    Navigate to the product details popup with select anyone customer    ${PhoneNumber}
    Verify the customer ledger popup confirm button
    Verify the order confirm button is working
    Click Element Until Visible  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']}[Cash_Img]
    sleep  5s
    @{Cash_Paymentummary_elements}  create list  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[BackArrow_Btn]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[CloseIcon]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[HeaderTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[Add_Product_Btn]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[Customer_logo]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[SelectedCustomer_lblTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[PaymentMethod_lblTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[PaymentMethodOf_Cash_text]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[CustomerName_lblTxt]
    ...     ${CustomerName_loc}
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[OrderDate_lblTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[OrderTime_lblTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[Outstanding_balance_checkbox]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[OutstandingBalance_LblTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[OutstandingBalance_CashImg]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[OutstandingBalance_Value]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[OrderAmount_LblTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[OrderAmount_CashImg]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[OrderAmount_Value]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[Discount_lblTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[Discount_CashImg]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[Discount_Value]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[FinalAmount_lblTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[FinalAmount_CashImg]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[FinalAmount_Value]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[ReceivedAmount_lblTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[ReceivedAmount_CashImg]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[ReceivedAmount_InputBox]   # regarding newly add the input filed for received amount
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[ReceivedAmount_PaymentTypeTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[RemainingAmount_lblTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[RemainingAmount_CashImg]
#    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[RemainingAmount_TxtBox]     # regarding changed the input filed for received amount
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[RemainingAmount_Value]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[Cancel_Btn]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[Complete_Btn]
    wait until elements are visible  @{Cash_Paymentummary_elements}
    capture the screen  Cash_Paymentummary_elements
    validate the cash payment summary elements texts
    Click Element Until Visible  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[BackArrow_Btn]
    wait until element is visible  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']}[Cash_Img]
    Click Element Until Visible  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']}[Cash_Img]
    sleep  5s
    Validate the cash payment summary cancel button
    Navigate to the product details popup with select anyone customer    ${PhoneNumber}
    Verify the customer ledger popup confirm button
    Verify the order confirm button is working
    Click Element Until Visible  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']}[Cash_Img]
    sleep  2s
    Validate the cash payment summary complete button
    Verify that all elements are visible in the success popup  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']}[Cash_Img]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[Complete_Btn]    ${PhoneNumber}

validate the cash payment summary elements texts
    [Documentation]  validate the cash payment summary elements texts
    @{Cash_PaymentummaryElements}  create list  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[HeaderTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[Add_Product_Btn]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[SelectedCustomer_lblTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[PaymentMethod_lblTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[PaymentMethodOf_Cash_text]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[CustomerName_lblTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[OrderDate_lblTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[OrderTime_lblTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[OutstandingBalance_LblTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[OutstandingBalance_Value]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[OrderAmount_LblTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[OrderAmount_Value]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[Discount_lblTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[Discount_Value]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[FinalAmount_lblTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[FinalAmount_Value]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[ReceivedAmount_lblTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[ReceivedAmount_PaymentTypeTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[RemainingAmount_lblTxt]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[RemainingAmount_Value]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[Cancel_Btn]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[Complete_Btn]
    @{Cash_PaymentummaryLblTxt}  create list  ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSummary']}[HeaderTxt]
    ...     ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSummary']}[Add_Product_Btn]
    ...     ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSummary']}[SelectedCustomer_lblTxt]
    ...     ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSummary']}[PaymentMethod_lblTxt]
    ...     ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSummary']}[Cash_OfPayment_LblTxt]
    ...     ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSummary']}[CustomerName_lblTxt]
    ...     ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSummary']}[OrderDate_lblTxt]
    ...     ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSummary']}[OrderTime_lblTxt]
    ...     ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSummary']}[OutstandingBalance_LblTxt]
    ...     ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSummary']}[AmountType]
    ...     ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSummary']}[OrderAmount_LblTxt]
    ...     ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSummary']}[AmountType]
    ...     ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSummary']}[Discount_lblTxt]
    ...     ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSummary']}[AmountType]
    ...     ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSummary']}[BuyOnCredit_FinalAmount_lblTxt]
    ...     ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSummary']}[AmountType]
    ...     ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSummary']}[ReceivedAmount_lblTxt]
    ...     ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSummary']}[AmountType]
    ...     ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSummary']}[RemainingAmount_lblTxt]
    ...     ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSummary']}[AmountType]
    ...     ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSummary']}[Cancel_Btn]
    ...     ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSummary']}[Complete_Btn]
    Check all the get elements text are should contain     ${Cash_PaymentummaryElements}  ${Cash_PaymentummaryLblTxt}

Validate the cash payment summary cancel button
    [Documentation]  Validate the cash payment summary cancel button
    wait until element is visible  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[Cancel_Btn]
    Click Element Until Visible  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[Cancel_Btn]
    sleep  2s
    wait until element is visible  ${locators_params['Home']['Order_Summary']}[Checkout_Btn]

Validate the cash payment summary complete button
    [Documentation]  Validate the cash payment summary complete button
    wait until element is visible  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[Complete_Btn]
    Click Element Until Visible  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['CashPaymentSummary']}[Complete_Btn]
    sleep  2s
#    wait until element is visible  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSuccess_Popup']}[PrintReceipt_Btn]        # Regarding this button is hidden for dev

############# Common Keywords for Home page ##################
Navigate to orders page from Hamburger menu list
    [Documentation]    Navigate to orders page from Hamburger menu list

Navigate to the select customer popup
    [Documentation]  Navigate to the select customer popup
    ${Hamburger_menu}  Run Keyword And Return Status    Wait Until Element Is Visible    ${locators_params['Home']['Hamburger_MenuIcons']}[Hamburger_menu]
    Run Keyword If    ${Hamburger_menu} == True    Run Keywords    Navigate To Home Page From Hamburger Menu List
    ...    ELSE   Navigate to Home page menu list
    sleep  5s
#    To Reload the Current page
    ${Categories_Btn}  format string  ${locators_params['Home']['Category_Section']}[CategoryField]     value=1
    sleep  2s
    wait until element is visible  ${Categories_Btn}
    Click Element Until Visible    ${Categories_Btn}
    Click Element Until Visible    ${locators_params['Home']['Product_Section']}[ProductBtn]
    Click Element Until Enabled   ${locators_params['Home']['Order_Summary']}[Checkout_Btn]
    page should contain  ${testData_config['Toast_Messages']}[ProductAdded_SuccessMsg]

Navigate to the product details popup with select anyone customer
    [Documentation]  Navigate to the product details popup with select anyone customer
    [Arguments]    ${PhoneNumber}
    Reload Page
    Navigate to the select customer popup
    wait until element is visible  ${locators_params['Home']['SelectCustomer_Popup']}[AddCustomer_Btn]
    ${Added_NewCustomer}  format string  ${locators_params['Home']['SelectCustomer_Popup']}[AddedCustomer_loc]   value=${PhoneNumber}
    wait until element is visible  ${Added_NewCustomer}
    Click Element Until Visible  ${Added_NewCustomer}
    Capture The Screen    ProductPopup

Verify that all elements are visible in the success popup
    [Documentation]  Verify that all elements are visible in the success popup
    [Arguments]  ${TypeOf_PaymentMode_loc}  ${CompleteBtn_loc}    ${PhoneNumber}
    wait until element is visible  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSuccess_Popup']}[Img]
    @{SuccessPopup_elements}  create list   ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSuccess_Popup']}[Msg_lblTxt]
#    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSuccess_Popup']}[PrintReceipt_Btn]        # Regarding this button is hidden for dev
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSuccess_Popup']}[SendMail_Btn]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSuccess_Popup']}[SendMsg_Btn]
    ...     ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSuccess_Popup']}[Done_Btn]
    wait until elements are visible  @{SuccessPopup_elements}
    capture the screen  PaymentSuccessPopup
    @{PaymentSuccessPopup_lblTxt}   create list  ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSuccess_Popup']}[SuccessMsg_lblTxt]
#    ...     ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSuccess_Popup']}[PrintReceipt_BtnTxt]        # Regarding this button is hidden for dev
    ...     ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSuccess_Popup']}[SendMail_Btn]
    ...     ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSuccess_Popup']}[SendMsg_Btn]
    ...     ${testData_config['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSuccess_Popup']}[Done_Btn]
    Check all the get elements text are should be equal  ${SuccessPopup_elements}  ${PaymentSuccessPopup_lblTxt}
#    Verify the print receipt button is working        # Regarding this button is hidden for dev
    Verify the send email button is working  ${TypeOf_PaymentMode_loc}  ${CompleteBtn_loc}    ${PhoneNumber}
    Verify the send message button is working  ${TypeOf_PaymentMode_loc}  ${CompleteBtn_loc}    ${PhoneNumber}
    Verify the done button is working  ${TypeOf_PaymentMode_loc}  ${CompleteBtn_loc}    ${PhoneNumber}

Verify the print receipt button is working
    [Documentation]  Verify the print receipt button is working
    wait until element is visible  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSuccess_Popup']}[PrintReceipt_Btn]
    click element until enabled  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSuccess_Popup']}[PrintReceipt_Btn]
    Go Back

Verify the send email button is working
    [Documentation]  Verify the send email button is working
    [Arguments]  ${TypeOf_PaymentMode_loc}  ${CompleteBtn_loc}    ${PhoneNumber}
    Navigate to the product details popup with select anyone customer    ${PhoneNumber}
    Verify the customer ledger popup confirm button
    Verify the order confirm button is working
    Click Element Until Visible  ${TypeOf_PaymentMode_loc}
    sleep  2s
    wait until element is visible  ${CompleteBtn_loc}
    Click Element Until Visible  ${CompleteBtn_loc}
    sleep  2s
#    wait until element is visible  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSuccess_Popup']}[PrintReceipt_Btn]        # Regarding this button is hidden for dev
    wait until element is visible  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSuccess_Popup']}[SendMail_Btn]
    click element until enabled  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSuccess_Popup']}[SendMail_Btn]
    page should contain  ${testData_config['Toast_Messages']}[SendEmail_Waiting_ResponseMsg]
    page should contain  ${testData_config['Toast_Messages']}[SendEmail_SuccessMsg]
    Capture the screen  DoneMsg
    Go Back

Verify the send message button is working
    [Documentation]  Verify the send message button is working
    [Arguments]  ${TypeOf_PaymentMode_loc}  ${CompleteBtn_loc}    ${PhoneNumber}
    Navigate to the product details popup with select anyone customer    ${PhoneNumber}
    Verify the customer ledger popup confirm button
    Verify the order confirm button is working
    Click Element Until Visible  ${TypeOf_PaymentMode_loc}
    sleep  2s
    wait until element is visible  ${CompleteBtn_loc}
    Click Element Until Visible  ${CompleteBtn_loc}
    sleep  2s
#    wait until element is visible  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSuccess_Popup']}[PrintReceipt_Btn]        # Regarding this button is hidden for dev
    wait until element is visible  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSuccess_Popup']}[SendMsg_Btn]
    click element until enabled  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSuccess_Popup']}[SendMsg_Btn]
    page should contain  ${testData_config['Toast_Messages']}[SendMsg_SuccessMsg]
    Capture the screen  DoneMsg
    Go Back

Verify the done button is working
    [Documentation]  Verify the done button is working
    [Arguments]  ${TypeOf_PaymentMode_loc}  ${CompleteBtn_loc}    ${PhoneNumber}
    Navigate to the product details popup with select anyone customer    ${PhoneNumber}
    Verify the customer ledger popup confirm button
    Verify the order confirm button is working
    Click Element Until Visible  ${TypeOf_PaymentMode_loc}
    sleep  2s
    wait until element is visible  ${CompleteBtn_loc}
    Click Element Until Visible  ${CompleteBtn_loc}
    sleep  2s
#    wait until element is visible  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSuccess_Popup']}[PrintReceipt_Btn]        # Regarding this button is hidden for dev
    wait until element is visible  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSuccess_Popup']}[Done_Btn]
    click element until enabled  ${locators_params['Home']['SelectCustomer_Popup']['Choose_PaymentMethod']['PaymentSuccess_Popup']}[Done_Btn]
    page should contain  ${testData_config['Toast_Messages']}[OrderTaken_Msg]
    Capture the screen  DoneMsg
    Sleep    2s
    Capture The Screen    Print_Receipt_Copy
    Go Back

Delete the customer
    [Documentation]  Delete the customer
    [Arguments]    ${SearchedCustomer_DeleteBtn}     ${Phonenumber}    ${Searched_Customer}
    wait until element is visible  ${SearchedCustomer_DeleteBtn}
    Click Element Until Visible  ${SearchedCustomer_DeleteBtn}
    @{DeleteCustomerPopup_elements}  create list  ${locators_params['Settings']['Customer']['DeleteCustomer_popup']}[HeaderTxt]
    ...     ${locators_params['Settings']['Customer']['DeleteCustomer_popup']}[Delete_CustomerName]
    ...     ${locators_params['Settings']['Customer']['DeleteCustomer_popup']}[Cancel_Btn]
    ...     ${locators_params['Settings']['Customer']['DeleteCustomer_popup']}[Confirm_Btn]
    wait until elements are visible  @{DeleteCustomerPopup_elements}
    capture the screen  DeleteCustomer_Popup
    Click Element Until Enabled  ${locators_params['Settings']['Customer']['DeleteCustomer_popup']}[Confirm_Btn]
    sleep  3s
    Click and clear element text    ${locators_params['Settings']['Customer']}[Search_PhoneNo_TxtBox]
    click and input the value    ${locators_params['Settings']['Customer']}[Search_PhoneNo_TxtBox]    ${Phonenumber}
    wait until element is not visible  ${Searched_Customer}
    capture the screen   Deleted_Customer

#### Customer Ledger Popup
Verify customer ledger popup all elements are visible
    [Documentation]    Verify customer ledger popup all elements are visible
    Navigate to the select customer popup
    Capture The Screen    SelectCustomer_pp
    wait until element is visible  ${locators_params['Home']['SelectCustomer_Popup']}[AddCustomer_Btn]
    sleep    5s
    ${response}  Call Method    ${API_POSLaundry}    getAPI_Customer
    ${Phonenumbers}    Set Variable    ${response}[4]
    ${Added_NewCustomer}  format string  ${locators_params['Home']['SelectCustomer_Popup']}[AddedCustomer_loc]   value=${Phonenumbers}[1]
    wait until element is visible  ${Added_NewCustomer}
    Click Element Until Visible  ${Added_NewCustomer}
    @{CustomerLedger_elements}    Create List    ${locators_params['Home']['SelectCustomer_Popup']['CustomerLedger_Popup']}[Header_LblTxt]
    ...    ${locators_params['Home']['SelectCustomer_Popup']['CustomerLedger_Popup']}[Name_LblTxt]  ${locators_params['Home']['SelectCustomer_Popup']['CustomerLedger_Popup']}[Name_ValueTxt]
    ...    ${locators_params['Home']['SelectCustomer_Popup']['CustomerLedger_Popup']}[RemainingBalance_LblTxt]  ${locators_params['Home']['SelectCustomer_Popup']['CustomerLedger_Popup']}[RemainingBalance_ValueTxt]
    ...    ${locators_params['Home']['SelectCustomer_Popup']['CustomerLedger_Popup']}[Cancel_Btn]  ${locators_params['Home']['SelectCustomer_Popup']['CustomerLedger_Popup']}[Confirm_Btn]
    Wait Until Elements Are Visible    @{CustomerLedger_elements}
    Capture The Screen    LedgerPopup
    Validate the customer ledger popup elements label texts

Validate the customer ledger popup elements label texts
    [Documentation]    Validate the customer ledger popup elements label texts
    @{CustomerLedger_elements}    Create List    ${locators_params['Home']['SelectCustomer_Popup']['CustomerLedger_Popup']}[Header_LblTxt]
    ...    ${locators_params['Home']['SelectCustomer_Popup']['CustomerLedger_Popup']}[Name_LblTxt]  ${locators_params['Home']['SelectCustomer_Popup']['CustomerLedger_Popup']}[RemainingBalance_LblTxt]
    ...    ${locators_params['Home']['SelectCustomer_Popup']['CustomerLedger_Popup']}[Cancel_Btn]  ${locators_params['Home']['SelectCustomer_Popup']['CustomerLedger_Popup']}[Confirm_Btn]
    @{CustomerLedger_LblTexts}    Create List    ${testData_config['Home']['SelectCustomer_Popup']['CustomerLedger_Popup']}[Header_LblTxt]
    ...    ${testData_config['Home']['SelectCustomer_Popup']['CustomerLedger_Popup']}[Name_LblTxt]  ${testData_config['Home']['SelectCustomer_Popup']['CustomerLedger_Popup']}[RemainingBalance_LblTxt]
    ...    ${testData_config['Home']['SelectCustomer_Popup']['CustomerLedger_Popup']}[Cancel_Btn]  ${testData_config['Home']['SelectCustomer_Popup']['CustomerLedger_Popup']}[Confirm_Btn]
    Check All The Get Elements Text Are Should Be Equal    ${CustomerLedger_elements}  ${CustomerLedger_LblTexts}

Verify the customer ledger popup cancel button
    [Documentation]    Verify the customer ledger popup cancel button
    Element Should Be Enabled    ${locators_params['Home']['SelectCustomer_Popup']['CustomerLedger_Popup']}[Cancel_Btn]
    Click Element Until Enabled    ${locators_params['Home']['SelectCustomer_Popup']['CustomerLedger_Popup']}[Cancel_Btn]
    Wait Until Element Is Visible    ${locators_params['Home']['SelectCustomer_Popup']}[AddCustomer_Btn]
    ${response}  Call Method    ${API_POSLaundry}    getAPI_Customer
    ${PhoneNumbers}    Set Variable    ${response}[4]
    ${Added_NewCustomer}  format string  ${locators_params['Home']['SelectCustomer_Popup']}[AddedCustomer_loc]   value=${PhoneNumbers}[1]
    wait until element is visible  ${Added_NewCustomer}
    Click Element Until Visible  ${Added_NewCustomer}

Verify the customer ledger popup confirm button
    [Documentation]    Verify the customer ledger popup confirm button
    Wait Until Element Is Visible    ${locators_params['Home']['SelectCustomer_Popup']['CustomerLedger_Popup']}[Header_LblTxt]
    Element Should Be Enabled    ${locators_params['Home']['SelectCustomer_Popup']['CustomerLedger_Popup']}[Confirm_Btn]
    Click Element Until Enabled    ${locators_params['Home']['SelectCustomer_Popup']['CustomerLedger_Popup']}[Confirm_Btn]
    Capture The Screen    ProductDetails_PP
    Wait Until Element Is Visible    ${locators_params['Home']['SelectCustomer_Popup']['Product_Details']}[HeaderTxt]