# Patentes

## Descripción

En esta sección se presentan las patentes analizadas como referencia para el desarrollo del proyecto. Cada patente aporta soluciones tecnológicas relacionadas con sistemas de riego, automatización, monitoreo de variables agrícolas y optimización del uso de recursos hídricos, permitiendo identificar características y funcionalidades relevantes para el diseño del prototipo.

<p align="center">
    <a href="https://github.com/SharkUsser/FdD_Equipo01/blob/main/Recursos/Patentes/US20250048979A1.pdf">
     <img src="https://img.shields.io/badge/Patente%201-Consultar-blue?style=for-the-badge">
    </a>
    <a href="https://github.com/SharkUsser/FdD_Equipo01/blob/main/Recursos/Patentes/PE20260366A1.pdf">
    <img src="https://img.shields.io/badge/Patente%202-Consultar-green?style=for-the-badge">
    </a>
    <a href="https://github.com/SharkUsser/FdD_Equipo01/blob/main/Recursos/Patentes/CN201674848U.pdf">
    <img src="https://img.shields.io/badge/Patente%203-Consultar-orange?style=for-the-badge">
    </a>
    <a href="https://github.com/SharkUsser/FdD_Equipo01/blob/main/Recursos/Patentes/ES2351902A1.pdf">
     <img src="https://img.shields.io/badge/Patente%204-Consultar-red?style=for-the-badge">
    </a>
</p>

---

# Patente 1

### Título

### **US20250048979A1: Irrigation System, Irrigation Sensor and Smart Scheduling for Irrigation, Processes, and Methods of Use**
*US20250048979A1: Sistema de riego, sensor de riego y programación inteligente para riego, procesos y métodos de uso*

### Descripción

Es un sistema de riego automatizado que utiliza sensores de humedad multinivel (estacas que miden la tierra a diferentes profundidades), controladores de válvulas y repetidores de señal para optimizar el uso del agua. El núcleo del invento es un software con Inteligencia Artificial y Machine Learning que analiza los datos del suelo, el clima actual y el pronóstico meteorológico para recalcular y reprogramar automáticamente los horarios de riego en tiempo real, evitando el desperdicio.

### Aporte al Proyecto: *¿Qué valor da al desarrollo del proyecto?*

- Monitoreo vertical real: En lugar de medir solo la superficie, su diseño de varilla permite saber cuánta agua hay exactamente a la altura de las raíces, evitando ahogar la planta o dejarla seca.  
- Riego dinámico por IA: Reemplaza los temporizadores fijos tradicionales por un algoritmo que "aprende" y adapta el riego según el clima y el tipo de suelo.  
- Arquitectura inalámbrica escalable: Estructura un modelo claro de comunicación ideal para diseñar sistemas automáticos en campos grandes.  
- Eficiencia energética de larga duración: Su diseño electrónico está optimizado para que los sensores remotos operen con baterías durante varios años sin mantenimiento constante. 

📄 [Ver patente completa](https://github.com/SharkUsser/FdD_Equipo01/blob/main/Recursos/Patentes/US20250048979A1.pdf)

---

# Patente 2

### Título

### **PE20260366A1: Dispositivo de Riego Automático con Control de Humedad, pH y Temperatura**

### Descripción

El invento consiste en un dispositivo electrónico-mecánico de riego automatizado e inteligente diseñado para optimizar el uso del agua en la agricultura. El sistema opera mediante un bloque de captación con sensores que miden continuamente la humedad, la temperatura y el pH del suelo, enviando estos datos físico-químicos en tiempo real a un microcontrolador central. Este componente procesa la información y ejecuta un algoritmo programado para activar de forma autónoma bombas o electroválvulas de riego solo cuando las variables salen de los rangos ideales del cultivo. Finalmente, el dispositivo cuenta con un módulo de comunicación inalámbrica que transmite todas las métricas recolectadas a una aplicación móvil, permitiendo al usuario monitorear e interactuar con el estado del suelo de manera remota.

### Aporte al Proyecto
Este antecedente técnico aporta directamente a nuestro desarrollo en los siguientes puntos:
- Validación del Hardware: Nos da el plano técnico y la certeza de que la integración de sensores (humedad/temperatura/pH) con un microcontrolador y actuadores hidráulicos es una arquitectura totalmente viable y funcional.  
- Sustento del Enfoque Multivariable: Justifica técnicamente por qué no basta con medir solo el agua; el control del pH y la temperatura es crítico para garantizar la absorción de nutrientes y la salud de la planta.
- Respaldo de Viabilidad: Funciona como un argumento sólido ante jurados o evaluaciones académicas, demostrando que nuestro proyecto está alineado con soluciones tecnológicas patentables y vigentes en el sector agroindustrial.  
- Punto de Partida para Innovar: Al conocer el alcance de su hardware y su app móvil, nos permite enfocarnos en mejorar el software, optimizar la eficiencia de las estructuras hidráulicas o añadir funciones que la patente no cubre.

📄 [Ver patente completa](https://github.com/SharkUsser/FdD_Equipo01/blob/main/Recursos/Patentes/PE20260366A1.pdf)

---

# Patente 3

### Título

### **CN201674848U: 太阳能自动滴灌装置**
*Dispositivo automático de riego por goteo solar*

### Descripción

El invento consiste en un dispositivo automático de riego por goteo alimentado por energía solar fotovoltaica, diseñado específicamente para zonas áridas o desérticas. El sistema consta de una bomba hidráulica conectada a un panel solar que extrae agua desde un pozo profundo hacia un depósito de almacenamiento, el cual integra un sensor de nivel para evitar desbordamientos. El núcleo de automatización opera en dos niveles de control: un controlador central conectado a un sensor de humedad ambiental que activa eléctricamente todo el sistema solo si la humedad del aire es menor al 80%, y un conjunto de sensores de humedad de suelo independientes colocados en la base de cada planta. Estos sensores sectoriales abren mecánicamente sus respectivas válvulas de suministro y goteros individuales únicamente cuando la humedad superficial del suelo cae por debajo del 40%, cerrándolas al superar dicho umbral para garantizar un riego autónomo y eficiente sin intervención humana.

### Aporte al Proyecto

- Estrategia de Control Condicional por Capas: Aporta un modelo lógico donde la humedad del aire actúa como un interruptor general de encendido/apagado para ahorrar energía, mientras que la humedad del suelo gestiona la apertura local de válvulas. Esto enriquece el algoritmo de nuestro software.  
- Optimización Hidráulica con Almacenamiento Intermedio: Valida técnicamente la inclusión de un depósito regulador entre la captación del agua (pozo) y la distribución final (goteros), estabilizando las presiones del flujo de riego.  
- Automatización del Llenado mediante Sensor de Nivel: Proporciona el principio de control para automatizar el reabastecimiento del tanque de agua mediante un sensor de nivel acoplado directamente al corte de la bomba, evitando pérdidas críticas de recurso hídrico.  
- Criterio de Umbrales Físicos Cuantificables: Nos da métricas específicas y ensayadas en el estado de la técnica (como el umbral de $<$ 40% de humedad en suelo para activar el riego y $<$ 80% de humedad ambiental) que sirven como línea base para calibrar nuestros propios sensores.

📄 [Ver patente completa](https://github.com/SharkUsser/FdD_Equipo01/blob/main/Recursos/Patentes/CN201674848U.pdf)  
📄 [Ver patente completa_traducida](https://github.com/SharkUsser/FdD_Equipo01/blob/main/Recursos/Patentes/CN201674848U_Traduccion_Espanol.pdf)

---

# Patente 4

### Título

### **ES2351902A1: Sistema de riego por goteo alineado fijo**

### Descripción

La invención describe un sistema de distribución para riego por goteo diseñado para resolver el desplazamiento e inestabilidad de las mangueras en el terreno agrícola. Mecánicamente, el sistema consta de una manguera de conducción equipada con goteros, a la cual se le instalan abrazaderas fijas en puntos estratégicos. De estas abrazaderas nacen componentes de sujeción flexibles (como cuerdas, cintas elásticas o bridas) encargados de abrazar de manera directa y firme el tronco de cada planta o árbol. La configuración geométrica de este acoplamiento está diseñada de tal forma que permite que la manguera rodee o gire parcialmente en torno a la base vegetal garantizando la fijación del punto de goteo, pero evitando estrictamente cualquier estrangulamiento o colapso en la sección transversal del conducto que impida el paso del flujo hidráulico.

### Aporte al Proyecto

- Estabilidad del Bulbo de Raíces y Eficiencia Hídrica: Al fijar mecánicamente el gotero respecto al tronco, se asegura que el agua impacte siempre exactamente en la misma zona del suelo. Para AgroSmart, esto optimiza la lectura de nuestros sensores de suelo, ya que el bulbo húmedo no se desplazará y los datos de humedad serán constantes y precisos.  
- Protección del Conducto Hidráulico (Anti-estrangulamiento): La patente valida el uso de un sistema de abrazaderas y bridas que guían la manguera sin aplastarla. Esto nos da una solución de diseño de bajo costo para el montaje en campo de nuestras estructuras de riego, impidiendo pérdidas de carga o caídas de presión por dobleces accidentales.  
- Reducción de Mantenimiento Físico: Al quedar la manguera alineada de manera fija con los árboles, se elimina la necesidad de reacomodar manualmente las líneas de riego tras labores agrícolas, robusteciendo la propuesta de valor de automatización total de nuestro proyecto.

📄 [Ver patente completa](https://github.com/SharkUsser/FdD_Equipo01/blob/main/Recursos/Patentes/ES2351902A1.pdf)