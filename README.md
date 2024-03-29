# Dusk Neovim

Dusk.nvim is a blazing fast Lua config suited for Full-stack Java development.

## Showcase

<img src="./showcase/dashboard.png" alt="Dashboard" title="Dashboard">
<img src="./showcase/javacode.png" alt="Javacode" title="Javacode">
<img src="./showcase/xmlcode.png" alt="xmlcode" title="xmlcode">

## Design Philosophy

A year after adopting a new code structure inspired by the powerful config of [nvimdots](https://github.com/ayamir/nvimdots), I decided to migrate dusk.nvim back to a simple, minimal structure, that I have the time to maintain.

The design principles of Dusk.nvim are as follows:

- Gotta go fast. Startup and run-time performance are priorities.
- Out-of-the-box complete. Just works with installation.
- Intuitive, consistent keybinding. f = find, s = search, b = buffer etc.
- Not opinionated. Striving for defaults wherever possible.

## Features

- Native LSP and autocompletion
- Syntax highlighting via nvim-treesitter
- Java code runner with jaq
- Java Unit Testing with vscode-java-test
- Java Debugging via nvim-dap
- Git integration with LazyGit
- Explore files via nvim-tree
- Fuzzy finder via Telescope
- Notes with Markdown
- Blazing fast performance

## Colorschemes

Supported colorschemes are:

1. Default - [Vscode](https://github.com/Mofiqul/vscode.nvim).
2. [Nightfox](https://github.com/EdenEast/nightfox.nvim)

Feel free to add your own colorschemes.
Most colorschemes will be compatible with Dusk.

## Dependencies

For Dusk.nvim to work as intended, you need to have the following dependencies installed:

1. Neovim version >= 0.9.0
2. Git 2.23+
3. Ripgrep for telescope
4. fd for telescope
5. Nodejs
6. Neovim node client (npm install -g neovim) - [neovim/node-client](https://github.com/neovim/node-client)
7. "zig", "clang", or "gcc" executables to be able to compile treesitter parsers (check your package manager for one of these)
8. Treesitter-cli nodejs module (Check your package manager for a treesitter or treesitter-cli package)
9. Java 17+ (for Java LSP server)
10. A font with nerdfont icons (my suggestion: <https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Hack>)
11. LazyGit if you are going to use it inside neovim.

NOTE: Run :checkhealth command to see what other dependencies you might be missing and to receive help if you have problems with installation.

## Installation

| Platform | Supported |
| :------: | :-------: |
| Windows  |    ✅     |
|  macOS   |    ✅     |
|  Linux   |    ✅     |

1. Make sure to remove or move your current `nvim` directory (`~/.config/nvim`), if it exists.
2. `git clone https://github.com/imbacraft/dusk.nvim`
3. Copy or Move the `nvim` folder from the cloned dusk.nvim project (not the dusk.nvim folder!) to your `~/.config/` folder.
   In the end, your folder should look like this: `~/.config/nvim`. Please note, depending on your OS, neovim might search for configuration in a different folder. In this case, run the `:checkhealth` command inside neovim, to see where it looks for configuration and place the nvim folder inside that.
4. Run the `nvim` command and wait for the plugins to be installed.
5. If some plugins fail to install at this point, don't be alarmed. Enter the `:qa!` command to exit neovim.
6. Re-run the `nvim` command and enter `SPC p s` to update the package manager.
7. Now all the plugins should have been installed. If some have not, run the `:checkhealth` command and check the dependencies section above to see what you might be missing.
8. Happy editing!


## Java Multiple Runtimes

In jdtls.lua, which you can find under the pluginconfigs folder, you can setup your Java runtimes.
The commented code for the runtimes is my own configuration.
Feel free to adjust it to your preferences.

My own config:

```lua
 path.runtimes = {
    --  {
    --   name = "JavaSE-1.8",
    --   path = "/Library/Java/JavaVirtualMachines/zulu-8.jdk/Contents/Home",
    --  },
    --  {
    --   name = "JavaSE-1.8",
    --   path = "/Library/Java/JavaVirtualMachines/jdk1.8.0_291.jdk/Contents/Home",
    --  },
    --  {
    --   name = "JavaSE-11",
    --   path = "/opt/homebrew/Cellar/openjdk@11/11.0.18/libexec/openjdk.jdk/Contents/Home",
    --  },
    --  {
    --   name = "JavaSE-19",
    --   path = "/opt/homebrew/Cellar/openjdk/19.0.2/libexec/openjdk.jdk/Contents/Home",
    --  },

    },
                

```
