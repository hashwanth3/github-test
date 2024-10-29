*** Settings ***
Resource    ../keywords/login.robot
Suite Setup       Open Browser    ${UI_BASE_URL}    ${BROWSER}
Suite Teardown    Close Browser    

*** Test Cases ***

Validate empty field inputs
    [Documentation]    Test case to validate entry of empty field inputs
    [Tags]    UI_Scenario_1    negative
    Validate empty email field
    Validate empty password field

Validate Login with incorrect credentials
    [Documentation]    Test case to validate incorrect credentials login
    [Tags]    UI_Scenario_1    negative
    Login to Environment    ${INCORRECT_USER}    ${INCORRECT_PASSWORD}
    Wait Until Element Is Visible    ${incorrect_cred_locator}    timeout=30

Login Test
    [Documentation]    Test case to validate login page
    [Tags]    UI_Scenario_1    positive
    Login to Environment    ${USER}    ${PASSWORD}
    validate home page




