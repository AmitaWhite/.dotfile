
# ANDROID Setting
set -x ANDROID_HOME /Users/amitawhite/Library/Android/sdk
set -x PATH $PATH $ANDROID_HOME/emulator $ANDROID_HOME/tools $ANDROID_HOME/tools/bin $ANDROID_HOME/platform-tools
set -x PATH $PATH $ANDROID_HOME/cmdline-tools/latest/bin
set -x PATH $PATH $HOME/.sdkman/bin


# JAVA Setting
set -x JAVA_HOME_11 /Library/Java/JavaVirtualMachines/adoptopenjdk-11.jdk/Contents/Home
set -x JAVA_HOME_14 /Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home
set -x JAVA_HOME_17 /Users/amitawhite/Library/Java/JavaVirtualMachines/graalvm-ce-17/Contents/Home

set -x JAVA_HOME $JAVA_HOME_17
