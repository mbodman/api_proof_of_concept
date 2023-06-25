*** Settings ***
Resource  ../../../../test-data/variables/imports.resource

Library  RequestsLibrary
Library    ../../../../lib/json_validate_schema.py

Test Tags    authentication

*** Test Cases ***
Verify Successful Login Returns 200
    [Documentation]  Ticket Number, User Story, or Robot specifics can be placed here
    [Tags]  POST
    Log To Console    \nSending Request To ${GLOBAL_ENDPOINT_LOGIN}\n
    &{jsonBody}    Create Dictionary    username=admin    password=masterPass
    ${response}    POST    url=${GLOBAL_ENDPOINT_LOGIN}    json=${jsonBody}    expected_status=200
    Validate Json Schema    input_json=${response.json()}    reference_schema_path=${GLOBAL_SCHEMA_LOGIN}




    