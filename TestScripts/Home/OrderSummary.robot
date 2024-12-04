*** Settings ***
Documentation    Validate of the Order Summary Section to Point of Sale application
Library          SeleniumLibrary
Suite Setup      Run Keywords   Initialize configuration parameters
...              AND    login to the user application
Suite Teardown   Close the browsers
Resource         ../../TestScripts/Base.robot

*** Test Cases ***
Validation of the Checkout Button
    [Documentation]  Validation of the Checkout Button
    [Tags]  Home  OrderSummary  Checkout   Regression
    Verify the checkout button is visible in the order summary
    Verify the warning message is visible when click the checkout button without selected anyone products
    Verify the successfull message is visible when click the checkout button with selected atleast one product

Validation of the New Order Button
    [Documentation]  Validation of the New Order Button
    [Tags]  Home  OrderSummary  SaveCart   Regression
    Verify the new order button is visible in the order summary
    Verify the new order button function
#    Verify the warning message is visible when click the New Order button without selected anyone products
#    Verify the successfull message is visible when click the New Order button with selected atleast one product
    
Validation of the Order Summary Section
    [Documentation]  Validation of the Order Summary section
    [Tags]  Home  OrderSummary   Regression
    Verify the order summary section elements are visible
    Verify the selected product is visible in the order summary section
#    Verify the increase and decrease the quantity value of selected product in the order summary section
    Verify the selected product delete button is visible and working properly in the order summary section
#    Verify and validate the discount field
    [Teardown]    Run Keyword If Test Failed  Close the select customer popup