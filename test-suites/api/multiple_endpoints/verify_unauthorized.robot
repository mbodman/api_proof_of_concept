*** Settings ***
Resource    ../../../test-data/variables/imports.Resource
Resource    ../../../keywords/imports.resource
Resource    ../../../keywords/setupTeardowns.robot

Test Tags    authentication    negative_testing

*** Variables ***
&{SUITE_WRONG_TOKEN_HEADER}  Authorization=Bearer broken-token 
&{SUITE_EMPTY_TOKEN_HEADER}  Authorization=${empty}

*** Test Cases ***                     ENDPOINT                     AUTH HEADER       
Verify Get Users Wrong Token Returns Error          ${GLOBAL_ENDPOINT_USERS}     ${SUITE_WRONG_TOKEN_HEADER}
    [Template]  Custom Test Template Get
    [Documentation]  Ticket Number, User Story, or Robot specifics can be placed here
    [Tags]  GET

Verify Get Users Empty Token Returns Error          ${GLOBAL_ENDPOINT_USERS}     ${SUITE_EMPTY_TOKEN_HEADER}
    [Template]  Custom Test Template Get 
    [Documentation]  Ticket Number, User Story, or Robot specifics can be placed here
    [Tags]  GET

Verify Get Users ID Wrong Token Returns Error          ${GLOBAL_ENDPOINT_USERS}/1     ${SUITE_WRONG_TOKEN_HEADER}
    [Template]  Custom Test Template Get
    [Documentation]  Ticket Number, User Story, or Robot specifics can be placed here
    [Tags]  GET

Verify Get Users ID Empty Token Returns Error          ${GLOBAL_ENDPOINT_USERS}/1     ${SUITE_EMPTY_TOKEN_HEADER}
    [Template]  Custom Test Template Get 
    [Documentation]  Ticket Number, User Story, or Robot specifics can be placed here
    [Tags]  GET

Verify Post Users Wrong Token Returns Error          ${GLOBAL_ENDPOINT_USERS}     ${SUITE_WRONG_TOKEN_HEADER}
    [Template]  Custom Test Template Post
    [Documentation]  Ticket Number, User Story, or Robot specifics can be placed here
    [Tags]  POST

Verify Post Users Empty Token Returns Error          ${GLOBAL_ENDPOINT_USERS}     ${SUITE_EMPTY_TOKEN_HEADER}
    [Template]  Custom Test Template Post
    [Documentation]  Ticket Number, User Story, or Robot specifics can be placed here
    [Tags]  POST

Verify Delete Users Wrong Token Returns Error          ${GLOBAL_ENDPOINT_USERS}/1     ${SUITE_WRONG_TOKEN_HEADER}
    [Template]  Custom Test Template Delete
    [Documentation]  Ticket Number, User Story, or Robot specifics can be placed here
    [Tags]  DELETE

Verify Delete Users Empty Token Returns Error          ${GLOBAL_ENDPOINT_USERS}/1     ${SUITE_EMPTY_TOKEN_HEADER}
    [Template]  Custom Test Template Delete
    [Documentation]  Ticket Number, User Story, or Robot specifics can be placed here
    [Tags]  DELETE

*** Keywords ***
Custom Test Template Get
    [Arguments]  ${endpoint}  ${authHeader}
    Log To Console    \nSending Request To ${GLOBAL_ENDPOINT_USERS}\n
    ${response}  GET  url=${endpoint}  expected_status=401  headers=${authHeader}
    Validate Schema    inputJson=${response.json()}    referenceSchemaPath=${GLOBAL_SCHEMA_ERROR}

Custom Test Template Post
    [Arguments]  ${endpoint}  ${authHeader}
    Log To Console    \nPosting To ${GLOBAL_ENDPOINT_USERS}\n
    ${response}  POST  url=${endpoint}  expected_status=401  headers=${authHeader}
    Validate Schema    inputJson=${response.json()}    referenceSchemaPath=${GLOBAL_SCHEMA_ERROR}

Custom Test Template Delete
    [Arguments]  ${endpoint}  ${authHeader}
    Log To Console    \nPosting To ${GLOBAL_ENDPOINT_USERS}\n
    ${response}  DELETE  url=${endpoint}  expected_status=401  headers=${authHeader}
    Validate Schema    inputJson=${response.json()}    referenceSchemaPath=${GLOBAL_SCHEMA_ERROR}