defmodule Bootleg.Tasks.PhoenixDigest do
  alias Bootleg.UI

  use Bootleg.Task do
    task :phoenix_digest do
      remote :build do
        "[ -f package.json ] && npm install || true"
        "[ -f brunch-config.js ] && [ -d node_modules ] && ./node_modules/brunch/bin/brunch b -p || true"
        "[ -d deps/phoenix ] && mix phoenix.digest || true"
      end
      UI.info "Phoenix asset digest generated"
    end

    after_task :compile, :phoenix_digest
  end
end
