*** Settings ***
Resource    ../../../../test-data/variables/imports.Resource
Resource    ../../../../keywords/imports.resource

Library    RequestsLibrary

Test Template    Custom Test Template

Test Tags    negative_testing    authentication

*** Test Cases ***                                          USERNAME        PASSWORD
Verify Login With Wrong Password Returns 401                admin           wrongPass
    [Documentation]  Ticket Number, User Story, or Robot specifics can be placed here
    [Tags]  POST 
    
Verify Login With Wrong Username Returns 401                guest           masterPass
    [Documentation]  Ticket Number, User Story, or Robot specifics can be placed here
    [Tags]  POST 

Verify Login With Empty Data Returns 401                    ${Empty}        ${Empty}
    [Documentation]  Ticket Number, User Story, or Robot specifics can be placed here
    [Tags]  POST 
    
Verify Login With Wrong User And Password Returns 401       guest        wrongPass
    [Documentation]  Ticket Number, User Story, or Robot specifics can be placed here
    [Tags]  POST 
    
*** Keywords ***
Custom Test Template
    [Arguments]  ${username}  ${password}
    Log To Console    \nSending Request To ${GLOBAL_ENDPOINT_LOGIN}\n
    &{jsonBody}  Create Dictionary  username=${username}  password=${password}
    ${response}  POST  url=${GLOBAL_ENDPOINT_LOGIN}  json=${jsonBody}  expected_status=401
    Validate Schema   inputJson=${response.json()}    referenceSchemaPath=${GLOBAL_SCHEMA_ERROR}