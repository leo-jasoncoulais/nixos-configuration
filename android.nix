
{ config, lib, pkgs, ... }:

{

  environment.systemPackages = [ pkgs.android-tools pkgs.android-studio ];
  users.users.nit.extraGroups = ["adbusers"];

}

