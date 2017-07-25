defmodule Bootleg.Tasks.PhoenixDigest do
  use Bootleg.Task do
    task :phoenix_digest do
      remote :build do
        "[ -f package.json ] && npm install || true"
        "[ -f brunch-config.js ] && [ -d node_modules ] && ./node_modules/brunch/bin/brunch b -p || true"
        "[ -d deps/phoenix ] && mix phoenix.digest || true"
      end
    end

    after_task :compile, :phoenix_digest
  end
end
