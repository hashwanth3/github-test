*** Settings ***
Resource            ../api_resources/common.robot
*** Keywords ***

Delete repo with readonly access
    ${delete_response}=  Delete    ${del_repo_endpoint}${Repo_Name}    headers=${token}    expected_status=404