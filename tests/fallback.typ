// Checks the fallback CASCADE, which is what makes the package robust:
// document language → English → the key itself.
#import "@local/intl-math:0.1.0": intl, languages
#set page(width: 14cm, height: auto, margin: 1cm)

#assert(languages() == ("en", "es"), message: "the shipped languages changed")

// (1) UNKNOWN language: everything must fall back to English, with no error.
#let m = intl()
#set text(lang: "de")
German (not shipped, falls back to English): $#m.sin (x)$, $#(m.lim)_(x->0)$, $#m.gcd (a,b)$

// (2) INCOMPLETE table: what is missing falls back to English, the rest is kept.
#let p = intl(extra: (it: (sin: "sen", gcd: "MCD")))
#set text(lang: "it")
Partial Italian: $#p.sin (x)$ and $#p.gcd (a,b)$ translated; $#p.tan (x)$ and $#p.rank (A)$ in English.

// (3) An `extra` can OVERRIDE a language the package does ship, so anyone who
//     disagrees with our conventions does not have to fork it.
#let q = intl(extra: (es: (tan: "tan", Pr: "Pr")))
#set text(lang: "es")
Spanish with my own conventions: $#q.tan (x)$ and $#q.Pr (A)$ instead of tg and P.
