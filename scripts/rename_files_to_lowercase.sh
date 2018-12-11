#!/bin/bash
#print usage
# Credit:
#   https://www.tecmint.com/rename-all-files-and-directory-names-to-lowercase-in-linux/

if [ -z "$1" ];then
        echo "Usage :$(basename "$0") parent-directory"
        exit 1
fi

#process all subdirectories and files in parent directory
all="$(find "$1" -depth)"



for name in ${all}; do
        #set new name in lower case for files and directories
        new_name="$(dirname "${name}")/$(basename "${name}" | tr '[:upper:]' '[:lower:]')"

        #check if new name already exists
        if [ "${name}" != "${new_name}" ]; then
                [ ! -e "${new_name}" ] && mv -T "${name}" "${new_name}"; echo "${name} was renamed to ${new_name}" || echo "${name} wasn't renamed!"
        fi
done

echo
echo
#list directories and file new names in lowercase
echo "Directories and files with new names in lowercase letters"
find "$(echo "$1" | tr '[:upper:]' '[:lower:]')" -depth

exit 0
