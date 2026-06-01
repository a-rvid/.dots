{ pkgs, lib, ... }: {
	imports = [
		./firefox.nix
		./dev.nix
		./nixvim.nix
		./gaming.nix
		./messaging.nix
		./desktop.nix
		./ssh.nix
	];
}
