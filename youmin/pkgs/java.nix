{ pkgs, ... }:
{
  home.packages = with pkgs; [
    zulu
  ];

  home.sessionVariables = {
    JAVA_HOME = "${pkgs.zulu}/Library/Java/JavaVirtualMachines/zulu-21.jdk/Contents/Home";
  };
}
