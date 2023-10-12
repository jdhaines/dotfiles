function release --wraps='cat /etc/*release*' --description 'alias release cat /etc/*release*'
  cat /etc/*release* $argv
        
end
