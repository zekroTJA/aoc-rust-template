C_GREY="\033[38;5;241m"
C_PINK="\033[38;5;198m"
C_RESET="\033[0m"

function run_day {
    if [ "$RELEASE" == "true" ]; then 
        TARGET=release
        RELEASE_FLAG="--release"
    else 
        TARGET=debug
    fi
    
    cargo build "$RELEASE_FLAG" -p "$1"

    echo -e "\n${C_GREY}----- Test Input -----${C_RESET}"
    if [ -f "$1/test_input.txt" ] && [ -z "$2" ]; then
        "./target/$TARGET/$1" --test
    fi

    echo -e "\n${C_GREY}----- Real Input -----${C_RESET}"
    echo -en "$C_PINK"
    "./target/$TARGET/$1" "$2"
    echo -en "$C_RESET"
}

if [ -z "$1" ] || [ "$1" == "--test" ]; then
    current_day=$(find . -maxdepth 1 -type d -name "day-*" | sort | tail -1 | cut -c 3-)
    run_day "$current_day" "$1"
else
    run_day "$(printf "day-%02d" "$1")" "$2"
fi