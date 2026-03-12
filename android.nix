
{ config, lib, pkgs, ... }:

{

  programs.adb.enable = true;
  users.users.nit.extraGroups = ["adbusers"];

  environment.systemPackages = [ pkgs.android-tools pkgs.android-studio ];

}

