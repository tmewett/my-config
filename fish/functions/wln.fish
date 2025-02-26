function wln --wraps ln
    MSYS="$MSYS winsymlinks:nativestrict" ln $argv
end
