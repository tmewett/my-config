#!/usr/bin/env fish
$argv
if test -d private
    cd private
    $argv
end
