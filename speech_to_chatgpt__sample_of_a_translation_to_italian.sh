#!/bin/bash
#
# https://github.com/francescor/speech-to-chatgpt-to-speech
#

# Esempio di funzionamento in Italiano, ma su codice vecchio
# meglio se prendi lo script iniziale, e semplicemente traduci i messaggi
# dall'Inglese: poi imposti LANG=it ma devi anche cambiare lingua in vosk-model

function say_message() {
echo "ROBOT: $message"
espeak -v $LANG "${message}"
}

# set talking language: en,en-us,de,es,it,pt,nl,ru,.
# if you change language then you better translate the below messages
# remember to adapt nerd-ditcation model, too
LANG=it
clear
message="Parlami.  Per uscire dimmi: STOP"
say_message
my_question=""
chat_session=$(mktemp /tmp/speech.XXXXXXXXX)
rm "$chat_session"
while [[ "${my_question::4}" != "stop" ]]; do
  while [[ "$my_question" == "" ]]; do
    echo
    echo "...ascolto"
    my_question=`nerd-dictation begin --input=SOX  --output=STDOUT --defer-output --timeout 2 2> /dev/null`
    # my_question="How many months in a year?"
    echo
    echo -n "TU: "
    echo $my_question
    if [[ "$my_question" == "" ]];  then
      message="Non capisco, ripeti"
      say_message
    fi
  done
  if [[ "${my_question::4}" != "stop" ]];  then
    message="Hai detto: ${my_question}"
    say_message
    message="Dimmi NO se ho capito male, altrimenti attendi"
    say_message
    echo
    echo "...ascolto"
    confirmed=`nerd-dictation begin --input=SOX  --output=STDOUT --defer-output --timeout 1 2> /dev/null`
    echo
    if [[ "${confirmed}" != "" ]]; then
      echo -n "TU: "
      echo $confirmed
    fi
    if [[ "${confirmed::2}" != "no" ]];  then
      echo "...domando a ChatGPT"
      echo 
      answer=`sgpt --chat $chat_session "\"${my_question}\""`
      echo -n "ChatGPT: "
      echo $answer
      espeak -v ${LANG}+f5  "\"${answer}\""
      my_question=""
      echo
      message="altro?"
      say_message
    else
      message="Ok, scusa, per favore ripeti!"
      say_message
      my_question=""
    fi
  fi
done
message="Ok, mi fermo"
say_message
