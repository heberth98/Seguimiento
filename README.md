# Seguimiento de Tareas - Componente LWC para Contactos

Este proyecto de Salesforce implementa un componente Lightning Web Component (LWC) que muestra el porcentaje de tareas completadas asociadas a un contacto. También incluye un trigger en Apex que limita la cantidad de tareas pendientes por contacto.

## 📦 Contenido
- Componente LWC: `seguimientoProgress`
- Clase Apex: `SeguimientoController`
- Trigger Apex: `LimitarPendientesSeguimiento`
- Objeto personalizado: `Seguimiento__c`
- Campos relevantes: `Etapa__c`, `Contacto__c`
