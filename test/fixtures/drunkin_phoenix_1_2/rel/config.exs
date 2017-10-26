# Import all plugins from `rel/plugins`
# They can then be used by adding `plugin MyPlugin` to
# either an environment, or release definition, where
# `MyPlugin` is the name of the plugin module.
["rel", "plugins", "*.exs"]
|> Path.join()
|> Path.wildcard()
|> Enum.map(&Code.eval_file(&1))

use Mix.Releases.Config,
    # This sets the default release built by `mix release`
    default_release: :default,
    # This sets the default environment used by `mix release`
    default_environment: Mix.env()

# For a full list of config options for both releases
# and environments, visit https://hexdocs.pm/distillery/configuration.html

# You may define one or more environments in this file,
# an environment's settings will override those of a release
# when building in that environment, this combination of release
# and environment configuration is called a profile

environment :dev do
  set dev_mode: true
  set include_erts: false
  set cookie: :"@{Dw&f<c)4Z2woVZv:2<B}}4h;|P$vg(;Vmd95?;,^IC6dx6ypFxXhi&v*(]xr:v"
end

environment :prod do
  set include_erts: true
  set include_src: false
  set cookie: :"|)_{DW_:9am0||wo4Xg@kJc^w>kd(LmfZSc5Iy,dD&OwhrGz|cy;K3]6Ni_FR*7<"
end

# You may define one or more releases in this file.
# If you have not set a default release, or selected one
# when running `mix release`, the first release in the file
# will be used by default

release :drunkin_phoenix do
  set version: current_version(:drunkin_phoenix)
  set applications: [
    :runtime_tools
  ]
end
