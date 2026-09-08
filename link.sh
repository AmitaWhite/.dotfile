#!/bin/sh
# 저장소 안의 설정 파일을 실제 경로에 심링크로 건다. 매니페스트는 links.txt.
#
#   ./link.sh                 현재 플랫폼(mac / linux) 항목을 전부 링크
#   ./link.sh --dry-run       무엇을 할지만 출력
#   ./link.sh --unlink        이 스크립트가 걸었던 링크 해제 (실파일은 건드리지 않음)
#   ./link.sh --platform=linux   플랫폼 강제 (WSL 은 linux 로 잡힌다)
#
# 규칙
# - 대상이 이미 올바른 링크면 건너뛴다
# - 대상이 실파일/다른 링크면 절대 덮어쓰지 않고 <대상>.pre-link-<시각> 으로 옮겨둔다
# - 저장소 쪽 파일이 없으면 SKIP (오타 방지)
set -eu

here=$(cd "$(dirname "$0")" && pwd)
manifest="$here/links.txt"
dry=0
unlink=0
platform=""

for a in "$@"; do
  case "$a" in
    --dry-run) dry=1 ;;
    --unlink) unlink=1 ;;
    --platform=*) platform=${a#*=} ;;
    -h|--help) sed -n '2,12p' "$0"; exit 0 ;;
    *) echo "unknown option: $a" >&2; exit 2 ;;
  esac
done

if [ -z "$platform" ]; then
  case "$(uname -s)" in
    Darwin) platform=mac ;;
    Linux) platform=linux ;;
    *) echo "unsupported OS: $(uname -s)" >&2; exit 1 ;;
  esac
fi

stamp=$(date +%Y%m%d-%H%M%S)
echo "platform: $platform   repo: $here"

while read -r plat src dst; do
  case "$plat" in ''|'#'*) continue ;; esac
  [ "$plat" = all ] || [ "$plat" = "$platform" ] || continue

  src_abs="$here/$src"
  dst_abs=$(printf '%s' "$dst" | sed "s|^~|$HOME|")

  if [ ! -e "$src_abs" ]; then
    echo "SKIP   $src (저장소에 없음)"
    continue
  fi

  if [ "$unlink" = 1 ]; then
    if [ -L "$dst_abs" ] && [ "$(readlink "$dst_abs")" = "$src_abs" ]; then
      echo "unlink $dst"
      [ "$dry" = 1 ] || rm "$dst_abs"
    fi
    continue
  fi

  if [ -L "$dst_abs" ] && [ "$(readlink "$dst_abs")" = "$src_abs" ]; then
    echo "ok     $dst"
    continue
  fi

  if [ -L "$dst_abs" ]; then
    # 다른 곳(또는 이제 없는 곳)을 가리키는 심링크 — 데이터가 아니므로 백업 없이 교체
    echo "relink $dst (was -> $(readlink "$dst_abs"))"
    [ "$dry" = 1 ] || rm "$dst_abs"
  elif [ -e "$dst_abs" ]; then
    echo "backup $dst -> $dst.pre-link-$stamp"
    [ "$dry" = 1 ] || mv "$dst_abs" "$dst_abs.pre-link-$stamp"
  fi

  echo "link   $dst -> $src"
  if [ "$dry" = 0 ]; then
    mkdir -p "$(dirname "$dst_abs")"
    ln -s "$src_abs" "$dst_abs"
  fi
done < "$manifest"
