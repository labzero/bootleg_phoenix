defmodule BootlegPhoenix.DigestTestHelpers do
  @moduledoc false
  @fixture_version_r ~r{_(?<major>\d+)_(?<minor>\d+)$}
  defmacro digest_test(fixture) do
    version = Regex.named_captures(@fixture_version_r, to_string(fixture))
    version_string = version["major"] <> "." <> version["minor"]

    quote do
      @tag boot: 2, timeout: 180_000, app_fixture: unquote(fixture)
      test "phoenix_digest generates the digest during compile (#{unquote(version_string)})", %{
        app_location: location,
        hosts: hosts
      } do
        shell_env = [
          {"BOOTLEG_PHOENIX_PATH", File.cwd!()},
          {"BOOTLEG_PATH", Path.join([File.cwd!(), "deps", "bootleg"])}
        ]

        build_host = List.first(hosts)
        app_hosts = hosts -- [build_host]

        File.open!(Path.join([location, "config", "deploy.exs"]), [:write], fn file ->
          IO.write(file, """
            use Bootleg.Config

            role :build, "#{build_host.ip}", port: #{build_host.port}, user: "#{build_host.user}",
              silently_accept_hosts: true, workspace: "workspace", identity: "#{
            build_host.private_key_path
          }"
          """)

          Enum.each(app_hosts, fn host ->
            IO.write(file, """
              role :app, "#{host.ip}", port: #{host.port}, user: "#{host.user}",
                silently_accept_hosts: true, workspace: "workspace", identity: "#{
              host.private_key_path
            }"
            """)
          end)
        end)

        Enum.each(["deps.get", "bootleg.build", "bootleg.deploy", "bootleg.start"], fn cmd ->
          {out, status} = System.cmd("mix", [cmd], env: shell_env, cd: location)
          assert status == 0, out

          if cmd == "bootleg.build" do
            assert String.match?(out, ~r/Phoenix asset digest generated/),
                   "Digest genration failed"
          end
        end)
      end
    end
  end
end
