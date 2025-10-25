
(deftemplate cliente
  (slot customer-id (type INTEGER))
  (slot name (type STRING))
  (slot banco-preferido (type SYMBOL))
  (slot phone (type STRING))
)

(deftemplate tarjeta-credito
  (slot customer-id (type INTEGER))
  (slot banco (type SYMBOL))
  (slot grupo (type SYMBOL)) ; visa, mastercard, amex
)

(deftemplate smartphone
  (slot marca (type SYMBOL))
  (slot modelo (type STRING))
  (slot color (type SYMBOL))
  (slot precio (type FLOAT))
)

(deftemplate computador
  (slot marca (type SYMBOL))
  (slot modelo (type STRING))
  (slot color (type SYMBOL))
  (slot precio (type FLOAT))
)

(deftemplate accesorio
  (slot tipo (type SYMBOL)) ; funda, mica, cargador
  (slot marca-compat (type SYMBOL)) ; apple, samsung, universal
  (slot precio (type FLOAT))
)

(deftemplate stock-item
  (slot tipo (type SYMBOL)) ; smartphone, computador
  (slot marca (type SYMBOL))
  (slot modelo (type STRING))
  (slot cantidad (type INTEGER))
)

(deftemplate orden-compra
  (slot customer-id (type INTEGER))
  (slot item-tipo (type SYMBOL))
  (slot marca (type SYMBOL))
  (slot modelo (type STRING))
  (slot qty (type INTEGER))
  (slot pago-tipo (type SYMBOL))
  (slot banco-tarjeta (type SYMBOL) (default nil))
)

(deftemplate vale-generado
  (slot customer-id (type INTEGER))
  (slot monto (type FLOAT))
)

(deftemplate oferta-aplicada
  (slot customer-id (type INTEGER))
  (slot mensaje (type STRING))
)

(deftemplate recomendacion
  (slot customer-id (type INTEGER))
  (slot mensaje (type STRING))
)