# Normas

## Descripción

En esta sección se presentan las normas técnicas consideradas durante el desarrollo del proyecto. Estas normas proporcionan lineamientos y criterios de diseño relacionados con la eficiencia en el uso del agua, la automatización de sistemas y las buenas prácticas de ingeniería, contribuyendo al desarrollo de una solución funcional y sostenible.

<p align="center">
    <a href="https://github.com/SharkUsser/FdD_Equipo01/blob/main/Recursos/Normas/NormaT%C3%A9cnica_1.pdf">
      <img src="https://img.shields.io/badge/Norma%201-Consultar-blue?style=for-the-badge">
    </a>
    <a href="https://github.com/SharkUsser/FdD_Equipo01/blob/main/Recursos/Normas/NormaT%C3%A9cnica_2.pdf">
      <img src="https://img.shields.io/badge/Norma%202-Consultar-green?style=for-the-badge">
    </a>
    <a href="https://github.com/SharkUsser/FdD_Equipo01/blob/main/Recursos/Normas/NormaT%C3%A9cnica_3.pdf">
      <img src="https://img.shields.io/badge/Norma%203-Consultar-orange?style=for-the-badge">
    </a>
</P>

---

# Norma Técnica 1

### Nombre de la Norma

### **IEC 60529 - Grados de Protección**

### Descripción

Esta norma internacional de la IEC establece un sistema estandarizado para clasificar el nivel de protección que ofrece una envolvente (carcasa/gabinete) de equipo eléctrico frente a dos amenazas: ingreso de cuerpos sólidos extraños (incluido el polvo) e ingreso de agua. La clasificación se expresa con el código IP seguido de dos dígitos característicos — el primero va del 0 al 6 e indica protección contra sólidos y acceso a partes peligrosas, el segundo va del 0 al 8 e indica el nivel de protección contra agua (desde goteo vertical hasta inmersión continua). Adicionalmente, la norma contempla letras opcionales para protección adicional y letras suplementarias para información complementaria. Cada nivel de clasificación tiene pruebas físicas estandarizadas que deben superarse para certificar el grado declarado.

### Aporte al Proyecto

- Selección del grado IP del gabinete: Al operar en campo abierto en Huaral, el enclosure impreso en PETG está expuesto a polvo agrícola y salpicaduras del riego. La norma justifica técnicamente apuntar a un mínimo de IP54 (protección total contra polvo + salpicaduras desde cualquier dirección) o IP65 si se busca hermeticidad completa.
- Decisiones de diseño del enclosure: Respalda elecciones como el uso de juntas de sellado en la tapa, el posicionamiento correcto de las entradas de cables y el tipo de cierre, asegurando que el gabinete cumpla el grado IP declarado.
- Justificación técnica ante evaluadores: Permite argumentar con respaldo normativo por qué el gabinete tiene las características físicas que tiene, en lugar de decidirlo de manera empírica.


📄 [Ver norma](https://github.com/SharkUsser/FdD_Equipo01/blob/main/Recursos/Normas/NormaT%C3%A9cnica_1.pdf)

---

# Norma Técnica 2

### Nombre de la Norma

### **ISO 46001:2019: Sistemas de gestión de la Eficiencia del Agua**

### Descripción

Esta norma ISO establece los requisitos y orientaciones para que cualquier organización — independientemente de su tamaño o sector — implemente, mantenga y mejore un Sistema de Gestión de la Eficiencia Hídrica (SGEH). Sigue la estructura del ciclo PDCA (Planificar–Hacer–Verificar–Actuar) y exige que la organización realice una revisión del uso del agua, identifique actividades de uso significativo, defina indicadores de actividad empresarial (BAI) e indicadores de eficiencia hídrica (WEI), establezca líneas base, fije objetivos y planes de acción, y realice seguimiento y auditoría periódica. La norma también contempla el enfoque de las 3R aplicado al agua: reducir, reemplazar y reutilizar, y reconoce fuentes alternativas como agua recuperada, aguas grises y agua de lluvia.

### Aporte al Proyecto

- Fundamentación del propósito del proyecto: El cultivo de arándanos requiere precisión hídrica para evitar estrés o exceso de agua. La norma respalda formalmente que monitorear y controlar el riego no es solo una decisión práctica, sino una necesidad alineada con estándares internacionales de eficiencia hídrica.
- Validación de los sensores utilizados: El sensor FC-28 (humedad del suelo) y el sensor TDS (conductividad del agua) responden directamente a la exigencia de la norma de medir el uso actual del agua e identificar actividades de uso significativo, tal como establece su cláusula 6.2.4.
- Base para indicadores de rendimiento: Los datos recolectados por el ESP32 permiten calcular indicadores como m³ de agua por kg de arándano producido, lo cual se alinea con la cláusula 6.2.6 que exige definir indicadores de eficiencia hídrica medibles.
- Justificación de la automatización del riego: La activación automática del relay para abrir o cerrar la electroválvula según los umbrales del sensor responde al requisito de la cláusula 8.1 sobre implementar controles operacionales sobre los usos significativos del agua.

📄 [Ver norma](https://github.com/SharkUsser/FdD_Equipo01/blob/main/Recursos/Normas/NormaT%C3%A9cnica_2.pdf)

---

# Norma Térnica 3

### Nombre de la Norma

### **ISO 16484-1:2024: Sistemas de automatización y control de edificios (BACS) — Parte 1: Especificación e implementación de proyectos**

### Descripción

Esta norma ISO define los principios guía y las fases que debe seguir cualquier proyecto de sistema de automatización y control, estructurándolo en cuatro etapas secuenciales: fase de diseño (determinación de requisitos, planificación, especificación técnica y contrato), fase de ingeniería (diseño detallado de hardware y funciones, configuración de estrategias de control y pruebas del sistema), fase de instalación (montaje físico y puesta en marcha/commissioning) y fase de finalización (demostración del sistema, formación al operador, entrega formal, aceptación y cierre del proyecto). También exige documentación as-built y establece que la calidad del sistema depende directamente de la rigurosidad en el diseño y en el proceso de commissioning.

### Aporte al Proyecto

- Estructura metodológica del proyecto: Aunque fue concebida para edificios, sus cuatro fases se aplicaron directamente a AgroSmart: la fase de diseño corresponde a la Lista de Exigencias y especificación del hardware; la fase de ingeniería al diseño del esquemático en EasyEDA y programación del firmware; la fase de instalación al montaje del PCB en el gabinete 3D; y la fase de finalización a la exposición y entrega de documentación.
- Exigencia de documentación técnica: La norma requiere documentación as-built del sistema, lo que respalda la generación de los documentos técnicos de AgroSmart (esquemático, lista de componentes, memoria descriptiva del enclosure) bajo versiones V1.0 hasta VFINAL.
- Validación del proceso de commissioning: La norma establece que el sistema debe probarse antes de la entrega formal, lo que justifica las pruebas de funcionamiento del circuito (verificación de sensores, relay y pantalla LCD) previas a la exposición final del proyecto.
- Respaldo normativo a la integración de subsistemas: La norma reconoce que un sistema de automatización integra múltiples subsistemas (sensores, actuadores, interfaz de usuario), validando la arquitectura de AgroSmart que combina ESP32, sensores, relay, LCD y módulo de energía solar en un solo sistema funcional.

📄 [Ver norma](https://github.com/SharkUsser/FdD_Equipo01/blob/main/Recursos/Normas/NormaT%C3%A9cnica_3.pdf)