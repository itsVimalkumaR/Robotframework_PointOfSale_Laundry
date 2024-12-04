*** Settings ***
Documentation    Json Reader
Library    JSONLibrary
Library   os
Library   Collections
Resource    ../Optimized_PO/ConfigParserKeywords.robot
*** Test Cases ***
Test title
    Set Root Directory
    ${JsonObj}   Load JSON From File    ${CURDIR}/Off.json
    ${ServiceName}  Get Value From Json   ${JsonObj}   $.blockedServices[:].service
    log   ${ServiceName}
#    FOR	${var}	IN	${ServiceName[0]}
#        Get Dictionary Values    ${var}   service
#        log   ${ServiceName}[${var}].service
#    END