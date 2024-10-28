*** Settings ***
Documentation       A suite with test cases to test post repo API

Resource            ../api_resources/common.robot
Resource            ../api_resources/api_vars.robot
Resource            ../keywords/post_repo.robot
Resource            ../keywords/delete_repo.robot

*** Test Cases ***
Create New Repository
    [Documentation]    creation of a repository using the /user/repos endpoint
    [Tags]    API_Scenario_1    poistive
    [Teardown]    delete a repository with name    ${Repo_Name}    ${deleted_code}

    ${Repo_Name}=    Generate random name with prefix and length    ${Repo_Prefix}    ${random_length}
    create a repository with name    ${Repo_Name}    ${created_code}    ${FALSE}
    Validate successful repo creation    ${response}    ${Repo_Name}

Create Repository Without Name
    [Documentation]    creation of a repository without a name
    [Tags]    API_Scenario_1    negative

    create a repository with name    ${NONE}    ${unprocessable_code}    ${FALSE}
    Validate failed repo creation with null name

Create a repository with existing name
    [Documentation]    creation of a repository with exising name
    [Tags]    API_Scenario_1    negative
    [Teardown]    delete a repository with name    ${Repo_Name}    ${deleted_code}

    ${Repo_Name}=    Generate random name with prefix and length    ${Repo_Prefix}    ${random_length}
    create a repository with name    ${Repo_Name}    ${created_code}    ${FALSE}
    Validate successful repo creation    ${response}    ${Repo_Name}

    create a repository with name    ${Repo_Name}    ${unprocessable_code}    ${FALSE}
    Validate failed repo creation with duplicate name

Create repository with invalid token
    [Documentation]    creation of a repository with invalid token
    [Tags]    API_Scenario_1    negative

    ${Repo_Name}=    Generate random name with prefix and length    ${Repo_Prefix}    ${random_length}
    ${token}=    Get Header    ${invalid_token}
    create a repository with name and token   ${Repo_Name}    ${unauthorized_code}    ${token}
    Validate failed repo creation with invalid token




