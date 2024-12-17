{config, pkgs, lib, ...}:
{
  options = with lib; {
    custom = {
      gitKey = mkOption {
	type = types.str;
      };
    };
  };
}
