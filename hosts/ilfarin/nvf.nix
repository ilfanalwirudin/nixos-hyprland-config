{pkgs, inputs, options, lib, ... }:

{

  nvf = {
    enable = true;
    settings = {

        vim.theme.enable = true;
        vim.theme.name = "gruvbox";
        vim.theme.style = "dark";


        vim.statusline.lualine.enable = true;
        vim.navigation.harpoon.enable = true;
        vim.autocomplete.enableSharedCmpSources = true;
        

        #Languages
        vim.languages.ts.enable = true;
        vim.languages.nix.enable = true;
        vim.languages.rust.enable = true;
        };

    };

}


