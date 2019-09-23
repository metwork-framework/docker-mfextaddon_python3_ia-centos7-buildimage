ARG BRANCH=master
FROM metwork/mfcom-centos7-buildimage:${BRANCH}
ARG BRANCH
RUN yum clean all
RUN yum -y install metwork-mfext-layer-python3_scientific
RUN wget -O bazel-0.25.2-installer-linux-x86_64.sh https://github.com/bazelbuild/bazel/releases/download/0.25.2/bazel-0.25.2-installer-linux-x86_64.sh && chmod +x bazel-0.25.2-installer-linux-x86_64.sh && ./bazel-0.25.2-installer-linux-x86_64.sh
