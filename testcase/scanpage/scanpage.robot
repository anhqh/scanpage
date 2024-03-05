*** Variables ***
${PROJECT_ABSOLUTE_PATH}
...     ${CURDIR}${/}..${/}..${/}

${test_target_sub_system}
...     batch_management

${test_target_sub_page_name}
...     timed_hold

*** Settings ***
Documentation     page user list
Library             String
Library             Collections
Library             RPA.Browser.Selenium    auto_close=${TRUE}
Library             RPA.FileSystem
Library             OperatingSystem

# import setting
Resource            ${PROJECT_ABSOLUTE_PATH}keyword${/}common${/}keyword.common.resource

Resource            ${PROJECT_ABSOLUTE_PATH}setting${/}setting.app.resource

*** Test Cases ***
Case 1

    Log     100
    Open Url
    ...     https://truyenfull.vn/nguoi-cam-quyen/chuong-511/

    sleep   2s
    ${content}=     Get Text    chapter-c
    ${content}=        Replace String      ${content}     \n\n       \n
    @{content_list}=    Split String By 4k Character        ${content}

    FOR     ${input_text}   IN  @{content_list}
        Log     ${input_text}
    END