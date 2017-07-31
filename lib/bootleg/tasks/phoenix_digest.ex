defmodule Bootleg.Tasks.PhoenixDigest do
  @moduledoc "Installs dependencies and calls `mix phoenix.digest`."

  alias Bootleg.{Config, UI}

  use Bootleg.Task do
    task :phoenix_digest do
      mix_env = Config.get_config(:mix_env, "prod")
      remote :build do
        "npm install"
        "./node_modules/brunch/bin/brunch build --production"
        "MIX_ENV=#{mix_env} mix phoenix.digest"
      end
      UI.info "Phoenix asset digest generated"
    end

    after_task :compile, :phoenix_digest
  end
end
