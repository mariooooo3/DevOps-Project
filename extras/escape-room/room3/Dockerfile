FROM alpine:3.18
ENV APP_NAME="springboot" APP_VERSION="2.1.4" DB_HOST="db.internal" DB_PORT="5432" \
    DB_NAME="appdb" CACHE_TTL="3600" MAX_CONNECTIONS="100" API_KEY="sk-f4k3-n0t-fl4g" \
    LOG_LEVEL="INFO" REGION="eu-central-1" BACKUP_ENABLED="true" METRICS_PORT="9100" \
    SESSION_TIMEOUT="1800" SMTP_HOST="mail.internal" SMTP_PORT="587" \
    SECRET_FLAG="FLAG{3nv_v4r5_h1d3_s3cr3ts}" FEATURE_BETA="false" MAX_UPLOAD="10MB"
RUN printf '#!/bin/sh\necho ""\necho "======================================"\necho "  CAMERA 3 / 4  -  Variabile de Mediu"\necho "======================================"\necho ""\necho "Serverul are MULTE variabile de mediu."\necho "Undeva printre ele se ascunde flag-ul."\necho ""\necho "Hint: env | grep -i flag"\necho "      sau: env | grep SECRET"\necho ""\nexec /bin/sh\n' > /home/start.sh && chmod +x /home/start.sh
WORKDIR /home
CMD ["/bin/sh", "/home/start.sh"]
