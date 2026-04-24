FROM alpine:3.18
RUN apk add --no-cache wget curl
RUN printf '#!/bin/sh\necho ""\necho "======================================"\necho "  CAMERA 4 / 4  -  FINALA: Retea"\necho "======================================"\necho ""\necho "Flag-ul final e pe un server secret."\necho "Adresa interceptata: vault:8888"\necho ""\necho "Hint: wget -q -O- http://vault:8888"\necho ""\nexec /bin/sh\n' > /home/start.sh && chmod +x /home/start.sh
WORKDIR /home
CMD ["/bin/sh", "/home/start.sh"]
