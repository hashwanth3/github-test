*** Settings ***

Library  SeleniumLibrary
Resource    ../../global_resources/env_variables.robot
Resource    ../ui_resources/ui_vars.robot

*** Keywords ***
Login to Environment
    [Arguments]    ${USER_input}    ${PASSWORD_input}
    Go To    ${login_endpoint}
    Wait Until Element Is Visible    ${user_field}
    
    Input Text    ${user_field}    ${USER_input}
    Sleep    2
    Input Text    ${password_field}    ${PASSWORD_input}
    Sleep    2
    Click Element    ${signin_field}

validate home page
    Wait Until Element Is Visible    ${dashboard_link}    timeout=30

Validate empty email field
    Go To    ${login_endpoint}
    Wait Until Element Is Visible    ${user_field}
    Click Element    ${signin_field}
    Wait Until Element Is Visible    ${user_field}

Validate empty password field
    Go To    ${login_endpoint}
    Wait Until Element Is Visible    ${password_field}
    Click Element    ${signin_field}
    Wait Until Element Is Visible    ${password_field}


