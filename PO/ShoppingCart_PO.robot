*** Settings ***
Library     SeleniumLibrary
Library     RequestsLibrary
Resource    ../Optimized_PO/CommonWrapper.robot
Resource    ../TestScripts/Base.robot

*** Keywords ***
Verify that all the shopping cart elements are visible
    [Documentation]     Verify that all the shopping cart elements are visible
    ${menuBar_Status}  Run Keyword And Return Status  Wait Until Element Is Visible    ${locators_params['Home']}[ShoppingCart_Icon]
    Run Keyword If    ${menuBar_Status} == False  Run Keywords  Click Element Until Visible    ${locators_params['Home']}[IconForward_Btn]
    ...    AND   Click Element Until Visible    ${locators_params['Home']}[ShoppingCart_Icon]
    ...    ELSE   Click Element Until Visible    ${locators_params['Home']}[ShoppingCart_Icon]
    @{ShoppingCart_elements}  Create List   ${locators_params['ShoppingCart']}[HeaderTxt]
    ...     ${locators_params['ShoppingCart']}[Table]
    ...     ${locators_params['ShoppingCart']}[Sno_Column]    ${locators_params['ShoppingCart']}[CartID_Column]
    ...     ${locators_params['ShoppingCart']}[CustomerName_Column]    ${locators_params['ShoppingCart']}[TotalQty_Column]
    ...     ${locators_params['ShoppingCart']}[TotalAmt_Column]    ${locators_params['ShoppingCart']}[Actions_Column]
    Wait Until Elements Are Visible  @{ShoppingCart_elements}
    Capture the Screen    ShoppingCart_elements
    Validation of the shopping cart table elements text

Validation of the shopping cart table elements text
    [Documentation]     Validation of the shopping cart table elements text
    @{ShoppingCart_elements}  Create List   ${locators_params['ShoppingCart']}[Sno_Column]    ${locators_params['ShoppingCart']}[CartID_Column]
    ...     ${locators_params['ShoppingCart']}[CustomerName_Column]    ${locators_params['ShoppingCart']}[TotalQty_Column]
    ...     ${locators_params['ShoppingCart']}[TotalAmt_Column]    ${locators_params['ShoppingCart']}[Actions_Column]
    @{ShoppingCart_elements_text}  Create List  ${testData_config['ShoppingCart']['Table']}[Sno_ColumnTxt]  ${testData_config['ShoppingCart']['Table']}[CartID_ColumnTxt]
    ...     ${testData_config['ShoppingCart']['Table']}[CustomerName_ColumnTxt]  ${testData_config['ShoppingCart']['Table']}[TotalQty_ColumnTxt]
    ...     ${testData_config['ShoppingCart']['Table']}[TotalAmt_ColumnTxt]  ${testData_config['ShoppingCart']['Table']}[Actions_ColumnTxt]
    Check all the get elements text are should be equal    ${ShoppingCart_elements}    ${ShoppingCart_elements_text}

Verify that make to order button is working in the shopping cart page
    [Documentation]     Verify that make to order button is working in the shopping cart page
    ${ShoppingCart_Data}  Call Method    ${API_POSLaundry}    getAPI_ShoppingCart_EndURL
    Log    ${ShoppingCart_Data}
    ${Cart_ID}  Set Variable   ${ShoppingCart_Data}[1]
    Run Keyword If    "${ShoppingCart_Data}[2]" == "True"  Validation of the make to order button  ${Cart_ID}
    ...  ELSE   Run Keywords  Verify the shopping cart table should be empty
    ...     AND  Verify user can add new order to shopping cart page
   
Verify the shopping cart table should be empty
    [Documentation]     Verify the shopping cart table should be empty
#    Page Should Contain    ${testData_config['Nodata']}[NoData_AvailableMsg]
    Log    In the Shopping Cart table is Empty
    Capture the Screen    Empty_ShoppingCart_Table

Verify user can add new order to shopping cart page
    [Documentation]     Verify user can add new order to shopping cart page
    Wait Until Element Is Visible    ${locators_params['Home']}[CreateNewOrder_Btn]
    Click Element Until Visible    ${locators_params['Home']}[CreateNewOrder_Btn]
    Wait Until Element Is Visible    ${locators_params['Home']['Category_Section']}[CategorySection_HeaderTxt]
    Verify the successfull message is visible when click the New Order button with selected atleast one product

Validation of the make to order button
    [Documentation]     Validation of the make to order button
    [Arguments]     ${Cart_ID}
    ${MakeToOrder_Btn}  Format String    ${locators_params['ShoppingCart']}[MakeToOrder_Btn]    value=${Cart_ID}
    Wait Until Element Is Visible    ${MakeToOrder_Btn}
    Click Element Until Visible    ${MakeToOrder_Btn}
    Capture the Screen    MakeTo_Order_Page
    Verify that all the shopping cart make to order page elements are visible

Verify that all the shopping cart make to order page elements are visible
    [Documentation]     Verify that all the shopping cart make to order page elements are visible
        @{TableHeader_Texts}    Create List    ${testData_config['Orders']['ViewOrders']['Table']}[SNo_ColumnHeaderTxt]  ${testData_config['Orders']['ViewOrders']['Table']}[ProductName_ColumnHeaderTxt]
    ...    ${testData_config['Orders']['ViewOrders']['Table']}[Amount_ColumnHeaderTxt]  ${testData_config['Orders']['ViewOrders']['Table']}[TotalQuantity_ColumnHeaderTxt]
    ...    ${testData_config['Orders']['ViewOrders']['Table']}[Total_ColumnHeaderTxt]
    Get text and Ensure the Headers are Equal  ${locators_params['Orders']['ViewOrders']}[tableHeaders_Txt]   @{TableHeader_Texts}
    Verify cart and price details section
    Verify customer details section
    Verify payment details section

Verify cart and price details section
    [Documentation]     Verify and validation of the Cart and Price details section elements and label text
    Verify cart and price details section elements are visible
    Validate the cart and price details section elements texts

Verify cart and price details section elements are visible
    [Documentation]     Verify cart and price details section elements are visible
    @{PriceDetails_Elements}  Create List   ${locators_params['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']}[CartID]
    ...     ${locators_params['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']}[Cart_DeleteBtn]   ${locators_params['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['PriceDetails']}[HeaderTxt]
    ...     ${locators_params['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['PriceDetails']}[Price_LblTxt]  ${locators_params['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['PriceDetails']}[Price_Value]
    ...     ${locators_params['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['PriceDetails']}[Discount_LblTxt]  ${locators_params['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['PriceDetails']}[Discount_Value]
    ...     ${locators_params['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['PriceDetails']}[DeliveryCharges_LblTxt]  ${locators_params['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['PriceDetails']}[DeliveryCharges_Value]
    ...     ${locators_params['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['PriceDetails']}[TotalPrice_LblTxt]  ${locators_params['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['PriceDetails']}[TotalPrice_Value]
    Wait Until Elements Are Visible     @{PriceDetails_Elements}

Validate the cart and price details section elements texts
    [Documentation]     Validate the cart and price details section elements texts
    ${ShoppingCart_Data}  Call Method    ${API_POSLaundry}    getAPI_ShoppingCart_EndURL
    ${CartID_Value}  Set Variable    ${ShoppingCart_Data}[1]
    ${product_count}  Get Element Count    ${locators_params['ShoppingCart']['MakeToOrder_CartDetails']}[Multiple_products]
    ${Price_lblTxt}  Set Variable   ${testData_config['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['PriceDetails']}[Price_LblTxt]
    @{LabelTxts}  Create List    ${testData_config['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']}[CartID]${CartID_Value}
    ...    ${testData_config['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['PriceDetails']}[HeaderTxt]
    ...    ${Price_lblTxt}    ${testData_config['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['PriceDetails']}[Discount_LblTxt]
    ...    ${testData_config['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['PriceDetails']}[DeliveryCharges_LblTxt]
    ...    ${testData_config['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['PriceDetails']}[TotalPrice_LblTxt]
    ...    ${testData_config['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['PriceDetails']}[Items_LblTxt]
    @{Elements}  Create List   ${locators_params['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']}[CartID]
    ...     ${locators_params['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['PriceDetails']}[HeaderTxt]   
    ...     ${locators_params['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['PriceDetails']}[Price_LblTxt]
    ...     ${locators_params['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['PriceDetails']}[Discount_LblTxt]   
    ...     ${locators_params['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['PriceDetails']}[DeliveryCharges_LblTxt]
    ...     ${locators_params['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['PriceDetails']}[TotalPrice_LblTxt]
    ...     ${locators_params['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['PriceDetails']}[Items_LblTxt]
    Check all the get elements text are should be equal    ${Elements}    ${LabelTxts}

Verify customer details section
    [Documentation]     Verify customer details section
    @{UnExpanded_CustomerDetails}  Create List     ${locators_params['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['CustomerDetails']}[HeaderTxt]
    ...     ${locators_params['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['CustomerDetails']}[Expand_Btn]
    Wait Until Elements Are Visible     @{UnExpanded_CustomerDetails}
    Verify expand customer details section
    Validate expand customer details elements text
    Click Element Until Enabled    ${locators_params['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['CustomerDetails']}[SelectCustomer_Btn]
    Verify the user able to add new customer in the customer details popup  ${locators_params['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['CustomerDetails']['SelectCustomer_Popup']}[AddCustomer_Btn]

Verify expand customer details section
    [Documentation]     Verify expand customer details section
    ${AddCustomerBtn_Status}  Run Keyword And Return Status    Wait Until Element Is Visible    ${locators_params['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['CustomerDetails']}[SelectCustomer_Btn]
    Run Keyword If    ${AddCustomerBtn_Status} == False
    ...    Click Element Until Visible    ${locators_params['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['CustomerDetails']}[Expand_Btn]
    Wait Until Element Is Visible    ${locators_params['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['CustomerDetails']}[SelectCustomer_Btn]
    @{Expanded_CustomerDetails}  Create List     ${locators_params['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['CustomerDetails']}[HeaderTxt]
    ...     ${locators_params['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['CustomerDetails']}[Expand_Btn]
    ...     ${locators_params['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['CustomerDetails']}[SelectCustomer_Btn]
    Wait Until Elements Are Visible     @{Expanded_CustomerDetails}
    
Validate expand customer details elements text
    [Documentation]     Validate expand customer details elements text
    @{Expanded_CustomerDetails}  Create List     ${locators_params['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['CustomerDetails']}[HeaderTxt]
    ...     ${locators_params['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['CustomerDetails']}[SelectCustomer_Btn]
    @{Expanded_CustomerDetails_LblTxts}  Create List     ${testData_config['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['CustomerDetails']}[HeaderTxt]
    ...     ${testData_config['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['CustomerDetails']}[SelectCustomer_Btn]
    Check all the get elements text are should be equal    ${Expanded_CustomerDetails}    ${Expanded_CustomerDetails_LblTxts}

Verify payment details section
    [Documentation]    Verify payment details section
    @{UnExpanded_PaymentDetails}  Create List     ${locators_params['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['PaymentDetails']}[HeaderTxt]
    ...     ${locators_params['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['PaymentDetails']}[Expand_Btn]
    Wait Until Elements Are Visible     @{UnExpanded_PaymentDetails}
    Capture The Screen    PaymentDetails_Section
    Verify expand payment details section
    Validate expand payment details elements text

Verify expand payment details section
    [Documentation]    Verify expand payment details section
    @{Expanded_PaymentMethods_Details_Elements}  Create List    ${locators_params['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['PaymentDetails']}[BuyOnCredit_lblTxt]
    ...    ${locators_params['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['PaymentDetails']}[BuyOnCredit_chkBox]
    ...    ${locators_params['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['PaymentDetails']}[CreditCard_lblTxt]
    ...    ${locators_params['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['PaymentDetails']}[CreditCard_ChkBox]
    ...    ${locators_params['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['PaymentDetails']}[Cash_lblTxt]
    ...    ${locators_params['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['PaymentDetails']}[Cash_ChkBox]
    ...    ${locators_params['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['PaymentDetails']}[Confirm_Btn]
    ${status}  Run Keyword And Return Status    Wait Until Elements Are Visible    @{Expanded_PaymentMethods_Details_Elements}
    Run Keyword If    ${status} == False    Click Element Until Visible    ${locators_params['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['CustomerDetails']}[Expand_Btn]
    ...    ELSE  Capture The Screen    Expanded_PaymentMethods_Details_Elements

Validate expand payment details elements text
    [Documentation]    Validate expand payment details elements text
    @{Expanded_PaymentMethods_Details_Elements}  Create List    ${locators_params['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['PaymentDetails']}[BuyOnCredit_lblTxt]
    ...    ${locators_params['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['PaymentDetails']}[CreditCard_lblTxt]
    ...    ${locators_params['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['PaymentDetails']}[Cash_lblTxt]
    ...    ${locators_params['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['PaymentDetails']}[Confirm_Btn]
    @{Expanded_PaymentMethods_Details_ElementTexts}  Create List    ${testData_config['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['PaymentDetails']}[BuyOnCredit_lblTxt]
    ...    ${testData_config['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['PaymentDetails']}[CreditCard_lblTxt]
    ...    ${testData_config['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['PaymentDetails']}[Cash_lblTxt]
    ...    ${testData_config['ShoppingCart']['MakeToOrder_CartDetails']['CartDetails']['PaymentDetails']}[Confirm_Btn]