{ pkgs, ... }:
{
  programs.password-store = {
    enable = true;
    package = pkgs.pass.withExtensions (es: with es; [
      pass-otp
      pass-update
    ]);
  };
}
