defmodule BootlegPhoenix.PhoenixDigestTest do
  use BootlegPhoenix.FunctionalCase

  import BootlegPhoenix.DigestTestHelpers, only: [digest_test: 1]

  digest_test(:drunkin_phoenix_1_2)
  digest_test(:drunkin_phoenix_1_3)
end
