# Dusk Neovim

Dusk is a lightweight, aesthetically minimal neovim config written in lua with a special bent for java developers.

## Showcase

<img src="./showcase/dashboard.png" alt="Dashboard" title="Dashboard">
<img src="./showcase/javacode.png" alt="Javacode" title="Javacode">
<img src="./showcase/nvimtree.png" alt="Nvimtree" title="Nvimtree">

## Design Philosophy

Dusk aims to strike a middle ground between the one-size-fits-all configs, who try to squeeze as much functionality as possible, and super minimal configs such as nyoom.nvim (which is great and you should try it too).
But with a little preference towards minimalism. Like the Dusk, between dark and light, but towards dark!

The goal is to create an IDE experience with exactly the necessary functionalities (no more, no less). 

Dusk is designed against the following principles (inspired by doom-emacs):

- Gotta go fast. Startup and run-time performance are priorities.
- Aesthetic Minimalism. Clutter on the screen is to be avoided. No fancy colors either.
- Functional completeness. Minimalism does not sacrifice the full necessary functionality of an IDE.
- Intuitive, consistent keybinding. f = find, s = search, b = buffer etc.
- Extensibility. Code base that is understandable and commented where possible, to help you configure it to your needs.
- Close to metal. There's less between you and vanilla neovim by design. That's less to grok and less to work around when you tinker.
- Opinionated, but not stubborn. Dusk is about reasonable defaults and curated opinions, but use as little or as much of it as you like.

I encourage you to try out this config and adjust it to your preferences.

## Highlight Features

- Native LSP
- Syntax highlighting via nvim-treesitter
- Explore files via nvim-tree 
- Fuzzy finder via Telescope
- Zen mode for distraction-free coding.
- Notes with Markdown or Org mode.

## Colorschemes

Supported colorschemes are:

1. All base16 themes (default is twilight).
2. Doom-one.
3. All the colorschemes from https://github.com/LunarVim/Colorschemes.

Change colorscheme while editing by SPC f c.

Of course you can add any colorscheme you want!

## Dependencies

1. Neovim version >= 0.7.0
2. Git 2.23+
3. Ripgrep (for telescope)
4. Nodejs (for copilot)
5. Java 11 (for LSP)
6. A font with nerdfont icons (my suggestion: https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Hack)

NOTE: Run :checkhealth command to see what other dependencies you might be missing.

## Installation

| Platform | Supported |
|:--------:|:---------:|
|  Windows |     ❌    |
|   macOS  |     ✅    |
|   Linux  |     ✅    |

1. Make sure to remove or move your current `nvim` directory (`~/.config/nvim`), if it exists.
2. git clone https://github.com/imbacraft/dusk.nvim
3. Copy or Move the `nvim` folder to `~/.config/` 
4. Run the `nvim` command and wait for the plugins to be installed.
5. Reload `nvim` and run :PackerSync (SPC p s).
6. Ready to go!

## Directory Structure

1. The entry file is `init.lua`. 
2. The `lua` folder contains all the configuration.
3. The `lua.plugins.lua` file defines the plugins to be used. Add or remove plugins here.
4. The `lua.settings` folder contains the neovim settings and keybinds.
5. The `lua.plugins` folder contains the configuration files for all the plugins.
6. The `jars` folder contains the necessary jars for Java debugging and testing. If you want to build them from source yourself, see "Java Debugging and Testing" section.
7. The `ftplugin` folder contains the configuration files for the language servers. Currently only java is configured.

## Credits

1. Kudos to https://github.com/ChristianChiarulli/nvim for providing the configuration for the Java Language server.
2. Aesthetics for Dusk were inspired by https://github.com/shaunsingh/nyoom.nvim.

## Miscellaneous

### Java Debugging and Testing

Jars required for Java debugging and testing are included in the jars folder.
But if you want to build them yourself from source, do the following:
```
1. git clone https://github.com/microsoft/java-debug
2. cd java-debug/
3. ./mvnw clean install
```
```
1. https://github.com/Microsoft/vscode-java-test
2. cd vscode-java-test
3. npm install
4. npm run build-plugin
```
### JSON formatting

1. sudo apt install jq in Ubuntu/Debian 
2. sudo dnf install jq on Fedora/RHEL/CentOS
3. brew install jq in macOS
4. Type the vim command: ":%!jq ." on a json file.
5. Json file is formatted.
