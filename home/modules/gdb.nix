{ config, pkgs, ... }: {
  xdg.configFile."gdb/gdbinit".text = ''
    python
    import sys
    sys.path.insert(0, '${pkgs.libgcc.lib}/share/gcc-${pkgs.libgcc.lib.version}/python')
    from libstdcxx.v6.printers import register_libstdcxx_printers
    register_libstdcxx_printers (None)
    end
  '';
}
