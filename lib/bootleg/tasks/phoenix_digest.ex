defmodule Bootleg.Tasks.PhoenixDigest do
  @moduledoc "Installs needed depedencies and calls `mix phoenix.digest`."

  use Bootleg.Task do
    task :phoenix_digest do
      alias Bootleg.UI

      mix_env = Keyword.get(config(), :mix_env, "prod")

      remote :build do
        "[ -f package.json ] && npm install || true"

        "[ -f package.json ] && npm build || true"

        "[ -f assets/package.json ] && cd assets && npm install || true"

        "[ -f assets/package.json ] && cd assets && npm build || true"

        "[ -d deps/phoenix ] && MIX_ENV=#{mix_env} mix phoenix.digest || true"
      end

      UI.info("Phoenix asset digest generated")
    end

    after_task(:compile, :phoenix_digest)
  end
end
