FROM rabbitmq:3-management

# Habilitar plugins necesarios (el management ya viene en la imagen base)
RUN rabbitmq-plugins enable --offline rabbitmq_management rabbitmq_web_dispatch

# Crear directorio para configuraciones personalizadas
RUN mkdir -p /etc/rabbitmq/conf.d

# Crear archivo de configuración para el management
RUN echo 'management.listener.port = 15672\n\
management.listener.ip = 0.0.0.0\n\
management.path.prefix = /\n\
management.cors.allow_origins.1 = *\n\
management.cors.max_age = 3600' > /etc/rabbitmq/conf.d/management.conf

# Exponer puertos necesarios
EXPOSE 5672 15672

# Configurar variables de entorno
ENV RABBITMQ_DEFAULT_USER=usuario
ENV RABBITMQ_DEFAULT_PASS=password
ENV RABBITMQ_DEFAULT_VHOST=/

# Variables necesarias para Render
ENV PORT=15672

# Script de inicio personalizado
COPY start.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start.sh

# Verificar la configuración es correcta
RUN rabbitmq-diagnostics check_port_connectivity || true
RUN rabbitmq-diagnostics status || true

# Configurar comando de inicio para usar nuestras configuraciones adicionales
CMD ["sh", "/usr/local/bin/start.sh"]
