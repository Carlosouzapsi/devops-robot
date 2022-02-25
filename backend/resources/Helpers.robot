*** Settings ***
Documentation   Helpers

*** Keywords ***
Get Token
    [Arguments]   ${user}

    # Obtendo o token
    ${payload}    Create Dictionary  
    ...           email=${user}[email]  
    ...           password=${user}[password]

    ${Response}   POST Session  ${payload}
    ${result}     Set Variable  ${EMPTY}

    IF  "200" in "${response}"
        ${result}      Set Variable  Bearer ${response.json()}[token]
    END

    [return]      ${result}



Remove User
    [Arguments]   ${user}

    ${token}      Get Token   ${user}

    ### Verifica se o user já está na base, se sim entra no IF e apaga ele.
    IF  "${token}"
        Delete User           ${token}
    END
