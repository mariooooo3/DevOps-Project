FROM alpine:3.18
RUN FLAG_B64=$(echo -n "FLAG{d3c0d3_m4st3r}" | base64) && \
    echo "2026-04-22 06:00:01 INFO  Server started" > /var/log/app.log && \
    echo "2026-04-22 06:00:08 INFO  dGVzdF9tZXNhajEyMw==" >> /var/log/app.log && \
    echo "2026-04-22 06:00:15 INFO  c2VjcmV0X2ZhbHM=" >> /var/log/app.log && \
    echo "2026-04-22 06:00:31 INFO  INTERCEPTED: $FLAG_B64" >> /var/log/app.log && \
    echo "2026-04-22 06:00:45 ERROR Connection timeout" >> /var/log/app.log
RUN printf '#!/bin/sh\necho ""\necho "======================================"\necho "  CAMERA 2 / 4  -  Criptografie"\necho "======================================"\necho ""\necho "Logurile serverului contin un mesaj"\necho "codificat in Base64."\necho ""\necho "Loguri: /var/log/app.log"\necho "Hint: echo mesaj | base64 -d"\necho ""\nexec /bin/sh\n' > /home/start.sh && chmod +x /home/start.sh
WORKDIR /home
CMD ["/bin/sh", "/home/start.sh"]
