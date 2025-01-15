FROM registry.redhat.io/ansible-automation-platform/ee-minimal-rhel8@sha256:b36188c3bcfceda268af3fb156b9ec854e9352355db7b46d927ba7a9384b2ffd

# Install base dependencies
RUN microdnf install -y \
   bash \
   shadow-utils \
   python3 \
   python3-pip && \
   microdnf clean all

# Update pip and install Python packages
RUN pip3 install --upgrade pip setuptools passlib

# Install required tools
RUN microdnf install -y \
   unzip \
   wget \
   jq

# Install Bitwarden CLI
RUN wget "https://github.com/bitwarden/cli/releases/download/v1.22.1/bw-linux-1.22.1.zip" -O /tmp/bw.zip && \
   unzip /tmp/bw.zip -d /tmp/ && \
   chmod +x /tmp/bw && \
   mv /tmp/bw /usr/local/bin/ && \
   rm /tmp/bw.zip

# Verify installation
RUN bw --version


ENTRYPOINT ["sh"]
