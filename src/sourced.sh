
if [[ "${BASH_SOURCE[0]}" != "${0}" ]]; then
    # sourced
else
    # ...
fi

# exit from script:
#   [ $S ] && return <x> || exit <x>
#   but this looks better
#   return <x> 2> /dev/null || exit <x>

