  function gg --description 'A git log --graph --pretty [customed]'
    set -l arg_str "%h - %s"  # 기본 format 문자열 설정

    if set -q argv[1]
        switch $argv[1]
            case '-s'
                set arg_str ""  # -s 옵션이 주어지면 format 문자열을 비움
            case '*'
                # 다른 모든 경우, 사용자 입력으로 format 문자열을 변경
                set arg_str $argv
        end
    end

    # 결정된 format 문자열로 git log 명령 실행
    git log --graph --pretty --pretty=:$arg_str
end

