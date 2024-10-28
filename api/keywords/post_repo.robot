*** Settings ***
Resource            ../api_resources/common.robot
Resource            ../api_resources/api_vars.robot

*** Keywords ***
create a repository with name
    [Arguments]    ${Repo_Name}    ${code}    ${private}

    ${create_repo_payload}=       Create Dictionary    name=${Repo_Name}    private=${private}
    ${AUTH_HEADER}=    Get Header    ${TOKEN}
    # Send POST request to create a new repository
    ${response}=      Post    ${BASE_URL}${Repo_Endpoint}    json=${create_repo_payload}    headers=${AUTH_HEADER}    expected_status=${code}
    Set Test Variable    ${response}

create a repository with name and token
    [Arguments]    ${Repo_Name}    ${code}    ${header}

    ${create_repo_payload}=       Create Dictionary    name=${Repo_Name}
    # Send POST request to create a new repository
    ${response}=      Post    ${BASE_URL}${Repo_Endpoint}    json=${create_repo_payload}    headers=${header}   expected_status=${code}
    Set Test Variable    ${response}

Validate successful repo creation
    [Arguments]    ${response}    ${Repo_Name}
    Should Be Equal As Strings    ${response.json()['name']}    ${Repo_Name}
    Should Be Equal As Strings    ${response.json()['private']}    False
    Should Be Equal As Strings    ${response.json()['owner']['login']}    ${USER}
    Should Contain                ${response.json()["html_url"]}    ${USER}/${REPO_NAME}
    Log To Console    Repository created with name : ${response.json()['name']}

Validate failed repo creation with null name
    Should Be Equal As Strings    ${response.json()["message"]}    ${creation_failed_msg}
    Should Be Equal As Strings    ${response.json()["errors"][0]["code"]}    ${missing_field_error}
    Should Be Equal As Strings    ${response.json()["errors"][0]["field"]}    ${missing_field_name}
    Log To Console    Validated repo creation with null name input passed

Validate failed repo creation with duplicate name
    Should Be Equal As Strings    ${response.json()["message"]}    ${creation_failed_msg}
    Should Be Equal As Strings    ${response.json()["errors"][0]["field"]}    ${missing_field_name}
    Should Be Equal As Strings    ${response.json()["errors"][0]["message"]}    ${duplicate_name_resp_msg}
    Log To Console    Validated failed repo creation with duplicate name

Validate failed repo creation with invalid token
    Should Be Equal As Strings    ${response.json()["message"]}    ${bad_credentials_msg}
    Log To Console    Validated failed repo creation with invalid token

