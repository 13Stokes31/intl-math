// Comprueba la CASCADA de respaldo, que es lo que hace el paquete robusto:
// idioma del documento → inglés → la clave tal cual.
#import "@local/intl-math:0.1.0": intl, languages
#set page(width: 14cm, height: auto, margin: 1cm)

#assert(languages() == ("en", "es"), message: "los idiomas del paquete cambiaron")

// (1) Idioma DESCONOCIDO: todo debe caer al inglés, sin error.
#let m = intl()
#set text(lang: "de")
Alemán (no soportado, cae al inglés): $#m.sin (x)$, $#(m.lim)_(x->0)$, $#m.gcd (a,b)$

// (2) Tabla INCOMPLETA: lo que falta cae al inglés, el resto se respeta.
#let p = intl(extra: (it: (sin: "sen", gcd: "MCD")))
#set text(lang: "it")
Italiano parcial: $#p.sin (x)$ y $#p.gcd (a,b)$ traducidos; $#p.tan (x)$ y $#p.rank (A)$ al inglés.

// (3) Un `extra` puede PISAR un idioma que trae el paquete, para el que no esté
//     de acuerdo con nuestras convenciones sin tener que forkear.
#let q = intl(extra: (es: (tan: "tan", Pr: "Pr")))
#set text(lang: "es")
Español con mis propias convenciones: $#q.tan (x)$ y $#q.Pr (A)$ en vez de tg y P.
