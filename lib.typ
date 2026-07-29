// ============================================================================
//  intl-math — operadores matemáticos que se imprimen en el idioma del
//  documento.
//
//  El problema: las abreviaturas matemáticas NO son universales. En español el
//  seno es "sen", el límite "lím" y el máximo común divisor "mcd"; en inglés son
//  "sin", "lim" y "gcd". Typst solo trae las inglesas, así que un documento en
//  español sale con notación inglesa — o hay que redefinir los operadores a mano
//  en cada proyecto.
//
//  La idea: el IDENTIFICADOR no cambia (sigues escribiendo `sin(x)`, el nombre
//  que ya usas y que documenta Typst); lo que cambia es la palabra IMPRESA, que
//  la decide `text.lang`. Adoptar el paquete no obliga a reescribir contenido.
//
//      #import "@preview/intl-math:0.1.0": intl
//      #let m = intl()
//      #set text(lang: "es")
//      $#m.sin (x)$   →  sen(x)
//      $#m.lim_(x->0)$ →  lím
//
//  Y con el idioma en "en", los mismos identificadores imprimen sin y lim.
// ============================================================================

#import "lang/en.typ" as en-lang
#import "lang/es.typ" as es-lang

// Los idiomas que trae el paquete. Añadir uno es añadir su fichero y una línea
// AQUÍ — en ningún otro sitio: los símbolos se construyen solos a partir de las
// claves del inglés (ver `intl` más abajo).
#let BUILTIN = (
  en: en-lang.words,
  es: es-lang.words,
)

// Qué FORMA tiene cada símbolo. No depende del idioma, así que vive aparte de
// las tablas: quien añade un idioma no tiene que saber nada de esto.
//   "op"     → operador matemático (math.op: se compone en redonda y con el
//              espaciado de operador que le corresponde).
//   "spaced" → palabra suelta dentro de una fórmula, con un espacio a cada lado
//              (el "si" de las funciones a trozos).
#let _shape = (
  pw-if: "spaced",
)

// Operadores que llevan los LÍMITES debajo, no al lado: `lim_(x->0)` pone la
// condición bajo la palabra, mientras que `log_a` la deja como subíndice. Es la
// misma lista que trae Typst para sus operadores nativos, comprobada
// compilándolos: el resto (log, sin, arg, dim…) NO lleva límites.
#let _limits = ("lim", "liminf", "limsup", "max", "min", "sup", "inf", "det", "gcd", "Pr")

// El `context` va DENTRO del `math.op`, y esto NO es un detalle de estilo.
//
// Al revés —`context { math.op(word) }`— el resultado deja de ser un operador a
// ojos de Typst: es contenido opaco. Y entonces se pierde el espaciado de
// operador en cuanto lleva subíndice, que es justo cuando más se usa:
// `log_a m` salía «log_a​m», pegado, y `lim_(x->0) f(x)` igual. Compila sin una
// queja y solo se ve comparando. Apareció migrando 4º ESO, donde una fórmula de
// logaritmos cabía en una línea con el motor nuevo y en dos con el anterior.
//
// Poniendo el `context` dentro, el nodo exterior SÍ es un `math.op` y conserva su
// clase; lo único que se resuelve tarde es la palabra.
#let _symbol(key, tables) = {
  // El respaldo es en cascada: idioma del documento → inglés → la clave tal cual.
  // Así una tabla incompleta NO rompe el documento (sale la palabra inglesa), y
  // un idioma desconocido tampoco (sale todo en inglés).
  let word = context {
    let table = tables.at(text.lang, default: tables.en)
    table.at(key, default: tables.en.at(key, default: key))
  }
  if _shape.at(key, default: "op") == "op" {
    math.op(word, limits: _limits.contains(key))
  } else {
    // Los espacios van FUERA del `context`: dentro, `word` ya es contenido y no
    // se puede concatenar con cadenas.
    math.text(" ") + word + math.text(" ")
  }
}

/// Los símbolos, resueltos según el idioma del documento.
///
/// - extra (dictionary): idiomas ADICIONALES, `(código: (clave: "palabra"))`.
///   Permite usar un idioma que el paquete no trae todavía **sin forkearlo**; si
///   además quieres contribuirlo, es un fichero en `lang/`.
///
/// Devuelve un diccionario con un símbolo por clave (ver `lang/en.typ` para la
/// lista completa). Se usa con `#`, porque en modo math un identificador suelto
/// se interpretaría como variables: `$#m.sin (x)$`.
#let intl(extra: (:)) = {
  let tables = BUILTIN + extra
  let out = (:)
  // Las claves salen de la tabla inglesa, que es la de referencia: añadir un
  // símbolo nuevo es añadirlo allí (y a `_shape` si no es un operador).
  for key in en-lang.words.keys() {
    out.insert(key, _symbol(key, tables))
  }
  out
}

/// Los códigos de idioma que trae el paquete, para saber si el tuyo está.
#let languages() = BUILTIN.keys()
