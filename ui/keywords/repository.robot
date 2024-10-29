*** Settings ***

Library  SeleniumLibrary
Resource    ../ui_resources/ui_vars.robot
Resource    ../keywords/login.robot

*** Keywords ***
Validate public repo creation
    [Arguments]    ${repo_name}
    Wait Until Element Is Visible    ${repo_name_link_locator}    timeout=30
    ${current_url}=    Get Location
    Should Be Equal    ${current_url}    ${UI_BASE_URL}/${USER}/${repo_name}
    Wait Until Element Is Visible    ${public_tag_locator}    timeout=30

Validate private repo creation
    [Arguments]    ${repo_name}
    Wait Until Element Is Visible    ${repo_name_link_locator}    timeout=30
    ${current_url}=    Get Location
    Should Be Equal    ${current_url}    ${UI_BASE_URL}/${USER}/${repo_name}
    Wait Until Element Is Visible    ${private_tag_locator}    timeout=30

repo Suite
    Open Browser    ${UI_BASE_URL}    ${BROWSER}
    Login to Environment    ${USER}    ${PASSWORD}