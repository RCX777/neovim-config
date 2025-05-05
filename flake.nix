{
  description = "My Neovim configuration";

  outputs = { self }: {
    # Export the config directory as-is for use in other flakes
    neovimConfig = self + /.;
  };
}

