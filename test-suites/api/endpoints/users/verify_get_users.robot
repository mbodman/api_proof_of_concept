*** Settings ***
Resource    ../../../../test-data/variables/imports.resource
Resource    ../../../../keywords/imports.resource
Resource    ../../../../keywords/setupTeardowns.robot

Suite Setup    Authorize

Test Tags    users

*** Test Cases ***
Verify All Users Display Successfully
    [Documentation]  Ticket Number, User Story, or Robot specifics can be placed her
    [Tags]  GET
    Log To Console    \nSending Request to ${GLOBAL_ENDPOINT_USERS}\n
    ${params}  Create Dictionary  filter=all
    ${response}  GET  url=${GLOBAL_ENDPOINT_USERS}  expected_status=200  
    ...  headers=${GLOBAL_AUTH_HEADER}  params=${params}
    Validate Schema    inputJson=${response.json()}    referenceSchemaPath=${GLOBAL_SCHEMA_USERS}


