# 주요 추가 설정 및 변경

> **arch linux** with \*\*caelestia-dot shell [git][https://github.com/caelestia-dots/caelestia]
> 설정 중
> caelestia-dot shell 설정 후 hyperland 세션에 초기 진입해서 foot(Terminal Emulator)을 열면
> 시스템은 bash 를 쓰지만, session 자체는 fish 를 쓴다.
>
> - caelestia-git에서 clone 후(install.fish) 를 실행 하기 전에 이미 다운 받았을 것, 추가 Dependencies 도
> - 기입되어 있으니 학인 가능

1. 한글 입력
2. locale 설정
3. 추가 lazyvim(nvim) 설정 변경
4. wifi 연결

## 1. 한글 입력

기본적으로 한글 폰트가 없기 때문에 한글 폰트 다운 및 fcitx5 입력 변환 툴을 사용

- 추가적으로 fcitx5 입력기를 auto-start 해 줄 필요 있음
- (2025.11.09) 클론 후 경로 (~/.config/hypr) 아래에 설정 파일들이 있다.

hyperland.conf 파일 제일 밑에

```
exec-one = fcitx5 &
```

입력 해 주자

## 2. locale 설정

- locale.conf 파일 중 화씨(F) -> 섭씨(C) 표현을 위해

```
LC_MEASUREMENT=ko_KR.UTF-8
```

- 시간이 왠지 한자로 뜨면 힙하니까

```
LC_TIME=ja_JP.UTF-8
```

- 그리고 locale.gen(시스템이 사용 할 수 있게 컴파일하는 locale-gen) 명령어 사용을위해
- (en_US.UTF-8 , ja_JP.UTF-8 , ko_KR.UTF-8) 을 주석 해제 해 주자

## 3. 추가 lazyvim(nvim) 설정 변경

- caelestia-dot shell 에는 배경 전체 색깔에 따라 GUI 색상값을 다양한 팔레트로 변경 해 준다
- (브라우저 다크모드, 라이트모드 처럼 시스템 값 [prefer-dark , prefer-white] 를 가져오나봄
- 이를 nvim에도 전해주기 위해서
- 1. 내 nvim 플러그인 설정 파일 아래 (colorscheme.lua , lualine.lua) 생상 변경이 필요한 부분에 해당 값을 전해주었다.
- 2. 또 nvim-tree.lua 에 임시로 배경 색을 전부 투명으로 바꿔주었다. (터미널이 기본 blur 되어 있어서)

## 4. network wifi 확인 및 연결

- 이게 아래 명령어로 cli 에서 확인이 되는데, GUI 환경에서 클릭으로 뭔가 연결이 잘 안되는 것 같다. (polkit 무슨 인증 데몬?)
- 일단 아래로 연결 해 보자

```fish
sudo systemctl status NetworkManager #네트워크 매니저 프로세스 확인
sudo systemctl start NetworkManager.service # NM 데몬 실행
nmcli device wifi list # wifi 리스트 확인
nmcli device wifi connection [your wifi name - ssid] paswword [your wifi passowrd - password]
```

# 여기서 부터 추가

- fish 파일 아래에 abbr 부분 잘 읽어보고 안 맞는거 삭제
- starship 으로 설정하기 위해서 몇가지 Dependencies 확인필요
