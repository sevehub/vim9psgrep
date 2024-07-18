# vim9psgrep

vim9psgrep is a Vim9script plugin that integrates ripgrep with Vim, utilizing PowerShell scripts and Visual Basic popups. 




## Features
- **Efficient Searching**: Utilizes ripgrep's performance for swift text searches.
- **Quickfix List Compilation**: Automatically populates the quickfix list with search results for easy access.
- **PowerShell Script Wrapper**: Bridges Vim and ripgrep through a custom PowerShell script.

## Prerequisites
- Vim9script
- PowerShell (Desktop or Core)
- ripgrep (rg.exe)
- Serpl (serpl.exe) (Optional)
- Ast-Grep (Optional)

## Installation
```sh   
    Plug 'sevehub/vim9psgrep'
```

Set the PowerShell's version if > 5 (.vimrc):
<pre>
    let g:powershell_version = 7 ""legacy
    g:powershell_version = 7 #vim9script
</pre>
## Usage
Preset mapping:

 - `<leader>gw` -- Locate the word under the cursor. ( *g*rep *w*ord)
 - `<leader>gp` -- Open a popup to search files in the working directory tree. ( *g*rep *p*attern) 
 - `<leader>gr` -- Find and Replace ( *g*rep *r*eplace)
 - `<leader>ga` -- Find code pattern ( *g*rep *a*st)

Your search will compile results into the quickfix list for you to navigate through.


## Notice
This repository is in the early stages of development and is not yet ready for general use. We are actively working on adding features and refining the project. Stay tuned for updates!


## Contributing
If you're interested in improving vim9psgrep, contributions are very welcome. Please submit pull requests or report any issues you encounter.

## License
vim9psgrep is open-sourced under the MIT License. For more details, see the LICENSE file in the repository.
