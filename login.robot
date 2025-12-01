*** Settings ***
Resource    init.robot
Suite Setup    Open Default Browser
Suite Teardown    Close Browser    ALL
Test Timeout    30

*** Test Cases ***
Login Swag
    Open Default Browser
    Go To    ${BASE_URL}
    Click    ${LOGIN_SINGNUP_BUTTON}
    Click    ${LOGIN_POPUP_ACCOUNT_LOGIN_BUTTON}
    Click    ${LOGIN_POPUP_ACCOUNT_LOGIN_OTHERS_BUTTON}
    Fill Text    ${LOGIN_POPUP_ACCOUNT_INPUT}    ${TEST_ACCOUNT}
    Fill Text    ${LOGIN_POPUP_PASSWORD_INPUT}    ${TEST_ACCOUNT_PASSWORD}
    Sleep    1s
    Click    ${LOGIN_POPUP_LOGIN_BUTTON}
    Run Keyword And Ignore Error    Try To Close AD
    Sleep    1s
    ${geetest_popup} =    Get Element Count     ${GEETEST_POPUP_TITLE}
    IF    ${geetest_popup} > 0
        Take Screenshot    GeeTest_Detected.png
        Fail    GeeTest Is Detected - Please Disable The GeeTest
    END
    Verify The Accoount ID Is Visible

*** Keywords ***
Open Default Browser
    Set Browser Timeout   60
    New Browser    browser=chromium
    New Context    viewport={'width': 1920, 'height': 1080}    recordVideo={'dir':'videos','size':{'width': 1920, 'height': 1080}}
    New Page

Verify The Accoount ID Is Visible
    Click    ${MAIN_PAGE_PROFILE_BUTTON}
    Get Element States   ${MAIN_FOLLOWING_TAB}    validate    visible    ${MAIN_PROFILE_SIDE_BAR_USERNAME.format(username='${TEST_ACCOUNT}')}
    [Teardown]    Click    ${MAIN_PROFILE_SIDE_BAR_X_BUTTON}

Try To Close AD
    ${AD_close_button} =    Get Element Count    ${AD_CLOSE_BUTTON}
    IF    ${AD_close_button} > 0
        Click    ${AD_CLOSE_BUTTON}
        Click    ${LOGIN_POPUP_LOGIN_BUTTON}
    END