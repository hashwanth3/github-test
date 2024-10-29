*** Settings ***
Resource    ../keywords/login.robot
Resource    ../keywords/repository.robot
Resource    ../../api/api_resources/common.robot
Resource    ../../api/keywords/delete_repo.robot

Suite Setup    Repo Suite

Suite Teardown    Close Browser


*** Test Cases ***
Create a public repo
    [Documentation]    Test case to validate create public repo from ui
    [Tags]    UI_Scenario_2    positive
    [Teardown]    delete a repository with name    ${repo_name}    ${deleted_code}
    

    validate home page
    Go To    ${new_repo_link}
    ${repo_name} =     Generate random name with prefix and length    ${repo_prefix}    ${random_length}
    Set Test Variable    ${repo_name}
    Input Text    ${input_repo_name_locator}    ${repo_name}
    Sleep    1
    Wait Until Element Is Visible    ${create_repo_button}    timeout=30
    Click Element    ${create_repo_button}
    Validate public repo creation    ${repo_name}

Create a private repo
    [Documentation]    Test case to validate create private repo from ui
    [Tags]    UI_Scenario_2    positive
    [Teardown]    delete a repository with name    ${repo_name}    ${deleted_code}

    Go To    ${UI_BASE_URL}
    validate home page
    Go To    ${new_repo_link}
    ${repo_name} =     Generate random name with prefix and length    ${repo_prefix}    ${random_length}
    Set Test Variable    ${repo_name}
    Input Text    ${input_repo_name_locator}    ${repo_name}
    Sleep    1
    Click Element    ${private_radio_button_locator}
    Wait Until Element Is Visible    ${create_repo_button}    timeout=30
    Click Element    ${create_repo_button}
    Validate private repo creation    ${repo_name}
    