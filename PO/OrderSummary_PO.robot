*** Settings ***
Library     SeleniumLibrary
Library     RequestsLibrary
Resource    ../Optimized_PO/CommonWrapper.robot
Resource    ../TestScripts/Base.robot

*** Keywords ***
Verify the order summary section elements are visible
    [Documentation]  Verify the order summary section elements are visible
    Go Back
    @{OrderSummary_elements}  create list  ${locators_params['Home']['Order_Summary']}[OrderSection_HeaderTxt]
    ...     ${locators_params['Home']['Order_Summary']}[SubTotal_lblTxt]  ${locators_params['Home']['Order_Summary']}[SubTotal_Value]
    ...     ${locators_params['Home']['Order_Summary']}[TotalQuantity_lblTxt]  ${locators_params['Home']['Order_Summary']}[TotalQuantity_Value]
    ...     ${locators_params['Home']['Order_Summary']}[Discount_LblTxt]  ${locators_params['Home']['Order_Summary']}[Discount_TxtBox]
    ...     ${locators_params['Home']['Order_Summary']}[Total_lblTxt]  ${locators_params['Home']['Order_Summary']}[Total_Value]
    ...     ${locators_params['Home']['Order_Summary']}[NewOrder_Btn]  ${locators_params['Home']['Order_Summary']}[Checkout_Btn]
    Wait Until Elements Are Visible  @{OrderSummary_elements}
    Validate the order summary page elements label texts
    
Validate the order summary page elements label texts
    [Documentation]    Validate the order summary page elements label texts
     @{UI_LblTexts}  create list  ${locators_params['Home']['Order_Summary']}[SubTotal_Value]
    ...     ${locators_params['Home']['Order_Summary']}[TotalQuantity_Value]  ${locators_params['Home']['Order_Summary']}[Total_Value]
    @{OrderSummary_elements}    Create List    ${locators_params['Home']['Order_Summary']}[OrderSection_HeaderTxt]
    ...     ${locators_params['Home']['Order_Summary']}[SubTotal_lblTxt]  ${locators_params['Home']['Order_Summary']}[TotalQuantity_lblTxt]
    ...     ${locators_params['Home']['Order_Summary']}[Discount_LblTxt]  ${locators_params['Home']['Order_Summary']}[Total_lblTxt]
    ...     ${locators_params['Home']['Order_Summary']}[NewOrder_Btn]  ${locators_params['Home']['Order_Summary']}[Checkout_Btn]
    ...     ${locators_params['Home']['Order_Summary']}[SubTotal_Value]  ${locators_params['Home']['Order_Summary']}[TotalQuantity_Value]
    ...     ${locators_params['Home']['Order_Summary']}[Total_Value]
    @{UI_OrderSummary_lblTexts}  create list  ${testData_config['Home']['Order_Summary']}[OrderSection_HeaderTxt]
    ...     ${testData_config['Home']['Order_Summary']}[SubTotal_lblTxt]  ${testData_config['Home']['Order_Summary']}[TotalQuantity_lblTxt]
    ...     ${testData_config['Home']['Order_Summary']}[Discount_lblTxt]  ${testData_config['Home']['Order_Summary']}[Total_lblTxt]
    ...     ${testData_config['Home']['Order_Summary']}[NewOrder_Btn]  ${testData_config['Home']['Order_Summary']}[Checkout_Btn]
    FOR    ${element}  IN    @{UI_LblTexts}
        ${text}    Get Text    ${element}
        ${ele}  Remove String  ${text}    ,    :${SPACE}
        Append To List  ${UI_OrderSummary_lblTexts}  ${ele}
    END
    Check all the get elements text are should be equal  ${OrderSummary_elements}  ${UI_OrderSummary_lblTexts}

Verify the selected product is visible in the order summary section
    [Documentation]  Verify the selected product is visible in the order summary section
    ${response}  call method  ${API_POSLaundry}  getAPI_Category
    log  ${response}
    run keyword if  "${response}[1]" == "No Data"   log   Categories is not added
    ...     ELSE    verify the products are visible

verify the products are visible
    [Documentation]  verify the products are visible
    ${response}  call method  ${API_POSLaundry}  getAPI_Product
    log  ${response}
    run keyword if  "${response}[2]" == "False"   log   Products is not added
    ...     ELSE    validation of the category section of elements

Verify the increase and decrease the quantity value of selected product in the order summary section
    [Documentation]  Verify the increase and decrease the quantity value of selected product in the order summary section
    ${response}  call method  ${API_POSLaundry}  getAPI_Product
    log  ${response}
    run keyword if  "${response}[2]" == "False"   log   Products is not added
    ...     ELSE   Validate the increase and decrease button

Scroll element if that element is hidden
    [Documentation]    Scroll element if that element is hidden
    [Arguments]    @{SelectedProduct_details}
    FOR   ${locator}   IN    @{SelectedProduct_details}
      ${status}    Run Keyword And Return Status    Wait Until Element Is Visible  ${locator}     timeout=${timeout}
      WHILE    ${status} != True
        Click Element Until Visible    //*[@id="order_details"]
        Click Element Until Visible    ${locators_params['Home']['Order_Summary']}[SelectedProduct_PriceTxt]
        Press Key    //*[@id="order_details"]    ARROW_DOWN
        Capture The Screen    demo
        ${status}    Run Keyword And Return Status    Wait Until Element Is Visible  ${locator}     timeout=${timeout}
      END
      Wait Until Element Is Visible    ${locator}
    END
    
Validate the increase and decrease button
    [Documentation]  Validate the increase and decrease button
    @{Product_Tiles}  get webelements  ${locators_params['Home']['Product_Section']}[ProductBtns_Name]
    FOR  ${Product_Tile}  IN  @{Product_Tiles}
        ${Selected_ProductName}  get text  ${Product_Tile}
        ${Added_ProductName_Loc}  format string  ${locators_params['Home']['Order_Summary']}[AddedProduct_Name]  value=${Selected_ProductName}
        ${Added_ProductDeleteBtn_Loc}  format string  ${locators_params['Home']['Order_Summary']}[AddedProduct_DeleteBtn]  value=${Selected_ProductName}
        ${Added_Product_DecreaseBtn_Loc}  format string  ${locators_params['Home']['Order_Summary']}[AddedProduct_DecreaseBtn]  value=${Selected_ProductName}
        ${Added_Product_IncreaseBtn_Loc}  format string  ${locators_params['Home']['Order_Summary']}[AddedProduct_IncreaseBtn]  value=${Selected_ProductName}
        ${Added_Product_Count_Loc}  format string  ${locators_params['Home']['Order_Summary']}[AddedProduct_Count]  value=${Selected_ProductName}
        @{SelectedProduct_details}  create list  ${Added_ProductName_Loc}  ${Added_ProductDeleteBtn_Loc}
        ...   ${Added_Product_DecreaseBtn_Loc}  ${Added_Product_IncreaseBtn_Loc}  ${Added_Product_Count_Loc}
        Scroll element if that element is hidden  @{SelectedProduct_details}
        ${Before_IncreaseAndDecrease}  get text  ${Added_Product_Count_Loc}
        Click Element Until Visible    ${Added_Product_IncreaseBtn_Loc}
        ${After_Increase}  get text  ${Added_Product_Count_Loc}
        should not be equal  ${Before_IncreaseAndDecrease}  ${After_Increase}
        Click Element Until Visible    ${Added_Product_DecreaseBtn_Loc}
        ${After_Decrease}  get text  ${Added_Product_Count_Loc}
        should be equal  ${Before_IncreaseAndDecrease}  ${After_Decrease}
        ${random_string}=    Generate Random String    5    [NUMBERS]_[UPPERCASE]_[LOWERCASE]
        capture the screen   IncreaseDecrease_${random_string}
    END

Verify the selected product delete button is visible and working properly in the order summary section
    [Documentation]  Verify the selected product delete button is visible and working properly in the order summary section
    @{Product_Delete_Btns}  get webelements  ${locators_params['Home']['Product_Section']}[Product_DeleteBtns]
    FOR  ${Product_Delete_Btn}  IN  @{Product_Delete_Btns}
#        ${Selected_ProductName}  get text  ${Product_Delete_Btn}
#        ${Added_ProductDelete_Btn}  format string  ${locators_params['Home']['Order_Summary']}[AddedProduct_DeleteBtn]  value=${Selected_ProductName}
        wait until element is visible  ${Product_Delete_Btn}
        click element until visible  ${Product_Delete_Btn}
        ${random_string}=    Generate Random String    5    [NUMBERS]_[UPPERCASE]_[LOWERCASE]
        capture the screen   OrderSummary_DeleteBtn_${random_string}
#        wait until element is not visible  ${Product_Delete_Btn}
    END

Verify and validate the discount field
    [Documentation]    Verify and validate the discount field
    ${UI_subtotal_value}    Get Text    ${locators_params['Home']['Order_Summary']}[SubTotal_Value]
    Log To Console    ${UI_subtotal_value}
    ${UI_TotalQuantity_value}    Get Text    ${locators_params['Home']['Order_Summary']}[TotalQuantity_Value]
    Log To Console    ${UI_TotalQuantity_value}
    ${UI_Total_value}    Get Text    ${locators_params['Home']['Order_Summary']}[Total_Value]
    Log To Console    ${UI_Total_value}
    Should Be Equal    ${UI_subtotal_value}    ${UI_Total_value}
    Wait Until Element Is Visible    ${locators_params['Home']['Order_Summary']}[Discount_LblTxt]
    ${discount_Lbltext}    Get Text    ${locators_params['Home']['Order_Summary']}[Discount_LblTxt]
    Should Be Equal    ${discount_Lbltext}    ${testData_config['Home']['Order_Summary']}[Discount_lblTxt]
    Wait Until Element Is Visible    ${locators_params['Home']['Order_Summary']}[Discount_TxtBox]
    ${value}    Generate Random String    1    0123456789
    ${random_decimal}  Evaluate    float(str(${value}) + ".")
    ${before_discount_value}  Get Element Attribute    ${locators_params['Home']['Order_Summary']}[Discount_TxtBox]    value
    JS Click Element    ${locators_params['Home']['Order_Summary']}[Discount_TxtBox]
    Wait Until Element Is Visible    css=input.discount_type    10s
    Click Element    css=input.discount_type
    Input Text    css=input.discount_type    ${random_decimal}
    Capture The Screen    discount_entered
    ${ele}  Remove Unwanted Characters from the price value    ${UI_subtotal_value}
    ${total_incl_discount_value}    Evaluate    ${ele}-${random_decimal}
    Should Not Be Equal    ${UI_subtotal_value}    ${total_incl_discount_value}
    Should Not Be Equal    ${total_incl_discount_value}    ${UI_Total_value}
    ${UI_Total_value_with_discount}    Get Text    ${locators_params['Home']['Order_Summary']}[Total_Value]
    Log To Console    ${UI_Total_value_with_discount}
    ${UI_Total_value_discount}  Remove Unwanted Characters from the price value    ${UI_Total_value_with_discount}
    ${UI_Total_value_discount_str}  Convert To String    ${UI_Total_value_discount}
    ${total_incl_discount_value_str}  Convert To String    ${total_incl_discount_value}
    Should Contain    ${UI_Total_value_discount_str}    ${total_incl_discount_value_str}
    Capture The Screen    Discount_textbox1
    
### Checkout Button ###
Verify the checkout button is visible in the order summary
    [Documentation]  Verify the checkout button is visible in the order summary
    Reload Page
    wait until element is visible   ${locators_params['Home']['Order_Summary']}[Checkout_Btn]
    Capture The Screen    CheckOut_Btn
    ${UI_Checkout_BtnTxt}  get text  ${locators_params['Home']['Order_Summary']}[Checkout_Btn]
    should be equal  ${UI_Checkout_BtnTxt}  ${testData_config['Home']['Order_Summary']}[Checkout_Btn]

Verify the warning message is visible when click the checkout button without selected anyone products
    [Documentation]  Verify the warning message is visible when click the checkout button without selected anyone products
    Click Element Until Enabled   ${locators_params['Home']['Order_Summary']}[Checkout_Btn]
    page should contain  ${testData_config['Toast_Messages']}[WithoutSelect_productMsg]

Verify the successfull message is visible when click the checkout button with selected atleast one product
    [Documentation]  Verify the successfully message is visible when click the checkout button with selected atleast one product
    ${Category_Btn}    format string  ${locators_params['Home']['Category_Section']}[Categories_Fields]     value=1
    Verify the product button in category section   ${Category_Btn}
    Verify and validate the discount field
    Click Element Until Enabled   ${locators_params['Home']['Order_Summary']}[Checkout_Btn]
    page should contain  ${testData_config['Toast_Messages']}[ProductAdded_SuccessMsg]
    page should not contain  ${testData_config['Toast_Messages']}[WithoutSelect_productMsg]
    wait until element is visible  ${locators_params['Home']['SelectCustomer_Popup']}[AddCustomer_Btn]
    click element until visible  ${locators_params['Home']['SelectCustomer_Popup']}[CloseIcon]

### New Order Button ###
Verify the New order button is visible in the order summary
    [Documentation]  Verify the new order button is visible in the order summary
    Reload Page
    wait until element is visible   ${locators_params['Home']['Order_Summary']}[NewOrder_Btn]
    ${UI_Checkout_BtnTxt}  get text  ${locators_params['Home']['Order_Summary']}[NewOrder_Btn]
    should be equal  ${UI_Checkout_BtnTxt}  ${testData_config['Home']['Order_Summary']}[NewOrder_Btn]

Verify the new order button function
    [Documentation]    Verify the new order button function
    wait until element is visible   ${locators_params['Home']['Order_Summary']}[NewOrder_Btn]
    ${Category_Btn}    format string  ${locators_params['Home']['Category_Section']}[Categories_Fields]     value=1
    Verify the product button in category section   ${Category_Btn}
    Verify and validate the discount field
    ${UI_subtotal_value}    Get Text    ${locators_params['Home']['Order_Summary']}[SubTotal_Value]
    ${UI_TotalQuantity_value}    Get Text    ${locators_params['Home']['Order_Summary']}[TotalQuantity_Value]
    ${UI_Total_value}    Get Text    ${locators_params['Home']['Order_Summary']}[Total_Value]
    ${UI_Discount_value}  Get Element Attribute    ${locators_params['Home']['Order_Summary']}[Discount_TxtBox]    value
    Capture The Screen    discount_entered
    @{Before_With_priceTag}    Create List    ${UI_subtotal_value}    ${UI_TotalQuantity_value}    ${UI_Total_value}
    ${Without_priceTag}    Validate the order summary price section    @{Before_With_priceTag}
    Capture The Screen    new_order_function
    Click Element Until Visible    ${locators_params['Home']['Order_Summary']}[NewOrder_Btn]
    Sleep    5s
    Verify The Title Of Home Page
    Capture The Screen    Cleared_Order summary product
    ${subtotal_value}    Get Text    ${locators_params['Home']['Order_Summary']}[SubTotal_Value]
    ${TotalQuantity_value}    Get Text    ${locators_params['Home']['Order_Summary']}[TotalQuantity_Value]
    ${Discount_value}  Get Element Attribute    ${locators_params['Home']['Order_Summary']}[Discount_TxtBox]    value
    ${Total_value}    Get Text    ${locators_params['Home']['Order_Summary']}[Total_Value]
    @{empty_prices}    Create List    ${subtotal_value}    ${TotalQuantity_value}    ${Total_value}
    ${Without_empty_priceTag}    Validate the order summary price section    @{empty_prices}
    ${Count}    Get Length    ${Without_empty_priceTag}
    FOR    ${i}    IN RANGE    0    ${Count}
        Should Not Be Equal    ${Without_empty_priceTag}[${i}]  ${Without_priceTag}[${i}]
    END
    ${discountValue}    Convert To String    ${Discount_value}
    Should Be Equal    None    ${discountValue}
    Capture The Screen    new_order_function

Validate the order summary price section
    [Documentation]    Validate the order summary price section
    [Arguments]    @{With_priceTag}
    @{Without_priceTag}    Create List
    FOR    ${price}    IN    @{With_priceTag}
        ${remove_priceTag}  Remove Unwanted Characters from the price value    ${price}
        Append To List    ${Without_priceTag}    ${remove_priceTag}
    END
    RETURN    ${Without_priceTag}
    
Verify the warning message is visible when click the New Order button without selected anyone products
    [Documentation]  Verify the warning message is visible when click the checkout button without selected anyone products
    Click Element Until Enabled   ${locators_params['Home']['Order_Summary']}[NewOrder_Btn]
    page should contain  ${testData_config['Toast_Messages']}[WithoutSelect_productMsg]

Verify the successfull message is visible when click the New Order button with selected atleast one product
    [Documentation]  Verify the successfull message is visible when click the New Order button with selected atleast one product
    validation of the category section of elements
    Click Element Until Enabled   ${locators_params['Home']['Order_Summary']}[NewOrder_Btn]
    page should contain  ${testData_config['Toast_Messages']}[ProductSaved_SuccessMsg]
    page should not contain  ${testData_config['Toast_Messages']}[WithoutSelect_productMsg]
    
Close the select customer popup
    [Documentation]    Close the select customer popup
    ${Popup_Status}    Run Keyword And Return Status    wait until element is visible  ${locators_params['Home']['SelectCustomer_Popup']}[CloseIcon]
    Run Keyword If    ${Popup_Status}     Click Element Until Visible    ${locators_params['Home']['SelectCustomer_Popup']}[CloseIcon]