
{ config, lib, pkgs, ... }:

{

  environment.systemPackages = [ pkgs.android-tools pkgs.android-studio ];

  programs.adb.enable = true;
  users.users.nit.extraGroups = ["adbusers"];

}

