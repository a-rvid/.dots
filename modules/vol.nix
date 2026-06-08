{ pkgs, ... }:

let
  vol = pkgs.stdenv.mkDerivation {
    name = "vol";
    src = ../config;
    buildCommand = ''
      mkdir -p $out/bin
      cat > $out/bin/vol <<'EOF'
${builtins.readFile ../config/vol.sh}
EOF
      chmod +x $out/bin/vol
    '';
  };
in {
  environment.systemPackages = [
    vol
    pkgs.bc
    pkgs.libnotify
    # other packages...
  ];
}
