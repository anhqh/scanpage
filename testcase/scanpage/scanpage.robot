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
Library             RPA.Browser.Selenium    auto_close=${False}
Library             RPA.FileSystem
Library             RPA.HTTP
Library             OperatingSystem

# import setting
Resource            ${PROJECT_ABSOLUTE_PATH}keyword${/}common${/}keyword.common.resource

Resource            ${PROJECT_ABSOLUTE_PATH}setting${/}setting.app.resource

*** Test Cases ***
Case 1
    Log     100
    # TODO for theo danh sach tap truyen vdu 511 512 513...
    # Todo create folder luu file mp3 theo ten truyen
    # TODO Delete all file Speech.mp3 (or move to folder backup)
    Open Url
    ...     https://truyenfull.vn/nguoi-cam-quyen/chuong-511/

    Wait Until Page Contains Element
    ...     chapter-c

    Sleep   2s

    Delete ADS Element

    ${content}=     Get Text    chapter-c
    ${content}=        Replace String      ${content}     \n\n       \n
    @{content_list}=    Split String By 4k Character        ${content}

    Open Url
    ...     https://ttsopenai.com/
    Sleep   2s

#    FOR     ${input_text}   IN  @{content_list}
    Input Text
    ...     input-text
    ...     ${content_list}[1]
    Sleep   2s
    Select From List By Value
    ...     voice
    ...     nova
    Sleep   2s
    Click Button When Visible
    ...     //button[@type="submit" and text()="Create Speech"]
    Sleep   2s
#    Wait Until Keyword Succeeds
#    ...     45m
#    ...     30s
#    ...     Page Should Contain Element
#    ...         //button[@type="button" and text()="Download MP3"]
    Wait Until Page Contains Element
    ...     //button[@type="button" and text()="Download MP3"]

    Click Button When Visible
    ...     //button[@type="button" and text()="Download MP3"]

    # TODO kiem tra file Speech.mp3 exist
    # Copy file den thu muc luu giu
    # Doi ten file sau khi copy xong
    # Kiem tra file doi ten thanh cong, file ton tai
    # Xoa file speech.mp3 trong thu muc dowload
    # kiem tra file da bi xoa
    # Tiep tuc vong For

#        Log     ${input_text}
#        Open Url
#        ...     https://ttsopenai.com/
#        input-text
#    END


