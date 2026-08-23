# shellcheck shell=bash
#
# Product metadata shared by script/update-formula and script/sync-formula.
#
# load_product PRODUCT sets:
#   product_formula_path   formula path, relative to the repo root
#   product_release_repo   GitHub repo publishing the release assets
#   product_asset_prefix   release asset basename prefix
#   product_platforms      release asset platform suffixes, in formula order
#   product_labels         human-readable label per platform, same order

# URL of the release checksum manifest for version $1. Both scripts must agree on
# this exact URL, so the release-asset layout is owned here alongside the fields
# it is built from. Requires load_product to have run.
product_checksum_url() {
  printf '%s\n' \
    "https://github.com/$product_release_repo/releases/download/v$1/$product_asset_prefix-$1.sha256"
}

load_product() {
  local product="$1"

  case "$product" in
    runfree)
      product_formula_path="Formula/runfree.rb"
      product_release_repo="genged/runfree"
      product_asset_prefix="runfree"
      product_platforms=(darwin-arm64 darwin-x64)
      product_labels=("macOS arm64" "macOS Intel")
      ;;
    capshelf)
      product_formula_path="Formula/capshelf.rb"
      product_release_repo="genged/capshelf"
      product_asset_prefix="capshelf"
      product_platforms=(darwin-arm64 darwin-x64 linux-arm64 linux-x64)
      product_labels=("macOS arm64" "macOS Intel" "Linux arm64" "Linux x64")
      ;;
    *)
      return 1
      ;;
  esac
}
