# My portable config. System-specific goes in ../config.fish

set MSYS2_ENV_CONV_EXCL "$MSYS2_ENV_CONV_EXCL;GEM_PATH"

# reset to default in case it was set in a parent
set -e MSYS2_ARG_CONV_EXCL

abbr -a -- xc x code
abbr -a -- lg wt lazygit
abbr -a -- e. explorer .
