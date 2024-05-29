# neovim + neovide personal config

## setup

Up to date packages for ubuntu (git version):

    $ sudo add-apt-repository ppa:neovim-ppa/unstable
    $ sudo apt update
    $ sudo apt install neovim

Install of neovide, require rustc:

    $ cargo install --git https://github.com/neovide/neovide/ 

The binary will be installed in ~/.cargo/bin/neovide, check that it is in your $PATH environment variable.
A shell alias can be useful:

    alias nv="neovide --fork"

Some dependencies are required for the modules of my configuration:

    $ sudo apt install fzf ripgrep clangd


Clone the configuration:

    $ git clone https://github.com/wlallemand/nvim-config ~/.config/nvim/


Then you can run `nvim` in console or `neovide` for the graphic interface.

