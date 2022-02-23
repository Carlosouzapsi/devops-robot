*** Settings ***
Documentation   Login teste suite

Resource    ${EXECDIR}/resources/Base.robot

Test Setup      Start Session
Test Teardown   After Test

*** Test Cases ***
User login

    [Tags]   smoke

    ${user}                  Factory User   login
    ### REPASSEI PRO DELORIAN:
    # Add User From Database   ${user}

    Go To Login Page
    Fill Credentials     ${user}
    Submit Credentials
    User Should Be Logged In   ${user}

Incorrect Pass

    [Tags]    inv_pass

    ${user}   Create Dictionary  email=carlos.souza@email.com   password=abc123  

    Go To Login Page
    FIll Credentials   ${user}
    Submit Credentials
    Modal Content Should Be  Usuário e/ou senha inválidos.

User not found

    [Tags]    user_404

    ${user}   Create Dictionary  email=papito@404.net   password=abc123  

    Go To Login Page
    FIll Credentials   ${user}
    Submit Credentials
    Modal Content Should Be  Usuário e/ou senha inválidos.

Incorret Email

    [Tags]    inv_email

    ${user}   Create Dictionary  email=papito.com.br   password=abc123  

    Go To Login Page
    FIll Credentials   ${user}
    Submit Credentials
    Should Be Type Email


Required Email

    [Tags]        temp

    ${user}   Create Dictionary  email=${EMPTY}   password=abc123

    Go To Login Page
    Fill Credentials  ${user}
    Submit Credentials
    Alert Span Should Be  E-mail obrigatório

Required Pass

    [Tags]        temp

    ${user}   Create Dictionary  email=carlos.souza@email.com   password=${EMPTY}

    Go To Login Page
    Fill Credentials  ${user}
    Submit Credentials
    Alert Span Should Be  Senha obrigatória

Required Fields

    [Tags]        temp

    ${expected_alerts}   Create List
    ...                  E-mail obrigatório
    ...                  Senha obrigatória

    ${user}   Create Dictionary  email=${EMPTY}   password=${EMPTY}

    Go To Login Page
    Submit Credentials
    Alert Spans Should Be  ${expected_alerts}