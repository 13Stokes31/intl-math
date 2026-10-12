# ROADMAP — intl-math

## By design (not bugs)

- **The `#` and the parentheses.** `$#m.sin (x)$`, and `$#(m.lim)_(x->0)$` when it
  carries a subscript. It comes from how Typst parses math mode, not from the
  package, and it is the price of keeping the identifiers unchanged.
- **The key is `opp`, not `op`.** `op` is a native Typst function (`math.op`);
  shadowing it would break documents silently.
- **`context` goes inside `math.op`, not around it.** The other way round the
  result stops being an operator for Typst and loses its spacing as soon as it
  takes a subscript. See the comment in `lib.typ`.

## Known limitations

- **Only English and Spanish ship with the package.** Any other language works
  through `extra:` without forking, which is the supported route; contributing a
  `lang/xx.typ` file is welcome but not required to use it.
- **Spanish means the conventions used in Spain.** Latin American usage differs in
  places (`tan` instead of `tg`, for one). That is what the override in `extra:`
  is for.

- **Unknown keys in `extra` are ignored silently.** `(es: (gdc: "MCD"))` — a typo
  for `gcd` — changes nothing and says nothing. Validating against the reference
  table would catch it, at the price of an error for anyone carrying a key from a
  newer version. Undecided.
- **Some Spanish words are a judgement call**: `csch` prints "csch" while `csc`
  prints "cosec" and `coth` "cotgh"; `deg` prints "deg" rather than "gr".
  Undecided whether to change them.

## Possible improvements (optional)

- **CI** that runs `just test` on the minimum compiler (0.14) and the current one.

- **More shipped languages** — French, German and Portuguese are the obvious
  next ones, and each is a file plus a line in `BUILTIN`.
- **A `set`-like helper** so a document can install the symbols once instead of
  binding `m` in every file. Not obviously possible without shadowing native
  names, which is exactly what this package refuses to do.

## Status

- **0.1.0** — published on Typst Universe on 2026-08-17 (`@preview/intl-math:0.1.0`,
  [typst/packages#5587](https://github.com/typst/packages/pull/5587)).
- **0.1.1** — fixed in the repository on 2026-10-12, **not yet published**. A
  published version is immutable, so the fixes below only reach users through a
  new PR to `typst/packages`.
  - [x] `extra` on a shipped language replaced its whole table instead of the
    listed keys: `intl(extra: (es: (tan: "tan")))` printed every other Spanish
    word in English, and a partial override of `en` printed bare keys
    (`liminf`, `mvt`, `pw-if`). The README promised the opposite. Now merged
    language by language.
  - [x] `lcm` takes its limits underneath, like Typst's native `lcm`.
  - [x] `liminf` / `limsup` use a thin space, like Typst's own (they were 1.45pt
    wider).
  - [x] `just test` no longer installs into the shared `@local` cache: the tests
    import `../lib.typ`. They now assert the fallback cascade, the overrides and
    parity with Typst's 39 native operators, instead of only compiling.
  - [ ] Tag `v0.1.1` and submit the PR (`packages/preview/intl-math/0.1.1/`).
  - [ ] Bump the import in `examkit` (`lib/notation.typ`) once it is published.
    Until then CURSOS and Evaluxia keep running 0.1.0, which is fine: they call
    `intl()` with no `extra`.
  - [ ] Manual pass on `TESTING.md` by the author (pending since 0.1.0).
