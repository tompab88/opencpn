MACRO (TODAY RESULT)
    IF (CMAKE_HOST_WIN32)
        EXECUTE_PROCESS(COMMAND "cmd" "/C" "date /T" OUTPUT_VARIABLE ${RESULT})
        string(REGEX REPLACE "(..)/(..)/(....).*" "\\3-\\2-\\1"
               ${RESULT} ${${RESULT}})
    ELSEIF(UNIX OR MINGW)
        EXECUTE_PROCESS(COMMAND "date" "-u" "+%d/%m/%Y" OUTPUT_VARIABLE ${RESULT})
        string(REGEX REPLACE "(..)/(..)/(....).*" "\\3-\\2-\\1"
               ${RESULT} ${${RESULT}})
    ELSE ()
        MESSAGE(SEND_ERROR "date not implemented")
        SET(${RESULT} 000000)
    ENDIF ()
ENDMACRO (TODAY)

MACRO (COMMIT_ID RESULT)
    # Get the latest abbreviated commit hash of the working branch
    execute_process(
      COMMAND git log -1 --format=%h
      WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
      OUTPUT_VARIABLE COMMIT_HASH
      OUTPUT_STRIP_TRAILING_WHITESPACE
    )
    SET(${RESULT} ${COMMIT_HASH})
ENDMACRO (COMMIT_ID)

MACRO (BUILD_NUM RESULT)
    # Get the current Travis/CircleCI build number, possibly ""
    execute_process(
      COMMAND /usr/bin/sh -c "echo $CIRCLE_BUILD_NUM$TRAVIS_BUILD_NUM$BUILD_NUMBER"
      OUTPUT_VARIABLE _BUILD_NUM
      OUTPUT_STRIP_TRAILING_WHITESPACE
    )
SET(${RESULT} ${_BUILD_NUM})
ENDMACRO (BUILD_NUM)
