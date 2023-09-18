function ducks --wraps='du -cksh * | sort -rn | head' --description 'alias ducks=du -cksh * | sort -rn | head'
  du -cksh * | sort -rn | head $argv; 
end
