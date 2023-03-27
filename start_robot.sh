#!/bin/bash

#
# https://github.com/francescor/speech-to-chatgpt-to-speech
#
# Simple script that:
#    * listen you talking (speech to text)
#    * ask ChatGPT, and
#    * speech out the answer (speech synthesizer)
#
# Requirements:
#   https://espeak.sourceforge.net `yum install espeak`
#   https://github.com/ideasman42/nerd-dictation (vosks, sox, xdotool...)
#   https://github.com/TheR1D/shell_gpt
# Env variables:
#   export OPENAI_API_KEY=XXXXXXXXXXXXX
#   export SOX_OPTS="....."
#
# vosks language models in 
#   ~/.config/nerd-dictation


# set talking language: en,en-us,de,es,it,pt,nl,ru,.
# if you change language then you better translate the below messages
# remember to adapt nerd-ditcation model, too

LANG=en
clear

function say_message() {
    echo "ROBOT: $1"
    espeak -v $LANG "$1"
}

say_message "Ask me anything. To exit say: STOP"

my_question=""
chat_session=$(openssl rand -base64 5)

while [[ "${my_question::4}" != "stop" ]]; do
  while [[ "$my_question" == "" ]]; do
    echo
    echo "...listening"
    my_question=$(nerd-dictation begin --input=SOX --output=STDOUT --defer-output --timeout 2 2> /dev/null)
    echo
    echo -n "YOU: "
    echo $my_question
    if [[ "$my_question" == "" ]]; then
      say_message "I don't get it, Please repeat"
    fi
  done
  if [[ "${my_question::4}" != "stop" ]]; then
    say_message "You said: ${my_question}"
    say_message "Say NO if I'm wrong, or just wait"
    echo
    echo "...listening"
    confirmed=$(nerd-dictation begin --input=SOX --output=STDOUT --defer-output --timeout 1 2> /dev/null)
    echo
    if [[ "${confirmed}" != "" ]]; then
      echo -n "YOU: "
      echo $confirmed
    fi
    if [[ "${confirmed::2}" != "no" ]]; then
      echo "...asking ChatGPT"
      echo 
      answer=$(sgpt --chat $chat_session "\"${my_question}\"")
      echo -n "ChatGPT: "
      echo $answer
      espeak -v ${LANG}+f5 "\"${answer}\""
      my_question=""
      echo
      say_message "anything else?"
    else
      say_message "Ok, sorry I did not get it; please repeat!"
      my_question=""
    fi
  fi
done

say_message "Ok, I stop!"

