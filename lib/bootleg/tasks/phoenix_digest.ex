defmodule Bootleg.Tasks.PhoenixDigest do
  @moduledoc "Installs needed dependencies and calls `mix phoenix.digest`."

  use Bootleg.Task do
    task :phoenix_digest do
      alias Bootleg.UI

      build_type = config({:build_type, "remote"})
      invoke(:"#{build_type}_phoenix_digest")
      UI.info("Phoenix asset digest generated")
    end

    bash_script = """
    [ -f package.json ] && npm install || true
    [ -f brunch-config.js ] && [ -d node_modules ] && ./node_modules/brunch/bin/brunch b -p || true
    [ -f assets/package.json ] && cd assets && npm install && cd .. || true
    [ -f assets/brunch-config.js ] && cd assets && [ -d node_modules ] && ./node_modules/brunch/bin/brunch b -p && cd .. || true
    [ -d deps/phoenix ] && mix phx.digest || true
    """

    task :local_phoenix_digest do
      source_path = config({:ex_path, File.cwd!()})

      File.cd!(source_path, fn ->
        System.cmd("/bin/bash", ["-c", bash_script],
          env: [{"MIX_ENV", mix_env}],
          into: IO.stream(:stdio, :line)
        )
      end)
    end

    task :docker_phoenix_digest do
      mix_env = config({:mix_env, "prod"})
      source_path = config({:ex_path, File.cwd!()})
      docker_image = config(:docker_build_image)
      docker_mount = config({:docker_build_mount, "#{source_path}:/opt/build"})
      docker_run_options = config({:docker_build_opts, []})

      docker_args =
        [
          "run",
          "-v",
          docker_mount,
          "--rm",
          "-t",
          "-e",
          "MIX_ENV=#{mix_env}"
        ] ++ docker_run_options ++ [docker_image]

      System.cmd("docker", docker_args ++ ["/bin/bash", "-c", bash_script],
        into: IO.stream(:stdio, :line)
      )
    end

    task :remote_phoenix_digest do
      mix_env = Keyword.get(config(), :mix_env, "prod")

      remote :build do
        "[ -f package.json ] && npm install || true"
        "[ -f brunch-config.js ] && [ -d node_modules ] && ./node_modules/brunch/bin/brunch b -p || true"
        "[ -f assets/package.json ] && cd assets && npm install && cd .. || true"
        "[ -f assets/brunch-config.js ] && cd assets && [ -d node_modules ] && ./node_modules/brunch/bin/brunch b -p && cd .. || true"
        "[ -d deps/phoenix ] && MIX_ENV=#{mix_env} mix phx.digest || true"
      end
    end

    after_task(:compile, :phoenix_digest)
  end
end
