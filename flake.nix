{
  description = "Typst Japanese report writing environment";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        jaFonts = with pkgs; [
          source-han-serif
          source-han-sans
          jetbrains-mono
        ];
        fontPaths = pkgs.lib.concatStringsSep ":" (
          map (p: "${p}/share/fonts") jaFonts
        );
      in
      {
        devShells.default = pkgs.mkShell {
          name = "typst-ja";
          packages = with pkgs; [
            typst
            tinymist
          ] ++ jaFonts;
          shellHook = ''
            export TYPST_FONT_PATHS="${fontPaths}"
            unset SOURCE_DATE_EPOCH
          '';
        };
      }
    );
}
