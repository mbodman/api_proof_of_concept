*** Settings ***
Resource    ../../../../test-data/variables/imports.resource
Resource    ../../../../keywords/imports.resource  
Resource    ../../../../keywords/setupTeardowns.robot

Suite Setup    Authorize

Test Tags    users

*** Test Cases ***
Verify View Existing User Succesful
    [Documentation]  Ticket Number, User Story, or Robot specifics can be placed here
    [Tags]  GET
    Log To Console    \nSending Request To ${GLOBAL_ENDPOINT_USERS}/1\n
    ${response}    GET    url=${GLOBAL_ENDPOINT_USERS}/1    expected_status=200    headers=${GLOBAL_AUTH_HEADER}
    Validate Schema    inputJson=${response.json()}    referenceSchemaPath=${GLOBAL_SCHEMA_USERS_ID}

