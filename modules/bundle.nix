{ pkgs, lib, ... }: {
	imports = [
		./macchanger.nix
		./dev.nix
		./gaming.nix
		./messaging.nix
		./desktop.nix
		./ssh.nix
	];
}
