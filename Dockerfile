FROM openjdk:8-jdk

ENV ANDROID_COMPILE_SDK="28"
ENV ANDROID_BUILD_TOOLS="28.0.2"
ENV ANDROID_SDK_TOOLS="4333796"

RUN apt-get --quiet update --yes
RUN apt-get --quiet install --yes wget tar unzip file
RUN wget --output-document=/tmp/android-sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS}.zip  && unzip -d /root/android-sdk-linux /tmp/android-sdk.zip && rm -rf /tmp/android-sdk.zip
RUN wget --output-document=/root/gradle-6.1.1-all.zip https://services.gradle.org/distributions/gradle-6.1.1-all.zip
RUN echo y | /root/android-sdk-linux/tools/bin/sdkmanager "platforms;android-${ANDROID_COMPILE_SDK}" >/dev/null
RUN echo y | /root/android-sdk-linux/tools/bin/sdkmanager "platform-tools" >/dev/null
RUN echo y | /root/android-sdk-linux/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS}" >/dev/null
RUN echo y | /root/android-sdk-linux/tools/bin/sdkmanager "ndk;21.0.6113669"

ENV ANDROID_HOME=/root/android-sdk-linux
ENV PATH=$PATH:/root/android-sdk-linux/platform-tools/

#RUN set +o pipefail
RUN yes | /root/android-sdk-linux/tools/bin/sdkmanager --licenses
#RUN set -o pipefail
