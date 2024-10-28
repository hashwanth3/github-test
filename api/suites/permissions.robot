*** Settings ***
Documentation       A suite with test cases to test  token permissions

Resource            ../api_resources/common.robot
Resource            ../keywords/get_repo.robot
Resource            ../keywords/delete_repo.robot
Resource            ../keywords/permissions.robot


*** Test Cases ***
Verify get Repo with no access token
    [Documentation]    creation of a repository with no access token
    [Tags]    API_Scenario_5    negative
    [Setup]    setup to create a repository    ${TRUE}
    [Teardown]    delete a repository with name    ${Repo_Name}    ${deleted_code}

    ${token}=    Get Header    ${NO_ACCESS_TOKEN}
    Send a get request to repo with    ${token}    ${Repo_Name}    ${not_found_code}

Verify get Repo with no access token
    [Documentation]    creation of a repository with expired token
    [Tags]    API_Scenario_5    negative
    [Setup]    setup to create a repository    ${TRUE}
    [Teardown]    delete a repository with name    ${Repo_Name}    ${deleted_code}

    ${token}=    Get Header    ${EXPIRED_TOKEN}
    Send a get request to repo with    ${token}    ${Repo_Name}    ${not_found_code}

Test Unauthorized delete with readonly access
    [Documentation]    Validate that an unauthorized action returns a 403 or appropriate error.
    [Tags]    API_Scenario_5    negative
    [Setup]    setup to create a repository    ${TRUE}
    [Teardown]    delete a repository with name    ${Repo_Name}    ${deleted_code}

    ${token}=    Get Header    ${READ_ACCESS_TOKEN}
    ${delete_response}=  Delete    ${del_repo_endpoint}${Repo_Name}    headers=${token}    expected_status=${not_found_code}
    
