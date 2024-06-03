function lt --wraps='lsd -t' --wraps='lsd --tree' --description 'alias lt=lsd --tree'
  lsd --tree $argv
        
end
