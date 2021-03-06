*** Settings ***
Documentation   Geek route test suite

Resource        ${EXECDIR}/resources/Base.robot

*** Test Cases ***
Be a geek

    #Dado que temos um novo usuário
    ${user}               Factory Be Geek
    Remove User           ${user}

    # E esse usuário é um cliente comum
    POST User             ${user}

    # E esse usuário possui um token válido
    ${token}               Get Token    ${user}

    # Quando faço uma requisição POST na rota /geeks
    ${response}            POST Geek    ${token}   ${user}[geek_profile]
 
    # Então deve retornar 201
    Status Should Be       201          ${response}

    # E ao cnsultar esse usuário na API Users
    ${response}            Get User     ${token}

    # Então o perfil geek deve ser retornado
    Should Be Equal As Strings                     ${user}[name]                           ${response.json()}[name]
    Should Be Equal As Strings                     ${user}[email]                          ${response.json()}[email]

    Should Be Equal As Strings                     ${user}[geek_profile][whatsapp]         ${response.json()}[whatsapp]
    Should Be Equal As Strings                     ${user}[geek_profile][desc]             ${response.json()}[desc]
    
    ${expected_float}                              Convert To Number                       ${user}[geek_profile][cost]
    ${got_float}                                   Convert To Number                       ${response.json()}[cost]
    
    Should Be Equal As Strings                     ${expected_float}                       ${got_float}
    Should Be Equal As Strings                     ${user}[geek_profile][cost]             ${response.json()}[cost]
    Should Be Equal As Strings                     ${user}[geek_profile][printer_repair]   ${response.json()}[printer_repair]
    Should Be Equal As Strings                     ${user}[geek_profile][work]             ${response.json()}[work]
    Should Be Equal As Strings                     None                                    ${response.json()}[avatar]
    Should Be Equal As Strings                     True                                    ${response.json()}[is_geek]

Get Geek List

    [tags]                      temp

    ${data}                     Factory Search For Geeks

    FOR  ${geek}    IN  @{data}[geeks]

        Post User  ${geek}

        ${token}   Get Token  ${geek}

        Post Geek  ${token}   ${geek}[geek_profile]

    END
        
    Post User                    ${data}[user]

    ${token}                     Get Token         ${data}[user]

    ${response}                  Get Geeks         ${token}
    Status Should Be             200               ${response}

    ${total}                     Get Length         ${response.json()}[Geeks]
    Should Be True               ${total} > 0





