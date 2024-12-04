*** Settings ***
Documentation    Insert multiple Categories list in the Point Of Sale application Settings - Categories page
Library          SeleniumLibrary
Library          CSVLibrary
Resource         ../../TestScripts/Base.robot
Suite Setup      Run Keywords   Initialize configuration parameters
...              AND  login to the user application
Suite Teardown   Close the browsers

*** Variables ***
${CSV_FILE}=    C:\\Users\\vk636\\Documents\\GitHub\\pos-laundary-tests\\utils\\Price_data.csv

*** Test Cases ***
Automate Laundry Categories Entry Without Duplicates
    [Documentation]    Automate Laundry Categories Entry Without Duplicates
    Navigate to the settings - Categories page
    @{laundry_data}   Read CSV Data
    @{unique_categories}    Get Unique Categories    @{laundry_data}
    ${categories_count}    Get Length    ${unique_categories}
    ${counter}=    Set Variable    0
    FOR    ${category}    IN    @{unique_categories}
        Log    Processing category number ${counter}: ${category}
        ${counter}=    Evaluate    ${counter} + 1
        Run Keyword If    ${counter} <= ${categories_count}   Validate Category Exists in Laundry Data    ${category}
    END
    Log To Console    All unique categories uploaded successfully

*** Keywords ***
Read CSV Data
    [Documentation]  Reads the CSV file with UTF-8 encoding to ensure proper handling of Arabic characters.
    ${csv_data}    Evaluate    pandas.read_csv(r'${CSV_FILE}', encoding='utf-8').to_dict(orient='records')    modules=pandas
    ${row_count}=    Get Length    ${csv_data}
    Log    CSV file read successfully with total rows: ${row_count}
    RETURN    @{csv_data}

Get Unique Categories
    [Arguments]    @{laundry_data}
    ${categories_list}=    Create List    # Create an empty list for categories
    ${unique_categories}=    Create List    # Create an empty list for unique categories
    FOR    ${row}    IN    @{laundry_data}
        ${category}=    Set Variable    ${row['Category']}
        Run Keyword If    "${category}" not in ${categories_list}    Append To List    ${unique_categories}    ${category}
        Append To List    ${categories_list}    ${category}
    END
    Log To Console    Unique categories: ${unique_categories}
    RETURN    @{unique_categories}

Validate Category Exists in Laundry Data
    [Arguments]    ${category}
    ${response}    Call Method    ${API_POSLaundry}    getAPI_Category
    @{Categories}    Set Variable    ${response}[1]
    ${is_category_present}=    Check If Category Exists    ${category}    @{Categories}
    Run Keyword If    ${is_category_present} == True    Log To Console    ${category} is already added.
    ...    ELSE   Add Category    ${category}

Check If Category Exists
    [Arguments]    ${expected_category}    @{Categories}
    FOR    ${category}    IN    @{Categories}
        Run Keyword If    "${category}" == "${expected_category}"    Return From Keyword    True
    END
    Return From Keyword    False

Add Category
    [Arguments]    ${category}
    Wait Until Element Visible    ${locators_params['Settings']['Categories']}[AddCategory_Btn]
    Click Element Until Visible    ${locators_params['Settings']['Categories']}[AddCategory_Btn]
    Wait Until Element Visible    ${locators_params['Settings']['Categories']['AddCategory_PopUp']}[Category_TxtBox]
    Input Text    ${locators_params['Settings']['Categories']['AddCategory_PopUp']}[Category_TxtBox]    ${category}
    Capture Page Screenshot    Before_Confirm_Category
    Click Element    ${locators_params['Settings']['Categories']['AddCategory_PopUp']}[Confirm_Btn]
    ${Status}     Run Keyword And Return Status    Page Should Contain    ${testData_config['Toast_Messages']}[CategoryAdded_SuccessMsg]
    Run Keyword If    ${Status}   Log To Console    Category ${category} added successfully.
    ...    ELSE   Run Keywords    Click Element Until Visible    ${locators_params['Settings']['Categories']['AddCategory_PopUp']}[Cancel_Btn]
    ...    AND     Log To Console    ${category} is already exists.
    Sleep    5s
    capture the screen  Added_Category