*** Settings ***
Documentation    Validate of the Orders page to Point of Sale application
Library          SeleniumLibrary
Suite Setup      Run Keywords   Initialize configuration parameters
...              AND    login to the user application
Suite Teardown   Close the browsers
Resource         ../../TestScripts/Base.robot

*** Test Cases ***
Validate the Orders Page
    [Documentation]  Validate the Orders Page
    [Tags]  Orders   Regression
    Navigate to orders page
    verify the order page elements are visible
    validate the orders page elements texts
    verify the choose an option filter field
    validate all the view order buttons are visible

Validate the Order details page
    [Documentation]    Validate the Order details page
    [Tags]  Order details   Regression
    verify the order details page elements are visible if the order status is Confirm
    verify the order details page elements are visible if the order status is in-process
    verify the order details page elements are visible if the order status is waiting for delivery
    verify the order details page elements are visible if the order status is delivered
    verify the order details page elements are visible if the order status is canceled
    verify the order details page elements are visible