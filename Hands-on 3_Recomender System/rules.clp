(defglobal ?*total-compra* = 0)

; Regla 1
(defrule validar-stock
  (declare (salience 100))
  ?orden <- (orden-compra (item-tipo ?t) (marca ?m) (modelo ?mod) (qty ?q))
  (stock-item (tipo ?t) (marca ?m) (modelo ?mod) (cantidad ?c&:(< ?c ?q)))
  =>
  (printout t "ERROR: Stock insuficiente para " ?q " " ?m " " ?mod ". Disponibles: " ?c crlf)
  (retract ?orden)
)

; Regla 2
(defrule validar-tarjeta
  (declare (salience 100))
  ?orden <- (orden-compra (customer-id ?cid) (pago-tipo tarjeta) (banco-tarjeta ?b&:(neq ?b nil)))
  (not (tarjeta-credito (customer-id ?cid) (banco ?b)))
  =>
  (printout t "ERROR: El cliente " ?cid " no tiene registrada una tarjeta del banco " ?b crlf)
  (retract ?orden)
)

; Regla 3
(defrule calcular-total-compra
  (declare (salience 90))
  (orden-compra (item-tipo smartphone) (marca ?m) (modelo ?mod) (qty ?q))
  (smartphone (marca ?m) (modelo ?mod) (precio ?p))
  =>
  (bind ?*total-compra* (* ?q ?p))
)

; Regla 4
(defrule calcular-total-compra-compu
  (declare (salience 90))
  (orden-compra (item-tipo computador) (marca ?m) (modelo ?mod) (qty ?q))
  (computador (marca ?m) (modelo ?mod) (precio ?p))
  =>
  (bind ?*total-compra* (* ?q ?p))
)

; Regla 5
(defrule clasificar-mayorista
  (declare (salience 50))
  (orden-compra (customer-id ?cid) (qty ?q&:(> ?q 10)))
  =>
  (printout t "INFO: Cliente " ?cid " clasificado como MAYORISTA." crlf)
)

; Regla 6
(defrule clasificar-menudista
  (declare (salience 50))
  (orden-compra (customer-id ?cid) (qty ?q&:(<= ?q 10)))
  =>
  (printout t "INFO: Cliente " ?cid " clasificado como MENUDISTA." crlf)
)

; Regla 7
(defrule oferta-iphone16-banamex
  (declare (salience 20))
  (orden-compra (customer-id ?cid) (item-tipo smartphone) (marca apple) (modelo "iPhone16") (pago-tipo tarjeta) (banco-tarjeta banamex))
  =>
  (assert (oferta-aplicada (customer-id ?cid) (mensaje "24 meses sin intereses con Banamex en iPhone 16")))
)

; Regla 8
(defrule oferta-note21-liverpool
  (declare (salience 20))
  (orden-compra (customer-id ?cid) (item-tipo smartphone) (marca samsung) (modelo "Note21") (pago-tipo tarjeta) (banco-tarjeta liverpool))
  =>
  (assert (oferta-aplicada (customer-id ?cid) (mensaje "12 meses sin intereses con Liverpool VISA en Note 21")))
)

; Regla 9
(defrule vale-macbook-iphone-contado
  (declare (salience 20))
  (orden-compra (customer-id ?cid) (item-tipo computador) (marca apple) (modelo "MacBookAir") (pago-tipo contado))
  =>
  (bind ?monto-vale (* (div ?*total-compra* 1000) 100))
  (assert (vale-generado (customer-id ?cid) (monto ?monto-vale)))
)

; Regla 10
(defrule desc-accesorios-por-smartphone
  (declare (salience 20))
  (orden-compra (customer-id ?cid) (item-tipo smartphone) (marca ?m))
  =>
  (assert (oferta-aplicada (customer-id ?cid) (mensaje (str-cat "15% de descuento en fundas y micas para " ?m))))
)

; Regla 11 corregida
(defrule oferta-apple-banamex
  (declare (salience 19)) ; Menor prioridad que la específica de iPhone 16
  (orden-compra
    (customer-id ?cid)
    (item-tipo ?t)
    (marca apple)
    (pago-tipo tarjeta)
    (banco-tarjeta banamex))
  (test (or (eq ?t smartphone) (eq ?t computador)))
  =>
  (assert (oferta-aplicada
    (customer-id ?cid)
    (mensaje "18 meses sin intereses en productos Apple con Banamex")))
)

; Regla 12
(defrule oferta-samsung-bbva
  (declare (salience 19))
  (orden-compra (customer-id ?cid) (item-tipo smartphone) (marca samsung) (pago-tipo tarjeta) (banco-tarjeta bbva))
  =>
  (assert (oferta-aplicada (customer-id ?cid) (mensaje "6 meses sin intereses en productos Samsung con BBVA")))
)

; Regla 13
(defrule desc-banco-preferido
  (declare (salience 20))
  (cliente (customer-id ?cid) (banco-preferido ?b))
  (orden-compra (customer-id ?cid) (pago-tipo tarjeta) (banco-tarjeta ?b))
  =>
  (assert (oferta-aplicada (customer-id ?cid) (mensaje (str-cat "5% de descuento adicional por usar tu banco preferido (" ?b ")"))))
)

; Regla 14
(defrule vale-compra-grande
  (declare (salience 15)) ;; se ejecuta después de las reglas de cálculo
  ?o <- (orden-compra (customer-id ?cid) (item-tipo ?t) (marca ?m) (modelo ?mod) (qty ?q))
  (or (smartphone (marca ?m) (modelo ?mod) (precio ?p))
      (computador (marca ?m) (modelo ?mod) (precio ?p)))
  =>
  (bind ?total (* ?q ?p))
  (if (> ?total 40000) then
      (assert (vale-generado (customer-id ?cid) (monto 500.0)))
  )
)

; Regla 15
(defrule recom-accesorios-apple
  (declare (salience 10))
  (orden-compra (customer-id ?cid) (item-tipo smartphone) (marca apple))
  =>
  (assert (recomendacion (customer-id ?cid) (mensaje "Completa tu ecosistema: Revisa fundas y micas Apple.")))
)

; Regla 16
(defrule recom-accesorios-samsung
  (declare (salience 10))
  (orden-compra (customer-id ?cid) (item-tipo smartphone) (marca samsung))
  =>
  (assert (recomendacion (customer-id ?cid) (mensaje "Protege tu inversión: Revisa cargadores y fundas Samsung.")))
)

; Regla 17
(defrule recom-upsell-macbook
  (declare (salience 10))
  (orden-compra (customer-id ?cid) (item-tipo computador) (marca apple) (modelo "MacBookAir"))
  =>
  (assert (recomendacion (customer-id ?cid) (mensaje "Por un poco más, llévate la MacBook Pro con 30% más de rendimiento.")))
)

; Regla 18
(defrule recom-monitor
  (declare (salience 10))
  (orden-compra (customer-id ?cid) (item-tipo computador))
  =>
  (assert (recomendacion (customer-id ?cid) (mensaje "Considera un monitor externo 4K para mejorar tu productividad.")))
)

; Regla 19
(defrule recom-liquidacion-iphone15
  (declare (salience 10))
  (orden-compra (customer-id ?cid) (item-tipo smartphone))
  (stock-item (tipo smartphone) (marca apple) (modelo "iPhone15") (cantidad ?c&:(> ?c 0)))
  =>
  (assert (recomendacion (customer-id ?cid) (mensaje "¡LIQUIDACIÓN! Llévate el iPhone 15 con 20% de descuento.")))
)

; Regla 20
(defrule actualizar-stock
  (declare (salience -10))
  ?orden <- (orden-compra (item-tipo ?t) (marca ?m) (modelo ?mod) (qty ?q))
  ?stock <- (stock-item (tipo ?t) (marca ?m) (modelo ?mod) (cantidad ?c))
  =>
  (modify ?stock (cantidad (- ?c ?q)))
  (printout t "STOCK: " ?m " " ?mod " actualizado. Nuevo total: " (- ?c ?q) crlf)
  (retract ?orden)
)

; Regla 21
(defrule imprimir-ofertas
  (declare (salience -20))
  ?f <- (oferta-aplicada (customer-id ?cid) (mensaje ?msg))
  =>
  (printout t "OFERTA (Cliente " ?cid "): " ?msg crlf)
  (retract ?f)
)

; Regla 22
(defrule imprimir-recomendaciones
  (declare (salience -20))
  ?f <- (recomendacion (customer-id ?cid) (mensaje ?msg))
  =>
  (printout t "RECOMENDACION (Cliente " ?cid "): " ?msg crlf)
  (retract ?f)
)

; Regla 23
(defrule imprimir-vales
  (declare (salience -20))
  ?f <- (vale-generado (customer-id ?cid) (monto ?val))
  (test (> ?val 0))
  =>
  (printout t "VALE (Cliente " ?cid "): Has generado un vale por $" ?val " para tu próxima compra." crlf)
  (retract ?f)
)

