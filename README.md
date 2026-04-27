# 주요 사항

## Nvim 설정

- lazyvim starter 로 시작했기 때문에, plugin 설정 같은 게 미리 ~/.local/share/nvim/ 아래에 잡혀있음
- 예를 들어, > which-key 플러그인에 잡혀있는 keymap 들은, lua/config/keymap.lua 에 작성해야 overriding 됨
- rg , fd, 등 몇몇 패키지를 설치해줘야함 (checkHealth 돌려볼것)
  - 설치 패키지
    1. rg
    2. fd
    3. curl
    4. git
    5. lazygit
    6. fzf - find grep file
       ... else
    7. {image}magick (image render)
       - 이거 있어야 nvim 에서 이미지,pdf 렌더링 해줌
    8. eza (lsd 비슷한 건데, git 상태 보기 기능 좋음)

## 환경 설정

- bat , tldr, yazi, zed(linux는 zeditor라는 이름일 수 있음) 설치
- fisher 설치 (fish 설정 프레임웤)
- sdkman 설치

---

## 유용한 TUI Program

- harlequin : SQLite 전용 간단한 TUI 뷰어 ,에디터

```sh
uv tool install squall-sql
```

- Shellbeats : 유튜브 음악 검색 및 다운로더 - 검색후 git 참조.

```sh
# git clone 해서 tmp 같은 임시 디렉토리로 옮겨줌
make
make install
```

- helix : rust로 만든 text editor

- ghostty : shell 에뮬레이터, 좋음

- taproom : mac homebrew TUI 관리 (검색 및 인스톨 여부 등)

- silicon : Code 를 image로 잘 만들어줌! (한글을 못씀)

- presenterm : 터미널 기반(md파일로) 프레젠 테이션 구성
  - slides : 프레젠테이션 가벼운

- nushell : 데이터 가공용(env, ls, json, html 보기 등) 강력한 shell

- zoxide : cd를 되게 편하게 해줌

- hyperfine : 벤치마크 도구

- tukai : 타이핑 연습

- tokei : Count 코드,파일들

- paneru : maxOS 용 niri 같은 윈도우 타일링
  - 이거 안 쓰는 게 낫겠다 Niri 만큼 부드럽지 않음

- duf : 디스크 용량 이쁘게 보여줌

- orbstack : colima 보다 좀 더 나은 맥 가상화 (docker 같은 거 쓸때)

- mole : 디스크 분석 및 정리 (CleanMyMac 같은거)

- celluid (셀룰로이드) : 예전 Gnome MPV player 인데, 리눅스에서 쓸 용도
