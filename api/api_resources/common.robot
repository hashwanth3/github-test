*** Settings ***
Documentation       This file contains all common functions across all the API's. login for example.
Library    RequestsLibrary
Library    			String
Resource    ../../global_resources/env_variables.robot
Resource    api_vars.robot


*** Keywords ***

Generate random name with prefix and length
    [Arguments]    ${prefix}    ${length}
    ${random_name}    Generate Random String    ${length}    [NUMBERS]
    ${generated_name}=    Set Variable    ${prefix}${random_name}
    RETURN    ${generated_name}

Get Header
    [Arguments]    ${curr_token}
    ${cur_header}=    Create Dictionary    Authorization=token ${curr_token}
    RETURN    ${cur_header}



