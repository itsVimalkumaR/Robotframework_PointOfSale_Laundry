*** Settings ***
Library     SeleniumLibrary
Library     RequestsLibrary
Resource    ../Optimized_PO/CommonWrapper.robot
Resource    ../TestScripts/Base.robot

*** Keywords ***
###  Settings  #####
Verify that all the tabs are visible in settings page
    [Documentation]  Verify that all the tabs are visible in settings page
    ${Hamburger_menu}  Run Keyword And Return Status    Wait Until Element Is Visible    ${locators_params['Home']['Hamburger_MenuIcons']}[Hamburger_menu]
    Run Keyword If    ${Hamburger_menu} == True    Run Keywords    Click Element Until Visible    ${locators_params['Home']['Hamburger_MenuIcons']}[Hamburger_menu]
    wait until element is visible  ${locators_params['Home']}[Settings_Icon]
    Click Element Until Visible  ${locators_params['Home']}[Settings_Icon]
    @{Settings_Tabs}  create list  ${locators_params['Settings']['Categories']}[Categories_TabBtn]
    ...     ${locators_params['Settings']['Products']}[Products_TabBtn]
    ...     ${locators_params['Settings']['Customer']}[Customer_TabBtn]
    wait until elements are visible  @{Settings_Tabs}
    capture the screen  SettingsPage_Tabs

###  Settings - Categories  #####
Navigate to the settings - Categories page
    [Documentation]    Navigate to the settings - Categories page
    ${Hamburger_menu}  Run Keyword And Return Status    Wait Until Element Is Visible    ${locators_params['Home']['Hamburger_MenuIcons']}[Hamburger_menu]
    Run Keyword If    ${Hamburger_menu} == True    Run Keywords    Navigate to Settings page from Hamburger menu list
    ...    ELSE   Navigate to Settings page menu list
#    Wait Until Element Is Visible    ${locators_params['Home']}[Settings_Icon]
#    Click Element Until Visible  ${locators_params['Home']}[Settings_Icon]
    Wait Until Element Is Visible    ${locators_params['Settings']['Categories']}[Categories_TabBtn]
    Click Element Until Visible  ${locators_params['Settings']['Categories']}[Categories_TabBtn]
    Capture The Screen    Settings_Categories_Tabs

Verify all the elements are visible in the categories settings page
    [Documentation]  Verify all the elements are visible in the categories settings page
    Click Element Until Visible  ${locators_params['Settings']['Categories']}[Categories_TabBtn]
    Verify the title of settings-categories page
    @{Settings_Tabs}  create list  ${locators_params['Settings']['Categories']}[AddCategory_Btn]
    ...     ${locators_params['Settings']}[Table]
    ...     ${locators_params['Settings']}[ShowEntries]
    wait until elements are visible  @{Settings_Tabs}
    capture the screen  Settings_CategoriesPage_Tabs

Verify the category table headers texts
    [Documentation]  Verify the category table headers texts
    Wait Until Element Visible    ${locators_params['Settings']['Categories']}[Categories_TabBtn]
    Click Element Until Visible    ${locators_params['Settings']['Categories']}[Categories_TabBtn]
    Wait Until Element Visible    ${locators_params['Settings']}[Clicked_Tab]
    ${SelectedTab}  get text  ${locators_params['Settings']}[Clicked_Tab]
    should be equal  ${SelectedTab}  ${testData_config['Settings']['Categories']}[TabName]
    @{Tableheader_Txts}  create list  ${testData_config['Settings']['Categories']['Table']}[SNo_ColumnTxt]
    ...     ${testData_config['Settings']['Categories']['Table']}[Categories_ColumnTxt]  ${testData_config['Settings']['Categories']['Table']}[NoOfProducts_ColumnTxt]
    ...     ${testData_config['Settings']['Categories']['Table']}[Actions_ColumnTxt]
    Get text and Ensure the Headers are Equal  ${locators_params['Settings']}[TableColumn_Headers]   @{Tableheader_Txts}
    capture the screen  Categories_Table_ColumnNames

Validate the add new category
    [Documentation]  Validate the add new category
    [Arguments]  ${New_CategoryName}  ${Edit_CategoryName}
    wait until element is visible  ${locators_params['Home']}[Settings_Icon]
    Click Element Until Visible  ${locators_params['Home']}[Settings_Icon]
    Wait Until Element Visible    ${locators_params['Settings']['Categories']}[Categories_TabBtn]
    Click Element Until Visible    ${locators_params['Settings']['Categories']}[Categories_TabBtn]
    Wait Until Element Visible    ${locators_params['Settings']}[Clicked_Tab]
    ${SelectedTab}  get text  ${locators_params['Settings']}[Clicked_Tab]
    should be equal  ${SelectedTab}  ${testData_config['Settings']['Categories']}[TabName]
    @{exist_category}  create list  ${New_CategoryName}
    FOR  ${category}  IN  @{exist_category}
        add new category in the Categories section   ${category}  ${Edit_CategoryName}
    END

verify all the elements are visible in the add category popup page
    [Documentation]  verify all the elements are visible in the add category popup page
    Wait Until Element Visible    ${locators_params['Settings']['Categories']}[AddCategory_Btn]
    Click Element Until Visible    ${locators_params['Settings']['Categories']}[AddCategory_Btn]
    @{AddCategoryPopup_elements}  create list  ${locators_params['Settings']['Categories']['AddCategory_PopUp']}[HeaderTxt]
    ...     ${locators_params['Settings']['Categories']['AddCategory_PopUp']}[CategoryTxtBox_PlaceHolder]
    ...     ${locators_params['Settings']['Categories']['AddCategory_PopUp']}[Category_TxtBox]
    ...     ${locators_params['Settings']['Categories']['AddCategory_PopUp']}[Cancel_Btn]
    ...     ${locators_params['Settings']['Categories']['AddCategory_PopUp']}[Confirm_Btn]
    ...     ${locators_params['Settings']['Categories']['AddCategory_PopUp']}[CloseIcon]
    Wait Until Elements Are Visible     @{AddCategoryPopup_elements}
    capture the screen  Add_CategoryPopup

verify that the add category cancel button is working
    [Documentation]  verify that the add category cancel button is working
    wait until element is visible  ${locators_params['Settings']['Categories']['AddCategory_PopUp']}[Cancel_Btn]
    click element until enabled  ${locators_params['Settings']['Categories']['AddCategory_PopUp']}[Cancel_Btn]
    wait until element is not visible  ${locators_params['Settings']['Categories']['AddCategory_PopUp']}[Cancel_Btn]
    Wait Until Element Visible    ${locators_params['Settings']['Categories']}[AddCategory_Btn]

verify that the add category confirm button is working
    [Documentation]  verify that the add category confirm button is working
    [Arguments]  ${CategoryName}
    wait until element is visible  ${locators_params['Settings']['Categories']}[AddCategory_Btn]
    click element until enabled  ${locators_params['Settings']['Categories']}[AddCategory_Btn]
    wait until element is visible  ${locators_params['Settings']['Categories']['AddCategory_PopUp']}[Confirm_Btn]
    validation of confirm button without filling any details in add category popup
    validation of confirm button filling all details in add category popup  ${CategoryName}

validation of confirm button without filling any details in add category popup
    [Documentation]  validation of confirm button without filling any details in add category popup
    wait until element is visible  ${locators_params['Settings']['Categories']['AddCategory_PopUp']}[Confirm_Btn]
    ${UI_Category_TxtBox_Value}  get element attribute  ${locators_params['Settings']['Categories']['AddCategory_PopUp']}[Category_TxtBox]  value
    should be empty  ${UI_Category_TxtBox_Value}
    Element Should Be Disabled  ${locators_params['Settings']['Categories']['AddCategory_PopUp']}[Confirm_Btn]
    Capture the Screen    Confirm_Button_Disabled

validation of confirm button filling all details in add category popup
    [Documentation]  validation of confirm button filling all details in add category popup
    [Arguments]  ${CategoryName}
    click and input the value  ${locators_params['Settings']['Categories']['AddCategory_PopUp']}[Category_TxtBox]  ${CategoryName}
    sleep  3s
    Click Element Until Visible    ${locators_params['Settings']['Categories']['AddCategory_PopUp']}[Confirm_Btn]
    page should contain  ${testData_config['Toast_Messages']}[CategoryAdded_SuccessMsg]

add new category in the Categories section
    [Documentation]  add new category in the Categories section
    [Arguments]  ${CategoryName}  ${Edit_CategoryName}
    ${Selected_Option}  format string   ${locators_params['Settings']}[RowsPerPage_DDOption]   value=All
    Click Element Until Visible   ${locators_params['Settings']}[RowsPerPage_DDArrow]
    Click Element Until Visible  ${Selected_Option}
    @{existCategory}  create list  ${CategoryName}  ${Edit_CategoryName}
    FOR    ${exist_category}  IN    @{existCategory}
        ${Category_Status}  run keyword and return status   page should contain  ${exist_category}
        run keyword if   ${Category_Status} == True  Delete the exist category  ${exist_category}  ${Edit_CategoryName}
        ...    ELSE   page should not contain  ${exist_category}
    END
    verify all the elements are visible in the add category popup page
    verify that the add category cancel button is working
    verify that the add category confirm button is working  ${CategoryName}
    find the data from the list   ${CategoryName}

verify that the edit category popup elements are visible
    [Documentation]  verify that the edit category popup elements are visible
    [Arguments]  ${CategoryName_EditBtn}
    Click Element Until Visible    ${CategoryName_EditBtn}
    @{EditCategoryPopup_elements}  create list  ${locators_params['Settings']['Categories']['EditCategory_Popup']}[HeaderTxt]
    ...     ${locators_params['Settings']['Categories']['EditCategory_Popup']}[CategoryTxtBox_PlaceHolder]
    ...     ${locators_params['Settings']['Categories']['EditCategory_Popup']}[Category_TxtBox]
    ...     ${locators_params['Settings']['Categories']['EditCategory_Popup']}[Cancel_Btn]
    ...     ${locators_params['Settings']['Categories']['EditCategory_Popup']}[Update_Btn]
    ...     ${locators_params['Settings']['Categories']['EditCategory_Popup']}[Close_Icon]
    Wait Until Elements Are Visible     @{EditCategoryPopup_elements}
    capture the screen  Edit_CategoryPopup

verify that the edit category cancel button is working
    [Documentation]  verify that the edit category cancel button is working
    [Arguments]  ${CategoryName}  ${CategoryName_EditBtn}
    wait until element is visible  ${locators_params['Settings']['Categories']['EditCategory_Popup']}[Cancel_Btn]
    ${UI_CategoryName_Txt}  get element attribute  ${locators_params['Settings']['Categories']['EditCategory_Popup']}[Category_TxtBox]   value
    should be equal  ${UI_CategoryName_Txt}  ${CategoryName}
    click element until enabled  ${locators_params['Settings']['Categories']['EditCategory_Popup']}[Cancel_Btn]
    wait until element is not visible  ${locators_params['Settings']['Categories']['EditCategory_Popup']}[Cancel_Btn]
    Wait Until Element Visible    ${locators_params['Settings']['Categories']}[AddCategory_Btn]
    verify that the edit category cancel button is working when clear all details  ${CategoryName_EditBtn}

verify that the edit category cancel button is working when clear all details
    [Documentation]  verify that the edit category cancel button is working when clear all details
    [Arguments]  ${CategoryName_EditBtn}
    click element until visible  ${CategoryName_EditBtn}
    Click and clear element text    ${locators_params['Settings']['Categories']['EditCategory_Popup']}[Category_TxtBox]
    click element until enabled  ${locators_params['Settings']['Categories']['EditCategory_Popup']}[Cancel_Btn]
    Wait Until Element Visible    ${locators_params['Settings']['Categories']}[AddCategory_Btn]
    Capture The Screen    Edit_Category_Cancel_button

verify that the edit category confirm button is working
    [Documentation]  verify that the edit category confirm button is working
    [Arguments]  ${CategoryName_EditBtn}  ${New_CategoryName}  ${Edit_CategoryName}
    click element until visible  ${CategoryName_EditBtn}
    ${UI_CategoryName_Txt}  get element attribute  ${locators_params['Settings']['Categories']['EditCategory_Popup']}[Category_TxtBox]   value
    should be equal  ${UI_CategoryName_Txt}  ${New_CategoryName}
    validation of confirm button clear all details in edit category popup
    validation of confirm button when edit all details in edit category popup  ${Edit_CategoryName}

validation of confirm button clear all details in edit category popup
    [Documentation]  validation of confirm button clear all details in edit category popup
    ${Before_UpdateBtn_Status}      Run Keyword And Return Status    Element Should Be Enabled  ${locators_params['Settings']['Categories']['EditCategory_Popup']}[Update_Btn]
    Click and clear element text    ${locators_params['Settings']['Categories']['EditCategory_Popup']}[Category_TxtBox]
    ${AfterClear_CategoryName_Txt}  get element attribute  ${locators_params['Settings']['Categories']['EditCategory_Popup']}[Category_TxtBox]   value
    should be empty  ${AfterClear_CategoryName_Txt}
    ${After_UpdateBtn_Status}      Run Keyword And Return Status    Element Should Be Disabled  ${locators_params['Settings']['Categories']['EditCategory_Popup']}[Update_Btn]
    Should Not Be Equal    ${Before_UpdateBtn_Status}    ${After_UpdateBtn_Status}
    wait until element is visible  ${locators_params['Settings']['Categories']['EditCategory_Popup']}[Update_Btn]

validation of confirm button when edit all details in edit category popup
    [Documentation]  validation of confirm button when edit all details in add category popup
    [Arguments]  ${Edit_CategoryName}
    Click and clear element text  ${locators_params['Settings']['Categories']['EditCategory_Popup']}[Category_TxtBox]
    click and input the value  ${locators_params['Settings']['Categories']['EditCategory_Popup']}[Category_TxtBox]  ${Edit_CategoryName}
    Click Element Until Enabled   ${locators_params['Settings']['Categories']['EditCategory_Popup']}[Update_Btn]
    page should contain  ${testData_config['Toast_Messages']}[CategoryUpdated_SuccessMsg]
    Wait Until Element Visible    ${locators_params['Settings']['Categories']}[AddCategory_Btn]
    Capture The Screen    Edit_Category_Confirm_Button

Validate the edit the new category
    [Documentation]  Validate the edit the new category
    [Arguments]  ${New_CategoryName}  ${Edit_CategoryName}
    ${CategoryName_EditBtn}  format string  ${locators_params['Settings']['Categories']}[Table_EditBtn]     value=${New_CategoryName}
    Wait Until Element Visible    ${CategoryName_EditBtn}
    verify that the edit category popup elements are visible  ${CategoryName_EditBtn}
    verify that the edit category cancel button is working  ${New_CategoryName}  ${CategoryName_EditBtn}
    verify that the edit category confirm button is working  ${CategoryName_EditBtn}  ${New_CategoryName}  ${Edit_CategoryName}
    find the data from the list   ${Edit_CategoryName}
    page should not contain  ${New_CategoryName}

verify that the delete category popup elements are visible
    [Documentation]  verify that the delete category popup elements are visible
    [Arguments]  ${CategoryName}
    @{DeleteCategoryPopup_elements}  create list  ${locators_params['Settings']['Categories']['DeleteCategory_Popup']}[HeaderTxt]
    ...     ${locators_params['Settings']['Categories']['DeleteCategory_Popup']}[Delete_CategoryName]
    ...     ${locators_params['Settings']['Categories']['DeleteCategory_Popup']}[Description_LblText]
    ...     ${locators_params['Settings']['Categories']['DeleteCategory_Popup']}[Note_LblText]
    ...     ${locators_params['Settings']['Categories']['DeleteCategory_Popup']}[Cancel_Btn]
    ...     ${locators_params['Settings']['Categories']['DeleteCategory_Popup']}[Confirm_Btn]
    Wait Until Elements Are Visible     @{DeleteCategoryPopup_elements}
    capture the screen  Delete_CategoryPopup
    ${UI_DeleteCategory_Name}  get text  ${locators_params['Settings']['Categories']['DeleteCategory_Popup']}[Delete_CategoryName]
    should contain  ${UI_DeleteCategory_Name}   ${CategoryName}

validate the delete category popup elements label texts
    [Documentation]    validate the delete category popup elements label texts
    [Arguments]    ${CategoryName}
    @{DeleteCategoryPopup_elements}  create list  ${locators_params['Settings']['Categories']['DeleteCategory_Popup']}[HeaderTxt]
    ...     ${locators_params['Settings']['Categories']['DeleteCategory_Popup']}[Delete_CategoryName]
    ...     ${locators_params['Settings']['Categories']['DeleteCategory_Popup']}[Description_LblText]
    ...     ${locators_params['Settings']['Categories']['DeleteCategory_Popup']}[Note_LblText]
    ...     ${locators_params['Settings']['Categories']['DeleteCategory_Popup']}[Cancel_Btn]
    ...     ${locators_params['Settings']['Categories']['DeleteCategory_Popup']}[Confirm_Btn]
    @{DeleteCategoryPopup_elements_labeltexts}    Create List    ${testData_config['Settings']['Categories']['DeleteCategory_Popup']}[Header_text]
    ...     ${testData_config['Settings']['Categories']['DeleteCategory_Popup']}[Delete_CategoryName]
    ...     ${testData_config['Settings']['Categories']['DeleteCategory_Popup']}[Description_LblText]
    ...     ${testData_config['Settings']['Categories']['DeleteCategory_Popup']}[Note_LblText]
    ...     ${testData_config['Settings']['Categories']['DeleteCategory_Popup']}[Cancel_Btn]
    ...     ${testData_config['Settings']['Categories']['DeleteCategory_Popup']}[Confirm_Btn]
    Check All The Get Elements Text Are Should Contain    ${DeleteCategoryPopup_elements}    ${DeleteCategoryPopup_elements_labeltexts}
    
verify that the delete category cancel button is working properly
    [Documentation]  verify that the delete category cancel button is working properly
    Wait Until Element Visible    ${locators_params['Settings']['Categories']['DeleteCategory_Popup']}[Cancel_Btn]
    Click Element Until Visible    ${locators_params['Settings']['Categories']['DeleteCategory_Popup']}[Cancel_Btn]
    Wait Until Element Visible    ${locators_params['Settings']['Categories']}[AddCategory_Btn]

verify that the delete category confirm button is working properly
    [Documentation]  verify that the delete category confirm button is working properly
    [Arguments]  ${CategoryName_DeleteBtn}
    click element until visible  ${CategoryName_DeleteBtn}
    Wait Until Element Visible    ${locators_params['Settings']['Categories']['DeleteCategory_Popup']}[Confirm_Btn]
    Click Element Until Visible    ${locators_params['Settings']['Categories']['DeleteCategory_Popup']}[Confirm_Btn]
    Wait Until Element Visible    ${locators_params['Settings']['Categories']}[AddCategory_Btn]

Validate the delete the new category
    [Documentation]  Verify the user can able to delete new or old or edit category
    [Arguments]  ${CategoryName}
    ${CategoryName_DeleteBtn}  format string  ${locators_params['Settings']['Categories']}[Table_DeleteBtn]     value=${CategoryName}
    ${DeleteBtn_Status}  run keyword and return status  Wait Until Element Visible    ${CategoryName_DeleteBtn}
    run keyword if  ${DeleteBtn_Status} == False  run keyword  find the data from the list  ${CategoryName}
    Click Element Until Visible    ${CategoryName_DeleteBtn}
    verify that the delete category popup elements are visible  ${CategoryName}
    validate the delete category popup elements label texts  ${CategoryName}
    verify that the delete category cancel button is working properly
    verify that the delete category confirm button is working properly  ${CategoryName_DeleteBtn}

Delete the exist category
    [Documentation]  Delete the exist category
    [Arguments]  ${New_CategoryName}  ${Edit_CategoryName}
    Scroll To Element     ${locators_params['Settings']}[ShowEntries]
    ${AddCategory_CancelBtn_Status}  run keyword and return status  Wait Until Element Is Visible    ${locators_params['Settings']}[Cancel_Btn]
    run keyword if  ${AddCategory_CancelBtn_Status} == True  click element until visible  ${locators_params['Settings']}[Cancel_Btn]
    @{TestData}  create list  ${New_CategoryName}  ${Edit_CategoryName}
    ${PagenationBtn_Status}  run keyword and return status  Wait Until Element Is Enabled     ${locators_params['Settings']}[Pagenations_NextBtn]
    Log    ${PagenationBtn_Status}
    FOR   ${data}    IN   @{TestData}
        ${Find_Data}  format string   ${locators_params['Settings']}[Category_ColumnValue]   value=${data}
        ${result}=  Run Keyword And Return Status    element should be visible   ${Find_Data}
        run keyword if  ${result} == False  Show all the data from the table   All
        ${TotalCount}    get text    ${locators_params['Settings']}[ShowEntries]
        ${CategoryName_DeleteBtn}  format string  ${locators_params['Settings']['Categories']}[Table_DeleteBtn]     value=${data}
        ${DeleteBtn_Status}  run keyword and return status  Wait Until Element Visible    ${CategoryName_DeleteBtn}
        run keyword if  ${DeleteBtn_Status} == True  Delete the category   ${data}  ${CategoryName_DeleteBtn}
        ...  ELSE   log  the exist category is not present
    END

Delete the category
    [Documentation]  Delete the category
    [Arguments]  ${data}  ${CategoryName_DeleteBtn}
    find the data from the list  ${data}
    Wait Until Element Visible    ${CategoryName_DeleteBtn}
    Click Element Until Visible    ${CategoryName_DeleteBtn}
    ${UI_DeleteCategory_Name}  get text  ${locators_params['Settings']['Categories']['DeleteCategory_Popup']}[Delete_CategoryName]
    should contain  ${UI_DeleteCategory_Name}   ${data}
    Wait Until Element Visible    ${locators_params['Settings']['Categories']['DeleteCategory_Popup']}[Confirm_Btn]
    Click Element Until Visible    ${locators_params['Settings']['Categories']['DeleteCategory_Popup']}[Confirm_Btn]

Closed the edit and delete category popup
    [Documentation]    Closed the edit and delete category popup
    ${DeleteCategory_CancelBtn}    Run Keyword And Return Status    Wait Until Element Is Visible    ${locators_params['Settings']['Categories']['DeleteCategory_Popup']}[HeaderTxt]
    Run Keyword If    ${DeleteCategory_CancelBtn} == True    Click Element Until Visible    ${locators_params['Settings']['Categories']['DeleteCategory_Popup']}[Cancel_Btn]
    ${EditCategory_CancelBtn}    Run Keyword And Return Status    Wait Until Element Is Visible    ${locators_params['Settings']['Categories']['EditCategory_Popup']}[HeaderTxt]
    Run Keyword If    ${EditCustomer_CancelBtn} == True    Click Element Until Visible    ${locators_params['Settings']['Categories']['EditCategory_Popup']}[Close_Icon]

###  Settings - Products  #####
Navigate to Settings page from Hamburger menu list
    [Documentation]    Navigate to Settings page from Hamburger menu list
    Click Element Until Visible    ${locators_params['Home']['Hamburger_MenuIcons']}[Hamburger_menu]
    Wait Until Element Is Visible    ${locators_params['Home']['Hamburger_MenuIcons']}[Settings_Icon]
    Click Element Until Visible    ${locators_params['Home']['Hamburger_MenuIcons']}[Settings_Icon]
    Verify The Title Of Settings-branches Page

Navigate to Settings page menu list
    [Documentation]    Navigate to Settings page menu list
    Wait Until Element Is Visible    ${locators_params['Home']}[Settings_Icon]
    Click Element Until Visible  ${locators_params['Home']}[Settings_Icon]
    Verify The Title Of Settings-branches Page
    
Navigate to the settings - products page
    [Documentation]    Navigate to the settings - products page
    ${Hamburger_menu}  Run Keyword And Return Status    Wait Until Element Is Visible    ${locators_params['Home']['Hamburger_MenuIcons']}[Hamburger_menu]
    Run Keyword If    ${Hamburger_menu} == True    Run Keywords    Navigate to Settings page from Hamburger menu list
    ...    ELSE   Navigate to Settings page menu list
    Wait Until Element Is Visible    ${locators_params['Settings']['Products']}[Products_TabBtn]
    Click Element Until Visible  ${locators_params['Settings']['Products']}[Products_TabBtn]
    Verify The Title Of Settings-products Page
    Capture The Screen    Settings_Products_Tabs

Verify the exist product is present or not
    [Documentation]  Verify the exist product is present or not
    [Arguments]  ${New_ProductName}  ${Edit_ProductName}
    wait until element is visible  ${locators_params['Settings']['Products']}[Products_TabBtn]
    Click Element Until Visible  ${locators_params['Settings']['Products']}[Products_TabBtn]
    Verify the title of settings-products page
    capture the screen  ProductsSettings_Page
    Delete the exist Product  ${New_ProductName}  ${Edit_ProductName}

Verify all the elements are visible in the products settings page
    [Documentation]  Verify all the elements are visible in the products settings page
    @{Settings_Tabs}  create list  ${locators_params['Settings']['Products']}[AddProduct_Btn]
    ...     ${locators_params['Settings']}[Table]
    ...     ${locators_params['Settings']}[ShowEntries]
    wait until elements are visible  @{Settings_Tabs}
    capture the screen  Settings_ProductsPage_Tabs
    
Verify the products table headers texts
    [Documentation]  Verify the products table headers textsWait Until Element Visible    ${locators_params['Settings']}[Clicked_Tab]
    ${SelectedTab}  get text  ${locators_params['Settings']}[Clicked_Tab]
    should be equal  ${SelectedTab}  ${testData_config['Settings']['Products']}[TabName]
    @{Tableheader_Txts}  create list  ${testData_config['Settings']['Products']['Table']}[SNo_ColumnTxt]
    ...     ${testData_config['Settings']['Products']['Table']}[ProductName_ColumnTxt]  ${testData_config['Settings']['Products']['Table']}[ProductAmount_ColumnTxt]
    ...     ${testData_config['Settings']['Products']['Table']}[CategoryType_ColumnTxt]  ${testData_config['Settings']['Products']['Table']}[Actions_ColumnTxt]
    Get text and Ensure the Headers are Equal  ${locators_params['Settings']}[TableColumn_Headers]   @{Tableheader_Txts}
    capture the screen  Products_Table_ColumnNames

Validate the add the new product
    [Documentation]  Validate the add the new product
    [Arguments]  ${New_ProductName}  ${Edit_ProductName}  ${New_ProductAmount}
    wait until element is visible  ${locators_params['Home']}[Settings_Icon]
    Click Element Until Visible  ${locators_params['Home']}[Settings_Icon]
    Wait Until Element Visible    ${locators_params['Settings']['Products']}[Products_TabBtn]
    Click Element Until Visible    ${locators_params['Settings']['Products']}[Products_TabBtn]
    Wait Until Element Visible    ${locators_params['Settings']}[Clicked_Tab]
    ${SelectedTab}  get text  ${locators_params['Settings']}[Clicked_Tab]
    should be equal  ${SelectedTab}  ${testData_config['Settings']['Products']}[TabName]
    @{exist_Product}  create list  ${New_ProductName}
    FOR  ${Product}  IN  @{exist_Product}
        ${category_name}    add new Product in the Products section   ${Product}  ${New_ProductAmount}
    END
    RETURN    ${category_name}

verify all the elements are visible in the add product popup page
    [Documentation]  verify all the elements are visible in the add product popup page
    Wait Until Element Visible    ${locators_params['Settings']['Products']}[AddProduct_Btn]
    Click Element Until Visible    ${locators_params['Settings']['Products']}[AddProduct_Btn]
    @{AddProductPopup_elements}  create list  ${locators_params['Settings']['Products']['AddProduct_PopUp']}[HeaderTxt]
    ...     ${locators_params['Settings']['Products']['AddProduct_PopUp']}[ProductNameTxtBox_PlaceHolder]
    ...     ${locators_params['Settings']['Products']['AddProduct_PopUp']}[ProductAmountTxtBox_PlaceHolder]
    ...     ${locators_params['Settings']['Products']['AddProduct_PopUp']}[ProductName_TxtBox]
    ...     ${locators_params['Settings']['Products']['AddProduct_PopUp']}[ProductAmount_TxtBox]
    ...     ${locators_params['Settings']['Products']['AddProduct_PopUp']}[SelectCategory_BtnTxt]
    ...     ${locators_params['Settings']['Products']['AddProduct_PopUp']}[SelectCategory_DDBtn]
    ...     ${locators_params['Settings']['Products']['AddProduct_PopUp']}[Cancel_Btn]
    ...     ${locators_params['Settings']['Products']['AddProduct_PopUp']}[Confirm_Btn]
    Wait Until Elements Are Visible     @{AddProductPopup_elements}
    capture the screen  Add_ProductPopup

verify that the add product popup cancel button is working properly
    [Documentation]  verify that the add product popup cancel button is working properly
    wait until element is visible  ${locators_params['Settings']['Products']['AddProduct_PopUp']}[Cancel_Btn]
    Click Element Until Enabled  ${locators_params['Settings']['Products']['AddProduct_PopUp']}[Cancel_Btn]
    wait until element is not visible  ${locators_params['Settings']['Products']['AddProduct_PopUp']}[Cancel_Btn]

verify that the add product popup confirm button is working properly
    [Documentation]  verify that the add product popup confirm button is working properly
    [Arguments]  ${New_ProductName}  ${New_ProductAmount}
    Wait Until Element Visible    ${locators_params['Settings']['Products']}[AddProduct_Btn]
    Click Element Until Visible    ${locators_params['Settings']['Products']}[AddProduct_Btn]
    wait until element is visible  ${locators_params['Settings']['Products']['AddProduct_PopUp']}[Confirm_Btn]
    validation of confirm button without filling any details in add product popup
    ${category_name}    validation of confirm button filling all details in add product popup  ${New_ProductName}  ${New_ProductAmount}
    RETURN    ${category_name}

validation of confirm button without filling any details in add product popup
    ${UI_ProductName_TxtBox_Value}  get element attribute  ${locators_params['Settings']['Products']['AddProduct_PopUp']}[ProductName_TxtBox]  value
    should be empty  ${UI_ProductName_TxtBox_Value}
    ${UI_ProductAmount_TxtBox_Value}  get element attribute  ${locators_params['Settings']['Products']['AddProduct_PopUp']}[ProductAmount_TxtBox]  value
    should be empty  ${UI_ProductAmount_TxtBox_Value}
    Element Should Be Disabled  ${locators_params['Settings']['Products']['AddProduct_PopUp']}[Confirm_Btn]

validation of confirm button filling all details in add product popup
    [Documentation]  validation of confirm button filling all details in add product popup
    [Arguments]  ${New_ProductName}  ${New_ProductAmount}
    Log    New Product Name:${New_ProductName}, New Product Amount:${New_ProductAmount}
    click and input the value     ${locators_params['Settings']['Products']['AddProduct_PopUp']}[ProductName_TxtBox]  ${New_ProductName}
    click and input the value     ${locators_params['Settings']['Products']['AddProduct_PopUp']}[ProductAmount_TxtBox]  ${New_ProductAmount}
    click element until visible   ${locators_params['Settings']['Products']['AddProduct_PopUp']}[SelectCategory_DDBtn]
    ${response}    Call Method    ${API_POSLaundry}    getAPI_Category
    ${Categories}    Set Variable    ${response}[1]
    ${category_name}    Set Variable    ${Categories}[1]
    ${Select_Opt}  format string  ${locators_params['Settings']['Products']['AddProduct_PopUp']}[SelectCategory_DDOption]  value=${category_name}
    click element until visible   ${Select_Opt}
    sleep  2s
    capture the screen  Selecting_CategoryProduct
    Click Element Until Visible   ${locators_params['Settings']['Products']['AddProduct_PopUp']}[Confirm_Btn]
    page should contain  ${testData_config['Toast_Messages']}[ProductAdded_SuccessMsg]
    RETURN    ${category_name}

add new Product in the Products section
    [Documentation]  add new Product in the Products section
    [Arguments]  ${New_ProductName}  ${New_ProductAmount}
    ${Selected_Option}  format string   ${locators_params['Settings']}[RowsPerPage_DDOption]   value=All
    Click Element Until Visible   ${locators_params['Settings']}[RowsPerPage_DDArrow]
    Click Element Until Visible  ${Selected_Option}
    ${productname}    check the product with category is present    ${New_ProductName}
    ${Product_Status}  run keyword and return status   page should contain  ${productname}
    run keyword if   ${Product_Status} == True  Validate the delete the new product  ${productname}
    ...    ELSE   page should not contain  ${productname}
    verify all the elements are visible in the add product popup page
    verify that the add product popup cancel button is working properly
    ${category_name}    verify that the add product popup confirm button is working properly  ${New_ProductName}  ${New_ProductAmount}
    find the data from the list   ${product_name}
    RETURN    ${category_name}

check the product with category is present
    [Documentation]    check the product with category is present
    [Arguments]    ${ProductName}
    ${Category_response}    Call Method    ${API_POSLaundry}    getAPI_Category
    @{categories_list}    Set Variable    ${Category_response}[1]
    Log   Categories list: ${categories_list}
    ${length_categories_list}    Get Length    ${categories_list}
    Log   Length of categories_list: ${length_categories_list}
    FOR    ${i}    IN RANGE    0    ${length_categories_list}
        ${name}=    Check the category name and append it to the product name     ${categories_list}[${i}]    ${ProductName}
        Log    Generated Product Name: ${name}
        ${response}    Call Method    ${API_POSLaundry}    is_product_present    ${name}
        Log    API Response: ${response}
        ${NameOf_Product}    Set Variable    ${response}[2]
        Exit For Loop If   ${response}[1] == True
    END
    Return From Keyword    ${NameOf_Product}
     
verify that the edit product popup elements are visible
    [Documentation]  verify that the edit product popup elements are visible
    [Arguments]  ${ProductName_EditBtn}
    Click Element Until Visible    ${ProductName_EditBtn}
    @{EditProductPopup_elements}  create list    ${locators_params['Settings']['Products']['EditProduct_Popup']}[HeaderTxt]
    ...     ${locators_params['Settings']['Products']['EditProduct_Popup']}[ProductNameTxtBox_PlaceHolder]
    ...     ${locators_params['Settings']['Products']['EditProduct_Popup']}[ProductAmountTxtBox_PlaceHolder]
    ...     ${locators_params['Settings']['Products']['EditProduct_Popup']}[ProductName_TxtBox]
    ...     ${locators_params['Settings']['Products']['EditProduct_Popup']}[ProductAmount_TxtBox]
    ...     ${locators_params['Settings']['Products']['EditProduct_Popup']}[SelectCategory_DDBtn]
    ...     ${locators_params['Settings']['Products']['EditProduct_Popup']}[Cancel_Btn]
    ...     ${locators_params['Settings']['Products']['EditProduct_Popup']}[Update_Btn]
    Wait Until Elements Are Visible     @{EditProductPopup_elements}
    capture the screen  Edit_ProductPopup

verify that the edit product cancel button is working
    [Documentation]  verify that the edit product cancel button is working
    [Arguments]  ${New_ProductName}  ${New_ProductAmount}    ${category_name}
    ${product_name}    Check the category name and append it to the product name    ${category_name}  ${New_ProductName}
    wait until element is visible  ${locators_params['Settings']['Products']['EditProduct_Popup']}[Cancel_Btn]
    ${UI_ProductName_TxtBox_Value}  get element attribute  ${locators_params['Settings']['Products']['EditProduct_Popup']}[ProductName_TxtBox]  value
    should be equal  ${UI_ProductName_TxtBox_Value}  ${product_name}
    ${UI_ProductAmount_TxtBox_Value}  get element attribute  ${locators_params['Settings']['Products']['EditProduct_Popup']}[ProductAmount_TxtBox]  value
    should be equal  ${UI_ProductAmount_TxtBox_Value}  ${New_ProductAmount}
    click element until enabled  ${locators_params['Settings']['Products']['EditProduct_Popup']}[Cancel_Btn]
    wait until element is not visible  ${locators_params['Settings']['Products']['EditProduct_Popup']}[Cancel_Btn]
    Wait Until Element Visible    ${locators_params['Settings']['Products']}[AddProduct_Btn]
    verify that the edit product cancel button is working when clear all details  ${product_name}

verify that the edit product cancel button is working when clear all details
    [Documentation]  verify that the edit product cancel button is working when clear all details
    [Arguments]  ${New_ProductName}
    ${ProductName_EditBtn}  format string  ${locators_params['Settings']['Products']}[Table_EditBtn]     value=${New_ProductName}
    Show all the data from the table   All
    Wait Until Element Visible    ${ProductName_EditBtn}
    click element until visible  ${ProductName_EditBtn}
    Click and clear element text    ${locators_params['Settings']['Products']['EditProduct_Popup']}[ProductName_TxtBox]
    Click and clear element text    ${locators_params['Settings']['Products']['EditProduct_Popup']}[ProductAmount_TxtBox]
    click element until enabled  ${locators_params['Settings']['Products']['EditProduct_Popup']}[Cancel_Btn]
    Wait Until Element Visible    ${locators_params['Settings']['Products']}[AddProduct_Btn]

verify that the edit product confirm button is working
    [Documentation]  verify that the edit product confirm button is working
    [Arguments]  ${New_ProductName}  ${ProductName_EditBtn}  ${Edit_ProductName}  ${Edit_ProductAmount}
    Show all the data from the table   All
    click element until visible  ${ProductName_EditBtn}
    ${UI_CategoryName_Txt}  get element attribute  ${locators_params['Settings']['Products']['EditProduct_Popup']}[ProductName_TxtBox]   value
    should not be equal  ${UI_CategoryName_Txt}  ${Edit_ProductName}
    ${UI_CategoryName_Txt}  get element attribute  ${locators_params['Settings']['Products']['EditProduct_Popup']}[ProductAmount_TxtBox]   value
    should not be equal  ${UI_CategoryName_Txt}  ${Edit_ProductAmount}
    validation of confirm button clear all details in edit product popup
    validation of confirm button when edit all details in edit product popup  ${New_ProductName}  ${Edit_ProductName}  ${Edit_ProductAmount}

validation of confirm button clear all details in edit product popup
    [Documentation]  validation of confirm button clear all details in edit product popup
    Click and clear element text    ${locators_params['Settings']['Products']['EditProduct_Popup']}[ProductName_TxtBox]
    Click and clear element text    ${locators_params['Settings']['Products']['EditProduct_Popup']}[ProductAmount_TxtBox]
    ${UI_ProductName_TxtBox_Value}  get element attribute  ${locators_params['Settings']['Products']['EditProduct_Popup']}[ProductName_TxtBox]  value
    should be empty  ${UI_ProductName_TxtBox_Value}
    ${UI_ProductAmount_TxtBox_Value}  get element attribute  ${locators_params['Settings']['Products']['EditProduct_Popup']}[ProductAmount_TxtBox]  value
    should be empty  ${UI_ProductAmount_TxtBox_Value}
    Element Should Be Disabled  ${locators_params['Settings']['Products']['EditProduct_Popup']}[Update_Btn]
    Capture the Screen    WithoutData_EditPopup
    Sleep    3s
    wait until element is visible  ${locators_params['Settings']['Products']['EditProduct_Popup']}[Update_Btn]

validation of confirm button when edit all details in edit product popup
    [Documentation]  validation of confirm button when edit all details in edit product popup
    [Arguments]  ${New_ProductName}  ${Edit_ProductName}  ${Edit_ProductAmount}
    Click and clear element text   ${locators_params['Settings']['Products']['EditProduct_Popup']}[ProductName_TxtBox]
    click and input the value  ${locators_params['Settings']['Products']['EditProduct_Popup']}[ProductName_TxtBox]  ${Edit_ProductName}
    Click and clear element text   ${locators_params['Settings']['Products']['EditProduct_Popup']}[ProductAmount_TxtBox]
    click and input the value  ${locators_params['Settings']['Products']['EditProduct_Popup']}[ProductAmount_TxtBox]  ${Edit_ProductAmount}
    Click Element Until Enabled   ${locators_params['Settings']['Products']['EditProduct_Popup']}[Update_Btn]
    page should contain  ${testData_config['Toast_Messages']}[ProductUpdated_SuccessMsg]
    Wait Until Element Visible    ${locators_params['Settings']['Products']}[AddProduct_Btn]

Find the added product from the product names list
    [Documentation]    Find the added product from the product names list
    [Arguments]    ${added_product_name}    ${ProductNames}    ${count}
    FOR    ${i}    IN RANGE    0    ${count}
        ${product_name} =   Evaluate  "${ProductNames}[${i}]"
        Run Keyword If  "${added_product_name}" == "${product_name}"    Return From Keyword    ${ProductNames}[${i}]
    END

Check the category name and append it to the product name
    [Arguments]    ${category}  ${product_name}
    Run Keyword If    "${category}" == "DRY CLEAN NORMAL"   Return From Keyword   ${product_name} [DCN]
    Run Keyword If    "${category}" == "DRY CLEAN URGENT"   Return From Keyword   ${product_name} [DCU]
    Run Keyword If    "${category}" == "WASHING NORMAL"   Return From Keyword   ${product_name} [WN]
    Run Keyword If    "${category}" == "WASHING URGENT"   Return From Keyword   ${product_name} [WU]
    Run Keyword If    "${category}" == "PRESSING NORMAL"   Return From Keyword   ${product_name} [PN]
    Run Keyword If    "${category}" == "PRESSING URGENT"   Return From Keyword   ${product_name} [PU]
    Return From Keyword    INVALID CATEGORY

Validate the edit the new product
    [Documentation]  Validate the edit the new product
    [Arguments]  ${New_ProductName}  ${New_ProductAmount}  ${Edit_ProductName}  ${Edit_ProductAmount}    ${category_name}
    ${response}  Call Method    ${API_POSLaundry}  getAPI_Product
    Log    ${response}
    ${ProductNames}    Set Variable    ${response}[1]
    ${count}  Get Length    ${ProductNames}
    ${product}    Check the category name and append it to the product name    ${category_name}    ${New_ProductName}
    ${product_name}    Find the added product from the product names list    ${product}    ${ProductNames}    ${count}
#    ${index} =    Evaluate  ${count}-1
#    ${product_name} =   Evaluate  "${ProductNames}[${index}]"
    Should Contain    ${product_name}  ${New_ProductName}    
    ${ProductName_EditBtn}  format string  ${locators_params['Settings']['Products']}[Table_EditBtn]     value=${product_name}
    Wait Until Element Visible    ${ProductName_EditBtn}
    verify that the edit product popup elements are visible  ${ProductName_EditBtn}
    verify that the edit product cancel button is working  ${New_ProductName}  ${New_ProductAmount}    ${category_name}
    verify that the edit product confirm button is working   ${New_ProductName}  ${ProductName_EditBtn}  ${Edit_ProductName}  ${Edit_ProductAmount}
    find the data from the list   ${Edit_ProductName}
    page should not contain  ${New_ProductName}

Validate the delete the new product
    [Documentation]  Verify the user can able to delete new or old or edit Product
    [Arguments]  ${ProductName}
    ${ProductName_DeleteBtn}  format string  ${locators_params['Settings']['Products']}[Table_DeleteBtn]     value=${ProductName}
    ${DeleteBtn_Status}  run keyword and return status  Wait Until Element Visible    ${ProductName_DeleteBtn}
    run keyword if  ${DeleteBtn_Status} == False  run keyword  find the data from the list  ${ProductName}
    Click Element Until Visible    ${ProductName_DeleteBtn}
    @{DeleteProductPopup_elements}  create list  ${locators_params['Settings']['Products']['DeleteProduct_Popup']}[HeaderTxt]
    ...     ${locators_params['Settings']['Products']['DeleteProduct_Popup']}[Delete_ProductName]
    ...     ${locators_params['Settings']['Products']['DeleteProduct_Popup']}[Cancel_Btn]
    ...     ${locators_params['Settings']['Products']['DeleteProduct_Popup']}[Confirm_Btn]
    Wait Until Elements Are Visible     @{DeleteProductPopup_elements}
    capture the screen  Delete_ProductPopup
    ${UI_DeleteProduct_Name}  get text  ${locators_params['Settings']['Products']['DeleteProduct_Popup']}[Delete_ProductName]
    should contain  ${UI_DeleteProduct_Name}   ${ProductName}
    Wait Until Element Visible    ${locators_params['Settings']['Products']['DeleteProduct_Popup']}[Cancel_Btn]
    Click Element Until Visible    ${locators_params['Settings']['Products']['DeleteProduct_Popup']}[Cancel_Btn]
    ${DeleteBtn_Status}  run keyword and return status  Wait Until Element Visible    ${ProductName_DeleteBtn}
    run keyword if  ${DeleteBtn_Status} == False  run keyword  find the data from the list  ${ProductName}
    Click Element Until Visible    ${ProductName_DeleteBtn}
    Capture The Screen    Delete_${ProductName}_product
    Click Element Until Visible    ${locators_params['Settings']['Products']['DeleteProduct_Popup']}[Confirm_Btn]
    Log    Deleted the ${ProductName} product
    ${Delete_Btn_Status}    find the data from the list  ${ProductName}
    Should Not Be True    ${Delete_Btn_Status}

Delete the exist Product
    [Documentation]  Delete the exist Product
    [Arguments]  ${New_ProductName}  ${Edit_ProductName}
    Scroll To Element     ${locators_params['Settings']}[ShowEntries]
    @{TestData}  create list  ${New_ProductName}  ${Edit_ProductName}
    ${PagenationBtn_Status}  run keyword and return status  Wait Until Element Is Enabled     ${locators_params['Settings']}[Pagenations_NextBtn]
    Log    ${PagenationBtn_Status}
    ${Popup_Status}  run keyword and return status  Wait Until Element Visible    ${locators_params['Settings']['Products']['DeleteProduct_Popup']}[Cancel_Btn]
    run keyword if  '${Popup_Status}' == 'True'  run keywords  Click Element Until Visible    ${locators_params['Settings']['Products']['DeleteProduct_Popup']}[Cancel_Btn]
    ...     AND    Delete the product   @{TestData}
    ...     ELSE    Delete the product   @{TestData}

Delete the product
    [Documentation]  Delete the product
    [Arguments]  @{TestData}
    FOR   ${data}    IN   @{TestData}
        ${Find_Data}  format string   ${locators_params['Settings']['Products']}[ProductName_ColumnValue]   value=${data}
        ${result}=  Run Keyword And Return Status    element should be visible    ${Find_Data}
        run keyword if  ${result} == False  Show all the data from the table   All
        ${TotalCount}    get text    ${locators_params['Settings']}[ShowEntries]
        ${ProductName_DeleteBtn}  format string  ${locators_params['Settings']['Products']}[Table_DeleteBtn]     value=${data}
        ${DeleteBtn_Status}  run keyword and return status  Wait Until Element Visible    ${ProductName_DeleteBtn}
        run keyword if  ${DeleteBtn_Status} == False  run keywords  find the data from the list  ${data}
        ...   AND   exit for loop
        Wait Until Element Visible    ${ProductName_DeleteBtn}
        Click Element Until Visible    ${ProductName_DeleteBtn}
        ${UI_DeleteProduct_Name}  get text  ${locators_params['Settings']['Products']['DeleteProduct_Popup']}[Delete_ProductName]
        should contain  ${UI_DeleteProduct_Name}   ${data}
        Wait Until Element Visible    ${locators_params['Settings']['Products']['DeleteProduct_Popup']}[Confirm_Btn]
        Click Element Until Visible    ${locators_params['Settings']['Products']['DeleteProduct_Popup']}[Confirm_Btn]
    END

Closed the edit and delete product popup
    [Documentation]    Closed the edit and delete product popup
    ${Deleteproduct_CancelBtn}    Run Keyword And Return Status    Wait Until Element Is Visible    ${locators_params['Settings']['Products']['DeleteProduct_Popup']}[HeaderTxt]
    Run Keyword If    ${DeleteCategory_CancelBtn} == True    Click Element Until Visible    ${locators_params['Settings']['Products']['DeleteProduct_Popup']}[Cancel_Btn]
    ${Editproduct_CancelBtn}    Run Keyword And Return Status    Wait Until Element Is Visible    ${locators_params['Settings']['Products']['EditProduct_Popup']}[HeaderTxt]
    Run Keyword If    ${EditCustomer_CancelBtn} == True    Click Element Until Visible    ${locators_params['Settings']['Products']['EditProduct_Popup']}[Close_Icon]

####  Settings - Customers ###
Verify all the elements are visible in customer settings page
    [Documentation]  verify all the elements are visible in customer settings page
    Click Element Until Visible   ${locators_params['Settings']['Customer']}[Customer_TabBtn]
    Verify the title of settings-customers page
    @{Customer_elements}  create list  ${locators_params['Settings']['Customer']}[Customer_TabBtn]
    ...     ${locators_params['Settings']['Customer']}[Search_PhoneNo_TxtBox]
    ...     ${locators_params['Settings']['Customer']}[SearchPhoneNo_TxtBoxPlaceHolder]
    Wait Until Elements Are Visible     @{Customer_elements}
    Capture the Screen    Settings_CustomerPage

### Add new Customer ###
Verify user can able to add new customer
    [Documentation]    Verify user can able to add new customer
    wait until element is visible  ${locators_params['Home']}[Home_Icon]
    sleep  5s
    Click Element Until Visible   ${locators_params['Home']}[Home_Icon]
    ${response}  call method  ${API_POSLaundry}  getAPI_Category
    log  ${response}
    ${Categories_Btn}  format string  ${locators_params['Home']['Category_Section']}[CategoryField]     value=1
    run keyword if  "${response}[1]" == "No Data"   wait until element is not visible  ${Categories_Btn}
    ...     ELSE    Select the category
        
Select the category
    [Documentation]    Select the category
    ${Categories_Btn}    Format String    ${locators_params['Home']['Category_Section']}[Category_Field]    value=1
    Click Element Until Visible    ${Categories_Btn}
    capture the screen  Categories_Buttons
    ${Product_Btn}  run keyword and return status  wait until element is visible   ${locators_params['Home']['Product_Section']}[ProductBtn]
    run keyword if  "${Product_Btn}" == "False"  Log  Product Name is not visible
    ...     ELSE  Select the product in the order summary page
        
Select the product in the order summary page
    [Documentation]    Select the product in the order summary page
    wait until element is visible   ${locators_params['Home']['Product_Section']}[ProductBtn]
    ${Product_BtnTxt}    get text    ${locators_params['Home']['Product_Section']}[ProductBtn]
    Click Element Until Visible    ${locators_params['Home']['Product_Section']}[ProductBtn]
    ${OrderProductName}  format string  ${locators_params['Home']['Order_Summary']}[Selected_ProductBtnTxt]     value=${Product_BtnTxt}
    ${OrderProduct_Status}  run keyword and return status  wait until element is visible  ${OrderProductName}
    run keyword if  ${OrderProduct_Status} == True   validation of the Product  ${Product_BtnTxt}  ${OrderProductName}
    ...   ELSE  should not be true  ${OrderProduct_Status}
    Click Element Until Enabled   ${locators_params['Home']['Order_Summary']}[Checkout_Btn]
    page should contain  ${testData_config['Toast_Messages']}[ProductAdded_SuccessMsg]
    page should not contain  ${testData_config['Toast_Messages']}[WithoutSelect_productMsg]
    Capture The Screen    Checkout button fun worked
    ${PhoneNo}    Verify the user able to add new customer in the customer details popup   ${locators_params['Home']['SelectCustomer_Popup']}[AddCustomer_Btn]
    Verify the added customer is visible in the settings - customer page
    
Verify and Validate the settings customers page
    [Documentation]  Verify and Validate the settings customers page
    ${response}  call method  ${API_POSLaundry}   getAPI_Customer
    log  ${response}
    ${Phone_Numbers}    set variable  ${response}[4]
    run keyword if  '${response}[1]' == 'True'  run keywords  Verify the customer search filed is working properly  ${Phone_Numbers}[1]
    ...     AND  Verify the edit customer popup  ${Phone_Numbers}[1]
    ...     AND  Verify the delete customer popup
    ...     ELSE   log  No Data available in table

Verify the customer search filed is working properly
    [Documentation]     verify the customer search filed is working properly
    [Arguments]  ${Phone_Number}
    Wait Until Element Is Visible    ${locators_params['Settings']['Customer']}[Search_PhoneNo_TxtBox]
    Click and clear element text  ${locators_params['Settings']['Customer']}[Search_PhoneNo_TxtBox]
    capture page screenshot    demo
    click and input the value  ${locators_params['Settings']['Customer']}[Search_PhoneNo_TxtBox]     ${Phone_Number}
    ${Searched_customer}  Format String    ${locators_params['Settings']['Customer']}[Searched_PhoneNo]    value=${Phone_Number}
    Wait Until Element Is Visible    ${Searched_customer}
    Capture the Screen    Searched_Customer_PhoneNo

### Edit Customer Popup
Verify the edit customer popup
    [Documentation]     Verify the edit customer popup
    [Arguments]  ${PhoneNumber}
    Verify all elements are visible in edit customer popup    ${PhoneNumber}
    Verify that edit customer popup update button is working  ${PhoneNumber}

Verify all elements are visible in edit customer popup
    [Documentation]     Verify all elements are visible in edit customer popup
    [Arguments]  ${PhNo}
    Show all the data from the table   All
    ${Searched_customer}  Format String    ${locators_params['Settings']['Customer']}[Searched_PhoneNo]    value=${PhNo}
    Wait Until Element Is Visible    ${Searched_customer}
    ${SearchedCustomer_EditBtn}  Format String    ${locators_params['Settings']['Customer']}[SearchedCustomer_EditBtn]    value=${PhNo}
    Click Element Until Visible    ${SearchedCustomer_EditBtn}
    ${UI_PhoneNo}  Get Element Attribute    ${locators_params['Settings']['Customer']['EditCustomer_popup']}[PhNo_Txtbox]    value
    Should Be Equal    ${UI_PhoneNo}    ${PhNo}
    @{Edit_Customer_elements}  Create List  ${locators_params['Settings']['Customer']['EditCustomer_popup']}[HeaderTxt]
    ...     ${locators_params['Settings']['Customer']['EditCustomer_popup']}[NameTxtbox_LblTxt]   ${locators_params['Settings']['Customer']['EditCustomer_popup']}[Name_Txtbox]
    ...     ${locators_params['Settings']['Customer']['EditCustomer_popup']}[PhNoTxtbox_LblTxt]   ${locators_params['Settings']['Customer']['EditCustomer_popup']}[PhNo_Txtbox]
    ...     ${locators_params['Settings']['Customer']['EditCustomer_popup']}[EmailTxtbox_LblTxt]   ${locators_params['Settings']['Customer']['EditCustomer_popup']}[Email_Txtbox]
    ...     ${locators_params['Settings']['Customer']['EditCustomer_popup']}[AddressTxtbox_LblTxt]
    ...     ${locators_params['Settings']['Customer']['EditCustomer_popup']['Address_Txtbox']}[StreetTxtBox_LblTxt]  ${locators_params['Settings']['Customer']['EditCustomer_popup']['Address_Txtbox']}[Street_TxtBox]
    ...     ${locators_params['Settings']['Customer']['EditCustomer_popup']['Address_Txtbox']}[DistrictTxtBox_LblTxt]  ${locators_params['Settings']['Customer']['EditCustomer_popup']['Address_Txtbox']}[District_TxtBox]
    ...     ${locators_params['Settings']['Customer']['EditCustomer_popup']['Address_Txtbox']}[PinCodeTxtBox_LblTxt]  ${locators_params['Settings']['Customer']['EditCustomer_popup']['Address_Txtbox']}[PinCode_TxtBox]
    ...     ${locators_params['Settings']['Customer']['EditCustomer_popup']}[Cancel_Btn]  ${locators_params['Settings']['Customer']['EditCustomer_popup']}[Update_Btn]
    Wait Until Elements Are Visible   @{Edit_Customer_elements}
    Element Should Be Enabled    ${locators_params['Settings']['Customer']['EditCustomer_popup']}[Cancel_Btn]
    Element Should Be Disabled    ${locators_params['Settings']['Customer']['EditCustomer_popup']}[Update_Btn]
    Capture the Screen    Edit_CustomerPopup_elements

Verify that edit customer popup update button is working
    [Documentation]     Verify that edit customer popup update button is working
    [Arguments]     ${PhoneNo}
    Verify the update button is disabled when clear all textboxes value  ${PhoneNo}
    Verify that update button is disabled when clear anyone of the required textfield  ${PhoneNo}
    Verify the update button is enabled when filling all textboxes value
    Verify the update button is working properly

Verify the update button is disabled when clear all textboxes value
    [Documentation]   Verify the update is disabled when clear all textboxes value
    [Arguments]     ${PhoneNo}
    @{EditCustomerPopup_TxtBoxes}  Create List  ${locators_params['Settings']['Customer']['EditCustomer_popup']}[Name_Txtbox]   ${locators_params['Settings']['Customer']['EditCustomer_popup']}[PhNo_Txtbox]
    ...     ${locators_params['Settings']['Customer']['EditCustomer_popup']}[Email_Txtbox]  ${locators_params['Settings']['Customer']['EditCustomer_popup']['Address_Txtbox']}[Street_TxtBox]
    ...     ${locators_params['Settings']['Customer']['EditCustomer_popup']['Address_Txtbox']}[District_TxtBox]  ${locators_params['Settings']['Customer']['EditCustomer_popup']['Address_Txtbox']}[PinCode_TxtBox]
    Clear all textboxes value   @{EditCustomerPopup_TxtBoxes}
    Element Should Be Disabled    ${locators_params['Settings']['Customer']['EditCustomer_popup']}[Update_Btn]
    Element Should Be Enabled    ${locators_params['Settings']['Customer']['EditCustomer_popup']}[Cancel_Btn]
    Click Element Until Visible    ${locators_params['Settings']['Customer']['EditCustomer_popup']}[Cancel_Btn]
    Show all the data from the table   All

Verify that update button is disabled when clear anyone of the required textfield
    [Documentation]     Verify that update button is disabled when clear anyone of the required textfield
    [Arguments]     ${PhoneNo}
    Show all the data from the table   All
    ${SearchedCustomer_EditBtn}  Format String    ${locators_params['Settings']['Customer']}[SearchedCustomer_EditBtn]    value=${PhoneNo}
    Click Element Until Visible    ${SearchedCustomer_EditBtn}
    @{EditCustomerPopup_TxtBoxes}  Create List  ${locators_params['Settings']['Customer']['EditCustomer_popup']}[Name_Txtbox]
    ...      ${locators_params['Settings']['Customer']['EditCustomer_popup']}[PhNo_Txtbox]
#    ...     ${locators_params['Settings']['Customer']['EditCustomer_popup']}[Email_Txtbox]
#    ...     ${locators_params['Settings']['Customer']['EditCustomer_popup']['Address_Txtbox']}[Street_TxtBox]
#    ...     ${locators_params['Settings']['Customer']['EditCustomer_popup']['Address_Txtbox']}[District_TxtBox]  ${locators_params['Settings']['Customer']['EditCustomer_popup']['Address_Txtbox']}[PinCode_TxtBox]
    FOR    ${element}    IN    @{EditCustomerPopup_TxtBoxes}
        Click and clear element text   ${element}
        Element Should Be Disabled    ${locators_params['Settings']['Customer']['EditCustomer_popup']}[Update_Btn]
        ${index}    Generate Random String    2    0123456789
        Capture the Screen    ClearElement_${index}
        Click Element Until Visible    ${locators_params['Settings']['Customer']['EditCustomer_popup']}[Cancel_Btn]
        Show all the data from the table   All
        ${SearchedCustomer_EditBtn}  Format String    ${locators_params['Settings']['Customer']}[SearchedCustomer_EditBtn]    value=${PhoneNo}
        Click Element Until Visible    ${SearchedCustomer_EditBtn}
    END

Verify the update button is enabled when filling all textboxes value
    [Documentation]     Verify the update is enabled when filling all textboxes value
    ${Phone_Number}    Generate Random String    8    0123456789
    ${Random_EmailID}   Generate Random Email
    @{EditCustomerPopup_TxtBoxes}  Create List  ${locators_params['Settings']['Customer']['EditCustomer_popup']}[Name_Txtbox]   ${locators_params['Settings']['Customer']['EditCustomer_popup']}[PhNo_Txtbox]
    ...     ${locators_params['Settings']['Customer']['EditCustomer_popup']}[Email_Txtbox]
    ...     ${locators_params['Settings']['Customer']['EditCustomer_popup']['Address_Txtbox']}[Street_TxtBox]
    ...     ${locators_params['Settings']['Customer']['EditCustomer_popup']['Address_Txtbox']}[District_TxtBox]  ${locators_params['Settings']['Customer']['EditCustomer_popup']['Address_Txtbox']}[PinCode_TxtBox]
    @{Input_Values}  Create List    ${testData_config['Settings']['Customer']['EditCustomer_Popup']}[New_Name]  ${Phone_Number}
    ...     ${Random_EmailID}
    ...     ${testData_config['Settings']['Customer']['EditCustomer_Popup']['New_Address']}[Street]
    ...     ${testData_config['Settings']['Customer']['EditCustomer_Popup']['New_Address']}[District]  ${testData_config['Settings']['Customer']['EditCustomer_Popup']['New_Address']}[PinCode]
    Edit multiple value in the inputfields  ${EditCustomerPopup_TxtBoxes}  ${Input_Values}
    Element Should Be Enabled    ${locators_params['Settings']['Customer']['EditCustomer_popup']}[Update_Btn]
    Capture the Screen    Edited_All_Details_InCustomer
    
Verify the update button is working properly
    [Documentation]     Verify the update button is working properly
    Wait Until Element Is Enabled    ${locators_params['Settings']['Customer']['EditCustomer_popup']}[Update_Btn]
    Click Element Until Enabled    ${locators_params['Settings']['Customer']['EditCustomer_popup']}[Update_Btn]
    Wait Until Element Is Visible    ${locators_params['Settings']['Customer']}[Search_PhoneNo_TxtBox]
    Capture the Screen    EditCustomer_Update_Sucsess

### Delete Customer Popup
Verify the delete customer popup
    [Documentation]     Verify the delete customer popup
    ${response}  call method  ${API_POSLaundry}   getAPI_Customer
    log  ${response}
    ${Phone_Numbers}    set variable  ${response}[4]
    Verify all elements are visible in delete customer popup    ${Phone_Numbers}[1]
    Verify the cancel button is working properly in the delete customer details popup
    Verify the confirm button is working properly in the delete customer details popup  ${Phone_Numbers}[1]

Verify all elements are visible in delete customer popup
    [Documentation]     Verify all elements are visible in delete customer popup
    [Arguments]     ${PhoneNum}
    Show all the data from the table   All
    ${SearchedCustomer_DeleteBtn}  Format String    ${locators_params['Settings']['Customer']}[SearchedCustomer_DeleteBtn]    value=${PhoneNum}
    Click Element Until Visible    ${SearchedCustomer_DeleteBtn}
    @{Delete_Customer_elements}  Create List   ${locators_params['Settings']['Customer']['DeleteCustomer_popup']}[HeaderTxt]  ${locators_params['Settings']['Customer']['DeleteCustomer_popup']}[Delete_CustomerName]
    ...     ${locators_params['Settings']['Customer']['DeleteCustomer_popup']}[Cancel_Btn]  ${locators_params['Settings']['Customer']['DeleteCustomer_popup']}[Confirm_Btn]
    Wait Until Elements Are Visible     @{Delete_Customer_elements}
    Capture the Screen    Delete_Customer_Popup

Verify the cancel button is working properly in the delete customer details popup
    [Documentation]     Verify the cancel button is working properly in the delete customer details popup
    Wait Until Element Is Visible    ${locators_params['Settings']['Customer']['DeleteCustomer_popup']}[Cancel_Btn]
    Click Element Until Enabled    ${locators_params['Settings']['Customer']['DeleteCustomer_popup']}[Cancel_Btn]
    Show all the data from the table   All
    Wait Until Element Is Visible    ${locators_params['Settings']['Customer']}[Search_PhoneNo_TxtBox]
    Capture the Screen    DeleteCustomer_Cancel_Sucsess

Verify the confirm button is working properly in the delete customer details popup
    [Documentation]     Verify the confirm button is working properly in the delete customer details popup
    [Arguments]     ${PhoneNum}
    ${SearchedCustomer_DeleteBtn}  Format String    ${locators_params['Settings']['Customer']}[SearchedCustomer_DeleteBtn]    value=${PhoneNum}
    Click Element Until Visible    ${SearchedCustomer_DeleteBtn}
    Wait Until Element Is Visible    ${locators_params['Settings']['Customer']['DeleteCustomer_popup']}[Confirm_Btn]
    Click Element Until Enabled    ${locators_params['Settings']['Customer']['DeleteCustomer_popup']}[Confirm_Btn]
    Wait Until Element Is Visible    ${locators_params['Settings']['Customer']}[Search_PhoneNo_TxtBox]
    Capture the Screen    DeleteCustomer_Confirm_Success

#Closed the edit and delete popup
#    [Documentation]    Closed the edit and delete popup
#    ${Edit_Popup_CancelBtn}    Run Keyword And Return Status    Wait Until Element Is Visible    ${locators_params['Settings']['Edit_popup']}[Cancel_Btn]
#    Run Keyword If    ${Edit_Popup_CancelBtn} == True    Run Keywords    Click Element Until Visible    ${locators_params['Settings']['Edit_popup']}[Cancel_Btn]
#    ...    AND    Wait Until Element Is Not Visible    ${locators_params['Settings']['Edit_popup']}[Cancel_Btn]
#    ${Delete_Popup_CancelBtn}    Run Keyword And Return Status    Wait Until Element Is Visible    ${locators_params['Settings']['Delete_popup']}[Header_Text]
#    Run Keyword If    ${Delete_Popup_CancelBtn} == True    Click Element Until Visible    ${locators_params['Settings']['Delete_popup']}[Cancel_Btn]
#    ...    AND    Wait Until Element Is Not Visible    ${locators_params['Settings']['Delete_popup']}[Cancel_Btn]
#    ${CloseIcon}    Run Keyword And Return Status    Wait Until Element Is Visible    ${locators_params['Home']['SelectCustomer_Popup']}[CloseIcon]
#    Run Keyword If    ${CloseIcon} == True    Click Element Until Visible    ${locators_params['Home']['SelectCustomer_Popup']}[CloseIcon]
#    ...    AND    Wait Until Element Is Not Visible    ${locators_params['Home']['SelectCustomer_Popup']}[CloseIcon]

#### Settings - Branches ###
Verify all the elements are visible in the branches settings page
    [Documentation]     Verify all the elements are visible in the branches settings page
    [Arguments]  ${Branch_Name}     ${Edit_BranchName}
    wait until element is visible  ${locators_params['Home']}[Settings_Icon]
    Click Element Until Visible  ${locators_params['Home']}[Settings_Icon]
    wait until element is visible    ${locators_params['Settings']['Branches']}[BranchesTab_Btn]
    Click Element Until Visible    ${locators_params['Settings']['Branches']}[BranchesTab_Btn]
    Capture the Screen    Settings_Branches_Tab
    Verify the title of settings-branches page
    ${response}  Call Method    ${API_POSLaundry}   getAPI_Branch
    Log    ${response}
    Run Keyword If    ${response}[1] == 0  Verify that branches page elements are visible when no branch is added
    ...     ELSE  run keywords  Verify all elements are visible in settings-branches page   ${Branch_Name}   ${Edit_BranchName}
    ...     AND   Verify all elements are visible in added branch section     ${BranchName}   ${Edit_BranchName}

Verify that branches page elements are visible when no branch is added
    [Documentation]  Verify that branches page elements are visible when no branch is added
    @{NoBranch_Added_elements}  Create List  ${locators_params['Settings']}[Clicked_Tab]
    ...     ${locators_params['Settings']['Branches']}[AddBranch_Btn]
    Wait Until Elements Are Visible  @{NoBranch_Added_elements}

Verify all elements are visible in settings-branches page
    [Documentation]     Verify all elements are visible in settings-branches page
    [Arguments]    ${Branch_Name}   ${Edit_BranchName}
    ${Actions_Btn}  Format String    ${locators_params['Settings']['Branches']}[Actions_Btn]  value=${BranchName}
    ${branch_Status}  run keyword and return status  wait until element is visible  ${Actions_Btn}
    run keyword if  ${branch_Status} == True  Validate all elements are visible in the branch page  ${BranchName}
    ${EditBranch_Actions_Btn}  Format String    ${locators_params['Settings']['Branches']}[Actions_Btn]  value=${Edit_BranchName}
    ${EditBranch_Status}  run keyword and return status  wait until element is visible  ${EditBranch_Actions_Btn}
    run keyword if  ${EditBranch_Status} == True  Validate all elements are visible in the branch page  ${Edit_BranchName}

Validate all elements are visible in the branch page
    [Documentation]  Validate all elements are visible in the branch page
    [Arguments]    ${BranchName}
    ${Actions_Btn}  Format String    ${locators_params['Settings']['Branches']}[Actions_Btn]  value=${BranchName}
    ${Added_Branches_Section}  Format String    ${locators_params['Settings']['Branches']}[Added_Branches_Section]  value=${BranchName}
    @{Branches_elements}  Create List  ${locators_params['Settings']}[Clicked_Tab]
    ...     ${locators_params['Settings']['Branches']}[AddBranch_Btn]  ${Added_Branches_Section}
    ...     ${Actions_Btn}
    Wait Until Elements Are Visible  @{Branches_elements}
    Capture the Screen    AddedBranch_Section

Verify all elements are visible in added branch section
    [Documentation]     Verify all elements are visible in added branch section
    [Arguments]  ${BranchName}  ${Edit_BranchName}
    ${NewBranch}    format string  ${locators_params['Settings']['Branches']}[Actions_Btn]  value=${BranchName}
    ${NewBranch_Status}  run keyword and return status  wait until element is visible  ${NewBranch}
    run keyword if  ${NewBranch_Status} == True  Verify the added branch section elements  ${BranchName}
    ${EditBranch}    format string  ${locators_params['Settings']['Branches']}[Actions_Btn]  value=${Edit_BranchName}
    ${EditBranch_Status}  run keyword and return status  wait until element is visible  ${NewBranch}
    run keyword if  ${EditBranch_Status} == True    Verify the added branch section elements  ${Edit_BranchName}
    @{AddedBranch_Section_LblTxts}  Create List  ${testData_config['Settings']['Branches']['Added_Branch_Section']}[BranchName_LblTxt]
    ...     ${testData_config['Settings']['Branches']['Added_Branch_Section']}[Branch_OpeningDate_LblTxt]    ${testData_config['Settings']['Branches']['Added_Branch_Section']}[ContactPersonName_LblTxt]
    ...     ${testData_config['Settings']['Branches']['Added_Branch_Section']}[ContactNumber_LblTxt]    ${testData_config['Settings']['Branches']['Added_Branch_Section']}[Address_LblTxt]
    @{AddedBranch_Section_Elements}  Create List  ${locators_params['Settings']['Branches']['Added_Branch_Section']}[BranchName_LblTxt]
    ...     ${locators_params['Settings']['Branches']['Added_Branch_Section']}[Branch_OpeningDate_LblTxt]   ${locators_params['Settings']['Branches']['Added_Branch_Section']}[ContactPersonName_LblTxt]
    ...     ${locators_params['Settings']['Branches']['Added_Branch_Section']}[ContactNumber_LblTxt]    ${locators_params['Settings']['Branches']['Added_Branch_Section']}[Address_LblTxt]
    ${AddedBranchSection_Elements}     create list
    FOR  ${element}  IN  @{AddedBranch_Section_Elements}
        ${ele}  format string  ${AddedBranch_Section_Elements}   value=${BranchName}
        append to list    ${AddedBranchSection_Elements}     ${ele}
    END
    check all the get elements text are should be equal  ${AddedBranchSection_Elements}    ${AddedBranch_Section_LblTxts}
    
Verify the added branch section elements
    [Documentation]  Verify the added branch section elements 
    [Arguments]  ${BranchName}
    @{AddedBranch_Section_Elements}  Create List  ${locators_params['Settings']['Branches']['Added_Branch_Section']}[BranchName_LblTxt]
    ...     ${locators_params['Settings']['Branches']['Added_Branch_Section']}[Branch_OpeningDate_LblTxt]   ${locators_params['Settings']['Branches']['Added_Branch_Section']}[ContactPersonName_LblTxt]
    ...     ${locators_params['Settings']['Branches']['Added_Branch_Section']}[ContactNumber_LblTxt]    ${locators_params['Settings']['Branches']['Added_Branch_Section']}[Address_LblTxt]
    ...     ${locators_params['Settings']['Branches']['Added_Branch_Section']}[BranchName_Value]    ${locators_params['Settings']['Branches']['Added_Branch_Section']}[Branch_OpeningDate_Value]
    ...     ${locators_params['Settings']['Branches']['Added_Branch_Section']}[ContactPersonName_Value]  ${locators_params['Settings']['Branches']['Added_Branch_Section']}[ContactNumber_Value]
    ...     ${locators_params['Settings']['Branches']['Added_Branch_Section']}[Address_Value]
    ${AddedBranchSection_Elements}     create list
    FOR  ${element}  IN  @{AddedBranch_Section_Elements}
        ${ele}  format string  ${AddedBranch_Section_Elements}   value=${BranchName}
        append to list    ${AddedBranchSection_Elements}     ${ele}
    END
    Wait Until Elements Are Visible  @{AddedBranchSection_Elements}

### Add Branch ###
Verify user able to add new branch
    [Documentation]     Verify user able to add new branch and validate the Add Branch button
    [Arguments]  ${BranchName}  ${Edit_BranchName}  
    Verify the exist branch is present or not   ${BranchName}  ${Edit_BranchName}
    Verify all elements are visible in add branch popup
    Validate all elements label texts in add branch popup
    Verify the add branch popup cancel button is working properly
    Verify the add branch popup confirm button is working properly

Verify all elements are visible in add branch popup
    [Documentation]     Verify all elements are visible in add branch popup
    Click Element Until Enabled    ${locators_params['Settings']['Branches']}[AddBranch_Btn]
    @{AddBranch_popupElements}  Create List  ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[Header_LblTxt]
    ...     ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[BranchNameTxtBox_LblTxt]  ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[BranchName_TxtBox]
    ...     ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[BranchOpeningDate_LblTxt]  ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[BranchOpeningDate_TxtBox]
    ...     ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[Apartment_Address_LblTxt]  ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[Apartment_Address_TxtBox]
    ...     ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[StreetNameTxtBox_LblTxt]  ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[StreetName_TxtBox]
    ...     ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[CountryDD_LblTxt]  ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[Country_DD]
    ...     ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[StateDD_LblTxt]  ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[State_DD]
    ...     ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[DistrictDD_LblTxt]  ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[District_DD]
    ...     ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[PinCodeTxtBox_LblTxt]  ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[PinCode_TxtBox]
    ...     ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[Cancel_Btn]  ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[Confirm_Btn]
    Wait Until Elements Are Visible  @{AddBranch_popupElements}
    Capture the Screen    AddBranch_popup_Elements

Verify the exist branch is present or not
    [Documentation]    Verify the exist branch is present or not
    [Arguments]  ${BranchName}  ${Edit_BranchName}
    ${response}  Call Method    ${API_POSLaundry}   getAPI_Branch
    Log    ${response}
    Run Keyword If    ${response}[1] != 0   run keywords  Verify all elements are visible in added branch section  ${BranchName}  ${Edit_BranchName}
    ...    AND   Delete all the exist branches   ${BranchName}  ${Edit_BranchName}
    ...    ELSE   log  Exists Branch is not available
    
Validate all elements label texts in add branch popup
    [Documentation]     Validate all elements label texts in add branch popup
    @{AddBranch_popupElements}  Create List  ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[Header_LblTxt]
    ...     ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[BranchNameTxtBox_LblTxt]    ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[Apartment_Address_LblTxt]
    ...     ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[StreetNameTxtBox_LblTxt]    ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[CountryDD_LblTxt]
    ...     ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[StateDD_LblTxt]    ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[DistrictDD_LblTxt]
    ...     ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[PinCodeTxtBox_LblTxt]
    ...     ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[Cancel_Btn]  ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[Confirm_Btn]
    @{AddBranch_popup_LblTxts}  Create List  ${testData_config['Settings']['Branches']['Add_Branch_Popup']}[Header_LblTxt]
    ...     ${testData_config['Settings']['Branches']['Add_Branch_Popup']}[BranchNameTxtBox_LblTxt]    ${testData_config['Settings']['Branches']['Add_Branch_Popup']}[Apartment_Address_LblTxt]
    ...     ${testData_config['Settings']['Branches']['Add_Branch_Popup']}[StreetNameTxtBox_LblTxt]    ${testData_config['Settings']['Branches']['Add_Branch_Popup']}[CountryDD_LblTxt]
    ...     ${testData_config['Settings']['Branches']['Add_Branch_Popup']}[StateDD_LblTxt]    ${testData_config['Settings']['Branches']['Add_Branch_Popup']}[DistrictDD_LblTxt]
    ...     ${testData_config['Settings']['Branches']['Add_Branch_Popup']}[PinCodeTxtBox_LblTxt]
    ...     ${testData_config['Settings']['Branches']['Add_Branch_Popup']}[Cancel_Btn]    ${testData_config['Settings']['Branches']['Add_Branch_Popup']}[Confirm_Btn]
    Check all the get elements text are should be equal    ${AddBranch_popupElements}    ${AddBranch_popup_LblTxts}

Verify the add branch popup cancel button is working properly
    [Documentation]     Verify the add branch popup cancel button is working properly
    Verify the add branch popup cancel button is working properly without fill any details
    Verify the add branch popup cancel button is working properly when filling any details

Verify the add branch popup cancel button is working properly without fill any details
    [Documentation]     Verify the add branch popup cancel button is working properly without fill any details
    ${Confirm_Btn_Txt}  Get Text  ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[Cancel_Btn]
    Should Be Equal    ${Confirm_Btn_Txt}    ${testData_config['Settings']['Branches']['Add_Branch_Popup']}[Cancel_Btn]
    Element Should Be Enabled    ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[Cancel_Btn]
    Click Element Until Enabled    ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[Cancel_Btn]
    Wait Until Element Is Visible    ${locators_params['Settings']['Branches']}[AddBranch_Btn]
    Click Element Until Enabled    ${locators_params['Settings']['Branches']}[AddBranch_Btn]
    Element Should Be Disabled    ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[Confirm_Btn]
    Element Should Be Enabled     ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[Cancel_Btn]

Verify the add branch popup cancel button is working properly when filling any details
    [Documentation]     Verify the add branch popup cancel button is working properly when filling any details
    @{AddBranch_Elements}  Create List  ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[BranchName_TxtBox]
    ...     ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[Apartment_Address_TxtBox]  ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[StreetName_TxtBox]
    ...     ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[PinCode_TxtBox]
    @{InputData_AddBranch}  Create List   ${testData_config['Settings']['Branches']['Add_Branch_Popup']['TestData']}[BranchName]
    ...     ${testData_config['Settings']['Branches']['Add_Branch_Popup']['TestData']}[Apartment_Address]    ${testData_config['Settings']['Branches']['Add_Branch_Popup']['TestData']}[StreetName]
    ...     ${testData_config['Settings']['Branches']['Add_Branch_Popup']['TestData']}[PinCode]
    Enter multiple value in the inputfields    ${AddBranch_Elements}    ${InputData_AddBranch}
    @{DropDown_Elements}  Create List   ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[Country_DD]
    ...    ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[State_DD]    ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[District_DD]
    @{DropDown_Values}  Create List   ${testData_config['Settings']['Branches']['Add_Branch_Popup']['TestData']}[CountryName]
    ...    ${testData_config['Settings']['Branches']['Add_Branch_Popup']['TestData']}[StateName]  ${testData_config['Settings']['Branches']['Add_Branch_Popup']['TestData']}[DistrictName]
#    Select from dropdown list option by labels    ${DropDown_Elements}  ${DropDown_Values}
    ${count}    Get Length    ${DropDown_Elements}
    FOR    ${i}    IN RANGE    0    ${count}
        Select from dropdown list option  ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[Dropdown_Options]  ${DropDown_Values}[${i}]   ${DropDown_Elements}[${i}]
    END
    Element Should Be Enabled    ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[Confirm_Btn]
    Click Element Until Enabled    ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[Cancel_Btn]
    Wait Until Element Is Visible    ${locators_params['Settings']['Branches']}[AddBranch_Btn]
    Click Element Until Enabled    ${locators_params['Settings']['Branches']}[AddBranch_Btn]
    Element Should Be Disabled    ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[Confirm_Btn]
    ${BrachName_TxtBox_Value}  Get Element Attribute    ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[BranchName_TxtBox]    value
    Should Not Be Equal    ${BrachName_TxtBox_Value}    ${testData_config['Settings']['Branches']['Add_Branch_Popup']['TestData']}[BranchName]
    Capture the Screen    Cancel_Button_Disabled

Verify the add branch popup confirm button is working properly
    [Documentation]     Verify the add branch popup confirm button is working properly
    Verify the add branch popup confirm button is working properly without fill any details
    Verify the add branch popup confirm button is working properly when filling any details

Verify the add branch popup confirm button is working properly without fill any details
    [Documentation]     Verify the add branch popup cancel button is working properly without fill any details
    Element Should Be Disabled    ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[Confirm_Btn]
    ${Confirm_Btn_Txt}  Get Text  ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[Confirm_Btn]
    Should Be Equal    ${Confirm_Btn_Txt}    ${testData_config['Settings']['Branches']['Add_Branch_Popup']}[Confirm_Btn]
    Click Element Until Enabled    ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[Cancel_Btn]
    Wait Until Element Is Visible    ${locators_params['Settings']['Branches']}[AddBranch_Btn]
    Click Element Until Enabled    ${locators_params['Settings']['Branches']}[AddBranch_Btn]
    Element Should Be Disabled    ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[Confirm_Btn]

Verify the add branch popup confirm button is working properly when filling any details
    [Documentation]     Verify the add branch popup cancel button is working properly when filling any details
    @{AddBranch_Elements}  Create List  ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[BranchName_TxtBox]
    ...     ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[Apartment_Address_TxtBox]  ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[StreetName_TxtBox]
    ...     ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[PinCode_TxtBox]
    @{InputData_AddBranch}  Create List   ${testData_config['Settings']['Branches']['Add_Branch_Popup']['TestData']}[BranchName]
    ...     ${testData_config['Settings']['Branches']['Add_Branch_Popup']['TestData']}[Apartment_Address]    ${testData_config['Settings']['Branches']['Add_Branch_Popup']['TestData']}[StreetName]
    ...     ${testData_config['Settings']['Branches']['Add_Branch_Popup']['TestData']}[PinCode]
    Enter multiple value in the inputfields    ${AddBranch_Elements}    ${InputData_AddBranch}
    @{DropDown_Elements}  Create List   ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[Country_DD]
    ...    ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[State_DD]    ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[District_DD]
    @{DropDown_Values}  Create List   ${testData_config['Settings']['Branches']['Add_Branch_Popup']['TestData']}[CountryName]
    ...    ${testData_config['Settings']['Branches']['Add_Branch_Popup']['TestData']}[StateName]  ${testData_config['Settings']['Branches']['Add_Branch_Popup']['TestData']}[DistrictName]
    ${count}    Get Length    ${DropDown_Elements}
    FOR    ${i}    IN RANGE    0    ${count}
        Select from dropdown list option  ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[Dropdown_Options]  ${DropDown_Values}[${i}]   ${DropDown_Elements}[${i}]
    END
    Sleep    3s
    Click Element Until Enabled    ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[Confirm_Btn]
#    Page Should Contain    ${testData_config['Toast_Messages']}[BranchCreated_SuccessMsg]
    Sleep    5s
    wait until element is visible  ${locators_params['Settings']['Branches']}[AddBranch_Btn]
    Page Should Contain Button    ${locators_params['Settings']['Branches']}[AddBranch_Btn]
    Capture The Screen    NewBranch_Added_Success

####  Actions - Edit and Delete ####
Verify the actions menu button
    [Documentation]  Verify the actions menu button
    [Arguments]    ${Branch_Name}
    ${action_Btn}  Format String    ${locators_params['Settings']['Branches']}[Actions_Btn]   value=${Branch_Name}
    Click Element Until Visible    ${action_Btn}
    capture the screen  Actions_Btn_Displayed
    @{Actions_buttons}  create list  ${locators_params['Settings']['Branches']}[Edit_action]  ${locators_params['Settings']['Branches']}[Delete_action]
    wait until elements are visible  @{Actions_buttons}
    Click Element Until Visible    ${action_Btn}
    capture the screen  ActionsBtn_NotDisplayed
    page should not contain multiple element  @{Actions_buttons}

####  Edit Branch ###
Verify user able to edit the added branch
    [Documentation]  Verify user able to edit the added branch
    [Arguments]  ${New_BranchName}  ${Edit_BranchName}
    Verify that all elements are visible in edit branch popup   ${New_BranchName}
    Validate all elements label texts and textbox value in edit branch popup
    Verify the edit branch popup cancel button is working properly  ${New_BranchName}  ${Edit_BranchName}
    Verify the edit branch popup update button is working properly  ${New_BranchName}  ${Edit_BranchName}

Verify that all elements are visible in edit branch popup
    [Documentation]  Verify that all elements are visible in edit branch popup
    [Arguments]  ${New_BranchName}
    ${action_Btn}  Format String    ${locators_params['Settings']['Branches']}[Actions_Btn]   value=${New_BranchName}
    Click Element Until Visible    ${action_Btn}
    Click Element Until Visible    ${locators_params['Settings']['Branches']}[Edit_action]
    sleep  2s
    Entered value should be  ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[Branch_TxtBox]  ${New_BranchName}
    @{EditBranch_elements}  create list  ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[Header_LblTxt]
    ...     ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[BranchTxtBox_LblTxt]  ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[Branch_TxtBox]
    ...     ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[Apartment_Address_LblTxt]  ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[Apartment_Address_TxtBox]
    ...     ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[StreetNameTxtBox_LblTxt]  ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[StreetName_TxtBox]
    ...     ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[CountryDD_LblTxt]  ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[Country_DDBox]
    ...     ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[StateDD_LblTxt]  ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[State_DDBox]
    ...     ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[DistrictDD_LblTxt]  ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[District_DDBox]
    ...     ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[PinCodeTxtBox_LblTxt]  ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[PinCode_TxtBox]
    ...     ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[Cancel_Btn]  ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[Update_Btn]
    wait until elements are visible  @{EditBranch_elements}
    capture the screen  EditBranch_Popup

Validate all elements label texts and textbox value in edit branch popup
    [Documentation]  Validate all elements label texts and textbox value in edit branch popup
    Validate all textbox values in edit branch popup
    Validate all elements label texts in edit branch popup     # (Regarding Placeholder name Bug - 193, 194)

Validate all textbox values in edit branch popup
    [Documentation]  Validate all textbox values in edit branch popup
    @{EditBranch_elements}  Create List  ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[Branch_TxtBox]
    ...     ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[Apartment_Address_TxtBox]    ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[StreetName_TxtBox]
    ...     ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[Country_DDBox]    ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[State_DDBox]
    ...     ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[District_DDBox]    ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[PinCode_TxtBox]
    @{InputData_AddBranch}  Create List  ${testData_config['Settings']['Branches']['Add_Branch_Popup']['TestData']}[BranchName]
    ...     ${testData_config['Settings']['Branches']['Add_Branch_Popup']['TestData']}[Apartment_Address]    ${testData_config['Settings']['Branches']['Add_Branch_Popup']['TestData']}[StreetName]
    ...     ${testData_config['Settings']['Branches']['Add_Branch_Popup']['TestData']}[country_name]    ${testData_config['Settings']['Branches']['Add_Branch_Popup']['TestData']}[state_name]
    ...     ${testData_config['Settings']['Branches']['Add_Branch_Popup']['TestData']}[DistrictName]    ${testData_config['Settings']['Branches']['Add_Branch_Popup']['TestData']}[PinCode]
    ${CountOf_TxtBoxes}=    get element count  ${EditBranch_elements}
    capture the screen  EditBranch_Popup_Validation
    Check all elements of attribute value of textfields     ${CountOf_TxtBoxes}   ${EditBranch_elements}   ${InputData_AddBranch}

Validate all elements label texts in edit branch popup
    [Documentation]  Validate all elements label texts in edit branch popup
    @{EditBranch_popupElements}  Create List  ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[Header_LblTxt]
    ...     ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[BranchTxtBox_LblTxt]  ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[Apartment_Address_LblTxt]
    ...     ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[StreetNameTxtBox_LblTxt]  ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[CountryDD_LblTxt]
    ...     ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[StateDD_LblTxt]  ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[DistrictDD_LblTxt]
    ...     ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[PinCodeTxtBox_LblTxt]
    ...     ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[Cancel_Btn]  ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[Update_Btn]
    @{EditBranch_popup_LblTexts}  Create List  ${testData_config['Settings']['Branches']['Edit_Branch_Popup']}[Header_LblTxt]
    ...     ${testData_config['Settings']['Branches']['Edit_Branch_Popup']}[BranchTxtBox_LblTxt]  ${testData_config['Settings']['Branches']['Edit_Branch_Popup']}[Apartment_Address_LblTxt]
    ...     ${testData_config['Settings']['Branches']['Edit_Branch_Popup']}[StreetNameTxtBox_LblTxt]  ${testData_config['Settings']['Branches']['Edit_Branch_Popup']}[CountryDD_LblTxt]
    ...     ${testData_config['Settings']['Branches']['Edit_Branch_Popup']}[StateTxtBox_LblTxt]  ${testData_config['Settings']['Branches']['Edit_Branch_Popup']}[DistrictTxtBox_LblTxt]
    ...     ${testData_config['Settings']['Branches']['Edit_Branch_Popup']}[PinCodeTxtBox_LblTxt]
    ...     ${testData_config['Settings']['Branches']['Edit_Branch_Popup']}[Cancel_Btn]  ${testData_config['Settings']['Branches']['Edit_Branch_Popup']}[Update_Btn]
    Check all the get elements text are should be equal    ${EditBranch_popupElements}    ${EditBranch_popup_LblTexts}

Verify the edit branch popup cancel button is working properly
    [Documentation]  Verify the edit branch popup cancel button is working properly
    [Arguments]  ${New_BranchName}  ${Edit_BranchName}
    Verify the edit branch popup cancel button is working properly when removed all editable details    ${New_BranchName}  ${Edit_BranchName}
    Verify the edit branch popup cancel button is working properly when edit any details    ${New_BranchName}  ${Edit_BranchName}

Verify the edit branch popup cancel button is working properly when removed all editable details
    [Documentation]  Verify the edit branch popup cancel button is working properly when removed all editable details
    [Arguments]  ${New_BranchName}  ${Edit_BranchName}
    ${BrachName_TxtBox_Value}  Get Element Attribute    ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[BranchName_TxtBox]    value
    Should Be Equal    ${BrachName_TxtBox_Value}    ${New_BranchName}
    @{EditBranch_elements}  create list  ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[Branch_TxtBox]
    ...     ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[Country_DDBox]   ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[State_DDBox]
    ...     ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[District_DDBox]
    capture the screen  CancelBtn_Of_EditBranch
    Element Status Should Be Disabled   ${New_BranchName}
    @{Attribute}    create list
    FOR  ${element}  IN   @{EditBranch_elements}
        ${Disabled}  Get Element Attribute  ${element}  disabled
        append to list     ${Attribute}     ${Disabled}
        log  ${Attribute}
    END
    ${count}  get length  ${Attribute}
    FOR  ${i}  IN RANGE  0  ${count}
        run keyword if  '${attribute}[${i}]' == 'None'  click and clear element text  ${EditBranch_elements}[${i}]
        ...     ELSE    log   The element is disabled, So, we can't able to edit.
#        element should be disabled  ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[Update_Btn]
    END
    capture the screen  ClearAll_Textboxes

Verify the edit branch popup cancel button is working properly when edit any details
    [Documentation]  Verify the edit branch popup cancel button is working properly when edit any details
    [Arguments]  ${New_BranchName}  ${Edit_BranchName}
    ${NewBranch_actionBtn}  Format String    ${locators_params['Settings']['Branches']}[Actions_Btn]   value=${New_BranchName}
    ${Confirm_Btn_Txt}  Get Text  ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[Cancel_Btn]
    Should Be Equal    ${Confirm_Btn_Txt}    ${testData_config['Settings']['Branches']['Edit_Branch_Popup']}[Cancel_Btn]
    Element Should Be Enabled    ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[Cancel_Btn]
    Update all the editable textbox values in the edit branch popup
    element should be enabled  ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[Update_Btn]
    Click Element Until Enabled    ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[Cancel_Btn]
    click element until visible  ${NewBranch_actionBtn}
    click element until visible  ${locators_params['Settings']['Branches']}[Edit_action]
    sleep  3s
    ${UI_EditBranch_HeaderTxt}  get text  ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[Header_LblTxt]
    should be equal  ${UI_EditBranch_HeaderTxt}     ${testData_config['Settings']['Branches']['Edit_Branch_Popup']}[Header_LblTxt]
    ${BrachName_TxtBox_Value}  Get Element Attribute    ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[BranchName_TxtBox]    value
    Should Be Equal    ${BrachName_TxtBox_Value}    ${New_BranchName}

Update all the editable textbox values in the edit branch popup
    [Documentation]  update all the editable textbox values in the edit branch popup
    @{EditBranch_elements}  create list  ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[Apartment_Address_TxtBox]
    ...     ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[StreetName_TxtBox]    ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[PinCode_TxtBox]
    @{InputData_EditBranch}  Create List   ${testData_config['Settings']['Branches']['Edit_Branch_Popup']['TestData']}[Apartment_Address]
    ...     ${testData_config['Settings']['Branches']['Edit_Branch_Popup']['TestData']}[StreetName]   ${testData_config['Settings']['Branches']['Edit_Branch_Popup']['TestData']}[PinCode]
    @{Attribute}    create list
    @{Editable_textbox_elements}    create list
    ${CountOf_TxtBox}       Get Length   ${EditBranch_elements}
    FOR    ${i}    IN RANGE    0    ${CountOf_TxtBox}
        ${Disabled}  Get Element Attribute  ${EditBranch_elements}[${i}]  disabled
        append to list     ${Attribute}     ${Disabled}
        log  ${Attribute}
        ${Disabled_Status}  convert to string  ${Disabled}
        run keyword if  '${Disabled_Status}' == 'None'   run keyword  append to list     ${Editable_textbox_elements}     ${EditBranch_elements}[${i}]
        ${Pincode_ErrMsg_Status}    run keyword and return status  wait until element is visible  ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[PinCode_ErrMsg]
        run keyword if  ${Pincode_ErrMsg_Status} == True  Validate the pincode error message
#        element should be disabled  ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[Update_Btn]
    END
    Clear all textboxes value   @{Editable_textbox_elements}
#    element should be disabled  ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[Update_Btn]
    Enter multiple value in the inputfields  ${Editable_textbox_elements}   ${InputData_EditBranch}
    capture the screen  Edited_Branch_001
    element should be enabled  ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[Update_Btn]

Validate the pincode error message
    [Documentation]  Validate the pincode error message
    ${UI_PinCode_ErrMsg_Txt}   get text  ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[PinCode_ErrMsg]
    capture the screen  PinCode_ErrMsg
    should be equal  ${UI_PinCode_ErrMsg_Txt}  ${testData_config['Settings']['Branches']['Edit_Branch_Popup']}[PinCode_ErrMsg]

Verify the edit branch popup update button is working properly
    [Documentation]  Verify the edit branch popup update button is working properly
    [Arguments]  ${New_BranchName}  ${Edit_BranchName}
    Verify the edit branch popup update button is working properly when removed all editable details    ${New_BranchName}  ${Edit_BranchName}
    Verify the edit branch popup update button is working properly when edit any details    ${New_BranchName}  ${Edit_BranchName}

Verify the edit branch popup update button is working properly when removed all editable details
    [Documentation]  Verify the edit branch popup update button is working properly when removed all editable details
    [Arguments]  ${New_BranchName}  ${Edit_BranchName}
    ${BrachName_TxtBox_Value}  Get Element Attribute    ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[BranchName_TxtBox]    value
    Should Be Equal    ${BrachName_TxtBox_Value}    ${New_BranchName}
    @{EditBranch_elements}  create list  ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[Branch_TxtBox]
    ...     ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[Address_TxtBox]   ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[StreetName_TxtBox]
    ...     ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[State_TxtBox]   ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[District_TxtBox]
    ...     ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[PinCode_TxtBox]
    capture the screen  CancelBtn_Of_EditBranch
    Element Status Should Be Disabled   ${New_BranchName}
    @{Attribute}    create list
    FOR  ${element}  IN   @{EditBranch_elements}
        ${Disabled}  Get Element Attribute  ${element}  disabled
        append to list     ${Attribute}     ${Disabled}
        log  ${Attribute}
        ${Disabled_Status}  convert to string  ${Disabled}
        run keyword if  '${Disabled_Status}' == 'None'   run keyword  click and clear element text  ${element}
#        element should be disabled  ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[Update_Btn]
    END
#    element should be disabled  ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[Update_Btn]
    capture the screen  ClearAll_Textfields

Verify the edit branch popup update button is working properly when edit any details
    [Documentation]  Verify the edit branch popup update button is working properly when edit any details
    [Arguments]  ${New_BranchName}  ${Edit_BranchName}
    ${NewBranch_actionBtn}  Format String    ${locators_params['Settings']['Branches']}[Actions_Btn]   value=${New_BranchName}
    ${Confirm_Btn_Txt}  Get Text  ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[Update_Btn]
    Should Be Equal    ${Confirm_Btn_Txt}    ${testData_config['Settings']['Branches']['Edit_Branch_Popup']}[Update_Btn]
    Element Should Be Enabled    ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[Cancel_Btn]
    Update all the editable textbox values in the edit branch popup
    element should be enabled  ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[Update_Btn]
    Click Element Until Enabled    ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[Update_Btn]
#    page should contain  ${testData_config['Toast_Messages']}[BranchUpdated_SuccessMsg]
    sleep  3s
    capture the screen  Updated_Branch
    wait until element is visible  ${locators_params['Settings']['Branches']}[AddBranch_Btn]
    Page Should Contain Button    ${locators_params['Settings']['Branches']}[AddBranch_Btn]
    Validate the edited data should be dispalyed    ${New_BranchName}
    ${EditBranch_actionBtn}  Format String    ${locators_params['Settings']['Branches']}[Actions_Btn]   value=${New_BranchName}
    wait until element is visible  ${EditBranch_actionBtn}
    click element until visible  ${EditBranch_actionBtn}
    click element until visible  ${locators_params['Settings']['Branches']}[Edit_action]
    sleep  3s
    ${UI_EditBranch_HeaderTxt}  get text  ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[Header_LblTxt]
    should be equal  ${UI_EditBranch_HeaderTxt}     ${testData_config['Settings']['Branches']['Edit_Branch_Popup']}[Header_LblTxt]
    ${BrachName_TxtBox_Value}  Get Element Attribute    ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[BranchName_TxtBox]    value
    Should Be Equal    ${BrachName_TxtBox_Value}    ${New_BranchName}
    capture the screen  Update_Button
    Click Element Until Enabled    ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[Cancel_Btn]
    sleep  3s
    Page Should Contain Button    ${locators_params['Settings']['Branches']}[AddBranch_Btn]

Validate the edited data should be dispalyed
    [Documentation]  Validate the edited data should be dispalyed
    [Arguments]  ${New_BranchName}
    ${UI_Data_EditedBranch_element}    format string  ${locators_params['Settings']['Branches']['Added_Branch_Section']}[Address_Value]  value=${New_BranchName}
    ${UI_Data}  get text  ${UI_Data_EditedBranch_element}
    capture the screen  Data_Displayed
    @{Edited_inputData}  create list  ${testData_config['Settings']['Branches']['Edit_Branch_Popup']['TestData']}[Apartment_Address]
    ...     ${testData_config['Settings']['Branches']['Edit_Branch_Popup']['TestData']}[StreetName]  ${testData_config['Settings']['Branches']['Edit_Branch_Popup']['TestData']}[PinCode]
    List comparision with element should contain the values    ${Edited_inputData}  ${UI_Data}
    @{Added_inputData}  create list  ${testData_config['Settings']['Branches']['Add_Branch_Popup']['TestData']}[Apartment_Address]
    ...     ${testData_config['Settings']['Branches']['Add_Branch_Popup']['TestData']}[StreetName]  ${testData_config['Settings']['Branches']['Add_Branch_Popup']['TestData']}[PinCode]
    List comparision with element should not contain the values    ${Added_inputData}  ${UI_Data}

####  Delete Branch Popup ###
Verify user able to delete the added or edited branch
    [Documentation]  Verify user able to delete the added or edited branch
    [Arguments]    ${Branch_Name}   ${Edit_Branch}
    ${NewBranch_actionBtn}  Format String    ${locators_params['Settings']['Branches']}[Actions_Btn]   value=${Branch_Name}
    ${Branch_Status}    run keyword and return status  wait until element is visible  ${NewBranch_actionBtn}
    run keyword if  ${Branch_Status} == True  Validate the delete branch popup  ${NewBranch_actionBtn}
    ${EditBranch_actionBtn}  Format String    ${locators_params['Settings']['Branches']}[Actions_Btn]   value=${Edit_Branch}
    ${Branch_Status}    run keyword and return status  wait until element is visible  ${EditBranch_actionBtn}
    run keyword if  ${Branch_Status} == True  Validate the delete branch popup  ${EditBranch_actionBtn}

Validate the delete branch popup
    [Documentation]  Validate the delete branch popup
    [Arguments]  ${Action_Btn}
    Click Element Until Visible    ${Action_Btn}
    Click Element Until Visible    ${locators_params['Settings']['Branches']}[Delete_action]
    Verify all the elements are visible in the delete branch popup page
    Verify all the elements label text in the delete branch popup page
    Validate the delete branch popup cancel is working  ${Action_Btn}
    Validate the delete branch popup confirm is working  ${Action_Btn}

Verify all the elements are visible in the delete branch popup page
    [Documentation]  Verify all the elements are visible in the delete branch popup page
    @{DeleteBranch_elements}    create list     ${locators_params['Settings']['Branches']['Delete_Branch_Popup']}[Header_LblTxt]
    ...     ${locators_params['Settings']['Branches']['Delete_Branch_Popup']}[Description_LblTxt]   ${locators_params['Settings']['Branches']['Delete_Branch_Popup']}[Cancel_Btn]
    ...     ${locators_params['Settings']['Branches']['Delete_Branch_Popup']}[Confirm_Btn]
    wait until elements are visible  @{DeleteBranch_elements}
    capture the screen  Delete_Branch_Popup

Verify all the elements label text in the delete branch popup page
    [Documentation]  Verify all the elements label text in the delete branch popup page
    @{DeleteBranch_elements}    create list     ${locators_params['Settings']['Branches']['Delete_Branch_Popup']}[Header_LblTxt]
    ...     ${locators_params['Settings']['Branches']['Delete_Branch_Popup']}[Description_LblTxt]   ${locators_params['Settings']['Branches']['Delete_Branch_Popup']}[Cancel_Btn]
    ...     ${locators_params['Settings']['Branches']['Delete_Branch_Popup']}[Confirm_Btn]
    @{DeleteBranch_LblTxts}    create list     ${testData_config['Settings']['Branches']['Delete_Branch_Popup']}[Header_LblTxt]
    ...     ${testData_config['Settings']['Branches']['Delete_Branch_Popup']}[Description_LblTxt]   ${testData_config['Settings']['Branches']['Delete_Branch_Popup']}[Cancel_Btn]
    ...     ${testData_config['Settings']['Branches']['Delete_Branch_Popup']}[Confirm_Btn]
    check all the get elements text are should be equal  ${DeleteBranch_elements}   ${DeleteBranch_LblTxts}

Validate the delete branch popup cancel is working
    [Documentation]  Validate the delete branch popup cancel is working
    [Arguments]  ${Action_Btn}
    ${UI_EditBranch_CancelBtn_Txt}  get text  ${locators_params['Settings']['Branches']['Delete_Branch_Popup']}[Cancel_Btn]
    should be equal  ${UI_EditBranch_CancelBtn_Txt}     ${testData_config['Settings']['Branches']['Delete_Branch_Popup']}[Cancel_Btn]
    element should be enabled  ${locators_params['Settings']['Branches']['Delete_Branch_Popup']}[Cancel_Btn]
    click element until enabled  ${locators_params['Settings']['Branches']['Delete_Branch_Popup']}[Cancel_Btn]
    wait until element is visible  ${Action_Btn}

Validate the delete branch popup confirm is working
    [Documentation]  Validate the delete branch popup confirm is working
    [Arguments]  ${Action_Btn}
    Click Element Until Visible    ${Action_Btn}
    Click Element Until Visible    ${locators_params['Settings']['Branches']}[Delete_action]
    ${UI_EditBranch_CancelBtn_Txt}  get text  ${locators_params['Settings']['Branches']['Delete_Branch_Popup']}[Confirm_Btn]
    should be equal  ${UI_EditBranch_CancelBtn_Txt}     ${testData_config['Settings']['Branches']['Delete_Branch_Popup']}[Confirm_Btn]
    element should be enabled  ${locators_params['Settings']['Branches']['Delete_Branch_Popup']}[Confirm_Btn]
    click element until enabled  ${locators_params['Settings']['Branches']['Delete_Branch_Popup']}[Confirm_Btn]
    wait until element is not visible  ${Action_Btn}

Delete all the exist branches
    [Documentation]    Delete all the exist branches
    [Arguments]    ${Branch_Name}   ${Edit_Branch}
    ${AddBranch_CancelBtn_Status}     run keyword and return status  wait until element is visible  ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[Cancel_Btn]
    run keyword if  ${AddBranch_CancelBtn_Status} == True   click element until enabled  ${locators_params['Settings']['Branches']['Add_Branch_Popup']}[Cancel_Btn]
    ${EditBranch_CancelBtn_Status}     run keyword and return status  wait until element is visible  ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[Cancel_Btn]
    run keyword if  ${EditBranch_CancelBtn_Status} == True   click element until enabled  ${locators_params['Settings']['Branches']['Edit_Branch_Popup']}[Cancel_Btn]
    capture the screen  Closeed_Popup
    ${NewBranch_actionBtn}  Format String    ${locators_params['Settings']['Branches']}[Actions_Btn]   value=${Branch_Name}
    ${Branch_Status}    run keyword and return status  wait until element is visible  ${NewBranch_actionBtn}
    run keyword if  ${Branch_Status} == True  Delete the branch  ${NewBranch_actionBtn}
    ${EditBranch_actionBtn}  Format String    ${locators_params['Settings']['Branches']}[Actions_Btn]   value=${Edit_Branch}
    ${Branch_Status}    run keyword and return status  wait until element is visible  ${EditBranch_actionBtn}
    run keyword if  ${Branch_Status} == True  Delete the branch  ${EditBranch_actionBtn}

Delete the branch
    [Documentation]  Delete the branch
    [Arguments]  ${action_Btn}
    Click Element Until Visible    ${action_Btn}
    capture the screen  Actions_Options
    Click Element Until Visible    ${locators_params['Settings']['Branches']}[Delete_action]
    Wait Until Element Is Visible   ${locators_params['Settings']['Branches']['Delete_Branch_Popup']}[Header_LblTxt]
    Click Element Until Enabled    ${locators_params['Settings']['Branches']['Delete_Branch_Popup']}[Confirm_Btn]
    sleep  3s
    Capture the Screen  Branch_Deleted
    wait until element is not visible  ${action_Btn}

#### Settings - Users ####
Verify all the elements are visible in the users settings page
    [Documentation]  Verify all the elements are visible in the users settings page
    wait until element is visible  ${locators_params['Home']}[Settings_Icon]
    Click Element Until Visible  ${locators_params['Home']}[Settings_Icon]
    Wait Until Element Visible    ${locators_params['Settings']['Users']}[UsersTab_Btn]
    Click Element Until Visible    ${locators_params['Settings']['Users']}[UsersTab_Btn]
    Verify the title of settings-users page
    ${SelectedTab}  get text  ${locators_params['Settings']}[Clicked_Tab]
    should be equal  ${SelectedTab}  ${testData_config['Settings']['Users']}[TabName]
    @{Users_elements}  create list  ${locators_params['Settings']['Users']}[AddUser_Btn]
    ...     ${locators_params['Settings']['Users']}[Table]
    Wait Until Elements Are Visible     @{Users_elements}
    Capture the Screen    Settings_UsersPage
    Validate the users table column headers texts

Validate the users table column headers texts
    [Documentation]  Validate the users table column headers texts
    @{Tableheader_Txts}  create list  ${testData_config['Settings']['Users']['Table']}[SNo_ColumnHeaderTxt]
    ...     ${testData_config['Settings']['Users']['Table']}[Name_ColumnHeaderTxt]  ${testData_config['Settings']['Users']['Table']}[UserName_ColumnHeaderTxt]
    ...     ${testData_config['Settings']['Users']['Table']}[PhoneNumber_ColumnHeaderTxt]   ${testData_config['Settings']['Users']['Table']}[DateOfJoining_ColumnHeaderTxt]
    ...     ${testData_config['Settings']['Users']['Table']}[LeavingDate_ColumnHeaderTxt]   ${testData_config['Settings']['Users']['Table']}[Status_ColumnHeaderTxt]
    ...     ${testData_config['Settings']['Users']['Table']}[SelectedBranch_ColumnHeaderTxt]   ${testData_config['Settings']['Users']['Table']}[Roles_ColumnHeaderTxt]
    ...     ${testData_config['Settings']['Users']['Table']}[Actions_ColumnHeaderTxt]
    Get text and Ensure the Headers are Equal    ${locators_params['Settings']}[TableColumn_Headers]  @{Tableheader_Txts}

#### Add User Popup #####
Validate the add user button text in the users page
    [Documentation]  Validate the add user button text in the users page
    ${AddUser_BtnTxt}  get text  ${locators_params['Settings']['Users']}[AddUser_Btn]
    should be equal  ${AddUser_BtnTxt}  ${testData_config['Settings']['Users']}[AddUser_BtnTxt]

Verify the add user button is working properly
    [Documentation]  Verify the add user button is working properly
    wait until element is visible  ${locators_params['Settings']['Users']}[AddUser_Btn]
    click element until enabled  ${locators_params['Settings']['Users']}[AddUser_Btn]
    wait until element is visible  ${locators_params['Settings']['Users']['Add_User_Popup']}[Header_LblTxt]

Verify all the add user popup elements are visible
    [Documentation]  Verify all the add user popup elements are visible
    @{AddUser_PopupElements}    create list  ${locators_params['Settings']['Users']['Add_User_Popup']}[Header_LblTxt]
    ...     ${locators_params['Settings']['Users']['Add_User_Popup']}[Name_TxtBox_LblTxt]    ${locators_params['Settings']['Users']['Add_User_Popup']}[Name_TxtBox]
    ...     ${locators_params['Settings']['Users']['Add_User_Popup']}[PhoneNo_TxtBox_LblTXt]    ${locators_params['Settings']['Users']['Add_User_Popup']}[PhoneNo_TxtBox]
    ...     ${locators_params['Settings']['Users']['Add_User_Popup']}[EmailId_TxtBox_LblTxt]    ${locators_params['Settings']['Users']['Add_User_Popup']}[EmailId_TxtBox]
    ...     ${locators_params['Settings']['Users']['Add_User_Popup']}[DOB_TxtBox_LblTxt]    ${locators_params['Settings']['Users']['Add_User_Popup']}[DOB_TxtBox]
    ...     ${locators_params['Settings']['Users']['Add_User_Popup']}[Address_TxtBox_LblTxt]    ${locators_params['Settings']['Users']['Add_User_Popup']}[Address_TxtBox]
    ...     ${locators_params['Settings']['Users']['Add_User_Popup']}[Cancel_Btn]    ${locators_params['Settings']['Users']['Add_User_Popup']}[Confirm_Btn]
    wait until elements are visible  @{AddUser_PopupElements}
    capture the screen  AddUser_Popup

Verify all the add user popup elements label texts
    [Documentation]  Verify all the add user popup elements label texts
    @{AddUser_PopupElements}    create list  ${locators_params['Settings']['Users']['Add_User_Popup']}[Header_LblTxt]
    ...     ${locators_params['Settings']['Users']['Add_User_Popup']}[Name_TxtBox_LblTxt]  ${locators_params['Settings']['Users']['Add_User_Popup']}[PhoneNo_TxtBox_LblTXt]
    ...     ${locators_params['Settings']['Users']['Add_User_Popup']}[EmailId_TxtBox_LblTxt]  ${locators_params['Settings']['Users']['Add_User_Popup']}[DOB_TxtBox_LblTxt]
    ...     ${locators_params['Settings']['Users']['Add_User_Popup']}[Address_TxtBox_LblTxt]   ${locators_params['Settings']['Users']['Add_User_Popup']}[Cancel_Btn]
    ...     ${locators_params['Settings']['Users']['Add_User_Popup']}[Confirm_Btn]
    @{AddUser_PopupLblTxts}    create list  ${testData_config['Settings']['Users']['Add_User_Popup']}[Header_LblTxt]
    ...     ${testData_config['Settings']['Users']['Add_User_Popup']}[Name_TxtBox_LblTxt]  ${testData_config['Settings']['Users']['Add_User_Popup']}[PhoneNo_TxtBox_LblTXt]
    ...     ${testData_config['Settings']['Users']['Add_User_Popup']}[EmailId_TxtBox_LblTxt]  ${testData_config['Settings']['Users']['Add_User_Popup']}[DOB_TxtBox_LblTxt]
    ...     ${testData_config['Settings']['Users']['Add_User_Popup']}[Address_TxtBox_LblTxt]   ${testData_config['Settings']['Users']['Add_User_Popup']}[Cancel_Btn]
    ...     ${testData_config['Settings']['Users']['Add_User_Popup']}[Confirm_Btn]

Verify and validate the add user popup cancel button
    [Documentation]  Verify and validate the add user popup cancel button
    [Arguments]    ${email_ID}
    Verify the add user popup cancel button is working properly without filling any details
    Verify the add user popup cancel button is working properly with filled all details    ${email_ID}

Verify the add user popup cancel button is working properly without filling any details
    [Documentation]  Verify the add user popup cancel button is working properly without filling any details
    element should be enabled  ${locators_params['Settings']['Users']['Add_User_Popup']}[Cancel_Btn]
    capture the screen  AddUser_CancelEnabled_WithoutFill
    click element until enabled  ${locators_params['Settings']['Users']['Add_User_Popup']}[Cancel_Btn]
    wait until element is visible  ${locators_params['Settings']['Users']}[AddUser_Btn]
    click element until enabled  ${locators_params['Settings']['Users']}[AddUser_Btn]
    wait until element is visible  ${locators_params['Settings']['Users']['Add_User_Popup']}[Header_LblTxt]

Verify the add user popup cancel button is working properly with filled all details
    [Documentation]  Verify the add user popup cancel button is working properly with filled all details
    [Arguments]    ${email_ID}
    @{AddUser_PopupElements}    create list  ${locators_params['Settings']['Users']['Add_User_Popup']}[Name_TxtBox]
    ...     ${locators_params['Settings']['Users']['Add_User_Popup']}[PhoneNo_TxtBox]  ${locators_params['Settings']['Users']['Add_User_Popup']}[EmailId_TxtBox]
    ...     ${locators_params['Settings']['Users']['Add_User_Popup']}[DOB_TxtBox]  ${locators_params['Settings']['Users']['Add_User_Popup']}[Address_TxtBox]
    @{AddUser_PopupValues}    create list  ${testData_config['Settings']['Users']['Add_User_Popup']['Testdata']}[Name]
    ...     ${testData_config['Settings']['Users']['Add_User_Popup']['Testdata']}[PhoneNo]  ${email_ID}
    ...     ${testData_config['Settings']['Users']['Add_User_Popup']['Testdata']}[DOB]  ${testData_config['Settings']['Users']['Add_User_Popup']['Testdata']}[Address]
    enter multiple value in the inputfields  ${AddUser_PopupElements}  ${AddUser_PopupValues}
    capture the screen  AddUser_CancelEnabled_WithFill
    element should be enabled  ${locators_params['Settings']['Users']['Add_User_Popup']}[Cancel_Btn]
    click element until enabled  ${locators_params['Settings']['Users']['Add_User_Popup']}[Cancel_Btn]
    wait until element is visible  ${locators_params['Settings']['Users']}[AddUser_Btn]
    click element until enabled  ${locators_params['Settings']['Users']}[AddUser_Btn]
    wait until element is visible  ${locators_params['Settings']['Users']['Add_User_Popup']}[Header_LblTxt]

Verify and validate the add user popup confirm button
    [Documentation]  Verify and validate the add user popup confirm button
    [Arguments]    ${email_ID}
    Verify the add user popup confirm button is working properly without filling any details
    Verify the add user popup confirm button is working properly with filled all details    ${email_ID}

Verify the add user popup confirm button is working properly without filling any details
    [Documentation]  Verify the add user popup confirm button is working properly without filling any details
    element should be disabled  ${locators_params['Settings']['Users']['Add_User_Popup']}[Confirm_Btn]
    capture the screen  AddUser_ConfirmEnabled_WithoutFill
    click element until enabled  ${locators_params['Settings']['Users']['Add_User_Popup']}[Cancel_Btn]
    wait until element is visible  ${locators_params['Settings']['Users']}[AddUser_Btn]
    click element until enabled  ${locators_params['Settings']['Users']}[AddUser_Btn]
    wait until element is visible  ${locators_params['Settings']['Users']['Add_User_Popup']}[Header_LblTxt]
    element should be disabled  ${locators_params['Settings']['Users']['Add_User_Popup']}[Confirm_Btn]

Verify the add user popup confirm button is working properly with filled all details
    [Documentation]  Verify the add user popup confirm button is working properly with filled all details
    [Arguments]    ${email_ID}
    ${res}  Call Method  ${API_POSLaundry}  getAPI_User
    log    ${res}
    @{AddUser_PopupElements}    create list  ${locators_params['Settings']['Users']['Add_User_Popup']}[Name_TxtBox]
    ...     ${locators_params['Settings']['Users']['Add_User_Popup']}[PhoneNo_TxtBox]  ${locators_params['Settings']['Users']['Add_User_Popup']}[EmailId_TxtBox]
    ...     ${locators_params['Settings']['Users']['Add_User_Popup']}[DOB_TxtBox]  ${locators_params['Settings']['Users']['Add_User_Popup']}[Address_TxtBox]
    @{AddUser_PopupValues}    create list  ${testData_config['Settings']['Users']['Add_User_Popup']['Testdata']}[Name]
    ...     ${testData_config['Settings']['Users']['Add_User_Popup']['Testdata']}[PhoneNo]  ${email_ID}
    ...     ${testData_config['Settings']['Users']['Add_User_Popup']['Testdata']}[DOB]  ${testData_config['Settings']['Users']['Add_User_Popup']['Testdata']}[Address]
    enter multiple value in the inputfields  ${AddUser_PopupElements}  ${AddUser_PopupValues}
    capture the screen  AddUser_ConfirmEnabled_WithFill
    element should be enabled  ${locators_params['Settings']['Users']['Add_User_Popup']}[Confirm_Btn]
    click element until enabled  ${locators_params['Settings']['Users']['Add_User_Popup']}[Confirm_Btn]
    Sleep    5s
    ### Below four lines testing purpose only
    ${SelectBranch_Popup_Status}    Run Keyword And Return Status    wait until element is visible  ${locators_params['Settings']['Users']['Select_Branch_Popup']}[HeaderTxt]
    Run Keyword If    ${SelectBranch_Popup_Status} == True    Click Element Until Enabled    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Cancel_Btn]
    ${Popup_Status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${locators_params['Settings']['Users']['Add_User_Popup']}[Confirm_Btn]
    Run Keyword If    ${Popup_Status}    Reload Page
    ###
    Wait Until Element Is Visible    ${locators_params['Settings']['Users']}[AddUser_Btn]
    Show all the data from the table   All
    Capture The Screen    UsersTable

#### Select Branch Popup ####
Verify and validate the select branch button and popup
    [Documentation]    Verify and validate the select branch button and popup
    ${response}  Call Method  ${API_POSLaundry}  getAPI_User
    log    ${response}
    ${UserNames}    Set Variable    ${response}[1]
    ${PhoneNumbers}    Set Variable    ${response}[3]
    ${count}  Get Length    ${UserNames}
    ${index}    Evaluate    ${count}-1
    ${SelectedBranch_Btn}  Format String    ${locators_params['Settings']['Users']}[SelectBranch_Btn]  value=${UserNames}[${index}]
    Wait Until Element Is Visible    ${SelectedBranch_Btn}
    Click Element Until Visible    ${SelectedBranch_Btn}
    Capture The Screen    SelectedBranch_Popup
    Verify all the select branch popup elements are visible
    Validate the select branch popup elements texts
    Validate the select branch admin role checkbox
    Validate the select branch employee role checkbox
    Verify the select branch popup close icon button  ${SelectedBranch_Btn}
    Verify the select branch popup cancel button    ${SelectedBranch_Btn}
    Verify the select branch popup confirm button    ${SelectedBranch_Btn}

Verify all the select branch popup elements are visible
    [Documentation]    Verify all the select branch popup elements are visible
    @{SelectBranch_Elements}    Create List    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[HeaderTxt]
    ...    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Role_LblTxt]  ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Admin_Role_LblTxt]
    ...    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Employee_Role_LblTxt]
    ...    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[SelectBranch_DDBox]
    ...    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Address_LblTxt]  ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Address_TxtBox]
    ...    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Cancel_Btn]  ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Confirm_Btn]
    ...    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Close_Icon]
    Wait Until Elements Are Visible    @{SelectBranch_Elements}
    Capture The Screen    SelectedBranchPopup

Validate the select branch popup elements texts
    [Documentation]    Validate the select branch popup elements texts
    @{SelectBranch_PopupElements}    Create List    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[HeaderTxt]
    ...    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Admin_Role_LblTxt]
    ...    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Employee_Role_LblTxt]  ${locators_params['Settings']['Users']['Select_Branch_Popup']}[SelectBranchDD_LblTxt]
    ...    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Address_LblTxt]  ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Cancel_Btn]
    ...    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Confirm_Btn]
    @{SelectBranch_LblTxts}    Create List    ${testData_config['Settings']['Users']['Select_Branch_Popup']}[Header_LblTxt]
    ...    ${testData_config['Settings']['Users']['Select_Branch_Popup']}[Admin_Role_LblTxt]
    ...    ${testData_config['Settings']['Users']['Select_Branch_Popup']}[Employee_Role_LblTxt]  ${testData_config['Settings']['Users']['Select_Branch_Popup']}[SelectBranch_DDTxt]
    ...    ${testData_config['Settings']['Users']['Select_Branch_Popup']}[Address_LblTxt]  ${testData_config['Settings']['Users']['Select_Branch_Popup']}[Cancel_Btn]
    ...    ${testData_config['Settings']['Users']['Select_Branch_Popup']}[Confirm_Btn]
    Check All The Get Elements Text Are Should Be Equal    ${SelectBranch_PopupElements}  ${SelectBranch_LblTxts}
    ${Role_LblTxt}    Get Text    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Role_LblTxt]
    ${Role_RequiredSymbol}    Get Text    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Role_RequiredSymbol]
    ${UI_Role_LblTxt}    Catenate  ${Role_LblTxt}  ${Role_RequiredSymbol}
    Should Be Equal    ${UI_Role_LblTxt}    ${testData_config['Settings']['Users']['Select_Branch_Popup']}[Role_LblTxt]

#### Select Branch Popup Roles Checkbox
Validate the select branch admin role checkbox
    [Documentation]    Validate the select branch admin role checkbox
    Page should contain the checkbox element    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Admin_Role_ChkBox]
    Checkbox Should Not Be Selected    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Admin_Role_ChkBox]
    Select checkbox    Admin_checkbox
    Checkbox Should Be Selected    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Admin_Role_ChkBox]
    Unselect checkbox    Admin_checkbox
    Checkbox Should Not Be Selected    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Admin_Role_ChkBox]
    Select checkbox    Admin_checkbox
    Checkbox Should Be Selected    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Admin_Role_ChkBox]

Validate the select branch employee role checkbox
    [Documentation]    Validate the select branch employee role checkbox
    Page should contain the checkbox element    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Employee_Role_ChkBox]
    Checkbox Should Not Be Selected    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Employee_Role_ChkBox]
    Select checkbox    Emp_checkbox
    Checkbox Should Be Selected    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Employee_Role_ChkBox]
    Unselect checkbox    Emp_checkbox
    Checkbox Should Not Be Selected    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Employee_Role_ChkBox]
    Select checkbox    Emp_checkbox
    Checkbox Should Be Selected    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Employee_Role_ChkBox]

#### Select Branch Popup Close Icon
Verify the select branch popup close icon button
    [Documentation]    Verify the select branch popup close icon button
    [Arguments]    ${SelectedBranch_Btn}
    Wait Until Element Is Visible    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Close_Icon]
    Click Element Until Visible    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Close_Icon]
    Wait Until Element Is Not Visible    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Close_Icon]
    Show all the data from the table   All
    Wait Until Element Is Visible    ${SelectedBranch_Btn}
    Click Element Until Visible    ${SelectedBranch_Btn}
    Wait Until Element Is Visible    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[HeaderTxt]

#### Select Branch Popup Cancel button
Verify the select branch popup cancel button
    [Documentation]    Verify the select branch popup cancel button
    [Arguments]    ${SelectedBranch_Btn}
    Verify the select branch popup cancel button is working properly without fill any details
    Show all the data from the table   All
    Wait Until Element Is Visible    ${SelectedBranch_Btn}
    Click Element Until Visible    ${SelectedBranch_Btn}
    Wait Until Element Is Visible    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[HeaderTxt]
    Verify the select branch popup cancel button is working properly with select admin only
    Verify the select branch popup cancel button is working properly with select employee only    ${SelectedBranch_Btn}
    Verify the select branch popup cancel button is working properly with select both admin and employee    ${SelectedBranch_Btn}

Verify the select branch popup cancel button is working properly without fill any details
    [Documentation]    verify the select branch popup cancel button is working properly without fill any details
    Wait Until Element Is Visible    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Cancel_Btn]
    Click Element Until Enabled      ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Cancel_Btn]
    Wait Until Element Is Not Visible    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Cancel_Btn]

Verify the select branch popup cancel button is working properly with select admin only
    [Documentation]    verify the select branch popup cancel button is working properly with filled any details
    Checkbox Should Not Be Selected    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Admin_Role_ChkBox]
    Select checkbox    Admin_checkbox
    Checkbox Should Not Be Selected    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Employee_Role_ChkBox]
    Click Element Until Visible    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[SelectBranch_DDBox]
    ${response}    Call Method    ${API_POSLaundry}    getAPI_Branch
    Log    ${response}
    ${branchNames}    Set Variable    ${response}[2]
    ${branchName}    Set Variable    ${branchNames}[0]
    ${opt}    Format String    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[SelectBranch_DDOption]    value=${branchName}
    Click Element Until Visible    ${opt}
    Wait Until Element Is Visible    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Address_TxtBox_Content]
    Element Should Be Enabled    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Confirm_Btn]
    Capture The Screen    AdminRole_Only
    Click Element Until Enabled    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Cancel_Btn]
    Wait Until Element Is Not Visible    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Cancel_Btn]

Verify the select branch popup cancel button is working properly with select employee only
    [Documentation]    Verify the select branch popup cancel button is working properly with select employee only
    [Arguments]    ${SelectedBranch_Btn}
    Show all the data from the table   All
    Wait Until Element Is Visible    ${SelectedBranch_Btn}
    Click Element Until Visible    ${SelectedBranch_Btn}
    Wait Until Element Is Visible    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[HeaderTxt]
    Checkbox Should Not Be Selected    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Admin_Role_ChkBox]
    Checkbox Should Not Be Selected    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Employee_Role_ChkBox]
    Select checkbox    Emp_checkbox
    Checkbox Should Be Selected    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Employee_Role_ChkBox]
    Click Element Until Visible    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[SelectBranch_DDBox]
    ${response}    Call Method    ${API_POSLaundry}    getAPI_Branch
    Log    ${response}
    ${branchNames}    Set Variable    ${response}[2]
    ${branchName}    Set Variable    ${branchNames}[0]
    ${opt}    Format String    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[SelectBranch_DDOption]    value=${branchName}
    Click Element Until Visible    ${opt}
    Wait Until Element Is Visible    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Address_TxtBox_Content]
    Element Should Be Enabled    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Confirm_Btn]
    Capture The Screen    EmpRole_Only
    Click Element Until Enabled    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Cancel_Btn]
    Wait Until Element Is Not Visible    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Cancel_Btn]

Verify the select branch popup cancel button is working properly with select both admin and employee
    [Documentation]    Verify the select branch popup cancel button is working properly with select both admin and employee
    [Arguments]    ${SelectedBranch_Btn}
    Show all the data from the table   All
    Wait Until Element Is Visible    ${SelectedBranch_Btn}
    Click Element Until Visible    ${SelectedBranch_Btn}
    Wait Until Element Is Visible    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[HeaderTxt]
    Checkbox Should Not Be Selected    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Admin_Role_ChkBox]
    Select checkbox    Admin_checkbox
    Checkbox Should Be Selected    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Admin_Role_ChkBox]
    Checkbox Should Not Be Selected    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Employee_Role_ChkBox]
    Select checkbox    Emp_checkbox
    Checkbox Should Be Selected    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Employee_Role_ChkBox]
    Click Element Until Visible    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[SelectBranch_DDBox]
    ${response}    Call Method    ${API_POSLaundry}    getAPI_Branch
    Log    ${response}
    ${branchNames}    Set Variable    ${response}[2]
    ${branchName}    Set Variable    ${branchNames}[0]
    ${opt}    Format String    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[SelectBranch_DDOption]    value=${branchName}
    Click Element Until Visible    ${opt}
    Wait Until Element Is Visible    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Address_TxtBox_Content]
    Sleep    3s
    Wait Until Element Is Enabled    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Confirm_Btn]
    Capture The Screen    Both_AdminEmp_Roles
    Click Element Until Enabled    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Cancel_Btn]
    Wait Until Element Is Not Visible    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Cancel_Btn]

#### Select Branch Popup Confirm button
Verify the select branch popup confirm button
    [Documentation]    Verify the select branch popup confirm button
    [Arguments]    ${SelectedBranch_Btn}
    Verify the select branch popup confirm button is working properly without fill any details    ${SelectedBranch_Btn}
    Verify the select branch popup confirm button is working properly with select admin only    ${SelectedBranch_Btn}
    Verify the select branch popup confirm button is working properly with select employee only    ${SelectedBranch_Btn}
    Verify the select branch popup confirm button is working properly with select both admin and employee    ${SelectedBranch_Btn}

Verify the select branch popup confirm button is working properly without fill any details
    [Documentation]    Verify the select branch popup confirm button is working properly without fill any details
    [Arguments]    ${SelectedBranch_Btn}
    Show all the data from the table   All
    Wait Until Element Is Visible    ${SelectedBranch_Btn}
    Click Element Until Visible    ${SelectedBranch_Btn}
    Wait Until Element Is Visible    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[HeaderTxt]
    Wait Until Element Is Visible    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Confirm_Btn]
    Element Should Be Disabled    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Confirm_Btn]

Verify the select branch popup confirm button is working properly with select admin only
    [Documentation]    Verify the select branch popup confirm button is working properly with select admin only
    [Arguments]    ${SelectedBranch_Btn}
#    Show all the data from the table   All
#    Wait Until Element Is Visible    ${SelectedBranch_Btn}
#    Click Element Until Visible    ${SelectedBranch_Btn}
    Wait Until Element Is Visible    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[HeaderTxt]
    Checkbox Should Not Be Selected    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Admin_Role_ChkBox]
    Select checkbox    Admin_checkbox
    Checkbox Should Not Be Selected    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Employee_Role_ChkBox]
    Click Element Until Visible    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[SelectBranch_DDBox]
    ${response}    Call Method    ${API_POSLaundry}    getAPI_Branch
    Log    ${response}
    ${branchNames}    Set Variable    ${response}[2]
    ${branchName}    Set Variable    ${branchNames}[0]
    ${opt}    Format String    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[SelectBranch_DDOption]    value=${branchName}
    Click Element Until Visible    ${opt}
    Wait Until Element Is Visible    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Address_TxtBox_Content]
    Element Should Be Enabled    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Confirm_Btn]
    Capture The Screen    AdminRole_Only
    Click Element Until Enabled    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Cancel_Btn]
    Wait Until Element Is Not Visible    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Cancel_Btn]

Verify the select branch popup confirm button is working properly with select employee only
    [Documentation]    Verify the select branch popup confirm button is working properly with select employee only
    [Arguments]    ${SelectedBranch_Btn}
    Show all the data from the table   All
    Wait Until Element Is Visible    ${SelectedBranch_Btn}
    Click Element Until Visible    ${SelectedBranch_Btn}
    Wait Until Element Is Visible    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[HeaderTxt]
    Checkbox Should Not Be Selected    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Admin_Role_ChkBox]
    Checkbox Should Not Be Selected    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Employee_Role_ChkBox]
    Select checkbox    Emp_checkbox
    Checkbox Should Be Selected    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Employee_Role_ChkBox]
    Click Element Until Visible    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[SelectBranch_DDBox]
    ${response}    Call Method    ${API_POSLaundry}    getAPI_Branch
    Log    ${response}
    ${branchNames}    Set Variable    ${response}[2]
    ${branchName}    Set Variable    ${branchNames}[0]
    ${opt}    Format String    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[SelectBranch_DDOption]    value=${branchName}
    Click Element Until Visible    ${opt}
    Wait Until Element Is Visible    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Address_TxtBox_Content]
    Element Should Be Enabled    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Confirm_Btn]
    Capture The Screen    EmpRole_Only
    Click Element Until Enabled    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Cancel_Btn]
    Wait Until Element Is Not Visible    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Cancel_Btn]

Verify the select branch popup confirm button is working properly with select both admin and employee
    [Documentation]    Verify the select branch popup confirm button is working properly with select both admin and employee
    [Arguments]    ${SelectedBranch_Btn}
    Show all the data from the table   All
    Wait Until Element Is Visible    ${SelectedBranch_Btn}
    Click Element Until Visible    ${SelectedBranch_Btn}
    Wait Until Element Is Visible    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[HeaderTxt]
    Checkbox Should Not Be Selected    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Admin_Role_ChkBox]
    Select checkbox    Admin_checkbox
    Checkbox Should Be Selected    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Admin_Role_ChkBox]
    Checkbox Should Not Be Selected    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Employee_Role_ChkBox]
    Select checkbox    Emp_checkbox
    Checkbox Should Be Selected    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Employee_Role_ChkBox]
    Click Element Until Visible    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[SelectBranch_DDBox]
    ${response}    Call Method    ${API_POSLaundry}    getAPI_Branch
    Log    ${response}
    ${branchNames}    Set Variable    ${response}[2]
    ${branchName}    Set Variable    ${branchNames}[0]
    ${opt}    Format String    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[SelectBranch_DDOption]    value=${branchName}
    Click Element Until Visible    ${opt}
    Wait Until Element Is Visible    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Address_TxtBox_Content]
    Element Should Be Enabled    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Confirm_Btn]
    Capture The Screen    Both_AdminEmp_Roles
    Click Element Until Enabled    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Cancel_Btn]
    Wait Until Element Is Not Visible    ${locators_params['Settings']['Users']['Select_Branch_Popup']}[Cancel_Btn]

Verify and validate the user edit button and popup
    [Documentation]    Verify and validate the user edit button and popup
     ${response}  Call Method  ${API_POSLaundry}  getAPI_User
    log    ${response}
    ${UserNames}    Set Variable    ${response}[1]
    ${PhoneNumbers}    Set Variable    ${response}[3]
    ${count}  Get Length    ${UserNames}
    ${index} =    Evaluate  ${count}-1
    ${username} =   Evaluate  "${UserNames}[${index}]"
    ${EditUser_Btn}  Format String    ${locators_params['Settings']['Users']}[EditUser_Btn]  value=${username}
    Show all the data from the table   All
    Wait Until Element Is Visible    ${EditUser_Btn}
    Click Element Until Visible    ${EditUser_Btn}
    Capture The Screen    SelectedBranch_Popup
    Verify all the edit user popup elements are visible
    Validate the edit user popup elements texts
#    Validate the edit user admin role checkbox
#    Validate the edit user employee role checkbox
#    Verify the edit user popup close icon button  ${EditUser_Btn}
#    Verify the edit user popup cancel button    ${EditUser_Btn}
#    Verify the edit user popup confirm button    ${EditUser_Btn}

Verify all the edit user popup elements are visible
    [Documentation]    Verify all the edit user popup elements are visible
    @{EditUser_Popup}    Create List    ${locators_params['Settings']['Users']['Edit_User_Popup']}[HeaderTxt]
    ...    ${locators_params['Settings']['Users']['Edit_User_Popup']}[Name_TextBox_LblTxt]    ${locators_params['Settings']['Users']['Edit_User_Popup']}[Name_TxtBox]
    ...    ${locators_params['Settings']['Users']['Edit_User_Popup']}[PhoneNo_TxtBox_LblTxt]    ${locators_params['Settings']['Users']['Edit_User_Popup']}[PhoneNo_TxtBox]
    ...    ${locators_params['Settings']['Users']['Edit_User_Popup']}[DateOfJoining_LblTxt]    ${locators_params['Settings']['Users']['Edit_User_Popup']}[DateOfJoining_TxtBox]
    ...    ${locators_params['Settings']['Users']['Edit_User_Popup']}[Address_LblTxt]    ${locators_params['Settings']['Users']['Edit_User_Popup']}[Address_TxtBox]
    ...    ${locators_params['Settings']['Users']['Edit_User_Popup']}[Cancel_Btn]    ${locators_params['Settings']['Users']['Edit_User_Popup']}[Update_Btn]
    ...    ${locators_params['Settings']['Users']['Edit_User_Popup']}[Close_Icon]
    Wait Until Elements Are Visible    @{EditUser_Popup}
    Capture The Screen    EditUser_Popup

Validate the edit user popup elements texts
    [Documentation]    Validate the edit user popup elements texts
    @{EditUser_Popup}    Create List    ${locators_params['Settings']['Users']['Edit_User_Popup']}[HeaderTxt]
    ...    ${locators_params['Settings']['Users']['Edit_User_Popup']}[Name_TextBox_LblTxt]
    ...    ${locators_params['Settings']['Users']['Edit_User_Popup']}[PhoneNo_TxtBox_LblTxt]
    ...    ${locators_params['Settings']['Users']['Edit_User_Popup']}[DateOfJoining_LblTxt]
    ...    ${locators_params['Settings']['Users']['Edit_User_Popup']}[Address_LblTxt]
    ...    ${locators_params['Settings']['Users']['Edit_User_Popup']}[Cancel_Btn]
    ...    ${locators_params['Settings']['Users']['Edit_User_Popup']}[Update_Btn]
    @{EditUserPopup_texts}    Create List    ${testData_config['Settings']['Users']['Edit_User_Popup']}[Header_LblTxt]
    ...    ${testData_config['Settings']['Users']['Edit_User_Popup']}[Name_TxtBox_LblTxt]
    ...    ${testData_config['Settings']['Users']['Edit_User_Popup']}[PhoneNo_TxtBox_LblTXt]
    ...    ${testData_config['Settings']['Users']['Edit_User_Popup']}[DateOfJoining_LblTxt]
    ...    ${testData_config['Settings']['Users']['Edit_User_Popup']}[Address_TxtBox_LblTxt]
    ...    ${testData_config['Settings']['Users']['Edit_User_Popup']}[Cancel_Btn]
    ...    ${testData_config['Settings']['Users']['Edit_User_Popup']}[Update_Btn]
    Capture The Screen    Edit_User_Popup

Closed the edit and delete popup
    [Documentation]    Closed the edit and delete popup
    ${Delete_CancelBtn}    Run Keyword And Return Status    Wait Until Element Is Visible    ${locators_params['Settings']}[Cancel_Btn]
    Run Keyword If    ${Delete_CancelBtn} == True    Click Element Until Visible    ${locators_params['Settings']}[Cancel_Btn]
    ${Edit_CancelBtn}    Run Keyword And Return Status    Wait Until Element Is Visible    ${locators_params['Settings']}[Close_Icon]
    Run Keyword If    ${Edit_CancelBtn} == True    Click Element Until Visible    ${locators_params['Settings']}[Close_Icon]