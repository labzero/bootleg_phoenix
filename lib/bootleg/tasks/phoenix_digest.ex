defmodule Bootleg.Tasks.PhoenixDigest do
  @moduledoc "Installs needed dependencies and calls `mix phoenix.digest`."

  use Bootleg.Task do
    task :phoenix_digest do
      alias Bootleg.UI

      mix_env = Keyword.get(config(), :mix_env, "prod")
      remote :build do
        "[ -f package.json ] && npm install || true"
        "[ -f brunch-config.js ] && [ -d node_modules ] && ./node_modules/brunch/bin/brunch b -p || true"
        "[ -f assets/package.json ] && cd assets && npm install || true"
        "[ -f assets/brunch-config.js ] && cd assets && [ -d node_modules ] && ./node_modules/brunch/bin/brunch b -p || true"
        "[ -d deps/phoenix ] && MIX_ENV=#{mix_env} mix phx.digest || true"
      end
      UI.info "Phoenix asset digest generated"
    end

    after_task :compile, :phoenix_digest
  end
end
