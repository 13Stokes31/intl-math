# List the available tasks
default:
    @just --list

local_pkg_dir := env_var('HOME') + "/.local/share/typst/packages/local"

# Install as @local/intl-math:0.1.0 (after editing lib.typ or lang/). The
# exclusions mirror the `exclude` in typst.toml, so the local copy is exactly
# the bundle that gets published.
install:
    rsync -a --delete --mkpath --exclude tests --exclude .git --exclude justfile \
      --exclude ROADMAP.md --exclude TESTING.md \
      ./ {{local_pkg_dir}}/intl-math/0.1.0/
    @echo "  intl-math installed into the local package cache"

# Compile the tests: both languages side by side, and the fallback cascade
test: install
    typst compile --root . tests/smoke.typ tests/smoke.pdf
    typst compile --root . tests/fallback.typ tests/fallback.pdf
    @echo "  ✓ smoke (en/es/fr) and fallback (unknown language, partial table, override)"
