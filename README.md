# intl-math

Operadores matemáticos que **se imprimen en el idioma del documento**.

Las abreviaturas matemáticas no son universales. En español el seno es `sen`, la
tangente `tg`, el límite `lím` y el máximo común divisor `mcd`; en inglés son
`sin`, `tan`, `lim` y `gcd`. Typst solo trae las inglesas, así que un documento
en español sale con notación inglesa — o hay que redefinir los operadores a mano
en cada proyecto.

**La idea: el identificador no cambia, lo impreso sí.** Sigues escribiendo
`sin(x)`, el nombre que documenta Typst; lo que decide qué se imprime es
`text.lang`. Adoptar el paquete **no obliga a reescribir contenido**.

```typst
#import "@preview/intl-math:0.1.0": intl
#let m = intl()

#set text(lang: "es")
$#m.sin (x)$          // sen(x)
$#(m.lim)_(x->0)$     // lím
$#m.gcd (12, 18)$     // mcd(12, 18)

#set text(lang: "en")
$#m.sin (x)$          // sin(x)
```

## Por qué `#` y por qué los paréntesis

Se usa con `#` porque en modo math un identificador suelto se interpretaría como
una multiplicación de variables:

```typst
$#m.sin (x)$     ✅
$m.sin(x)$       ❌  «m por punto por sin…»
```

Y **si lleva subíndice o superíndice, hace falta envolverlo en paréntesis**, o
Typst intenta leerlo como un método del diccionario:

```typst
$#(m.lim)_(x->0) f(x)$    ✅
$#m.lim_(x->0) f(x)$      ❌  «type dictionary has no method `lim_`»
```

Es la única aspereza de la API y viene de cómo Typst parsea el modo math.

## Idiomas

Ahora mismo: **inglés** y **español** (convenciones de España).

El inglés es además la tabla de **referencia**: define qué claves existen y de
ahí sale el respaldo. La cascada es *idioma del documento → inglés → la clave
tal cual*, así que una tabla incompleta no rompe el documento (sale la palabra
inglesa) y un idioma desconocido tampoco (sale todo en inglés).

### Añadir un idioma sin forkear

Si tu idioma no está, pásalo al construir y ya:

```typst
#let m = intl(extra: (fr: (sin: "sin", tan: "tg", gcd: "pgcd", lcm: "ppcm")))
#set text(lang: "fr")
$#m.gcd (12, 18)$     // pgcd(12, 18)
```

Solo hacen falta las claves que **cambien** respecto al inglés. Lo que no pongas
se imprime en inglés.

### No estar de acuerdo con las convenciones

`extra` puede **pisar** un idioma que sí trae el paquete, así que no hace falta
forkearlo para discrepar. Si en tu país la tangente se escribe `tan` y la
probabilidad `Pr`:

```typst
#let m = intl(extra: (es: (tan: "tan", Pr: "Pr")))
```

Solo se sustituyen las claves que pongas; el resto del español sigue igual.

### Contribuir un idioma

Es un fichero y una línea:

1. Copia `lang/es.typ` a `lang/xx.typ` con tu código de idioma.
2. Deja solo las claves cuya palabra impresa cambia respecto al inglés, y borra
   el resto. **No hay que traducirlo todo**: `cos`, `log`, `ln`, `exp`, `det`,
   `dim`, `tr`, `mod`, `arg`, `Re`, `Im`… son iguales en muchos idiomas.
3. Añade `xx: xx-lang.words` al diccionario `BUILTIN` de `lib.typ`.

No hay que tocar ningún operador: se construyen solos a partir de las claves de
`lang/en.typ`. La lista completa de claves está ahí, comentada por familias.

## Símbolos

Cubre los operadores predefinidos de Typst (trigonometría, límites y extremos,
logaritmos, álgebra) más algunos que Typst no trae y que el material de
matemáticas necesita:

| Clave | Inglés | Español |
|---|---|---|
| `sin` `arcsin` `sinh` | sin, arcsin, sinh | **sen, arcsen, senh** |
| `tan` `arctan` `tanh` | tan, arctan, tanh | **tg, arctg, tgh** |
| `cot` `coth` `csc` | cot, coth, csc | **cotg, cotgh, cosec** |
| `lim` `liminf` `limsup` | lim, lim inf, lim sup | **lím, lím inf, lím sup** |
| `max` `min` `inf` | max, min, inf | **máx, mín, ínf** |
| `gcd` `lcm` | gcd, lcm | **mcd, mcm** |
| `rank` `adj` | rank, adj | **rang, Adj** |
| `opp` | opp | **op** |
| `dom` `proj` | dom, proj | **Dom, proy** |
| `Pr` | Pr | **P** |
| `mvt` | MVT | **TVM** |
| `pw-if` | if | **si** |

`pw-if` no es un operador: es la palabra de las funciones a trozos, y se imprime
con un espacio a cada lado.

`opp` es el opuesto (inverso aditivo): `opp(-17)` sale «op(−17)» en español. La
clave se llama `opp` y no `op` a propósito: `op` es una función NATIVA de Typst
(`math.op`), y un paquete que se la quita a quien lo instala es una trampa —
además de una que falla callada, porque `$op(-17)$` seguiría compilando sin
error, solo cambiando de significado.

```typst
$f(x) = cases(x^2 & #m.pw-if x > 0, -x & #m.pw-if x <= 0)$
```

Los que no aparecen en la tabla se imprimen igual en los dos idiomas (`cos`,
`sec`, `log`, `ln`, `lg`, `exp`, `det`, `dim`, `tr`, `mod`, `arg`, `deg`, `ker`,
`hom`, `id`, `dist`, `rad`, `Re`, `Im`, `sinc`, `sup`, `Normal`, `Bin`).

## Relación con `alterlang`

[`alterlang`](https://typst.app/universe/package/alterlang/) hace algo parecido
para los operadores estándar. Las diferencias:

- `intl-math` **no obliga a cambiar los identificadores**: escribes `sin` y sale
  `sen`. En `alterlang` se importa el símbolo ya traducido (`sen`).
- `intl-math` deja **añadir un idioma sin forkear**, pasándolo al construir.
- `intl-math` cubre además símbolos que Typst no trae (`rank`, `dom`, `proj`,
  `mvt`, `pw-if`).

Son complementarios; si solo necesitas los estándar y te va bien escribir los
nombres traducidos, `alterlang` es más directo.

## Estado

Pre-publicación. Se usa en local (`@local/intl-math:0.1.0`) mientras se decide
si merece la pena publicarlo en Typst Universe. La carencia que cubre está
reconocida en el propio Typst:
[#3238](https://github.com/typst/typst/issues/3238) y
[#7159](https://github.com/typst/typst/issues/7159).

## Pruebas

```bash
just test      # instala y compila tests/smoke.typ (3 idiomas) + tests/fallback.typ
```
