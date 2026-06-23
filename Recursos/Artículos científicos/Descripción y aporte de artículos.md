# Artículos Científicos

## Descripción

En esta sección se presentan los artículos científicos utilizados como sustento técnico para el desarrollo del proyecto. Cada artículo aporta información relevante para la selección de tecnologías, el diseño del sistema y la validación de las decisiones de ingeniería implementadas.
<p align="center">
    <a href="https://github.com/SharkUsser/FdD_Equipo01/blob/main/Recursos/Art%C3%ADculos%20cient%C3%ADficos/Art%C3%ADculoCient%C3%ADfico_01.pdf">
    <img src="https://img.shields.io/badge/Artículo%201-Consultar-blue?style=for-the-badge">
    </a>
    <a href="https://github.com/SharkUsser/FdD_Equipo01/blob/main/Recursos/Art%C3%ADculos%20cient%C3%ADficos/Art%C3%ADculoCient%C3%ADfico_02.pdf">
     <img src="https://img.shields.io/badge/Artículo%202-Consultar-green?style=for-the-badge">
    </a>
</p>

---

# Artículo 1

### Título

### **IoT-Enabled Soil Moisture and Conductivity Monitoring Under Controlled and Field Fertigation Systems**

### Descripción

El estudio evaluó el desempeño de un sistema de monitoreo de suelo basado en IoT para el seguimiento en tiempo real de la conductividad eléctrica (CE) y la humedad del suelo bajo distintas condiciones de fertirriego, tanto en laboratorio como en campo. Se utilizaron sensores TEROS-12 conectados a un microcontrolador Particle Argon con transmisión de datos a la plataforma en la nube Ubidots. Los experimentos se realizaron en tres tipos de suelo (arena, arena franca y franco arenoso) y en un huerto comercial de manzanos en Michigan, EE.UU. Los resultados demostraron una alta precisión del sistema (R² = 0.999) y confirmaron que la CE y la humedad del suelo responden de forma diferenciada según el tipo de suelo y el fertilizante aplicado.

### Aporte al Proyecto

- Valida el uso de sensores de bajo costo para monitorear humedad del suelo y conductividad eléctrica, parámetros clave en el sistema AgroSmart implementados mediante el FC-28 y el módulo TDS.
- Sustenta la decisión de integrar monitoreo continuo en tiempo real mediante IoT con transmisión inalámbrica de datos, tal como se implementó con el ESP32 en el proyecto.
- Confirma que la conductividad eléctrica del suelo es un indicador confiable del estado de nutrientes y riesgo de lixiviación, justificando su medición como variable de control en el sistema de riego inteligente para arándanos.

📄 [Ver artículo completo](https://github.com/SharkUsser/FdD_Equipo01/blob/main/Recursos/Art%C3%ADculos%20cient%C3%ADficos/Art%C3%ADculoCient%C3%ADfico_01.pdf)

---

# Artículo 2

### Título

### **IoT Sensing for Advanced Irrigation Management: A Systematic Review of Trends, Challenges, and Future Prospects**

### Descripción

Esta revisión sistemática analizó el panorama actual de las aplicaciones IoT en la gestión del riego, examinando 92 estudios publicados entre 2014 y 2024 en la base de datos Web of Science. Mediante análisis bibliométrico con VOSviewer, se identificaron tendencias de investigación, microcontroladores más utilizados, tecnologías de comunicación predominantes y principales aplicaciones del IoT en sistemas de riego inteligente. Los resultados revelan que el monitoreo remoto, la optimización del uso del agua y el monitoreo de humedad del suelo son las aplicaciones más frecuentes, y que el ESP32, el ESP8266 y Arduino son los microcontroladores de código abierto más empleados, mientras que WiFi y LoRa lideran las tecnologías de comunicación.

### Aporte al Proyecto

- Respalda la elección del ESP32 como unidad de control del sistema AgroSmart, al identificarlo como uno de los microcontroladores de mayor adopción y crecimiento en sistemas IoT para agricultura de precisión.
- Justifica el uso de WiFi como protocolo de comunicación en el prototipo, reconocido como la tecnología más empleada en sistemas de riego inteligente en entornos controlados y a pequeña escala.
- Aporta un marco de referencia sobre las capacidades esperadas de un sistema IoT agrícola —monitoreo en tiempo real, control remoto y eficiencia hídrica— que orientaron el diseño funcional del sistema AgroSmart para el cultivo de arándanos en Huaral.

📄 [Ver artículo completo](https://github.com/SharkUsser/FdD_Equipo01/blob/main/Recursos/Art%C3%ADculos%20cient%C3%ADficos/Art%C3%ADculoCient%C3%ADfico_02.pdf)