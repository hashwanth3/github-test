*** Settings ***
Resource            ../api_resources/common.robot
Resource            ../api_resources/api_vars.robot

*** Keywords ***
Create Issue
    [Documentation]    Creates an issue in the specified repository.
    ${issue_title_name}=    Generate random name with prefix and length    ${issue_title_prefix}    ${random_length}
    ${issue_body}=    Generate random name with prefix and length    ${issue_body_prefix}    ${random_length}
    ${payload}=    Create Dictionary    title=${issue_title_name}    body=${issue_body}
    Set Test Variable    ${issue_title_name}
    Set Test Variable    ${issue_body}
    ${AUTH_HEADER}=    Get Header    ${TOKEN}
    ${response}=    Post    ${Get_Repo_Endpoint}${Repo_Name}${issues_endpoint}    json=${payload}    headers=${AUTH_HEADER}    expected_status=${created_code}
    Set Test Variable    ${response}
    Log To Console    Issue Created Successfully for ${Repo_Name} with title ${issue_title_name}
    RETURN    ${response.json()}

Validate Create issue
    Should Be Equal As Strings    ${response.json()["title"]}    ${issue_title_name}

List Issues
    [Documentation]    Lists all issues in the specified repository.
    ${AUTH_HEADER}=    Get Header    ${TOKEN}
    ${response}=    Get    ${List_Endpoint}${REPO_NAME}${issues_endpoint}    headers=${AUTH_HEADER}    expected_status=${success_code}
    Set Test Variable    ${response}
    RETURN    ${response.json()}

Verify Issue Details
    [Arguments]    ${issues}    ${expected_issue}
    ${found_issue}=    Set Variable    False
    Should Be Equal As Strings    ${issue_title_name}    ${expected_issue["title"]}
    Should Be Equal As Strings    ${issue_body}    ${expected_issue["body"]}
