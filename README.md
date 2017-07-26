# Bootleg-Phoenix

[![CircleCI](https://img.shields.io/circleci/project/github/labzero/bootleg_phoenix/master.svg)](https://circleci.com/gh/labzero/bootleg_phoenix)

Provides Phoenix-specific Bootleg tasks.

## Tasks

### `phoenix_digest`

This task makes sure your NPM dependencies are up-to-date and `brunch` is available, then does a
`mix phoenix.digest` after the Bootleg `compile` task completes.

## Installation

The package can be installed by adding `bootleg_phoenix` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:bootleg_phoenix, "~> 0.1.0"}]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/bootleg_phoenix](https://hexdocs.pm/bootleg_phoenix).

## Contributing

We welcome everyone to contribute to Bootleg-Phoenix and help us tackle existing issues!

Use the [issue tracker][issues] for bug reports or feature requests.
Open a [pull request][pulls] when you are ready to contribute.

If you are planning to contribute documentation, please check
[the best practices for writing documentation][writing-docs].

## LICENSE

Bootleg-Phoenix source code is released under the MIT License.
Check the [LICENSE](LICENSE) file for more information.

  [issues]: https://github.com/labzero/bootleg_phoenix/issues
  [pulls]: https://github.com/labzero/bootleg_phoenix/pulls
  [writing-docs]: http://elixir-lang.org/docs/stable/elixir/writing-documentation.html