[![forthebadge](https://forthebadge.com/images/badges/contains-cat-gifs.svg)](https://forthebadge.com)

# Search Replace

## Make this script exicutable

`chmod 755 search-replace.sh`

Script is placed in the parent folder of items you want to search and replace. First it loops though all folders, once it finds the file in the folder with your given extension, it then loops though the lines of code till it finds the search pattern, it then replaces the search pattern with your replacement.

1. Place script in parent folder
2. Run `bash search-replace` in terminal
3. Follow prompts

### File extension

Add the file extension you wanna search for, i.e `html, txt, md`

### Search pattern

This can be regular text or a regex, remember to escape characters e.g. `<\/style>`

### Replace with

The content you wanna replace, remember to escape characters e.g. `<\/style>`
