_ : {
  programs.aerospace = {
    enable = false;
    launchd.enable = true;
    settings = {
      start-at-login = true;
      mode.main.binding = {
        alt-h = "focus left";
        alt-j = "focus down";
        alt-k = "focus up";
        alt-l = "focus right";

        alt-shift-h = "move left";
        alt-shift-j = "move down";
        alt-shift-k = "move up";
        alt-shift-l = "move right";

        alt-1 = "workspace 1";
        alt-2 = "workspace 2";
        alt-3 = "workspace 3";
        alt-4 = "workspace 4";
        alt-5 = "workspace 5";
        alt-6 = "workspace 6";
        alt-7 = "workspace 7";
        alt-8 = "workspace 8";
        alt-9 = "workspace 9";
        alt-a = "workspace A";
        alt-b = "workspace B";
        alt-c = "workspace C";
        alt-d = "workspace D";
        alt-e = "workspace E";
        alt-f = "workspace F";
        alt-g = "workspace G";
        alt-m = "workspace M";
        alt-n = "workspace N";
        alt-p = "workspace P";
        alt-q = "workspace Q";
        alt-r = "workspace R";
        alt-s = "workspace S";
        alt-t = "workspace T";
        alt-u = "workspace U";
        alt-v = "workspace V";
        alt-w = "workspace W";
        alt-x = "workspace X";
        alt-y = "workspace Y";
        alt-z = "workspace Z";

        alt-shift-1 = "move-node-to-workspace 1";
        alt-shift-2 = "move-node-to-workspace 2";
        alt-shift-3 = "move-node-to-workspace 3";
        alt-shift-4 = "move-node-to-workspace 4";
        alt-shift-5 = "move-node-to-workspace 5";
        alt-shift-6 = "move-node-to-workspace 6";
        alt-shift-7 = "move-node-to-workspace 7";
        alt-shift-8 = "move-node-to-workspace 8";
        alt-shift-9 = "move-node-to-workspace 9";
        alt-shift-a = "move-node-to-workspace A";
        alt-shift-b = "move-node-to-workspace B";
        alt-shift-c = "move-node-to-workspace C";
        alt-shift-d = "move-node-to-workspace D";
        alt-shift-e = "move-node-to-workspace E";
        alt-shift-f = "move-node-to-workspace F";
        alt-shift-g = "move-node-to-workspace G";
        alt-shift-i = "move-node-to-workspace I";
        alt-shift-m = "move-node-to-workspace M";
        alt-shift-n = "move-node-to-workspace N";
        alt-shift-o = "move-node-to-workspace O";
        alt-shift-p = "move-node-to-workspace P";
        alt-shift-q = "move-node-to-workspace Q";
        alt-shift-r = "move-node-to-workspace R";
        alt-shift-s = "move-node-to-workspace S";
        alt-shift-t = "move-node-to-workspace T";
        alt-shift-u = "move-node-to-workspace U";
        alt-shift-v = "move-node-to-workspace V";
        alt-shift-w = "move-node-to-workspace W";
        alt-shift-x = "move-node-to-workspace X";
        alt-shift-y = "move-node-to-workspace Y";
        alt-shift-z = "move-node-to-workspace Z";
        alt-tab = "workspace-back-and-forth";
        alt-shift-tab = "move-workspace-to-monitor --wrap-around next";

        # cmd-h = []; # Disable "hide application"
        cmd-alt-h = []; # Disable "hide others"
      };

      workspace-to-monitor-force-assignment = {
        "S" = "secondary";
        "M" = "main";
      };

      after-startup-command = [
        # Launch Kitty and assign to workspace 1
        "exec-and-forget /etc/profiles/per-user/dev/bin/kitty"
      ];
      on-window-detected = [
        {
          # check-further-callbacks = false;
          "if" = {
            app-id = "net.kovidgoyal.kitty";
            # app-name-regex-substring = "CoolApp";
            # during-aerospace-startup = false;
            # window-title-regex-substring = "Title";
            # workspace = "cool-workspace";
          };
          run = [
            "move-node-to-workspace 1"
          ];
        }
        {
          "if" = {
            app-id = "org.mozilla.firefox";
          };
          run = [
            "move-node-to-workspace 2"
          ];
        }
        {
          "if" = {
            app-id = "com.tinyspeck.slackmacgap";
          };
          run = [
            "move-node-to-workspace 3"
          ];
        }
        {
          "if" = {
            app-id = "com.linear";
          };
          run = [
            "move-node-to-workspace 4"
          ];
        }
        {
          # check-further-callbacks = false;
          "if" = {
            app-id = "com.google.Chrome";
          };
          run = [
            "move-node-to-workspace C"
          ];
        }
        {
          "if" = {
            app-id = "com.electron.dockerdesktop";
          };
          run = [
            "move-node-to-workspace D"
          ];
        }
        {
          "if" = {
            app-id = "com.spotify.client";
          };
          run = [
            "move-node-to-workspace S"
          ];
        }
        {
          "if" = {
            app-id = "com.openai.chat";
          };
          run = [
            "move-node-to-workspace G"
          ];
        }
        {
          "if" = {
            app-id = "app.yaak.desktop";
          };
          run = [
            "move-node-to-workspace Y"
          ];
        }
        {
          # check-further-callbacks = false;
          "if" = {
            app-id = "app.zen-browser.zen";
          };
          run = [
            "move-node-to-workspace 9"
          ];
        }
        {
          # check-further-callbacks = false;
          "if" = {
            app-id = "app.cattr";
          };
          run = [
            "move-node-to-workspace 9"
          ];
        }
        {
          "if" = {
            app-id = "com.atlassian.trello";
          };
          run = [
            "move-node-to-workspace T"
          ];
        }
        {
          "if" = {
            app-id = "tech.httptoolkit.desktop";
          };
          run = [
            "move-node-to-workspace T"
          ];
        }
        {
          "if" = {
            app-id = "org.mozilla.firefoxdeveloperedition";
          };
          run = [
            "move-node-to-workspace F"
          ];
        }
        {
          "if" = {
            app-id = "net.ankiweb.launcher";
          };
          run = [
            "move-node-to-workspace A"
          ];
        }
        {
          "if" = {
            app-id = "com.bitwarden.desktop";
          };
          run = [
            "move-node-to-workspace B"
          ];
        }
      ];
    };
  };
}
