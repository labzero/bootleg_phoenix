defmodule BootlegPhoenix.PhoenixDigestTest do
  alias BootlegPhoenix.Fixtures
  use BootlegPhoenix.FunctionalCase

  setup do
    %{
      app_location: Fixtures.inflate_project(:drunkin_phoenix)
    }
  end

  @tag boot: 2, timeout: 360_000
  test "phoenix_digest generates the digest during compile", %{app_location: location, hosts: hosts} do
    shell_env = [
      {"BOOTLEG_PHOENIX_PATH", File.cwd!},
      {"BOOTLEG_PATH", Path.join([File.cwd!, "deps", "bootleg"])}
    ]
    build_host = List.first(hosts)
    app_hosts = hosts -- [build_host]
    build_id =
      build_host
      |> Map.get(:id)
      |> String.slice(0, 12)
    IO.puts "Build host is #{build_id}"

    File.open!(Path.join([location, "config", "deploy.exs"]), [:write], fn file ->
      IO.write(file, """
        use Bootleg.Config

        role :build, "#{build_host.ip}", port: #{build_host.port}, user: "#{build_host.user}",
          silently_accept_hosts: true, workspace: "workspace", identity: "#{build_host.private_key_path}"
      """)
      Enum.each(app_hosts, fn host ->
        IO.write(file, """
          role :app, "#{host.ip}", port: #{host.port}, user: "#{host.user}",
            silently_accept_hosts: true, workspace: "workspace", identity: "#{host.private_key_path}"
        """)
      end)
    end)

    Enum.each(["deps.get", "bootleg.build", "bootleg.deploy", "bootleg.start"], fn cmd ->
      assert {out, 0} = System.cmd("mix", [cmd], [env: shell_env, cd: location])
      if cmd == "bootleg.build" do
        assert String.match?(out, ~r/Phoenix asset digest generated/)
      end
    end)
  end
end
