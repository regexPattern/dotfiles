host: {
  logo = {
    source =
      {
        "carlos-macbook-pro" = "macos_small";
        "carlos-inspiron" = "linux_small";
        "carlos-rapsberry-pi" = "raspbian_small";
      }.${
        host
      };
    padding.left = 1;
  };
  modules = [
    {
      type = "host";
      key = "HOST";
    }
    {
      type = "cpu";
      key = "CPU";
    }
    {
      type = "gpu";
      key = "GPU";
    }
    {
      type = "memory";
      key = "MEMORY";
    }
    {
      type = "disk";
      key = "DISK";
      folders = "/";
    }
    {
      type = "os";
      key = "OS";
    }
    {
      type = "packages";
      key = "PACKAGES";
    }
    {
      type = "shell";
      key = "SHELL";
    }
  ];
}
