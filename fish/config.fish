set -x fish_ambiguous_width 2

# ANDROID Setting
set -x ANDROID_HOME /Users/amitawhite/Library/Android/sdk
set -x PATH $PATH $ANDROID_HOME/emulator $ANDROID_HOME/tools $ANDROID_HOME/tools/bin $ANDROID_HOME/platform-tools
set -x PATH $PATH $ANDROID_HOME/cmdline-tools/latest/bin
set -x PATH $PATH $HOME/.sdkman/bin


# JAVA Setting
set -x JAVA_HOME_11 /Library/Java/JavaVirtualMachines/adoptopenjdk-11.jdk/Contents/Home
set -x JAVA_HOME_14 /Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home
set -x JAVA_HOME_17 /Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home

set -x JAVA_HOME $JAVA_HOME_17

# Created by `pipx` on 2024-10-05 06:12:39
set PATH $PATH /Users/amitawhite/.local/bin

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /usr/local/Caskroom/miniconda/base/bin/conda
    eval /usr/local/Caskroom/miniconda/base/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/usr/local/Caskroom/miniconda/base/etc/fish/conf.d/conda.fish"
        . "/usr/local/Caskroom/miniconda/base/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/usr/local/Caskroom/miniconda/base/bin" $PATH
    end
end
# <<< conda initialize <<<

