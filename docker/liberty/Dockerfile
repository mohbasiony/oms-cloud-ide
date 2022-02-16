FROM ibmoms/liberty-core:20.0.0.12

COPY jvm.options /config/jvm.options
COPY server.xml /config/server.xml
COPY entrypoint.sh /

RUN chmod -R 775 /config \
    && chmod -R 775 /opt/ibm/wlp \
    && chmod -R 775 /logs \
    && mkdir -p /home/user \ 
    && chgrp -R 0 /home \
    && chmod -R g=u /etc/passwd /etc/group /home \
    && chmod +x /entrypoint.sh

# Install common terminal editors in container to aid development process
COPY install-editor-tooling.sh /tmp
RUN chmod +x /tmp/install-editor-tooling.sh \
  && /tmp/install-editor-tooling.sh \
  && rm -f /tmp/install-editor-tooling.sh

EXPOSE 9080

USER 10001
ENV HOME=/home/user
WORKDIR /projects
ENTRYPOINT [ "/entrypoint.sh"  ]
CMD ["tail", "-f", "/dev/null"]
