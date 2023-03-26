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
clear
echo "ROBOT: Ask me anything"
echo "To exit say: stop"
espeak "Ask me anything"
espeak "To exit say: stop"
my_question=""
chat_session="$(mktemp XXXXXXXXX)"

while [[ "${my_question::4}" != "stop" ]]; do
  while [[ "$my_question" == "" ]]; do
    echo
    echo "...listening"
    my_question=`nerd-dictation begin --input=SOX  --output=STDOUT --defer-output --timeout 2`
    # my_question="How many months in a year?"
    echo
    echo -n "YOU: "
    echo $my_question
    if [[ "$my_question" == "" ]];  then
      echo "ROBOT: I don't get it, Please repeat"
      espeak "I don't get it, Please repeat"
    fi
  done
  if [[ "${my_question::4}" != "stop" ]];  then
    echo -n "ROBOT: you said: "
    echo $my_question 
    echo "ROBOT: Say NO if I'm wrong, or just wait"
    espeak "\"You said: ${my_question}\""
    espeak "Say NO if I'm wrong, or just wait"
    echo
    echo "...listening"
    confirmed=`nerd-dictation begin --input=SOX  --output=STDOUT --defer-output --timeout 1 2> /dev/null`
    echo
    if [[ "${confirmed}" != "" ]]; then
      echo -n "YOU: "
      echo $confirmed
    fi
    if [[ "${confirmed::2}" != "no" ]];  then
      echo "...asking ChatGPT"
      echo 
      answer=`sgpt --chat $chat_session "\"${my_question}\""`
      echo -n "ChatGPT: "
      echo $answer
      # echo "\"${answer}\""
      espeak -v en-us+f5  "\"${answer}\""
      my_question=""
      echo
      echo "ROBOT: anything else?"
      espeak "anything else?"
    else
      echo "ROBOT: Ok, sorry I did not get it; please repeat!"
      espeak "Ok, sorry I did not get it; please repeat!"
      my_question=""
    fi
  fi
done
echo "Ok, I stop!"
espeak "Ok, I stop!"

