#!/bin/sh
# 저장소의 설정 파일을 실제 경로(~/.config/...)에 연결한다. 매니페스트는 links.txt.
#
#   ./link.sh                  현재 플랫폼(mac / linux) 의 link 항목을 심링크
#   ./link.sh --dry-run        무엇을 할지만 출력 (--pull 과 함께 써도 된다)
#   ./link.sh --pull           pull 항목을 시스템 → 저장소로 복사해 온다
#   ./link.sh --unlink         이 스크립트가 걸었던 링크만 해제 (실파일은 건드리지 않음)
#   ./link.sh --platform=linux 플랫폼 강제 (WSL 은 linux 로 잡힌다)
#
# 모드 (links.txt 4번째 칸, 생략하면 link)
#   link : 저장소가 소유. 실제 경로에 심링크를 건다.
#   pull : 도구가 소유(예: DankMaterialShell 이 쓰는 niri config.kdl).
#          심링크를 걸면 도구가 저장할 때 심링크를 일반 파일로 갈아치우고,
#          다음 link.sh 실행에서 저장소 것이 다시 덮어써 도구의 변경이 날아간다.
#          그래서 pull 항목은 평소엔 건드리지 않고, --pull 일 때만 시스템 → 저장소로 복사한다.
#          복사 후 반드시 `git diff` 로 확인하고 커밋할 것.
#
# 규칙
# - 대상이 이미 올바른 링크면 건너뛴다
# - 대상이 실파일이면 절대 덮어쓰지 않고 <대상>.pre-link-<시각> 으로 옮겨둔다
# - 다른 곳을 가리키는 심링크는 데이터가 아니므로 백업 없이 교체한다
# - 저장소(link) / 시스템(pull) 쪽 원본이 없으면 SKIP
set -eu

here=$(cd "$(dirname "$0")" && pwd)
manifest="$here/links.txt"
dry=0
unlink=0
pull=0
platform=""

for a in "$@"; do
  case "$a" in
    --dry-run) dry=1 ;;
    --unlink) unlink=1 ;;
    --pull) pull=1 ;;
    --platform=*) platform=${a#*=} ;;
    -h|--help) sed -n '2,27p' "$0"; exit 0 ;;
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
echo "platform: $platform   repo: $here   mode: $([ "$pull" = 1 ] && echo pull || echo link)"

while read -r plat src dst mode; do
  case "$plat" in ''|'#'*) continue ;; esac
  [ "$plat" = all ] || [ "$plat" = "$platform" ] || continue
  mode=${mode:-link}

  src_abs="$here/$src"
  dst_abs=$(printf '%s' "$dst" | sed "s|^~|$HOME|")

  # ---- pull 모드: 시스템이 소유. --pull 일 때만 저장소로 복사해 온다 ----
  if [ "$mode" = pull ]; then
    if [ "$unlink" = 1 ]; then continue; fi
    if [ "$pull" = 0 ]; then
      echo "pull?  $dst (도구 소유 — --pull 로 저장소에 반영)"
      continue
    fi
    if [ ! -e "$dst_abs" ]; then
      echo "SKIP   $dst (시스템에 없음)"
      continue
    fi
    if [ -L "$dst_abs" ]; then
      echo "WARN   $dst 가 심링크다. 도구가 저장소 파일을 직접 고치고 있을 수 있다 — 확인할 것"
    fi
    if diff -r -q "$dst_abs" "$src_abs" >/dev/null 2>&1; then
      echo "same   $src"
      continue
    fi
    echo "pull   $src <- $dst"
    if [ "$dry" = 0 ]; then
      mkdir -p "$(dirname "$src_abs")"
      rm -rf "$src_abs"
      cp -R "$dst_abs" "$src_abs"
    fi
    continue
  fi

  # ---- link 모드 (기본): 저장소가 소유 ----
  if [ "$pull" = 1 ]; then continue; fi

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
