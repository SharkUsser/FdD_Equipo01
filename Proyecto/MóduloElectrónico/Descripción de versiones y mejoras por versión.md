# Módulo Electrónico – Historial de Versiones


## Descripción

Esta sección documenta la evolución del módulo electrónico del proyecto de riego inteligente. Se presentan las diferentes versiones desarrolladas durante el proceso de diseño, incluyendo las mejoras implementadas en cada etapa hasta llegar a la versión final.

---

## Versión 1

<p align="center">
  <a href="https://github.com/SharkUsser/FdD_Equipo01/tree/main/Proyecto/M%C3%B3duloElectr%C3%B3nico/V_1.0">
    <img src="https://img.shields.io/badge/Ver-Versión%201-red?style=for-the-badge">
  </a>
</p>


### Descripción
Esta es la primera versión funcional completa del esquemático. Integra el ESP32 (U1) como unidad de control, conectado a los tres sensores (DHT11, TDS y FC-28) y a la pantalla LCD I2C mediante el bus SDA/SCL directamente desde los pines del microcontrolador, sin conversión de nivel lógico intermedia. El control del actuador se realiza mediante un módulo relé de un solo canal (RLY1, etiquetado U2) que acciona la electrobomba ("Bomba"). La etapa de energía está compuesta por el cargador TP4056 (módulo "CARGADOR1"), un elevador de tensión MT3608 ("ELEVADOR1") y una batería conectada mediante un conector de dos pines tipo AFC12-S02DCC-00. Se incluye además un divisor resistivo (R1 = 1.2k, R2 = 2k, R3 = 1k) asociado al control de un LED desde un GPIO del ESP32.

### Elementos característicos de esta versión:
- 	Relé de un solo canal (U2 / RLY1) en lugar de módulo de doble canal.
- 	Conexión directa de SDA/SCL del LCD a los pines del ESP32 (sin level shifter).
-	Conector de batería tipo barril AFC12-S02DCC-00.
-	Divisor de tensión con tres resistencias (R1, R2, R3) para gobierno del LED.
-	No existen borneras de alimentación independientes; las conexiones de potencia son directas.
-	No hay interruptor general ni LED indicador como bloque etiquetado aparte.


---

## Versión 2

<p align="center">
  <a href="https://github.com/SharkUsser/FdD_Equipo01/tree/main/Proyecto/M%C3%B3duloElectr%C3%B3nico/V_2.0">
    <img src="https://img.shields.io/badge/Ver-Versión%202-orange?style=for-the-badge">
  </a>
</p>

### Descripción
Se rediseña por completo la etapa de gestión de energía y la etapa de potencia del actuador. El módulo cargador pasa a ser un TP4056 con entrada USB Tipo-C (U8), reemplazando la versión anterior alimentada por conector de barril. Se incorporan dos borneras (J1) independientes: una para la batería y otra para la alimentación general de 5 V, lo que mejora la modularidad y facilidad de ensamblaje del circuito físico. El relé de canal único se reemplaza por un módulo relé de 2 canales (U9, "2 Channel Relay Module"), aunque en esta versión solo se utiliza un canal para accionar la bomba. Se elimina por completo el bloque del LED y su divisor resistivo (R1, R2, R3) presente en V1.0.

### Mejoras respecto a la Versión 1
- Cargador de batería: se sustituye el TP4056 genérico por un módulo TP4056 con entrada USB Tipo-C (U8).
- Conector de batería: cambia del conector de barril AFC12-S02DCC-00 a un conector JST de 2 pines simple, vía bornera.
- Se agregan dos borneras nuevas (J1): "Bornera" de alimentación de batería y "Bornera Alimentación 5V".
- Módulo relé: se reemplaza el relé de un canal (U2) por un módulo relé de 2 canales (U9).
- Se elimina el bloque LED y las resistencias R1/R2/R3 del divisor de tensión.
- Se elimina el elevador de tensión MT3608 como bloque independiente etiquetado ("ELEVADOR" se mantiene como nombre de referencia, integrado en la nueva configuración de carga).


---

## Versión 3

<p align="center">
  <a href="https://github.com/SharkUsser/FdD_Equipo01/tree/main/Proyecto/M%C3%B3duloElectr%C3%B3nico/V_3.0">
    <img src="https://img.shields.io/badge/Ver-Versión%203-yellow?style=for-the-badge">
  </a>
</p>

### Descripción
Esta versión introduce los elementos de interacción manual del sistema. Se agrega un interruptor general (KEY1, tipo KEY_3x4X2_SMT) con su propia bornera (J1 "Interruptor"), que permite energizar o desenergizar el circuito de forma manual entre la batería y la línea +5V_P. Asimismo, se reincorpora un LED indicador (LED1) conectado directamente a un GPIO del ESP32, ahora documentado como bloque propio en la leyenda de componentes ("LED"). Se mantiene la arquitectura de energía de V2.0 (cargador TP4056 con USB Tipo-C, borneras de batería y alimentación) y el módulo relé de 2 canales (U9).

### Mejoras respecto a la Versión 2
-	Se añade un interruptor general (KEY1, KEY_3x4X2_SMT) con bornera "Interruptor" dedicada en la línea de alimentación de batería (+5V_P).
-	Se reincorpora el LED indicador (LED1), ahora etiquetado como bloque "LED" en la leyenda, conectado a un GPIO del ESP32.
-	Se actualiza la nomenclatura de la leyenda de bloques: se agregan las etiquetas "Módulo Relé" e "Interruptor" como bloques diferenciados.
-	Se mantiene sin cambios la etapa de carga (TP4056 + USB Tipo-C) y el relé de 2 canales introducidos en V2.0.


---

## Versión 4

<p align="center">
  <a href="https://github.com/SharkUsser/FdD_Equipo01/tree/main/Proyecto/M%C3%B3duloElectr%C3%B3nico/V_4.0">
    <img src="https://img.shields.io/badge/Ver-Versión%204-green?style=for-the-badge">
  </a>
</p>

### Descripción
Se incorpora un cambio significativo a nivel de compatibilidad eléctrica: un Conversor de Nivel Lógico de 4 canales (LEVEL-SHIFTER-4CH), colocado entre el bus I2C del ESP32 (3.3 V) y la pantalla LCD (5 V), separando las señales en SDA/SCL (lado ESP32, 3.3 V) y SDA_LCD/SCL_LCD (lado LCD, 5 V). Esto corrige un riesgo de incompatibilidad de niveles lógicos que existía en las versiones anteriores, donde el LCD se alimentaba a 5 V pero recibía señales I2C de 3.3 V sin acondicionamiento. Adicionalmente, el LED indicador cambia de tecnología de montaje superficial a través-hueco (THT, D4) y se le agrega una resistencia pull-down R2 (10k) además de la resistencia limitadora R1 (330 Ω) ya existente, mejorando la estabilidad de la señal de control.

### Mejoras respecto a la Versión 3
-	Se agrega el Conversor de Nivel Lógico (LEVEL-SHIFTER-4CH) entre el ESP32 y el LCD I2C.
-	El bus I2C se divide en dos dominios de tensión: SDA/SCL (3.3 V, lado ESP32) y SDA_LCD/SCL_LCD (5 V, lado LCD), conectados a través del conversor de nivel.
-	El LED cambia de empaquetado SMD a tipo THT (referencia D4).
-	Se añade una resistencia pull-down R2 (10k) en la línea de control del LED, manteniendo la resistencia limitadora de corriente R1 (330 Ω).
-	Se actualiza la leyenda de bloques, incorporando "Conversor de Nivel Lógico" y "Resistencia pull-down" como elementos documentados.


---

## Versión Final

<p align="center">
  <a href="https://github.com/SharkUsser/FdD_Equipo01/tree/main/Proyecto/M%C3%B3duloElectr%C3%B3nico/V_Final">
    <img src="https://img.shields.io/badge/Ver-Versión%20Final-blueviolet?style=for-the-badge">
  </a>
</p>

### Descripción
Esta es la versión consolidada y definitiva del esquemático para la entrega del proyecto. Mantiene íntegramente la arquitectura eléctrica de V4.0: conversor de nivel lógico para el bus I2C del LCD, LED indicador tipo THT con resistencias R1 (330 Ω) y R2 pull-down (10k), interruptor general, módulo relé de 2 canales y etapa de carga vía TP4056 con entrada USB Tipo-C. Los cambios respecto a V4.0 son de carácter organizativo y de presentación: se reordena la disposición textual de las etiquetas de bloques funcionales en la leyenda (intercambiando el orden visual de "Sensor de Humedad del Suelo" y "Conversor de Nivel Lógico"), sin que esto implique modificaciones en la conectividad eléctrica ni en los componentes del circuito.

### Mejoras respecto a la Versión 4
- •	Se reordena la posición de las etiquetas descriptivas de los bloques funcionales en la leyenda del esquemático, para mejorar la legibilidad y organización visual del documento.
- Se agrego etiqueta al interruptor.

---

## Cuadro Comparativo

| Elemento | Estado | Versión actual |
|----------|----------|-----------|
| Conector de batería | Conector tipo barril AFC12-S02DCC-00 (V1.0) | Bornera JST de 2 pines (desde V2.0) |
| Módulo cargador | TP4056 genérico (V1.0) | TP4056 con entrada USB Tipo-C — U8 (desde V2.0) |
| Elevador de tensión | MT3608 independiente ("ELEVADOR1", V1.0) | Integrado en la nueva etapa de carga (desde V2.0) |
| Borneras de alimentación | No existen (V1.0) | Bornera de batería + Bornera de 5V (desde V2.0) |
| Módulo relé | Relé de 1 canal (U2 / RLY1, V1.0) | Módulo relé de 2 canales (U9, desde V2.0) |
| LED indicador | Presente con divisor R1/R2/R3 (V1.0) → ausente (V2.0) | Reincorporado SMD (V3.0) → THT con pull-down (V4.0/FINAL) |
| Interruptor general | No existe (V1.0, V2.0) | KEY1 + bornera dedicada (desde V3.0) |
| Conversor de nivel lógico (I2C del LCD) | No existe — LCD conectado directo al ESP32 (V1.0–V3.0) | LEVEL-SHIFTER-4CH añadido (desde V4.0) |
| Organización de leyenda | Orden original de bloques | Reordenamiento visual sin cambio eléctrico (VFINAL) |

---

## Concluciones

- 	La evolución del esquemático de AgroSmart refleja un proceso de diseño iterativo orientado a mejorar la robustez eléctrica (incorporación del conversor de nivel lógico), la modularidad física (borneras independientes) y la usabilidad (interruptor general y LED indicador).
-	El cambio más relevante desde el punto de vista técnico es la introducción del conversor de nivel lógico en V4.0, que corrige una incompatibilidad de tensiones entre el bus I2C del ESP32 (3.3 V) y la pantalla LCD (5 V).
-	Las versiones V4.0 y VFINAL son eléctricamente equivalentes; la diferencia entre ambas es exclusivamente de organización y presentación de la leyenda de bloques funcionales.
