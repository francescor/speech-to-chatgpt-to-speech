# Speech-to-ChatGpt-to-Speech

Would you like to use ChatGPT simply by speaking and listening? this simple bash script will let you play a bit :) 

Demo Video 

[![Watch the video](https://github.com/francescor/speech-to-chatgpt-to-speech/raw/main/.github/images/video_preview.png)](https://raw.githubusercontent.com/francescor/speech-to-chatgpt-to-speech/main/.github/images/demo.mov)

[View in youtube](https://www.youtube.com/watch?v=n-De2hJPQ-s)

# Background

This afternoon I played a bit with https://github.com/TheR1D/shell_gpt, then tired 
of typing and reading I desired the ability to speak to ChatGPT while walking around my house and hear its responses.

This is just a game, nothing serious :)


# Requirements:

* https://espeak.sourceforge.net `yum install espeak`
* https://github.com/ideasman42/nerd-dictation (vosks, sox, xdotool...)
* https://github.com/TheR1D/shell_gpt  (the real cool stuff)

# Privacy

No audios are sent over the Internet, the speech recognition is local to your laptop.

# Only English? 

ChatGPT can understand and generate text in English, Spanish, French, German, Italian, Portuguese, Dutch, Russian, Chinese, Japanese, Korean, and many more, the same for speech recognitions: see https://alphacephei.com/vosk/models

As an example see `speech_to_chatgpt__sample_of_a_translation_to_italian.sh` for Italian.

# Let's try


It is just a basic bash script, so to install end execute download & run:

```
./speech_to_chatgpt.sh
```
### Env variables:

```
export OPENAI_API_KEY=XXXXXXXXXXXXX
export SOX_OPTS="....."
````

### Config

vosks language models in 

```
~/.config/nerd-dictation
```




## Example of live session


```
./speech_to_chatgpt.sh
ROBOT: Ask me anything
To exit say: stop

...listening

YOU: what is the population of london
ROBOT: you said: what is the population of london
ROBOT: Say NO if I'm wrong, or just wait

...listening

...asking ChatGPT

ChatGPT: As an AI language model, my database might not be updated with real-time information, but according to the latest estimate by the Office for National Statistics, the population of London in 2021 is estimated to be 9.3 million people.

ROBOT: anything else?

...listening

YOU: and the year before
ROBOT: you said: and the year before
ROBOT: Say NO if I'm wrong, or just wait

...listening

...asking ChatGPT

ChatGPT: According to the same source, the estimated population of London in 2020 was 9.1 million people.

ROBOT: anything else?

...listening

YOU: stop
Ok, I stop!
```

# Similar projects

* https://gigq.com/@justin/109453980426756736 using Wisper https://github.com/openai/whisper
* https://github.com/RetricSu/chatGPT-auto-speech Brave app (experimental)
* https://news.ycombinator.com/item?id=33858035 (did not get how it work)
* https://github.com/franalgaba/chatgpt-telegram-bot-serverless 
