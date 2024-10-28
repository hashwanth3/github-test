*** Settings ***
Resource            ../api_resources/common.robot
Resource            ../api_resources/api_vars.robot

*** Keywords ***
delete a repository with name
    [Arguments]    ${Repo_Name}    ${code}

    ${AUTH_HEADER}=    Get Header    ${token}
    ${delete_response}=  Delete    ${del_repo_endpoint}${Repo_Name}    headers=${AUTH_HEADER}    expected_status=${code}