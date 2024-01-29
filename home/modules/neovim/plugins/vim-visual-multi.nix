{pkgs, ...}: 
let
    vim-visual-multi = pkgs.vimUtils.buildVimPlugin {
        name = "vim-visual-multi";
        src = pkgs.fetchFromGitHub {
            owner = "mg979";
            repo = "vim-visual-multi";
            rev = "e67f7fa011c98fc5426352d3bb06362a0f70af3c";
            sha256 = "sha256-rg2FLbnJfhRMdmOak+HSwkrNLbdn0YoV9ar74ylaUBQ=";
        };
    };
in
{
    # programs.neovim.plugins = [{ 
    #     plugin = vim-visual-multi;
    #     type = "vim";
    #     config = '' let g:VM_maps["Toggle Block"] = "" '';
    # }];
}
