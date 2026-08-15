# Listar tareas
default:
    @just --list

local_pkg_dir := env_var('HOME') + "/.local/share/typst/packages/local"

# Instalar como @local/intl-math:0.1.0 (tras editar lib.typ o lang/)
install:
    rsync -a --delete --mkpath --exclude tests --exclude .git --exclude justfile \
      --exclude ROADMAP.md --exclude TESTING.md \
      ./ {{local_pkg_dir}}/intl-math/0.1.0/
    @echo "  intl-math instalado en la caché local"

# Compilar los tests: los 3 idiomas + la cascada de respaldo
test: install
    typst compile --root . tests/smoke.typ tests/smoke.pdf
    typst compile --root . tests/fallback.typ tests/fallback.pdf
    @echo "  ✓ smoke (es/en/fr) y fallback (idioma desconocido, tabla incompleta, override)"
