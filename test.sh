#!/bin/bash
set -u

sucessed() {
    printf "\033[32mSucessed\033[m\n"
}
faild() {
    printf "\033[31mFaild\033[m\n"
}
return_code=0

which zsh
echo "Start checking\n"

echo "Check zsh file"
for path in ".zshenv" ".zprofile" ".zshrc"
do
    echo -n "Loading $HOME/$path "
    output=$(zsh $HOME/$path)
    if [[ $? -eq 0 ]] ; then
        sucessed
    else
        return_code=1
        faild
        echo $output
    fi
done

printf "\nTest Finished\n"
printf "Result: "
if [[ $return_code -eq 0 ]] ; then
    sucessed
else
    faild
fi
exit $return_code
