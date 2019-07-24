_cleanup() {
    echo "     ...cleaning up"
    rm -rf _init
    echo "     ...init script removed"
    rm --"$0"
    exit 0
}