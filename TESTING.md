# TESTING — intl-math

Manual verification checklist. Automated coverage is `tests/smoke.typ` and
`tests/fallback.typ` (both compile-only, plus one `assert` on the shipped language
list); this file is for the things a human should eyeball.

Render both with:

```sh
just test
```

Then check `tests/smoke.pdf`:

- [ ] **Spanish trigonometry** — `sen`, `tg`, `arctg`, `tgh`, `cotg`, `cosec`,
  `arcsen`, `senh`. No English abbreviation left over.
- [ ] **Accents** — `lím`, `máx`, `mín`, `ínf` carry their accent and it is not
  clipped by the line above.
- [ ] **`lim` with its condition underneath** — `$#(m.lim)_(x->0) f(x)$` puts
  `x->0` *below* the word, not as a subscript beside it.
- [ ] **Operator spacing with a subscript** — `#(m.proj)_u (v)` and the `lim`
  above are *not* glued to what follows. This is the regression that motivated
  putting `context` inside `math.op`: it compiles either way and only shows up
  by comparison.
- [ ] **Spanish algebra** — `mcd`, `mcm`, `rang`, `Adj`, `det`, `op(-17)`.
- [ ] **Spanish analysis and probability** — `Dom`, `proy`, `P(A)`, `TVM`.
- [ ] **Piecewise `si`** — `pw-if` prints with a space on each side and lines up
  inside `cases(...)`.
- [ ] **English section** — the same identifiers print `sin`, `cot`, `csc`,
  `lim`, `gcd`, `rank`, `dom`, `Pr`, `opp`, `if`.
- [ ] **French via `extra`** — `tg`, `pgcd`, `ppcm` translated; `rank` and `dom`
  fall back to English.

And `tests/fallback.pdf`:

- [ ] **Unknown language (`de`)** — everything falls back to English, no error.
- [ ] **Partial table (`it`)** — `sen` and `MCD` translated, `tan` and `rank`
  fall back to English.
- [ ] **Override of a shipped language** — `intl(extra: (es: (tan: "tan", Pr: "Pr")))`
  prints `tan` and `Pr` instead of `tg` and `P`, and leaves the rest of Spanish
  untouched.

## Before publishing

- [ ] Compare a real CURSOS page built with `@local/intl-math` before and after
  any change to `lib.typ` — this package is load-bearing there.
