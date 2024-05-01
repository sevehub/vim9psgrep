# vim9psgrep

vim9psgrep is a Vim9script plugin that integrates ripgrep with Vim, utilizing PowerShell scripts and Visual Basic popups. 

node
## Features
- **Efficient Searching**: Utilizes ripgrep's performance for swift text searches.
- **Quickfix List Compilation**: Automatically populates the quickfix list with search results for easy access.
- **PowerShell Script Wrapper**: Bridges Vim and ripgrep through a custom PowerShell script.

## Prerequisites
- Vim9script
- PowerShell (Desktop and Core)
- ripgrep (rg.exe)

## Installation
```sh   
    Plug 'sevehub/vim9psgrep'
```

## Usage
Preset mapping:

 - `<leader>gw` -- Locate the word under the cursor. ( *g*rep *w*ord)
 - `<leader>gp` -- Open a popup to search files in the working directory tree. ( *g*rep *p*attern) 


Your search will compile results into the quickfix list for you to navigate through.


## Notice
This repository is in the early stages of development and is not yet ready for general use. We are actively working on adding features and refining the project. Stay tuned for updates!


## Contributing
If you're interested in improving vim9psgrep, contributions are very welcome. Please submit pull requests or report any issues you encounter.

## License
vim9psgrep is open-sourced under the MIT License. For more details, see the LICENSE file in the repository.
