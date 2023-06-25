*** Settings ***
Resource    ../../../../test-data/variables/imports.resource
Resource    ../../../../keywords/imports.resource
Resource    ../../../../keywords/setupTeardowns.robot

Suite Setup    Authorize

Suite Teardown    Delete User    ${SUITE_USER_ID}

Test Tags    users

*** Test Cases ***
Verify Create New User Successful
    [Documentation]  Ticket Number, User Story, or Robot specifics can be placed here
    [Tags]  POST
    Log To Console    \nSending Request to ${GLOBAL_ENDPOINT_USERS}\n
    ${id}  ${response}  Create New User
    Set Suite Variable    ${SUITE_USER_ID}  ${id}
    Validate Schema    inputJson=${response.json()}  referenceSchemaPath=${GLOBAL_SCHEMA_USERS_POST}


