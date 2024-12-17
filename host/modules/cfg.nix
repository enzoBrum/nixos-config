{config, pkgs, lib, ...}:
{
    options = with lib; {
      custom = {
	  hostName = mkOption {
	    type = types.str;
	    default = "enzoPC";
	  };
      };
    };
}
