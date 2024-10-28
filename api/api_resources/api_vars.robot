*** Settings ***
Resource    ../../global_resources/env_variables.robot
*** Variables ***
${Repo_Prefix}     test-repo
${random_length}    5
${invalid_token}    ghp_wXxjSpfoasg7jgFljAYj1QEomxhzmv
${Invalid_Repo_Name}    random-123
${issue_title_prefix}    issue-title
${issue_body_prefix}    issue-body
${test_repo_name}         test-data
${test_branch_name}        test-branch
${TARGET_BRANCH}     main
${PR_TITLE}          New Feature PR
${PR_BODY}           This PR introduces new features.

#endpoints
${Repo_Endpoint}    /user/repos
${Get_Repo_Endpoint}    ${BASE_URL}/repos/${USER}/
${Del_repo_Endpoint}    ${BASE_URL}/repos/${USER}/
${issues_endpoint}      /issues
${List_Endpoint}    ${BASE_URL}/repos/${USER}/
${pr_endpoint}    ${BASE_URL}/repos/${USER}/${test_repo_name}/pulls
#status_codesx
${success_code}    200
${deleted_code}    204
${created_code}    201
${unprocessable_code}    422
${unauthorized_code}    401
${not_found_code}    404

#response msgs
${creation_failed_msg}    Repository creation failed.
${missing_field_error}    missing_field
${missing_field_name}    name
${duplicate_name_resp_msg}    name already exists on this account
${bad_credentials_msg}    Bad credentials
${not_found_resp_msg}    Not Found