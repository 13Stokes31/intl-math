// ============================================================================
//  es.typ — ESPAÑOL (convenciones de España, enseñanza secundaria).
//
//  Solo lo que CAMBIA respecto al inglés. Lo que no está aquí se imprime igual
//  que en inglés (cos, sec, log, ln, exp, det, dim, tr, mod, arg, Re, Im…), que
//  es lo correcto: esas abreviaturas son las mismas en los dos idiomas.
// ============================================================================

#let words = (
  // --- Trigonometría ---
  // Seno: "sen" es la forma española; "sin" es un anglicismo muy extendido.
  sin: "sen",
  arcsin: "arcsen",
  sinh: "senh",
  // Tangente: "tg" es la forma tradicional en España (Typst ya trae `tg` como
  // operador suelto, pero aquí lo que importa es que quien escribe `tan(x)`
  // —el nombre que documenta Typst— vea "tg" impreso sin cambiar su contenido).
  tan: "tg",
  arctan: "arctg",
  tanh: "tgh",
  // Cotangente y cosecante: en español se escriben desarrolladas.
  cot: "cotg",
  coth: "cotgh",
  csc: "cosec",

  // --- Límites y extremos (llevan tilde) ---
  lim: "lím",
  liminf: "lím inf",
  limsup: "lím sup",
  max: "máx",
  min: "mín",
  inf: "ínf",

  // --- Álgebra y aritmética ---
  rank: "rang",            // rango de una matriz
  gcd: "mcd",              // máximo común divisor
  lcm: "mcm",              // mínimo común múltiplo
  adj: "Adj",              // matriz adjunta (con mayúscula, como es habitual)
  opp: "op",               // opuesto de un número: op(−17) = 17

  // --- Análisis ---
  dom: "Dom",              // dominio, con mayúscula en la convención española
  proj: "proy",            // proyección

  // --- Probabilidad ---
  Pr: "P",                 // probabilidad: P(A), no Pr(A)

  // --- Teoremas ---
  mvt: "TVM",              // Teorema del Valor Medio

  // --- Palabras dentro de fórmulas ---
  pw-if: "si",
)
