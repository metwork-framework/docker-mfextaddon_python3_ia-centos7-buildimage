ARG BRANCH
FROM metwork/mfext-centos7-buildimage:${BRANCH}
RUN yum clean all && echo -e "[metwork_${BRANCH}]\n\
name=Metwork Continuous Integration Branch ${BRANCH}\n\
baseurl=http://metwork-framework.org/pub/metwork/continuous_integration/rpms/${BRANCH}/portable/\n\
gpgcheck=0\n\
enabled=1\n\
metadata_expire=0\n" >/etc/yum.repos.d/metwork.repo
RUN yum -y install metwork-mfext-layer-python3_scientific metwork-mfext-layer-python3_devtools
RUN wget -O bazel-0.25.2-installer-linux-x86_64.sh https://github.com/bazelbuild/bazel/releases/download/0.25.2/bazel-0.25.2-installer-linux-x86_64.sh && chmod +x bazel-0.25.2-installer-linux-x86_64.sh && ./bazel-0.25.2-installer-linux-x86_64.sh
