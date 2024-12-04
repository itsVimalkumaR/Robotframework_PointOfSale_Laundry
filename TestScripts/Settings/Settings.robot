*** Settings ***
Documentation    Validate of the Settings page to Point of Sale application
Library          SeleniumLibrary
Suite Setup      Run Keywords   Initialize configuration parameters
...              AND  login to the user application
Suite Teardown   Close the browsers
Resource         ../../TestScripts/Base.robot

*** Test Cases ***
Validation of Settings page
    [Documentation]  Validation of Settings page
    [Tags]  Settings   Regression
    Verify that all the tabs are visible in settings page

Validation of the Categories Settings Page
    [Documentation]  Validation of the Categories Settings Page
    [Tags]  Settings   Categories  Regression
    Verify all the elements are visible in the categories settings page
    Verify the category table headers texts
    Validate the add new category  ${testData_config['Settings']['Categories']}[New_CategoryName]
    ...     ${testData_config['Settings']['Categories']}[Edit_CategoryName]
    Validate the edit the new category  ${testData_config['Settings']['Categories']}[New_CategoryName]
    ...     ${testData_config['Settings']['Categories']}[Edit_CategoryName]
    Validate the delete the new category   ${testData_config['Settings']['Categories']}[Edit_CategoryName]
    [Teardown]   Run Keyword If Test Failed   run keywords    Delete the exist category     ${testData_config['Settings']['Categories']}[New_CategoryName]
    ...     ${testData_config['Settings']['Categories']}[Edit_CategoryName]
    ...     AND    Closed the edit and delete popup

Validation of the Products Settings Page
    [Documentation]  Validation of the Products Settings Page
    [Tags]  Settings   Products  Regression
    Verify the exist product is present or not  ${testData_config['Settings']['Products']}[New_ProductName]
    ...     ${testData_config['Settings']['Products']}[Edit_ProductName]
    Verify all the elements are visible in the products settings page
    Verify the products table headers texts
    ${category_name}    Validate the add the new product  ${testData_config['Settings']['Products']}[New_ProductName]
    ...     ${testData_config['Settings']['Products']}[Edit_ProductName]    ${testData_config['Settings']['Products']}[New_ProductAmount]
    Validate the edit the new product  ${testData_config['Settings']['Products']}[New_ProductName]  ${testData_config['Settings']['Products']}[New_ProductAmount]
    ...     ${testData_config['Settings']['Products']}[Edit_ProductName]    ${testData_config['Settings']['Products']}[Edit_ProductAmount]    ${category_name}
    Validate the delete the new product   ${testData_config['Settings']['Products']}[Edit_ProductName]
    [Teardown]   Run Keyword If Test Failed   run keywords    Delete the exist product     ${testData_config['Settings']['Products']}[New_ProductName]
    ...     ${testData_config['Settings']['Products']}[Edit_ProductName]
    ...     AND    Closed the edit and delete popup

Validation of the Customer Settings Page
    [Documentation]     Validation of the Customer Settings Page
    [Tags]  Settings   Customers  Regression
    Verify all the elements are visible in customer settings page
    Verify user can able to add new customer
    Verify and Validate the settings customers page
    [Teardown]    Run Keyword If Test Failed  Closed the edit and delete popup

Validation of the Branches Settings Page
    [Documentation]  Validation of the Branches Settings Page
    [Tags]  Settings   Branches  Regression
    Verify all the elements are visible in the branches settings page   ${testData_config['Settings']['Branches']['Add_Branch_Popup']['TestData']}[BranchName]
    ...   ${testData_config['Settings']['Branches']['Edit_Branch_Popup']['TestData']}[BranchName]
    Verify user able to add new branch   ${testData_config['Settings']['Branches']['Add_Branch_Popup']['TestData']}[BranchName]
    ...   ${testData_config['Settings']['Branches']['Edit_Branch_Popup']['TestData']}[BranchName]
    Verify the actions menu button  ${testData_config['Settings']['Branches']['Add_Branch_Popup']['TestData']}[BranchName]
    Verify user able to edit the added branch   ${testData_config['Settings']['Branches']['Add_Branch_Popup']['TestData']}[BranchName]
    ...   ${testData_config['Settings']['Branches']['Edit_Branch_Popup']['TestData']}[BranchName]
    Verify user able to delete the added or edited branch   ${testData_config['Settings']['Branches']['Add_Branch_Popup']['TestData']}[BranchName]
    ...   ${testData_config['Settings']['Branches']['Edit_Branch_Popup']['TestData']}[BranchName]
    [Teardown]    Run Keyword If Test Failed    run keywords    Delete all the exist branches      ${testData_config['Settings']['Branches']['Add_Branch_Popup']['TestData']}[BranchName]
    ...   ${testData_config['Settings']['Branches']['Edit_Branch_Popup']['TestData']}[BranchName]
    ...   AND    Closed the edit and delete popup

Validate the Users Settings Page
    [Documentation]  Validate the Users Settings Page
    [Tags]  Settings   Users  Regression
    ${email_ID}    Generate Random Email ID
    Verify all the elements are visible in the users settings page
    Validate the add user button text in the users page
    Verify the add user button is working properly
    Verify all the add user popup elements are visible
    Verify all the add user popup elements label texts
    Verify and validate the add user popup cancel button    ${email_ID}
    Verify and validate the add user popup confirm button    ${email_ID}
    Verify and validate the select branch button and popup
    Verify and validate the user edit button and popup
#    Verify and validate the edit branch button and popup

#*** Comments ***
#pabot --processes 8 -i Regression -d settingslog TestScripts/Settings
#pabot --processes 11 -e Regression -d settingslogReports TestScripts/Settings