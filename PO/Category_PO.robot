*** Settings ***
Library     SeleniumLibrary
Library     RequestsLibrary
Resource    ../Optimized_PO/CommonWrapper.robot
Resource    ../TestScripts/Base.robot

*** Keywords ***
Verify that all the category section elements are visible
    [Documentation]  Verify that all the category section elements are visible
    ${response}  call method  ${API_POSLaundry}  getAPI_Category
    log  ${response}
    ${Categories_Btn}  format string  ${locators_params['Home']['Category_Section']}[CategoryField]     value=1
    run keyword if  "${response}[1]" == "No Data"   wait until element is not visible  ${Categories_Btn}
    ...     ELSE    validation of the category section of elements
    capture the screen  CategorySection

validation of the category section of elements
    [Documentation]  validation of the category section of elements
    @{UI_Categories_Btns}       get webelements  ${locators_params['Home']['Category_Section']}[Categories_Fields]
    FOR  ${Categories_Btn}  IN  @{UI_Categories_Btns}
        ${Categories_BtnTxt}    get text    ${Categories_Btn}
        run keyword if  "${Categories_BtnTxt}" == " "   wait until element is not visible  ${Categories_Btn}
        ...     AND  Log  The Categories Names are not visible in the Home page
        ...     ELSE   Verify the category button  ${Categories_Btn}
    END

Verify the category button
    [Documentation]  Verify the category and product buttons
    [Arguments]  ${Categories_Btn}
    Click Element Until Visible    ${Categories_Btn}
    capture the screen  Categories_Btns
    ${Product_Btn}  run keyword and return status  wait until element is visible   ${locators_params['Home']['Product_Section']}[ProductBtn]
    run keyword if  "${Product_Btn}" == "False"  Log  Product Name is not visible
    ...     ELSE  Verify the product button in category section  ${Categories_Btn}

Verify the product button in category section
    [Documentation]  Verify the product button
    [Arguments]  ${Categories_Btn}
    ${Product_Btn}  run keyword and return status  wait until element is visible   ${locators_params['Home']['Product_Section']}[ProductBtn]
    run keyword if  "${Product_Btn}" == "False"  Click Element Until Visible    ${Categories_Btn}
    ${Product_BtnTxt}    get text    ${locators_params['Home']['Product_Section']}[ProductBtn]
    Click Element Until Visible    ${locators_params['Home']['Product_Section']}[ProductBtn]
    capture the screen  Product_Btns
    @{UI_Products_Btns}       get webelements  ${locators_params['Home']['Product_Section']}[Products_Btns]
    FOR  ${ProductBtn}  IN  @{UI_Products_Btns}
        ${ProductBtn_Txt}  get text  ${ProductBtn}
        click element until visible  ${ProductBtn}
        ${OrderProductName}  format string  ${locators_params['Home']['Order_Summary']}[Selected_ProductBtnTxt]     value=${ProductBtn_Txt}
        ${OrderProduct_Status}  run keyword and return status  wait until element is visible  ${OrderProductName}
        capture the screen  SelectedProduct
        run keyword if  ${OrderProduct_Status} == True   validation of the Product  ${Product_BtnTxt}  ${OrderProductName}
        ...   ELSE  should not be true  ${OrderProduct_Status}
    END

validation of the Product
    [Arguments]  ${Product_BtnTxt}  ${OrderProductName}
    ${OrderProduct_Txt}   get text  ${OrderProductName}
    should be equal  ${ProductBtn_Txt}   ${OrderProduct_Txt}