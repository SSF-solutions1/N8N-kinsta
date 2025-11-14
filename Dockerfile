FROM n8nio/n8n:latest

USER root
RUN mkdir -p /tmp/n8n && chmod 777 /tmp/n8n
USER node

ENV N8N_USER_FOLDER=/tmp/n8n
ENV DB_TYPE=sqlite
ENV DB_SQLITE_DATABASE=/tmp/n8n/database.sqlite
ENV N8N_PORT=8080

EXPOSE 8080

CMD ["n8n", "start"]
