FROM mongo:8.0.19

# Render SSH compatibility — needed for the SSH gateway
# to hand off sessions into this container.
USER root

RUN mkdir -p /root/.ssh \
    && chmod 0700 /root/.ssh \
    && (usermod --unlock root || passwd -u root)
