*** Settings ***
Resource    ../api_resources/api_vars.robot
Resource    ../api_resources/common.robot
Library    RequestsLibrary
Library    Collections

*** Keywords ***

Create a Pull request
    ${pr_data}=       Create Dictionary    title=${PR_TITLE}    head=${USER}:${test_branch_name}    base=${TARGET_BRANCH}    body=${PR_BODY}

    ${AUTH_HEADER}=    Get Header    ${TOKEN}
    # Send request to create a pull request
    ${response}=      Post    ${pr_endpoint}    headers=${AUTH_HEADER}    json=${pr_data}    expected_status=${created_code}
    Set Test Variable    ${response}

Validate successful pull request

    Should Be Equal As Strings    ${response.json()["title"]}    ${PR_TITLE}
    Should Be Equal As Strings    ${response.json()["body"]}     ${PR_BODY}
    Should Be Equal As Strings    ${response.json()["head"]["ref"]}    ${test_branch_name}
    Should Be Equal As Strings    ${response.json()["base"]["ref"]}    ${TARGET_BRANCH}

Close PR
    [Arguments]    ${pr_number}
    ${close_pr_data}=    Create Dictionary    state=closed
    ${AUTH_HEADER}=    Get Header    ${TOKEN}
    ${issue_endpoint}=    Set Variable    ${BASE_URL}/repos/${USER}/${test_repo_name}/issues/${pr_number}
    PATCH    ${issue_endpoint}    headers=${AUTH_HEADER}    json=${close_pr_data}    expected_status=200
    Log To Console    PR ${pr_number} closed successfully.