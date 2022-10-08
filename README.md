# Dusk Neovim

Dusk is a lightweight, aesthetically minimal Neovim config, written in Lua, able to provide for web and Java development. 

## Showcase

<img src="./showcase/dashboard.png" alt="Dashboard" title="Dashboard">
<img src="./showcase/javacode.png" alt="Javacode" title="Javacode">
<img src="./showcase/xmlcode.png" alt="xmlcode" title="xmlcode">

## Design Philosophy

Dusk aims to strike a middle ground between the one-size-fits-all configs, who try to squeeze as much functionality as possible, and minimal configs such as nyoom.nvim. However, it maintains a little preference towards minimalism. Like the Dusk, between dark and light, but towards dark!

The goal is to create an IDE experience with exactly the necessary functionalities (no more, no less). 

Dusk is designed against the following principles (inspired by doom-emacs):

- Gotta go fast. Startup and run-time performance are priorities.
- Aesthetic Minimalism. Clutter on the screen is to be avoided.
- Functional completeness. Minimalism does not sacrifice the full necessary functionality of an IDE.
- Intuitive, consistent keybinding. f = find, s = search, b = buffer etc.
- Extensibility. Code base that is understandable and commented where possible, to help you configure it to your needs.
- Close to metal. There's less between you and vanilla neovim by design. That's less to grok and less to work around when you tinker.
- Opinionated, but not stubborn. Dusk is about reasonable defaults and curated opinions, but use as little or as much of it as you like.

I encourage you to try out this config and adjust it to your preferences.

## Features

- Native LSP and autocompletion
- Syntax highlighting via nvim-treesitter
- Java code runner with jaq
- Java Maven commands with the help of neoterm
- Java Unit Testing with vscode-java-test
- Explore files via nvim-tree 
- Fuzzy finder via Telescope
- Zen mode for distraction-free coding
- Notes with Markdown

## Colorschemes

Supported colorschemes are:

1. Nightfox themes (https://github.com/EdenEast/nightfox.nvim) - Default is carbonfox.
2. All the colorschemes from https://github.com/LunarVim/Colorschemes. 
3. All base16 themes.
4. Doom-one (port from doom-emacs).

Change colorscheme while editing by SPC f c.
Change default colorscheme in colorscheme.lua file.

## Dependencies

For Dusk.nvim to work as intended, you need to have the following dependencies installed:

1. Neovim version >= 0.8.0
2. Git 2.23+
3. Ripgrep (for telescope)
4. Nodejs (for copilot and treesitter)
5. Gcc package to be able to compile treesitter parsers (check your package manager for a gcc package)
6. Treesitter-cli nodejs module (Check your package manager for a treesitter or treesitter-cli package)
7. Java 11 (for Java LSP server)
8. A font with nerdfont icons (my suggestion: https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Hack)

NOTE: Run :checkhealth command to see what other dependencies you might be missing and to receive help if you have problems with installation.

## Installation

| Platform | Supported |
|:--------:|:---------:|
|  Windows |     ❌    |
|   macOS  |     ✅    |
|   Linux  |     ✅    |

1. Make sure to remove or move your current `nvim` directory (`~/.config/nvim`), if it exists.
2. git clone https://github.com/imbacraft/dusk.nvim
3. Copy or Move the `nvim` folder from the cloned dusk.nvim project to your `~/.config/` folder. 
4. Run the `nvim` command and wait for the plugins to be installed.
5. Enter the :qa! command to exit `nvim`.
6. Re-run the `nvim` command and run :PackerSync (SPC p s).
7. Ready to go!

## Directory Structure

1. The entry file is `init.lua`. 
2. The `lua` folder contains all the configuration.
3. The `lua.plugins.lua` file defines the plugins to be used. Add or remove plugins here.
4. The `lua.settings` folder contains the neovim settings and keybinds.
5. The `lua.plugins` folder contains the configuration files for all the plugins.
6. The `jars` folder contains the necessary jars for Java debugging and testing. If you want to build them from source yourself, see "Java Debugging and Testing" section.
7. The `ftplugin` folder contains the configuration files for the language servers. Currently only java is configured.

## Credits

Kudos to https://github.com/ChristianChiarulli/nvim for providing the configuration for the Java Language server.

## Miscellaneous

### Java Debugging and Testing

The jars required for Java debugging and testing are included in the jars folder.
However, if you want to build them yourself from source, do the following:

```
1. git clone https://github.com/microsoft/java-debug
2. cd java-debug/
3. ./mvnw clean install
```
```
1. git clone https://github.com/Microsoft/vscode-java-test
2. cd vscode-java-test
3. npm install
4. npm run build-plugin
```
## Changelog

### 1.00

Release

### 1.01 (10.07.2022)

1. Introduced keymaps for window navigation
2. Don't lazyload telescope
3. Set Telescope find files to search for hidden files also.

### 1.02 (31.07.2022)


1. Removed Surround plugin as unneccesary.
2. Additional keymap for "gcc" to comment.
3. Modified search in buffer and search in Project keymaps (NEW: SPC s b, SPC s p)
4. Updated lsp handlers and null-ls config.

### 1.03 (20.08.2022)

1. Fixed deprecated variables in bufferline.lua.
2. Added SPC SPC keymap for find file (for emacs users).
3. Added SPC f p keymap for find projects.
4. Added SPC b k and K for close current buffer and close all buffers respectively.

### 1.04 (20.09.2022)

1. Added BufOnly plugin for better mass buffer closure performance.
2. Added more ensured installed treesitter parsers (json, javascript, css, typescript, bash, python)

### 1.1 (24.09.2022) - Major update

1. Migrated to mason.nvim (https://github.com/williamboman/mason.nvim/) from nvim-lsp-installer.
2. Added jaq code runner (https://github.com/is0n/jaq-nvim), which can be used to run Java files (SPC + j + r).
3. Added Neoterm to run terminal commands in a new buffer.
4. Added keymaps to run Maven commands (SPC + m).
5. Added https://github.com/vuciv/vim-bujo plugin for easy Project Agenda management with markdown files and created related keymaps (SPC + a).
6. Added markdown preview plugin.
7. Added autosave plugin (https://github.com/Pocco81/auto-save.nvim).
8. Changed default colorscheme (carbonfox).
9. Show absolute code line numbers by default.
10. Cleaned up many old keymaps (ex. shift + Q).

### 1.11 (05.10.2022)

1. Fixed deprecated client.resolved_capabilities.document_formatting in lsp handler.
2. Removed filetype.lua plugin since it has become native in Neovim v.8.0.
3. Added treesitter textobjects (https://github.com/nvim-treesitter/nvim-treesitter-textobjects) for better selection experience.
4. Cleaned null-ls config and added shell script formatting.
