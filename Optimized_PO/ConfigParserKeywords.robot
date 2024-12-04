*** Settings ***
Documentation     Library for parsing the Network Topology Information
Library           String
Library           ../utils/config_parser.py
Variables         ../utils/configReader.py
Resource          ../TestScripts/Base.robot

*** Keywords ***
Set Root Directory
    ${rootDirectory}    Fetch From Left    ${CURDIR}  pos-laundary-tests
    ${RootDirectory}    Set Variable    ${rootDirectory}${/}pos-laundary-tests
    Set Suite Variable    ${rootDirectory}    ${RootDirectory}

Parsing locators information
    [Documentation]    This keyword parses the locators information from yaml file
    Set Log Level    NONE
    ${locators_params}=    parse_yaml    ${rootDirectory}${/}utils${/}locators_info.yml
    Set Log Level    INFO
    Set suite variable    ${locators_params}
    Log    ${locators_params}

Parsing test data config
    [Documentation]  This keyword parses the test data config from yaml file
    Set Log Level    NONE
    ${testData_config}=    parse_yaml    ${rootDirectory}${/}utils${/}Info_TestData.yml
    Set Log Level    INFO
    Set suite variable    ${testData_config}
    Log    ${testData_config}