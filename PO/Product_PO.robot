*** Settings ***
Library     SeleniumLibrary
Library     RequestsLibrary
Resource    ../Optimized_PO/CommonWrapper.robot
Resource    ../TestScripts/Base.robot

*** Keywords ***
Verify that all the Product section elements are visible
    [Documentation]  Verify that all the Product section elements are visible
    ${response}  call method  ${API_POSLaundry}  getAPI_Category
    log  ${response}
    ${Categories_Btn}  format string  ${locators_params['Home']['Category_Section']}[CategoryField]     value=1
    ${Products_Btn}  format string  ${locators_params['Home']['Product_Section']}[ProductField]     value=1
    run keyword if  "${response}[2]" == "False"   run keywords  wait until element is not visible  ${Categories_Btn}
    ...     AND  wait until element is not visible  ${Categories_Btn}
    ...     ELSE    Validate the product section  ${Products_Btn}
    capture the screen  Category_ProductSection

Validate the product section
    [Documentation]  Validate the product section
    [Arguments]  ${Products_Btn}
    ${response}  call method  ${API_POSLaundry}  getAPI_Product
    log  ${response}
    run keyword if  "${response}[2]" == "False"   wait until element is not visible  ${Products_Btn}
    ...     ELSE    validation of the Product section of elements
    capture the screen  ProductSection

validation of the Product section of elements
    [Documentation]  validation of the Product section of elements
    @{UI_Categories_Btns}       get webelements  ${locators_params['Home']['Category_Section']}[Categories_Fields]
    FOR  ${Categories_Btn}  IN  @{UI_Categories_Btns}
        ${Categories_BtnTxt}    get text    ${Categories_Btn}
        run keyword if  "${Categories_BtnTxt}" == " "   wait until element is not visible  ${Categories_Btn}
        ...     AND  Log  Category Name is not visible
        ...     ELSE    Verify the category button  ${Categories_Btn}
    END

Verify the Products section button
    [Documentation]  Verify the Products section button
    [Arguments]  ${Categories_Btn}
    Click Element Until Visible    ${Categories_Btn}
    capture the screen  Categories_Btns
    ${Product_Btn}  run keyword and return status  wait until element is visible   ${locators_params['Home']['Product_Section']}[ProductBtn]
    run keyword if  "${Product_Btn}" == "False"  Log  Product Name is not visible
    ...     ELSE  Verify the product button

Verify the product button
    [Documentation]  Verify the product button
    ${Product_BtnTxt}    get text    ${locators_params['Home']['Product_Section']}[ProductBtn]
    Click Element Until Visible    ${locators_params['Home']['Product_Section']}[ProductBtn]
    capture the screen  Product_Btns
    @{UI_Productss_Btns}       get webelements  ${locators_params['Home']['Product_Section']}[Products_Btns]
    FOR  ${ProductBtn}  IN  @{UI_Productss_Btns}
        ${ProductBtn_Txt}  get text  ${ProductBtn}
        click element until visible  ${ProductBtn}
        ${OrderProductName}  format string  ${locators_params['Home']['Order_Summary']}[Selected_ProductBtnTxt]     value=${ProductBtn_Txt}
        ${OrderProduct_Status}  run keyword and return status  wait until element is visible  ${OrderProductName}
        run keyword if  ${OrderProduct_Status} == True   ${OrderProduct_Txt}   get text  ${OrderProductName}
        ...   AND   should be equal  ${ProductBtn_Txt}   ${OrderProduct_Txt}
        ...   ELSE  should not be true  ${OrderProduct_Status}
    END