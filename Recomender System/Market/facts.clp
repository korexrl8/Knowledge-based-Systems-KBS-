(deffacts clientes-y-tarjetas
  (cliente (customer-id 101) (name "Jose") (banco-preferido banamex) (phone "555-1111"))
  (cliente (customer-id 102) (name "Maria") (banco-preferido bbva) (phone "555-2222"))
  (cliente (customer-id 103) (name "Bob") (banco-preferido liverpool) (phone "555-3333"))

  (tarjeta-credito (customer-id 101) (banco banamex) (grupo oro))
  (tarjeta-credito (customer-id 101) (banco bbva) (grupo visa))
  (tarjeta-credito (customer-id 102) (banco bbva) (grupo platinum))
  (tarjeta-credito (customer-id 103) (banco liverpool) (grupo visa))
  (tarjeta-credito (customer-id 103) (banco banamex) (grupo clasica))
)

(deffacts catalogo-productos
  (smartphone (marca apple) (modelo "iPhone16") (color rojo) (precio 27000.0))
  (smartphone (marca apple) (modelo "iPhone15") (color azul) (precio 21000.0))
  (smartphone (marca samsung) (modelo "Note21") (color negro) (precio 25000.0))
  
  (computador (marca apple) (modelo "MacBookAir") (color gris) (precio 30000.0))
  (computador (marca apple) (modelo "MacBookPro") (color plata) (precio 47000.0))
  (computador (marca dell) (modelo "XPS15") (color negro) (precio 42000.0))

  (accesorio (tipo funda) (marca-compat apple) (precio 500.0))
  (accesorio (tipo mica) (marca-compat apple) (precio 300.0))
  (accesorio (tipo cargador) (marca-compat samsung) (precio 700.0))
  (accesorio (tipo funda-note) (marca-compat samsung) (precio 450.0))
)

(deffacts inventario-inicial
  (stock-item (tipo smartphone) (marca apple) (modelo "iPhone16") (cantidad 50))
  (stock-item (tipo smartphone) (marca apple) (modelo "iPhone15") (cantidad 20))
  (stock-item (tipo smartphone) (marca samsung) (modelo "Note21") (cantidad 40))
  (stock-item (tipo computador) (marca apple) (modelo "MacBookAir") (cantidad 30))
  (stock-item (tipo computador) (marca apple) (modelo "MacBookPro") (cantidad 15))
  (stock-item (tipo computador) (marca dell) (modelo "XPS15") (cantidad 25))
)
