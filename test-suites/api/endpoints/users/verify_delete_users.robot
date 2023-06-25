*** Settings ***
Resource    ../../../../test-data/variables/imports.resource
Resource    ../../../../keywords/imports.resource
Resource    ../../../../keywords/setupTeardowns.robot

Suite Setup    Custom Suite Setup

Test Tags    users
*** Variables ***

${SUITE_USER_ID}  ${EMPTY}

*** Test Cases ***
Verify Delete User Successful
    [Documentation]  Ticket Number, User Story, or Robot specifics can be placed here 
    [Tags]  DELETE
    ${response}  Delete User    ${SUITE_USER_ID}
    Validate Schema    inputJson=${response.json()}    referenceSchemaPath=${GLOBAL_SCHEMA_USERS_DELETE}


*** Keywords ***
Custom Suite Setup
    Authorize
    ${id}  ${response}  Create New User
    Set Suite Variable    ${SUITE_USER_ID}  ${id}
