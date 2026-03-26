# Equipo 01 - Fundamentos de Diseño
### Carrera de Ingeniería Ambiental / Informática / Industrial  
**Universidad Peruana Cayetano Heredia**

---

## Sobre nosotros:  
Somos el **Equipo 01** del curso **Fundamentos de Diseño 2026-1**, conformado por estudiantes de la carrera de Ingeniería Ambiental / Informática / Industrial.

Nuestro objetivo es desarrollar soluciones que conecten la tecnología con problemas reales del entorno laboral y ambiental en el Perú. Buscamos generar propuestas que no solo sean innovadoras, sino también aplicables en contextos reales.

<p align="center">
<img width="1408" height="768" alt="imagen_alumnos_IA" src="https://github.com/SharkUsser/FdD_Equipo01/blob/main/Recursos/Im%C3%A1genes/WhatsApp%20Image%202026-03-19%20at%2012.13.21%20PM.jpeg" />
  <em>Figura 1. Fotografía del equipo 01</em>
</p>

---

## 👥 Integrantes del Equipo  

| Foto | Nombre | Rol | Intereses |
|------|--------|-----|-----------|
| <img src="/Recursos/Imágenes/Lidia.jpg" width="90"/> | **Landa Torres, Lidia** | Líder del equipo | Innovación social, sostenibilidad |
| <img src="/Recursos/Imágenes/Yenifer Loayza Pineda.jpeg" width="90"/> | **Loayza Pineda, Yenifer** | Responsable de investigación | Gestión ambiental, desarrollo comunitario |
| <img src="/Recursos/Imágenes/pellanne-carlos.jpg" width="90"/> | **Pellanne Aro, Carlos** | Diseñador | Diseño de prototipos, creatividad aplicada |
| <img src="/Recursos/Imágenes/gianella.jpeg" width="90"/> | **Benites Tena, Gianella** | Responsable de documentación y análisis de información | Comunicación científica, redacción técnica, Interpretación de datos ambientales|
| <img src="/Recursos/Imágenes/B819A807-9F5F-43F0-AB15-746606625547_1_201_a.jpeg" width="90"/> | **Delerna Infantes, Anderson** | Programador - Modelador | Programación, análisis de datos, simulación |

---

## ¿Por qué este proyecto?
En muchos espacios laborales, especialmente en entornos industriales o urbanos de Lima, los trabajadores están expuestos a condiciones ambientales que pueden afectar su salud, como la mala calidad del aire o la presencia de contaminantes.

Aunque existen medidas de protección, no siempre se sabe con certeza si son suficientes o si las condiciones del ambiente están dentro de niveles seguros.

Como equipo, nos interesa abordar este problema desde una mirada preventiva, usando tecnología para generar información clara y útil.

---

## ODS en los que nos enfocamos:
Nuestro proyecto se relaciona con los siguientes Objetivos de Desarrollo Sostenible: 

- **ODS 9: Industria, innovación e infraestructura**
  Promueve el uso de la tecnología y la innovación para resolver problemas, lo cual se refleja en el desarrollo de un sistema accesible basado en Arduino para monitorear la calidad del aire.

- **ODS 11: Ciudades y comunidades sostenibles**
  Busca mejorar la calidad de vida en las ciudades reduciendo problemas como la contaminación del aire, y en este proyecto se aplica al monitorear las condiciones ambientales en entornos laborales de Lima para identificar riesgos y promover espacios más seguros.

- **ODS 12: Producción y consumo responsables**
  Busca fomentar prácticas responsables que reduzcan el impacto ambiental, y en este proyecto se aplica al incentivar mejoras en las condiciones laborales y ambientales dentro de las empresas.

- **ODS 13: Acción por el clima**
  Se enfoca en la acción frente al cambio climático, y en este proyecto se relaciona al generar conciencia sobre la contaminación del aire y su impacto en la salud de los trabajadores.

---

## Problemática
En la ciudad de Lima, muchos trabajadores desarrollan sus actividades en espacios cerrados o con ventilación limitada, como talleres, almacenes, fábricas o incluso oficinas ubicadas en zonas con alta contaminación ambiental. En estos entornos, es común la presencia de contaminantes como polvo en suspensión, gases y partículas finas que pueden afectar la calidad del aire.

Según el MINAM y el SENAMHI, durante el periodo de aislamiento por la pandemia se registraron niveles de PM2.5 de hasta 3 µg/m³, mientras que en condiciones normales estos valores aumentan significativamente debido a la actividad urbana. Además, en distritos de Lima Este y Lima Sur, como Ate y Villa María del Triunfo, se han registrado niveles de calidad del aire clasificados como insalubres, con altas concentraciones de partículas finas.

El problema principal es que, a pesar de este contexto, **no existe un monitoreo constante dentro de los espacios laborales**, lo que impide conocer en tiempo real si las condiciones son seguras. Esto hace que los trabajadores estén expuestos a contaminantes que no siempre son visibles, pero que pueden generar enfermedades respiratorias y otros problemas a largo plazo.

Frente a ello, surge la necesidad de contar con herramientas que permitan medir y visualizar la calidad del aire en los entornos de trabajo, facilitando la toma de decisiones para reducir riesgos.

---

## Enfoque y sustento
La preocupación por la exposición de los trabajadores a contaminantes en el ambiente laboral no es un tema aislado, sino una problemática reconocida a nivel internacional.

Según la Administración de Seguridad y Salud Ocupacional (OSHA), la inhalación de partículas como el polvo de sílice puede provocar enfermedades graves como la silicosis, una afección pulmonar incurable e incluso mortal. Estudios recientes han evidenciado casos en los que trabajadores expuestos a estos contaminantes han desarrollado complicaciones severas, incluyendo trasplantes de pulmón y fallecimientos.

Asimismo, la exposición a partículas finas como el PM2.5 —presentes tanto en entornos industriales como urbanos— representa un riesgo significativo, ya que pueden ingresar a los pulmones e incluso al torrente sanguíneo, estando asociadas a enfermedades respiratorias, cardíacas y renales.

Frente a este contexto, organismos internacionales destacan la importancia del monitoreo constante de la calidad del aire, el uso adecuado de equipos de protección y la implementación de medidas preventivas en los espacios de trabajo.

En este sentido, el uso de tecnologías de monitoreo en tiempo real se presenta como una herramienta clave para identificar riesgos y mejorar las condiciones laborales a partir de datos concretos.

---

## Nuestra propuesta
Nuestra propuesta consiste en crear un dispositivo tecnológico automático que permita monitorear la calidad de aire en un ambiente laboral, detectaremos el material particulado fino (PM2.5) mediante el uso de un sensor PMS5003 Particulate Matter Sensor. 

Este sistema permitirá detectar en tiempo real los niveles de partículas en el aire y generar alertas cuando representen un riesgo para la salud. 

De esta manera, se busca prevenir enfermedades respiratorias y mejorar las condiciones de trabajo mediante el uso de información clara y objetiva.

<p align="center">
<img width="1408" height="768" alt="imagen_alumnos_IA" src="https://github.com/SharkUsser/FdD_Equipo01/blob/main/Recursos/Im%C3%A1genes/WhatsApp%20Image%202026-03-19%20at%2012.13.21%20PM.jpeg" />
  <em>Fuente: ITM (Instituto Tecnológico Metropolitano)</em>
</p>

El prototipo estará instalado dentro de un espacio laboral encargado de medir la calidad del aire. Este sistema incluye:
- Un sensor de material particulado PMS5003 Particulate Matter Sensor para medir PM2.5
- Indicadores visuales que alerten cuando los niveles sean peligrosos
- Un sistema básico de visualización de datos (pantalla o conexión a una app)
El dispositivo permitirá monitorear el ambiente en tiempo real y advertir sobre posibles riesgos para la salud.

---
## ¿Qué haríamos con la información?
Identificar si el ambiente laboral es seguro o si existe un riesgo para la salud de los trabajadores. Además, ayudará a tomar decisiones de manera oportuna, como mejorar la ventilación, ajustar las condiciones del espacio o reforzar el uso de equipos de protección, contribuyendo así a la  mejora continua de las condiciones laborales. 

La idea es transformar datos en decisiones que realmente protejan a los trabajadores.

---

## Reflexión final
Creemos que muchas veces los problemas ambientales dentro de espacios laborales pasan desapercibidos.

Con este proyecto, buscamos visibilizarlos y proponer una solución que permita actuar a tiempo, antes de que los efectos sean más graves.

---

## 📌 Resumen Final  
Este README presenta quiénes somos, qué problema buscamos abordar y cómo estamos desarrollando una propuesta que combina tecnología, salud y sostenibilidad en el contexto laboral peruano. 
