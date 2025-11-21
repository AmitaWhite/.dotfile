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
    6. fzf
       ... else

## 환경 설정

- bat , tldr 설치
- fisher 설치 (fish 설정 프레임웤)
- sdkman 설치

---

# **TODO**

- [x] : terminal 설정
- [x] : lsp 분리 및 설정 -> result -> 어느정도 이해해서, 이제 jdtl 같은거 추가하면서 파일 구조 보강해야할듯
