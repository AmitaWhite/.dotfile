function gg --description 'A git log --graph --pretty [customized] with optional branch'
    set -l arg_str "%h - %s"  # 기본 format 문자열 설정
    set -l branch "HEAD"      # 기본적으로 현재 브랜치를 사용

    for arg in $argv
        if test $arg = "-s"
            set arg_str ""  # -s 옵션이 주어지면 format 문자열을 비움
        else if git rev-parse --verify --quiet "refs/heads/$arg" || git rev-parse --verify --quiet "refs/remotes/origin/$arg"
            set branch $arg  # 로컬 또는 리모트 브랜치로 설정
        else
            set arg_str $arg  # 포맷 문자열로 설정
        end
    end

    # git log 명령 실행 (브랜치 및 format 문자열 적용)
    git log --graph --pretty=format:"$arg_str" $branch
end
