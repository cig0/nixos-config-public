{ ... }:

{
  programs.starship = {
    enable = true;
    settings = {
      format = "$aws\$gcloud\$kubernetes\$helm\$docker_context\$terraform\$package\$rust\$golang\$nodejs\$python\$env_var\$line_break\$username\$hostname\$nix_shell\$shlvl\$directory\$git_branch\$git_commit\$git_state\$git_status\$cmd_duration\$time\$status\$jobs\$character";

      character = {
        success_symbol = "[λ](bold green)";
        error_symbol = "[λ](bold red)";
      };

      cmd_duration = {
        disabled = false;
      };

      directory = {
        style = "white";
        # truncation_length = "14";
      };

      status = {
        disabled = false;
      };

      time = {
        disabled = true;
      };

      nix_shell = {
        disabled = false;
        heuristic = true;
        symbol = "(bold blue)\(nix\)";
        impure_msg = "[impure shell](bold red)";
        pure_msg = "[pure shell](bold green)";
        unknown_msg = "[unknown shell](bold yellow)";
        # format = "[${symbol} $state( \($name\))](bold blue) "; # Nix complains of 'variable symbol not defined' -- TODO: further investigate the issue.
        format = "[(bold blue)\(nix\) $state( \($name\))](bold blue) "; # I had to replace the '${symbol}' reference for the whole definition.
      };

      shlvl = {
        disabled = false;
        format = "[$shlvl level(s) down ](bold red)";
        threshold = 2;
      };

      aws = {
        disabled=false;
        symbol = "🅰 ";
        format = "[($profile )(\($region\))](bold fg:215)";
      };

      aws.region_aliases = {
        ap-southeast-2 = "au";
        us-east-1 = "va";
        us-west-2 = "oregon";
      };

      gcloud = {
        disabled = true;
        format = "[$project]($style)";
      };

      kubernetes = {
        disabled = false;
        style = "bold blue";
        format = " :: [$context]($style) [$namespace](bold white)";
      };

      #kubernetes.context_aliases = {};

      helm = {
        format = " :: [$version](bold fg:81)";
        disabled = true;
      };

      docker_context = {
        format = " :: [$context](blue bold)";
      };

      terraform = {
        disabled = false;
        format = " :: [$workspace]($style)";
        detect_extensions = ["tf" "tfplan" "tfstate"];
        detect_folders = [".terraform"];
      };

      package = {
        format = " :: [$version](bold fg:212)";
      };

      rust = {
        format = " :: [⚙ $version](red bold)";
      };

      golang = {
        format = " :: [$version](bold cyan)";
      };

      nodejs = {
        format = " :: [$version](bold green)";
      };

      python  = {
        python_binary = "python3";
        format = " :: [($virtualenv)](bold fg:228)";
      };

      # git_branch = {
      #   truncation_length = "30";
      #   truncation_symbol = "...";
      # };

      # git_status = {
      #   ahead = "⇡${count}";
      #   diverged = "⇕⇡${ahead_count}⇣${behind_count}";
      #   staged = "+${count}";
      #   untracked = "new: ${count} ";
      #   behind = "⇣${count} ";
      #   deleted = "del: ${count} ";
      #   modified = "!${count}";
      # };
    };
  };
}