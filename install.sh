#!/bin/sh
# bctx installer
# Usage: curl -fsSL https://betterctx.com/install.sh | sh
# Or:    BCTX_VERSION=0.1.1 sh install.sh
set -e

REPO="better-ctx-org/bctx-releases"
INSTALL_DIR="${BCTX_INSTALL_DIR:-$HOME/.local/bin}"

# ── detect platform ────────────────────────────────────────────────────────────

OS=$(uname -s)
ARCH=$(uname -m)

case "$OS" in
  Darwin) OS_NAME="apple-darwin" ;;
  Linux)  OS_NAME="unknown-linux" ;;
  *)
    echo "Unsupported OS: $OS" >&2
    exit 1
    ;;
esac

case "$ARCH" in
  x86_64)  ARCH_NAME="x86_64" ;;
  aarch64|arm64) ARCH_NAME="aarch64" ;;
  *)
    echo "Unsupported architecture: $ARCH" >&2
    exit 1
    ;;
esac

# Linux: musl vs glibc
if [ "$OS" = "Linux" ]; then
  if ldd --version 2>&1 | grep -q musl; then
    TARGET="${ARCH_NAME}-${OS_NAME}-musl"
  else
    TARGET="${ARCH_NAME}-${OS_NAME}-gnu"
  fi
else
  TARGET="${ARCH_NAME}-${OS_NAME}"
fi

# ── resolve version ────────────────────────────────────────────────────────────

if [ -n "$BCTX_VERSION" ]; then
  VERSION="$BCTX_VERSION"
else
  VERSION=$(curl -fsSL "https://api.github.com/repos/${REPO}/releases/latest" \
    | grep '"tag_name"' | sed 's/.*"v\([^"]*\)".*/\1/')
  if [ -z "$VERSION" ]; then
    echo "Could not determine latest version. Set BCTX_VERSION to install a specific version." >&2
    exit 1
  fi
fi

echo "Installing bctx ${VERSION} for ${TARGET}..."

# ── download + verify ──────────────────────────────────────────────────────────

ARCHIVE="bctx-${VERSION}-${TARGET}.tar.gz"
BASE_URL="https://github.com/${REPO}/releases/download/v${VERSION}"
TMP=$(mktemp -d)

curl -fsSL "${BASE_URL}/${ARCHIVE}" -o "${TMP}/${ARCHIVE}"
curl -fsSL "${BASE_URL}/SHA256SUMS" -o "${TMP}/SHA256SUMS"

cd "$TMP"
if command -v sha256sum >/dev/null 2>&1; then
  grep "${ARCHIVE}" SHA256SUMS | sha256sum -c -
elif command -v shasum >/dev/null 2>&1; then
  grep "${ARCHIVE}" SHA256SUMS | shasum -a 256 -c -
else
  echo "Warning: cannot verify checksum (no sha256sum or shasum)" >&2
fi

# ── install ────────────────────────────────────────────────────────────────────

tar -xzf "${ARCHIVE}"
mkdir -p "$INSTALL_DIR"
mv bctx "$INSTALL_DIR/bctx"
if [ -f bctx-cloud ]; then
  mv bctx-cloud "$INSTALL_DIR/bctx-cloud"
fi
chmod +x "$INSTALL_DIR/bctx"

cd - >/dev/null
rm -rf "$TMP"

# ── PATH hint ─────────────────────────────────────────────────────────────────

case ":$PATH:" in
  *":$INSTALL_DIR:"*) ;;
  *)
    echo ""
    echo "Add $INSTALL_DIR to your PATH:"
    echo "  echo 'export PATH=\"\$PATH:$INSTALL_DIR\"' >> ~/.zshrc  # or ~/.bashrc"
    ;;
esac

# ── post-install ───────────────────────────────────────────────────────────────

echo ""
echo "bctx ${VERSION} installed to ${INSTALL_DIR}/bctx"
echo ""

if command -v "$INSTALL_DIR/bctx" >/dev/null 2>&1; then
  echo "Configuring bctx for installed AI agents..."
  "$INSTALL_DIR/bctx" init 2>/dev/null || true
  echo ""
fi

echo "Run 'bctx doctor' to verify your installation."
