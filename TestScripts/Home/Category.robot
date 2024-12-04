*** Settings ***
Documentation    Validate of the CategorySection to Point of Sale application
Library          SeleniumLibrary
Suite Setup      Run Keywords   Initialize configuration parameters
...              AND  login to the user application
Suite Teardown   Close the browsers
Resource         ../../TestScripts/Base.robot

*** Test Cases ***
Validation of the category section
    [Documentation]  Validation of the category section
    [Tags]  Home  Category   Regression
    Verify that all the category section elements are visible