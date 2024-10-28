*** Settings ***
Documentation       A suite with test cases to test get repo API

Resource            ../api_resources/common.robot
Resource            ../keywords/issues.robot
Resource            ../keywords/get_repo.robot
Resource            ../keywords/delete_repo.robot


*** Test Cases ***
Verify Create Issues
    [Documentation]    Creates an issue and verifies it is listed correctly.
    [Tags]    API_Scenario_3    poistive
    [Setup]    setup to create a repository    ${FALSE}
    [Teardown]    delete a repository with name    ${Repo_Name}    ${deleted_code}

    Create Issue
    Validate Create issue

Verify List Issues
    [Documentation]    Creates an issue and verifies it is listed correctly.
    [Tags]    API_Scenario_3    poistive
    [Setup]    setup to create a repository    ${FALSE}
    [Teardown]    delete a repository with name    ${Repo_Name}    ${deleted_code}

    ${created_issue}=    Create Issue
    Validate Create issue

    ${issues}=    List Issues

    Verify Issue Details    ${issues}    ${created_issue}

###need to test
#
Verify Pagination for Issues
    [Documentation]    This test case verifies pagination when retrieving issues.
    [Tags]    API_Scenario_3    poistive
    [Setup]    setup to create a repository    ${FALSE}
    [Teardown]    delete a repository with name    ${Repo_Name}    ${deleted_code}

    # Create multiple issues for pagination testing
    FOR    ${i}    IN RANGE    1    15
        Create Issue
    END

    ${AUTH_HEADER}=    Get Header    ${TOKEN}

    ${pagenation_params_page_1} =    Create Dictionary    per_page=5    page=1
    ${pagenation_params_page_2} =    Create Dictionary    per_page=5    page=2

    ${response}=    Get    ${BASE_URL}/repos/${USER}/${Repo_Name}/issues   params=${pagenation_params_page_1}    headers=${AUTH_HEADER}    expected_status=${success_code}
    ${page_1_issues_count}=    Evaluate    len(${response.json()})
    Should Be True    ${page_1_issues_count} <= 5    Should retrieve 5 or fewer issues on the first page.

    ${response}=    Get    ${BASE_URL}/repos/${USER}/${Repo_Name}/issues    params=${pagenation_params_page_2}    headers=${AUTH_HEADER}    expected_status=${success_code}
    ${page_2_issues_count}=    Evaluate    len(${response.json()})
    Should Be True    ${page_2_issues_count} <= 5    Should retrieve 5 or fewer issues on the first page.


