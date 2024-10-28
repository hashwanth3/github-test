*** Settings ***
Library    RequestsLibrary
Library    Collections

Resource    ../keywords/pull_requests.robot
Resource    ../api_resources/api_vars.robot
Resource    ../api_resources/common.robot

*** Test Cases ***
Create and Verify Pull Request
    [Documentation]    This test case creates a pull request and verifies the response metadata.
    [Teardown]    Close PR    ${response.json()["number"]}
    [Tags]    API_Scenario_4

    Create a Pull request
    Validate Successful Pull Request
    Log To Console    PR created successfully: ${response.json()["html_url"]}


