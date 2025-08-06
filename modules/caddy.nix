{ config, pkgs, ... }: {
  networking.firewall.allowedTCPPorts = [ 80 443 ];
  services.caddy = {
    enable = true;
    package = pkgs.caddy.withPlugins {
      plugins = [
        "github.com/caddy-dns/loopia@v1.0.0"
        "github.com/caddy-dns/cloudflare@v0.2.1"
      ];
      hash = "sha256-twZmWoa9IyPnzr9Z3Sg7cXG16AXMripe4HXlPbWElW8=";
    };
    logFormat = "level INFO ";
    extraConfig = ''
            (cloudflare) {
              tls {
      	  dns cloudflare L-5YBUUMXzw_JcQ-1ZUHB5tOxNE6PT4fdsMTN1le
      	}
            }
    '';
    virtualHosts = {
      "home.local.rapprocks.se".extraConfig =
        "  reverse_proxy http://10.100.0.27:3000\n  import cloudflare\n";
      "jellyfin.local.rapprocks.se".extraConfig =
        "    reverse_proxy http://10.100.0.68:8096\n    import cloudflare\n";
      "pve-dev-1.rapprocks.se".extraConfig = ''
        	  tls internal
                  reverse_proxy 10.100.0.55:8006 {
        	    transport http {
                      tls_insecure_skip_verify
        	    }
        	  }
        	'';
      "sonarr.homelab.local".extraConfig =
        "  tls internal\n  reverse_proxy 10.100.0.24:8989\n";
    };
  };
}
