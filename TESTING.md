# TESTING — intl-math

Manual verification checklist. Automated coverage is `tests/smoke.typ`
(compile-only) and `tests/fallback.typ` (asserts on the fallback cascade, the
overrides and parity with Typst's native operators); this file is for the things
a human should eyeball.

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
  untouched: the same line shows `sen`, `lím` and `mcd`. (Fixed in 0.1.1.)
- [ ] **Override of English** — `P(A)` instead of `Pr(A)`, and `lim inf` and `MVT`
  still print as words, not as bare keys. (Fixed in 0.1.1.)

New in 0.1.1, in `tests/smoke.pdf`:

- [ ] **`lim inf` / `lím inf`** — the gap between the two words is a thin space,
  narrower than a normal one.
- [ ] **`lcm` / `mcm` with a subscript in block math** — the subscript goes
  underneath, as with `gcd`.

## Before publishing

- [ ] Compare a real CURSOS page before and after any change to `lib.typ` — this
  package is load-bearing there (through `examkit`, which imports it from
  `@preview`).
