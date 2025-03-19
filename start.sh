#!/bin/sh

# Ajustar permisos para asegurar acceso a los directorios
chown -R rabbitmq:rabbitmq /var/lib/rabbitmq

# Imprimir información de inicio
echo "==============================="
echo "Iniciando RabbitMQ en Render..."
echo "Interfaz de administración disponible en el puerto: $PORT"
echo "Servidor AMQP disponible en puerto: 5672"
echo "==============================="

# Verificar que los plugins necesarios estén activados
rabbitmq-plugins list | grep management

# Imprimir las configuraciones activas
echo "Configuraciones de RabbitMQ:"
cat /etc/rabbitmq/conf.d/management.conf
echo "==============================="

# Iniciar RabbitMQ
# Usamos exec para que RabbitMQ reciba las señales del sistema
exec rabbitmq-server

# Este comando es un respaldo si el exec falla
# rabbitmq-server
