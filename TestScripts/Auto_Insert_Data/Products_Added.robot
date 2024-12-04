*** Settings ***
Documentation    Insert multiple products list in the Point Of Sale application Settings - Products page
Library          SeleniumLibrary
Library          CSVLibrary
Library          PandasLibrary
Resource         ../../TestScripts/Base.robot
Suite Setup      Run Keywords   Initialize configuration parameters
...              AND  login to the user application
Suite Teardown   Close the browsers

*** Variables ***
${CSV_FILE}=    C:\\Users\\vk636\\Documents\\GitHub\\pos-laundary-tests\\utils\\Price_data.csv

*** Test Cases ***
Automate Laundry Product Entry
    Navigate to the settings - products page
    @{laundry_data}   Read CSV Data
    FOR    ${row}    IN    @{laundry_data}
        ${product_name}=    Set Variable    ${row['Product Name']}
        ${product_price}=   Set Variable    ${row['Product Price']}
        ${category}=        Set Variable    ${row['Category']}
        ${arabic_name}=        Set Variable    ${row['Arabic name']}
        Log To Console    Arabic name: ${arabic_name}
        Validate Product Exists in Laundry Data    ${product_name}    ${product_price}    ${category}    ${arabic_name}
    END
    Log To Console    All Products and prices uploaded successfully

*** Keywords ***
Read CSV Data
    [Documentation]  Reads the CSV file with UTF-8 encoding to ensure proper handling of Arabic characters.
    ${csv_data}    Evaluate    pandas.read_csv(r'${CSV_FILE}', encoding='utf-8').to_dict(orient='records')    modules=pandas
    ${row_count}=    Get Length    ${csv_data}
    Log    CSV file read successfully with total rows: ${row_count}
    RETURN    @{csv_data}

Validate Product Exists in Laundry Data
    [Arguments]    ${product_name}    ${product_price}    ${category}    ${arabic_name}
    ${response}    Call Method    ${API_POSLaundry}    getAPI_Product
    @{Products}    Set Variable    ${response}[1]
    Log    ${response}
    ${product}    Check the category name and append it to the product name    ${category}  ${product_name}
    Log    appended category --> ${product}
    ${is_product_present}=    Check If Product Exists    ${product}    ${Products}
    Log    Is_product_present --> ${is_product_present}
    Run Keyword If    ${is_product_present} == True    Log    ${product_name} is already added.
    ...    ELSE    Add Product If Price Not NA    ${product_name}    ${product_price}    ${category}    ${arabic_name}

Check the category name and append it to the product name
    [Arguments]    ${category}  ${product_name}
    Run Keyword If    "${category}" == "DRY CLEAN NORMAL"   Return From Keyword   ${product_name} [DCN]
    Run Keyword If    "${category}" == "DRY CLEAN URGENT"   Return From Keyword   ${product_name} [DCU]
    Run Keyword If    "${category}" == "WASHING NORMAL"   Return From Keyword   ${product_name} [WN]
    Run Keyword If    "${category}" == "WASHING URGENT"   Return From Keyword   ${product_name} [WU]
    Run Keyword If    "${category}" == "PRESSING NORMAL"   Return From Keyword   ${product_name} [PN]
    Run Keyword If    "${category}" == "PRESSING URGENT"   Return From Keyword   ${product_name} [PU]
    Return From Keyword    INVALID CATEGORY

Check If Product Exists
    [Arguments]    ${expected_product}    ${Products}
    ${products_list}    Convert To String    ${Products}
    ${is_contained}=    Evaluate    """"${expected_product}" in ${products_list}"""
    Log    ${is_contained}
    Run Keyword If    ${is_contained}    Run Keywords    Log    Item "${expected_product}" found in list.
    ...    AND  Return From Keyword    True
    Run Keyword If    not ${is_contained}    Run Keywords   Log   Item "${expected_product}" not found in list "${products_list}".
    ...    AND    Return From Keyword    False

Add Product If Price Not NA
    [Arguments]    ${product_name}    ${product_price}    ${category}    ${arabic_name}
    # Check if product price is N/A, and skip if so
    Run Keyword If    "${product_price}" != "N/A"    Add Product Entry    ${product_name}    ${product_price}    ${category}    ${arabic_name}

Add Product Entry
    [Arguments]    ${product_name}    ${product_price}    ${category}    ${arabic_name}
    Wait Until Element Visible    ${locators_params['Settings']['Products']}[AddProduct_Btn]
    Click Element Until Visible    ${locators_params['Settings']['Products']}[AddProduct_Btn]
    wait until element is visible  ${locators_params['Settings']['Products']['AddProduct_PopUp']}[Confirm_Btn]
    click and input the value     ${locators_params['Settings']['Products']['AddProduct_PopUp']}[ProductName_TxtBox]  ${product_name}
    click and input the value     ${locators_params['Settings']['Products']['AddProduct_PopUp']}[ArabicName_TxtBox]  ${arabic_name}
    click and input the value     ${locators_params['Settings']['Products']['AddProduct_PopUp']}[ProductAmount_TxtBox]  ${product_price}
    click element until visible   ${locators_params['Settings']['Products']['AddProduct_PopUp']}[SelectCategory_DDBtn]
    ${Select_Opt}  format string  ${locators_params['Settings']['Products']['AddProduct_PopUp']}[SelectCategory_DDOption]  value=${category}
    click element until visible   ${Select_Opt}
    sleep  2s
    capture the screen  Add_Product
    Click Element Until Visible   ${locators_params['Settings']['Products']['AddProduct_PopUp']}[Confirm_Btn]
    ${Status}     Run Keyword And Return Status    Page Should Contain    ${testData_config['Toast_Messages']}[ProductAdded_SuccessMsg]
    Run Keyword If    ${Status}   Log   The ${product_name} was successfully placed into the ${category}.
    ...    ELSE   Run Keywords    Click Element Until Visible    ${locators_params['Settings']['Products']['AddProduct_PopUp']}[Cancel_Btn]
    ...    AND     Log    Already, the ${product_name} product is in the ${category}.
    Sleep    5s
    capture the screen  Added_Products