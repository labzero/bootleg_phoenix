defmodule Bootleg.Tasks.PhoenixDigest do
  @moduledoc "Installs dependencies and calls `mix phoenix.digest`."
  alias Bootleg.{Config, UI}

  use Bootleg.Task do
    task :phoenix_digest do
      mix_env = Config.get_config(:mix_env, "prod")
      remote :build do
        "[ -f package.json ] && npm install || true"
        "[ -f brunch-config.js ] && [ -d node_modules ] && ./node_modules/brunch/bin/brunch b -p || true"
        "[ -d deps/phoenix ] && MIX_ENV=#{mix_env} mix phoenix.digest || true"
      end
      UI.info "Phoenix asset digest generated"
    end

    after_task :compile, :phoenix_digest
  end
end
