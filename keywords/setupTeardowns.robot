*** Settings ***
Resource    ../test-data/variables/imports.resource
Library    RequestsLibrary
Library    Collections


*** Keywords ***
Authorize
    IF  not ${GLOBAL_AUTH_SET}
        &{jsonBody}  Create Dictionary  username=admin  password=masterPass
        ${response}  POST  url=${GLOBAL_ENDPOINT_LOGIN}  json=${jsonBody}  expected_status=200
        ${responseJson}  Set Variable  ${response.json()}
        ${token}  Get From Dictionary  ${responseJson}  token 
        ${headers}  Create Dictionary  Authorization=Bearer ${token}
        Set Global Variable    ${GLOBAL_AUTH_HEADER}  ${headers}
        Set Global Variable    ${GLOBAL_AUTH_SET}  ${True}
    END

Create New User
    [Arguments]  ${active}=${True}  ${city}=Worcester  ${contractsCurrency}=GBP  ${contractsId}=33
    ...  ${contractsPrice}=${9.99}  ${contractsType}=basic  ${email}=marc@bodman.com
    ...  ${name}=marc  ${street}=Sansome Mews  ${surname}=bodman  ${zip}=777
    ...  ${numberOfContracts}=${1}  ${expectedStatusCode}=201
    @{contracts}  Create List
    IF  ${numberOfContracts} > ${0}
        FOR    ${counter}    IN RANGE    ${numberOfContracts}
            ${contract}  Create Dictionary  currency=${contractsCurrency}  id=${contractsId}  
            ...  price=${contractsPrice}  type=${contractsType}
            Append To List    ${contracts}  ${contract} 
        END
    END

    ${body}  Create Dictionary  active=${active}  city=${city}  contracts=${contracts}
    ...  email=${email}  name=${name}  street=${street}  surname=${surname}  zip=${zip}
    
    ${response}  POST  url=${GLOBAL_ENDPOINT_USERS}  json=${body}  expected_status=${expectedStatusCode}  headers=${GLOBAL_AUTH_HEADER}
    ${userId}  Set Variable  ${empty}
    IF  "${expectedStatusCode}" == "201"
        ${userId}  Get From Dictionary  ${response.json()}  ID         
    END 
    [Return]  ${userId}  ${response}

Delete User
    [Arguments]  ${userId}
    ${response}  DELETE    url=${GLOBAL_ENDPOINT_USERS}/${userId}  expected_status=200  headers=${GLOBAL_AUTH_HEADER}
    [Return]  ${response}