FROM mongo:8.0.19

# Render SSH compatibility:
# 1. openssh-server provides the binaries Render's gateway needs to hand
#    off sessions into this container. We install it but do NOT start sshd
#    ourselves — Render's gateway handles that.
# 2. ~/.ssh must exist with 0700 perms for the running user (root).
# 3. The root account must be unlocked (some base images lock it).
USER root

RUN apt-get update \
    && apt-get install -y --no-install-recommends openssh-server \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /root/.ssh \
    && chmod 0700 /root/.ssh \
    && (usermod --unlock root || passwd -u root)
