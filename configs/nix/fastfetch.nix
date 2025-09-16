{
  host,
  isLinux,
}: rec {
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
  modules =
    (
      if logo.source == "raspbian_small"
      then [{type = "break";}]
      else []
    )
    ++ [
      {
        type = "host";
      }
      {
        type = "cpu";
      }
      {
        type = "memory";
      }
      {
        type = "disk";
        folders = "/";
      }
      {
        type = "os";
      }
    ]
    ++ (
      if isLinux
      then [{type = "localip";}]
      else []
    )
    ++ [
      {
        type = "packages";
      }
      {
        type = "uptime";
      }
    ];
}
