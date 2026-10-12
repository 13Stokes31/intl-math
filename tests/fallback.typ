// Checks the fallback CASCADE, which is what makes the package robust:
// document language → English → the key itself. The printed word is resolved
// late (inside a `context`), so the asserts compare MEASURES: two formulas that
// print the same word measure the same.
#import "../lib.typ": intl, languages
#set page(width: 14cm, height: auto, margin: 1cm)

#assert(languages() == ("en", "es"), message: "the shipped languages changed")

#let m = intl()
#let same(a, b) = measure(a) == measure(b)
// `a` under the current language against `b` typeset in English.
#let same-as-en(a, b) = measure(a) == measure(text(lang: "en", b))

// (1) UNKNOWN language: everything must fall back to English, with no error.
#set text(lang: "de")
German (not shipped, falls back to English): $#m.sin (x)$, $#(m.lim)_(x->0)$, $#m.gcd (a,b)$
#context assert(same-as-en($#m.gcd (a,b)$, $#m.gcd (a,b)$), message: "unknown language is not English")

// (2) INCOMPLETE table: what is missing falls back to English, the rest is kept.
#let p = intl(extra: (it: (sin: "sen", gcd: "MCD")))
#set text(lang: "it")
Partial Italian: $#p.sin (x)$ and $#p.gcd (a,b)$ translated; $#p.tan (x)$ and $#p.rank (A)$ in English.
#context {
  assert(same($#p.gcd$, $op("MCD")$), message: "extra language not applied")
  assert(same-as-en($#p.rank (A)$, $#m.rank (A)$), message: "missing key did not fall back to English")
}

// (3) An `extra` can OVERRIDE a language the package does ship, so anyone who
//     disagrees with our conventions does not have to fork it. Only the listed
//     keys change: the rest of Spanish must stay Spanish.
#let q = intl(extra: (es: (tan: "tan", Pr: "Pr")))
#set text(lang: "es")
Spanish with my own conventions: $#q.tan (x)$ and $#q.Pr (A)$ instead of tg and P;
the rest untouched: $#q.sin (x)$, $#(q.lim)_(x->0)$, $#q.gcd (a,b)$.
#context {
  assert(same-as-en($#q.tan (x)$, $#m.tan (x)$), message: "override not applied")
  assert(not same($#q.tan (x)$, $#m.tan (x)$), message: "override not applied")
  for key in ("sin", "lim", "gcd", "pw-if") {
    assert(same(q.at(key), m.at(key)), message: "the override wiped Spanish `" + key + "`")
  }
}

// (4) Overriding part of ENGLISH — the fallback table, so the delicate case —
//     must not leave the other keys without a word.
#let e = intl(extra: (en: (Pr: "P")))
#set text(lang: "en")
English with P for probability: $#e.Pr (A)$; the rest untouched: $#e.liminf$, $#e.mvt$.
#context {
  assert(same($#e.Pr$, $op("P")$), message: "English override not applied")
  for key in ("liminf", "Normal", "mvt", "pw-if") {
    assert(same(e.at(key), m.at(key)), message: "the override wiped English `" + key + "`")
  }
}

// (5) PARITY with Typst: in English, every key Typst also ships must typeset
//     exactly like the native operator — same word, same spacing next to a
//     subscript, same placement of limits in block math.
#let native = (
  sin: math.sin, cos: math.cos, tan: math.tan, cot: math.cot, sec: math.sec, csc: math.csc,
  arcsin: math.arcsin, arccos: math.arccos, arctan: math.arctan,
  sinh: math.sinh, cosh: math.cosh, tanh: math.tanh, coth: math.coth, sech: math.sech, csch: math.csch,
  sinc: math.sinc, lim: math.lim, liminf: math.liminf, limsup: math.limsup,
  max: math.max, min: math.min, sup: math.sup, inf: math.inf,
  log: math.log, ln: math.ln, lg: math.lg, exp: math.exp,
  det: math.det, dim: math.dim, tr: math.tr, gcd: math.gcd, lcm: math.lcm, mod: math.mod,
  ker: math.ker, hom: math.hom, arg: math.arg, deg: math.deg, id: math.id, Pr: math.Pr,
)
#context {
  for (key, op) in native {
    for shape in (o => $ #o _(x->0) f(x) $, o => $#o _a m$, o => $2 #o x$) {
      assert(same(shape(m.at(key)), shape(op)), message: "`" + key + "` differs from Typst's native operator")
    }
  }
}
Parity with Typst's #native.len() native operators: checked.
