*** Settings ***
Resource            ../api_resources/common.robot
Resource            ../api_resources/api_vars.robot
Resource            post_repo.robot

*** Keywords ***

setup to create a repository
    [Arguments]    ${private}
    ${Repo_Name}=    Generate random name with prefix and length    ${Repo_Prefix}    ${random_length}    
    create a repository with name    ${Repo_Name}    ${created_code}    ${private}
    Set Test Variable    ${Repo_Name}
   # Validate successful repo creation    ${response}    ${Repo_Name}

Send a get request to repo with
    [Arguments]    ${AUTH_HEADER}    ${Repo_Name}    ${code}
    ${response}=   Get    ${Get_Repo_Endpoint}${Repo_Name}   headers=${AUTH_HEADER}    expected_status=${code}
    Set Test Variable    ${response}

Validate get request metadata
    Should Be Equal As Strings    ${response.json()["name"]}    ${Repo_Name}
    Should Be Equal As Strings    ${response.json()["full_name"]}    ${USER}/${Repo_Name}


Validate get request with non existant Repository
    Should Be Equal As Strings    ${response.json()["message"]}    ${not_found_resp_msg}

Validate failed get request with invalid token
    Should Be Equal As Strings    ${response.json()["message"]}    ${bad_credentials_msg}

