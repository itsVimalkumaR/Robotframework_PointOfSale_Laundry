*** Settings ***
Library         RequestsLibrary
Library         SeleniumLibrary
Library         Collections
Library         OperatingSystem
Library         DateTime
Library         BuiltIn
Library         String
Library         json
Variables       ../utils/config_parser.py
Variables       ../utils/configReader.py
Variables       ../utils/Implement.py
Variables       ../utils/OptimizeAPI.py
Resource        ../TestScripts/Base.robot
Resource        ../Optimized_PO/ConfigParserKeywords.robot
Resource        ../Optimized_PO/API_Integration.robot
Resource        ../Optimized_PO/landingpage.robot

*** Keywords ***
Execution start time stage
        ${startTime}=   call method    ${objBfrRun}   startTimeInsert

Execution end time
        ${endTime}=   call method    ${objBfrRun}   endTimeUpdate

ConfigReader for login User
        Log    ${API_POSLaundry}
        ${response_ConfigReader}=   call method    ${API_POSLaundry}   ConfigReader
        log to console  ${response_ConfigReader}

API Call for init_All_Varibles
        ${response}=   call method    ${API_POSLaundry}   init_All_Varibles
        log to console  ${response}

API Call for end_url
        ${response}=   call method    ${API_POSLaundry}   end_url
        log to console  ${response}

API Call for Subscribers
        ${response}=   call method    ${API_POSLaundry}      Subscribers
        log to console  ${response}
        should contain     '''${response}'''     200

API Call for UserLogin
        ${response}=   call method    ${API_POSLaundry}      LoginAPI
        log to console  ${response}
        should contain     '''${response}'''     200

API Call for get Category
    ${response}  call method  ${API_POSLaundry}  getAPI_Category
    log to console  ${response}
    should contain     '''${response}'''     200

Zoom In the Page
        ${response}=   call method    ${objBfrRun}   zoom_In
        log to console  ${response}

Zoom Out the Page
        ${response}=   call method    ${objBfrRun}   zoom_Out
        log to console  ${response}

Generate Random Email ID
        ${response}=   call method    ${objBfrRun}   generate_random_email
        log to console  ${response}
        RETURN    ${response}
        
Save the new user login credential
    [Arguments]    ${username}    ${password}  ${business_name}
    ${response}=   call method    ${objBfrRun}   saveToExcel_userData  ${username}    ${password}  ${business_name}
    log to console  ${response} 
    
Generate random string without special character
    ${response}=   call method    ${objBfrRun}   generate_random_string_without_splChar
    log to console  ${response}
    RETURN    ${response}
    
Generate random string with special character
    ${response}=   call method    ${objBfrRun}   generate_random_string_with_splChar
    log to console  ${response}
    RETURN    ${response}