// ============================================================================
//  en.typ — INGLÉS. Es además la tabla de REFERENCIA: define qué claves existen
//  y de aquí sale el respaldo cuando otro idioma no traduce una.
//
//  Los nombres de las claves son los identificadores que se escriben en el
//  documento, y coinciden con los de Typst: quien ya escribe `sin(x)` no cambia
//  nada, solo cambia lo que se IMPRIME.
//
//  Para añadir un idioma NO se toca este fichero: se copia a `lang/xx.typ`, se
//  traduce lo que cambie y se borra el resto (lo que falte cae aquí).
// ============================================================================

#let words = (
  // --- Trigonometría ---
  sin: "sin", cos: "cos", tan: "tan",
  cot: "cot", sec: "sec", csc: "csc",
  arcsin: "arcsin", arccos: "arccos", arctan: "arctan",
  sinh: "sinh", cosh: "cosh", tanh: "tanh",
  coth: "coth", sech: "sech", csch: "csch",
  sinc: "sinc",

  // --- Límites y extremos ---
  lim: "lim", liminf: "lim inf", limsup: "lim sup",
  max: "max", min: "min", sup: "sup", inf: "inf",

  // --- Logaritmos y exponencial ---
  log: "log", ln: "ln", lg: "lg", exp: "exp",

  // --- Álgebra y aritmética ---
  det: "det", dim: "dim", rank: "rank", tr: "tr",
  gcd: "gcd", lcm: "lcm", mod: "mod",
  adj: "adj", ker: "ker", hom: "hom", arg: "arg", deg: "deg",
  // Opuesto (inverso aditivo): opp(-17) = 17. La clave NO puede llamarse `op`
  // aunque sea así como se abrevia en varios idiomas: `op` es una función nativa
  // de Typst (`math.op`), y un paquete que se la quita a quien lo instala es una
  // trampa. Con `opp` no hay colisión.
  opp: "opp",

  // --- Análisis y geometría ---
  dom: "dom", id: "id", proj: "proj", dist: "dist", rad: "rad",
  Re: "Re", Im: "Im",

  // --- Probabilidad y estadística ---
  Pr: "Pr", Normal: "N", Bin: "Bin",

  // --- Teoremas ---
  mvt: "MVT",

  // --- Palabras dentro de fórmulas (no operadores) ---
  // El "si" de las funciones a trozos: f(x) = x^2 si x > 0.
  pw-if: "if",
)
