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

## Possible improvements (optional)

- **More shipped languages** — French, German and Portuguese are the obvious
  next ones, and each is a file plus a line in `BUILTIN`.
- **A `set`-like helper** so a document can install the symbols once instead of
  binding `m` in every file. Not obviously possible without shadowing native
  names, which is exactly what this package refuses to do.

## Before publishing to Typst Universe

- [x] Add a `LICENSE` file — the manifest declared MIT without shipping one,
  which is an automatic rejection. (2026-08-15)
- [x] `typst.toml`: add `repository` and `exclude`, and put the description in
  English. Categories `languages`/`text`, disciplines `mathematics`/`education`.
  (2026-08-15)
- [x] Translate the README to English. (2026-08-15)
- [x] Confirm the name `intl-math` is free in the Typst package index.
  (2026-08-15, checked against `packages.typst.org/preview/index.json`)
- [ ] Create the GitHub repository `13Stokes31/intl-math` (public) and push. The
  URL currently 404s, so `repository` in the manifest points nowhere yet.
- [ ] Manual pass on `TESTING.md`.
- [ ] Tag `v0.1.0` — the Universe bot wants README links to be permalinks, not
  `main`.
- [ ] Submit a PR to `typst/packages` (`packages/preview/intl-math/0.1.0/`),
  title `intl-math:0.1.0`.
