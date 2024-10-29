*** Settings ***
Resource    ../../global_resources/env_variables.robot
*** Variables ***

##Endpoints
${login_endpoint}    ${UI_BASE_URL}/login
${new_repo_link}    ${UI_BASE_URL}/new
##variables
${INCORRECT_USER}    Random
${INCORRECT_PASSWORD}    Randompassword


##Locators
${user_field}    //*[@id="login_field"]
${password_field}    //*[@id="password"]
${signin_field}    //input[@value='Sign in']
${dashboard_link}    //a[@data-analytics-event='{"category":"SiteHeaderComponent","action":"context_region_crumb","label":"Dashboard","screen_size":"full"}']//span[contains(text(),'Dashboard')]
${incorrect_cred_locator}    //*[@id="js-flash-container"]/div/div/div
${new_repo_locator}    /html/body/div[1]/div[5]/div/div/aside/div/div/loading-context/div/div[1]/div/div[1]/a/span
${input_repo_name_locator}    //*[@id=":r5:"]
${create_repo_button}    //button[@type='submit']//span[@data-component='buttonContent']
${repo_name_link_locator}    //*[@id="repo-content-pjax-container"]
${private_radio_button_locator}    //*[@id=":ra:"]
${public_tag_locator}    //span[normalize-space()='Public']
${private_tag_locator}    //span[normalize-space()='Private']