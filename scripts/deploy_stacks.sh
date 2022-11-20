function deployStackPrompt() {
    # Show user Availble Stacks (https://github.com/adamsiwiec1/stacks.git)
    echo ""
    echo "Available Stacks:"
    count=0
    for stack_compose_file in $stack_compose_files; do
        echo "$count) $stack_compose_file"
        count=$((count+1))
    done
    echo "Enter the # of the stack you would like to deploy or -# to tear it down."

    # Deploy Stack
    count=0
    for stack_compose_file in $stack_compose_files; do
        case $REPLY in
            $count) 
            echo "Deploying $stack_compose_file..."
            docker compose -f $stack_compose_file up -d
            ;;
            "-$count") 
            echo "Destroying $stack_compose_file..."
            docker compose -f $stack_compose_file down
        esac
        count=$((count+1))
    done
}

# Entrypoint: Find all *-compose.yml files in the stacks repo
cd stacks
stack_compose_files=$(find . -maxdepth 2 -name "*.yml" -type f -printf "%p ")

# Whule loop to deploy stacks
deployStackPrompt
while IFS= read -n3 -r -p "# to Deploy (-# to destroy):" && [[ $REPLY != q ]]; do
deployStackPrompt
done



