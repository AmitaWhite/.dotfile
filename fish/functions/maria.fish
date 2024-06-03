function maria --wraps='docker exec -it mariadb mariadb-uroot -p' --description 'alias maria=docker exec -it mariadb mariadb-uroot -p'
  docker exec -it mariadb mariadb-uroot -p $argv
        
end
