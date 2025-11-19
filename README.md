# 주요 사항

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

> **TODO**
>  - [x] : terminal 설정
>  - [] : lsp 분리 및 설정
