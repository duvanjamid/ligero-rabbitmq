FROM rabbitmq:3-management

# Exponer puertos necesarios
EXPOSE 5672 15672

# Configurar variables de entorno básicas
ENV RABBITMQ_DEFAULT_USER=usuario
ENV RABBITMQ_DEFAULT_PASS=password
ENV RABBITMQ_DEFAULT_VHOST=/

# Variables necesarias para Render
ENV PORT=15672

# Script de inicio simplificado
COPY start.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start.sh

# Comando para iniciar RabbitMQ
CMD ["sh", "/usr/local/bin/start.sh"]
