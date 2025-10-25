;; 1. Cargar la estructura de la Base de Conocimientos
(load "templates.clp")

;; 2. Cargar los hechos iniciales
(load "facts.clp")

;; 3. Cargar el motor de inferencia / reglas
(load "rules.clp")

;; 4. Cargar los hechos de 'deffacts' en la memoria
(reset)