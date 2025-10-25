;; ----------------------------------------------------
;; RUN.CLP
;; Carga todos los archivos y prepara el sistema
;; ----------------------------------------------------

;; 1. Cargar la estructura de la Base de Conocimientos
(load "templates.clp")

;; 2. Cargar los datos (hechos) iniciales
(load "facts.clp")

;; 3. Cargar el motor de inferencia (reglas)
(load "rules.clp")

;; 4. Cargar los hechos de 'deffacts' en la memoria
(reset)

(printout t "------------------------------------------------------" crlf)
(printout t "--- Sistema Recomendador (Hands-on 3) Cargado ---" crlf)
(printout t "------------------------------------------------------" crlf)
(printout t "Hechos iniciales cargados. Listo para recibir órdenes." crlf crlf)
(printout t "Ejemplo de prueba:" crlf)
(printout t "(assert (orden-compra (customer-id 101) (item-tipo smartphone) (marca apple) (modelo \"iPhone16\") (qty 1) (pago-tipo tarjeta) (banco-tarjeta banamex)))" crlf)
(printout t "(run)" crlf crlf)