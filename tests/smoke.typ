#import "@local/intl-math:0.1.0": intl, languages
#let m = intl()

#set page(width: 15cm, height: auto, margin: 1cm)

= intl-math

Idiomas del paquete: #languages().join(", ")

== Español

#set text(lang: "es")
$#m.sin (x)$, $#m.tan (x)$, $#m.arctan (x)$, $#m.tanh (x)$, $#m.cot (x)$, $#m.csc (x)$, $#m.arcsin (x)$, $#m.sinh (x)$

$#(m.lim)_(x->0) f(x)$, $#m.max$, $#m.min$, $#m.inf$, $#m.sup$

$#m.gcd (12, 18)$, $#m.lcm (4, 6)$, $#m.rank (A)$, $#m.adj (A)$, $#m.det (A)$, $#m.opp (-17) = 17$

$#m.dom (f)$, $#(m.proj)_u (v)$, $#m.Pr (A)$, $#m.mvt$

$f(x) = cases(x^2 & #m.pw-if x > 0, -x & #m.pw-if x <= 0)$

== Inglés

#set text(lang: "en")
$#m.sin (x)$, $#m.cot (x)$, $#m.csc (x)$, $#m.arcsin (x)$, $#m.sinh (x)$

$#(m.lim)_(x->0) f(x)$, $#m.max$, $#m.min$, $#m.inf$

$#m.gcd (12, 18)$, $#m.rank (A)$, $#m.dom (f)$, $#m.Pr (A)$, $#m.opp (-17) = 17$

$f(x) = cases(x^2 & #m.pw-if x > 0)$

== Un idioma que NO trae el paquete, sin forkear

#let fr = intl(extra: (fr: (sin: "sin", cos: "cos", tan: "tg", lim: "lim", gcd: "pgcd", lcm: "ppcm")))
#set text(lang: "fr")
$#fr.tan (x)$, $#fr.gcd (12, 18)$, $#fr.lcm (4, 6)$ — y lo que no traduce cae al inglés: $#fr.rank (A)$, $#fr.dom (f)$
