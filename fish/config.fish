
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#eval /Users/amitawhite/opt/anaconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<
   alias desktophide '~/desktophide.sh'
set -x PATH $PATH /usr/local

# Android SDK 경로 설정
set -x ANDROID_HOME $HOME/Library/Android/sdk

# Command line tools 경로 추가
set -x PATH $ANDROID_HOME/cmdline-tools/tools/bin $PATH

# Platform tools (adb 등) 경로 추가
set -x PATH $ANDROID_HOME/platform-tools $PATH

