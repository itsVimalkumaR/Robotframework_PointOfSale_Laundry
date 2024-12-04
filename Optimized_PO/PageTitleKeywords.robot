*** Settings ***
Library         SeleniumLibrary
Library         OperatingSystem
Library         DateTime
Library         String
Library         Collections
Library         RequestsLibrary
Resource        ../TestScripts/Base.robot

*** Keywords ***
Verify the title of Login page
    [Documentation]    Integrated with UI
    Title Should Be    ${testData_config['Title']}[Login]

Verify the title of Signup page
    [Documentation]    Integrated with UI
    Title Should Be    ${testData_config['Title']}[Signup]

Verify the title of Home page
    [Documentation]    Integrated with UI
    Title Should Be    ${testData_config['Title']}[Home]

Verify the title of Orders page
    [Documentation]    Integrated with UI
    Title Should Be    ${testData_config['Title']}[Orders]

Verify the title of Order details page
    [Documentation]    Integrated with UI
    Title Should Be    ${testData_config['Title']}[OrdersDetails]

Verify the title of Shopping cart page
    [Documentation]    Integrated with UI
    Title Should Be    ${testData_config['Title']}[ShoppingCart]

Verify the title of Ledger page
    [Documentation]    Integrated with UI
    Title Should Be    ${testData_config['Title']}[Ledger]

Verify the title of Ledger details page
    [Documentation]    Integrated with UI
    Title Should Be    ${testData_config['Title']}[LedgerDetails]

Verify the title of settings-users page
    [Documentation]    Integrated with UI
    Title Should Be    ${testData_config['Title']}[Users]

Verify the title of settings-branches page
    [Documentation]    Integrated with UI
    Title Should Be    ${testData_config['Title']}[Branches]

Verify the title of settings-categories page
    [Documentation]    Integrated with UI
    Title Should Be    ${testData_config['Title']}[Categories]

Verify the title of settings-products page
    [Documentation]    Integrated with UI
    Title Should Be    ${testData_config['Title']}[Products]

Verify the title of settings-customers page
    [Documentation]    Integrated with UI
    Title Should Be    ${testData_config['Title']}[Customers]