FROM alpine:3.18
RUN mkdir -p /opt/.secret /opt/fisiere /home/agent && \
    echo "FLAG{f1l3s_4r3_3v3rywh3r3}" > /opt/.secret/.flag && \
    echo "nimic_util=true" > /opt/fisiere/config.txt && \
    echo "Nu e nimic interesant aici..." > /opt/readme.txt
RUN printf '#!/bin/sh\necho ""\necho "======================================"\necho "  CAMERA 1 / 4  -  Fisiere Ascunse"\necho "======================================"\necho ""\necho "Gaseste flag-ul ascuns pe acest sistem."\necho "Format: FLAG{...}"\necho ""\necho "Hint: Nu toate fisierele sunt vizibile"\necho "      cu un simplu ls..."\necho "      Incearca: find /opt -name *.flag"\necho ""\nexec /bin/sh\n' > /home/agent/start.sh && chmod +x /home/agent/start.sh
WORKDIR /home/agent
CMD ["/bin/sh", "/home/agent/start.sh"]
