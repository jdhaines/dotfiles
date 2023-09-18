function flushdns --wraps='sudo resolvectl flush-caches' --description 'alias flushdns=sudo resolvectl flush-caches'
  sudo resolvectl flush-caches $argv
        
end
