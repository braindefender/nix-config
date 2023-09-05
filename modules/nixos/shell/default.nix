{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    fzf     # CLI fuzzy-finder
    killall
    unzip
    # file
    jq      # CLI JSON processor
    # clac
    wget
    # TODO: move to Home Manager 
    zoxide  # a smarter cd command 
    # TODO: make settings for shell
    exa     # modern replacement for ls 
    ripgrep # recursive search for a regex in directory
    fd      # simple, fast and user-friendly alternative to `find`
  ];
}
