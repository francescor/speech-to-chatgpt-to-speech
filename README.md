# speech-to-chatgpt-to-speech
Fancy using ChatGPT just by talking and listening?


# Why

This afternoon I played a bit with https://github.com/filippofinke/cli-gpt, then tired 
of typing and reading I wanted to be able to speech to ChatGPT, and listen the answer back.

This is just a game, nothing serious


# Requirements:

* https://espeak.sourceforge.net `yum install espeak`
* https://github.com/ideasman42/nerd-dictation (vosks, sox, xdotool...)
* https://github.com/TheR1D/shell_gpt


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
