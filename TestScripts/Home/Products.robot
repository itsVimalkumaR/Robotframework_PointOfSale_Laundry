*** Settings ***
Documentation    Validate of the Products Section to Point of Sale application
Library          SeleniumLibrary
Suite Setup      Run Keywords   Initialize configuration parameters
...              login to the user application
Suite Teardown   Close the browsers
Resource         ../../TestScripts/Base.robot

*** Test Cases ***
Validation of the products section
    [Documentation]  Validation of the Products section
    [Tags]  Home  Product   Regression
    Verify that all the product section elements are visible