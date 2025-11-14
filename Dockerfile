FROM n8nio/n8n:latest

USER root
RUN mkdir -p /tmp/n8n && chmod 777 /tmp/n8n
USER node

# Environment variables for n8n
ENV N8N_USER_FOLDER=/tmp/n8n
ENV DB_TYPE=sqlite
ENV DB_SQLITE_DATABASE=/tmp/n8n/database.sqlite
ENV N8N_PORT=8080
ENV N8N_PROTOCOL=https
ENV WEBHOOK_URL=https://your-app.kinsta.app

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=10s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://localhost:8080/healthz || exit 1

EXPOSE 8080

CMD ["n8n", "start"]
