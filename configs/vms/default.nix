let
  hostname = "nixbox";

  rdevilleDefault = {
    hostname = hostname;
    username = "rdeville";
    presets = {
      sudo = true;
      main = true;
      game = true;
      server = true;
      work = true;
    };
  };

  rdevilleGUI =
    rdevilleDefault
    // {
      presets =
        rdevilleDefault.presets
        // {
          gui = true;
        };
    };

  vmUsers = gui: {
    "rdeville" = (
      if gui
      then rdevilleGUI
      else rdevilleDefault
    );
  };

  nixVM = builtins.listToAttrs (
    builtins.map (vmCfg: {
      name =
        if vmCfg.graphics
        then "c${builtins.toString vmCfg.cpus}-r${builtins.toString vmCfg.ram}-g1"
        else "c${builtins.toString vmCfg.cpus}-r${builtins.toString vmCfg.ram}-g0";
      value = {
        presets = {
          gui = vmCfg.graphics;
          main = true;
          game = true;
          server = true;
          work = true;
        };
        users = vmUsers vmCfg.graphics;
        vms = {disk = defaultDisk;} // vmCfg;
        hostname = hostname;
      };
    })
    data
  );

  defaultDisk = 50;
  data = [
    {
      cpus = 1;
      ram = 2;
      graphics = false;
    }
    {
      cpus = 2;
      ram = 4;
      graphics = false;
    }
    {
      cpus = 4;
      ram = 8;
      graphics = false;
    }
    {
      cpus = 1;
      ram = 2;
      graphics = true;
    }
    {
      cpus = 2;
      ram = 4;
      graphics = true;
    }
    {
      cpus = 4;
      ram = 8;
      graphics = true;
    }
  ];
in
  nixVM
