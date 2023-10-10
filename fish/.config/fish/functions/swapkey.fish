function swapkey --wraps='gpg-connect-agent "scd serialno" "learn --force" /bye' --description 'alias swapkey gpg-connect-agent "scd serialno" "learn --force" /bye'
  gpg-connect-agent "scd serialno" "learn --force" /bye $argv
        
end
