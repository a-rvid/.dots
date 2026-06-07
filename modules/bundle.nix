{ pkgs, lib, ... }: {
	imports = [
		./firefox.nix
		./macchanger.nix
		./dev.nix
		./nixvim.nix
		./gaming.nix
		./messaging.nix
		./desktop.nix
		./ssh.nix
	];
}
