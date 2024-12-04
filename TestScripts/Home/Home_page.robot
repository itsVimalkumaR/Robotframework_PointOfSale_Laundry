*** Settings ***
Documentation    Validate of the Home page to Point of Sale application
Library          SeleniumLibrary
Suite Setup      Run Keywords   Initialize configuration parameters
...              AND  login to the user application
Suite Teardown   Close the browsers
Resource         ../../TestScripts/Base.robot

*** Test Cases ***
Validation of the Home page
    [Documentation]  Verify and validate of the Home page
    [Tags]  Home  Regression
    Validate the home page elements
    Verify that all the elements of category section are visible
    Verify the order summary section elements are visible

Validation of the Select Customer Popup
    [Documentation]  Validation of the Select Customer Popup
    [Tags]  Home   Regression
    ${response}  Call Method    ${API_POSLaundry}    getAPI_Category
    ${Categories_Status}    Set Variable    ${response}[2]
    Run Keyword If  ${Categories_Status} == True    Validate the products status
    ...    ELSE   The Categories status is ${Categories_Status}
    [Teardown]  verify the exist customer