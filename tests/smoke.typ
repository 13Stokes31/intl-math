// Smoke test: every symbol side by side in both shipped languages, so the two
// columns can be compared at a glance, plus the cases where the *shape* matters
// (limits underneath, operator spacing with a subscript, piecewise word).
#import "@local/intl-math:0.1.0": intl, languages
#let m = intl()

#set page(width: 16cm, height: auto, margin: 1cm)
#set text(lang: "en")

= intl-math

Languages shipped: #languages().join(", ")

== Every symbol, English vs Spanish

The two columns are the *same* identifier rendered under a different `text.lang`.
A row where both columns match is a symbol Spanish does not change.

#let sym(key, s) = (
  raw(key),
  text(lang: "en", $#s$),
  text(lang: "es", $#s$),
)

#table(
  columns: (auto, 1fr, 1fr),
  align: (left, center, center),
  stroke: 0.5pt + luma(70%),
  table.header([*key*], [*en*], [*es*]),
  ..sym("sin", m.sin), ..sym("cos", m.cos), ..sym("tan", m.tan),
  ..sym("cot", m.cot), ..sym("sec", m.sec), ..sym("csc", m.csc),
  ..sym("arcsin", m.arcsin), ..sym("arccos", m.arccos), ..sym("arctan", m.arctan),
  ..sym("sinh", m.sinh), ..sym("cosh", m.cosh), ..sym("tanh", m.tanh),
  ..sym("coth", m.coth), ..sym("sech", m.sech), ..sym("csch", m.csch),
  ..sym("sinc", m.sinc),
  ..sym("lim", m.lim), ..sym("liminf", m.liminf), ..sym("limsup", m.limsup),
  ..sym("max", m.max), ..sym("min", m.min), ..sym("sup", m.sup), ..sym("inf", m.inf),
  ..sym("log", m.log), ..sym("ln", m.ln), ..sym("lg", m.lg), ..sym("exp", m.exp),
  ..sym("det", m.det), ..sym("dim", m.dim), ..sym("rank", m.rank), ..sym("tr", m.tr),
  ..sym("gcd", m.gcd), ..sym("lcm", m.lcm), ..sym("mod", m.mod),
  ..sym("adj", m.adj), ..sym("ker", m.ker), ..sym("hom", m.hom),
  ..sym("arg", m.arg), ..sym("deg", m.deg), ..sym("opp", m.opp),
  ..sym("dom", m.dom), ..sym("id", m.id), ..sym("proj", m.proj),
  ..sym("dist", m.dist), ..sym("rad", m.rad),
  ..sym("Re", m.Re), ..sym("Im", m.Im),
  ..sym("Pr", m.Pr), ..sym("Normal", m.Normal), ..sym("Bin", m.Bin),
  ..sym("mvt", m.mvt), ..sym("pw-if", m.pw-if),
)

== In a formula, same expressions in both languages

Each pair below is the *same source*, only `text.lang` differs.

#let pair(body) = table(
  columns: (3em, 1fr),
  stroke: none,
  inset: (x: 4pt, y: 6pt),
  [en], text(lang: "en", body),
  [es], text(lang: "es", body),
)

Limits go *underneath* the word in block math (this is where `limits: true`
shows; inline, Typst puts them beside, which is the correct behaviour):
#pair($ #(m.lim)_(x->0) f(x) = #(m.max)_(x in A) g(x) $)

Operator spacing survives a subscript — nothing should be glued together:
#pair($#(m.proj)_u (v) + #(m.log)_a m$)

Divisibility and matrices:
#pair($#m.gcd (12, 18) + #m.lcm (4, 6) + #m.rank (A) + #m.adj (A) + #m.det (A)$)

Trigonometry:
#pair($#m.sin (x) + #m.tan (x) + #m.arctan (x) + #m.cot (x) + #m.csc (x)$)

Analysis, probability, the additive inverse and a theorem:
#pair($#m.dom (f) + #m.Pr (A) + #m.opp (-17) + #m.mvt$)

Piecewise functions — `pw-if` carries a space on each side:
#pair($f(x) = cases(x^2 & #m.pw-if x > 0, -x & #m.pw-if x <= 0)$)

== A language the package does not ship, without forking

#let fr = intl(extra: (fr: (sin: "sin", cos: "cos", tan: "tg", lim: "lim", gcd: "pgcd", lcm: "ppcm")))
#set text(lang: "fr")
$#fr.tan (x)$, $#fr.gcd (12, 18)$, $#fr.lcm (4, 6)$ — and what it does not
translate falls back to English: $#fr.rank (A)$, $#fr.dom (f)$
