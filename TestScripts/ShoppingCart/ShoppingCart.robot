*** Settings ***
Documentation    Validate of the Shopping Cart page to Point of Sale application
Library          SeleniumLibrary
Suite Setup      Run Keywords   Initialize configuration parameters
...              login to the user application
Suite Teardown   Close the browsers
Resource         ../../TestScripts/Base.robot

*** Test Cases ***
Validation of the Shopping Cart Page
    [Documentation]  Validation of the Shopping Cart Page
    [Tags]  ShoppingCart   Regression
    Verify that all the shopping cart elements are visible
    Verify that make to order button is working in the shopping cart page