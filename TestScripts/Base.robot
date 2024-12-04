*** Settings ***
Resource    ../Optimized_PO/API_Integration.robot
Resource    ../Optimized_PO/CommonWrapper.robot
Resource    ../Optimized_PO/ConfigParserKeywords.robot
Resource    ../Optimized_PO/landingpage.robot
Resource    ../Optimized_PO/PageTitleKeywords.robot
Resource    ../PO/LogInOut_PO.robot
Resource    ../PO/SignUpOut_PO.robot
Resource    ../PO/Home_PO.robot
Resource    ../PO/Category_PO.robot
Resource    ../PO/Product_PO.robot
Resource    ../PO/OrderSummary_PO.robot
Resource    ../PO/Orders_PO.robot
Resource    ../PO/Settings_PO.robot
Resource    ../Optimized_PO/PageTitleKeywords.robot
Resource    ../PO/ShoppingCart_PO.robot
Resource    ../TestScripts/Auto_Insert_Data/Products_Added.robot
Resource    ../TestScripts/Auto_Insert_Data/Categories_Added.robot

#### Variables
Variables    ../utils/config_parser.py
Variables    ../utils/configReader.py
Variables    ../utils/Implement.py
Variables    ../utils/OptimizeAPI.py
