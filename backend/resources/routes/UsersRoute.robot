*** Settings ***
Documentation   Users route


*** Keywords ***
Post User
    [Arguments]   ${payload}
 
    ${response}    POST               
    ...            ${API_USERS}/users 
    ...            json=${payload}
    ...            expected_status=any

    [return]       ${response}

Delete User
    [Arguments]   ${token}

    ${headers}    Create Dictionary  Authorization=${token}
 
    ${response}    DELETE               
    ...            ${API_USERS}/users
    ...            headers=${headers}
    ...            expected_status=any

    [return]       ${response}

Get User
    [Arguments]   ${token}

    ${headers}    Create Dictionary  Authorization=${token}
 
    ${response}    GET               
    ...            ${API_USERS}/users
    ...            headers=${headers}
    ...            expected_status=any

    [return]       ${response}

Put User
    [Arguments]   ${token}                       ${payload}

    ${headers}    Create Dictionary  Authorization=${token}
 
    ${response}    PUT               
    ...            ${API_USERS}/users 
    ...            json=${payload}
    ...            expected_status=any
    ...            headers=${headers}

    [return]       ${response}
