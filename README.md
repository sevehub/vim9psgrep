# vim9psgrep
vim9psgrep is a Vim9script plugin that integrates the power of ripgrep with Vim, utilizing a PowerShell script as a wrapper. It provides a compiler that feeds search results directly into Vim's quickfix list, enhancing your code navigation and editing workflow.



## Features
- **Efficient Searching**: Utilizes ripgrep's performance for swift text searches.
- **Quickfix List Compilation**: Automatically populates the quickfix list with search results for easy access.
- **PowerShell Script Wrapper**: Bridges Vim and ripgrep through a custom PowerShell script.
- **Streamlined Workflow**: Navigate through search results within Vim effortlessly.

## Prerequisites
- Vim9script
- PowerShell
- ripgrep (rg.exe)

## Installation
Clone this repository into your Vim plugin directory to install vim9psgrep. Ensure you have all the prerequisites installed.

## Usage
Invoke vim9psgrep within Vim to search for text patterns:


:PsGrep <pattern>


Your search will compile results into the quickfix list for you to navigate through.

## Configuration
Customize vim9psgrep by setting options in your `.vimrc` file to fit your preferences.

## Notice
This repository is in the early stages of development and is not yet ready for general use. We are actively working on adding features and refining the project. Stay tuned for updates!


## Contributing
If you're interested in improving vim9psgrep, contributions are very welcome. Please submit pull requests or report any issues you encounter.

## License
vim9psgrep is open-sourced under the MIT License. For more details, see the LICENSE file in the repository.
