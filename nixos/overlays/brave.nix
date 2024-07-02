self: super: {
  brave = super.brave.overrideAttrs (oldAttrs: {
    postInstall = oldAttrs.postInstall + ''
      wrapProgram $out/bin/brave-browser \
        --add-flags "--enable-features=VaapiVideoDecodeLinuxGL" \
        --add-flags "--ignore-gpu-blocklist" \
        --add-flags "--enable-zero-copy" \
        --add-flags "--enable-features=UseOzonePlatform" \
        --add-flags "--ozone-platform=wayland"
    '';
  });
}