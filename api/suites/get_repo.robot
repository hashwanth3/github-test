*** Settings ***
Documentation       A suite with test cases to test get repo API

Resource            ../api_resources/common.robot
Resource            ../keywords/get_repo.robot
Resource            ../keywords/delete_repo.robot


*** Test Cases ***
Verify successful get repository
    [Documentation]    This test case validates susccessful get repo API
    [Tags]    API_Scenario_2    poistive
    [Setup]    setup to create a repository    ${FALSE}
    [Teardown]    delete a repository with name    ${Repo_Name}    ${deleted_code}
    
    ${AUTH_HEADER}=    Get Header    ${TOKEN}
    Send a get request to repo with    ${AUTH_HEADER}    ${Repo_Name}    ${success_code}
    Validate get request metadata

Verify get Repository with Non-existent Repository
    [Documentation]    Verify that an error is returned for a non-existent repository
    [Tags]    API_Scenario_2    negative

    ${AUTH_HEADER}=    Get Header    ${TOKEN}
    Send a get request to repo with    ${AUTH_HEADER}    ${Invalid_Repo_Name}    ${not_found_code}
    Validate get request with non existant Repository

Verify get repo with invalid token
    [Documentation]    creation of a repository with invalid token
    [Tags]    API_Scenario_2    negative

    ${token}=    Get Header    ${invalid_token}
    Send a get request to repo with   ${token}    ${Invalid_Repo_Name}    ${unauthorized_code}
    Validate failed get request with invalid token

Verify get Repo with no access
    [Documentation]    creation of a repository with no access token
    [Tags]    API_Scenario_2    negative
    [Setup]    setup to create a repository    ${TRUE}
    [Teardown]    delete a repository with name    ${Repo_Name}    ${deleted_code}

    ${token}=    Get Header    ${NO_ACCESS_TOKEN}
    Send a get request to repo with    ${token}    ${Repo_Name}    ${not_found_code}

Verify get Repository with no Repository name
    [Documentation]    Verify that an error is returned for a non-existent repository
    [Tags]    API_Scenario_2    negative

    ${AUTH_HEADER}=    Get Header    ${TOKEN}
    Send a get request to repo with    ${AUTH_HEADER}    ${NONE}    ${not_found_code}
    Validate get request with non existant Repository

