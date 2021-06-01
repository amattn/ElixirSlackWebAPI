defmodule SlackTest do
  use ExUnit.Case

  describe "simple error test" do
    test "simple error test" do
      options = %{
        token: "NOT_A_REAL_TOKEN",
        limit: 10
      }

      resp = SlackWeb.Users.list(options)

      # hackney automatically injects the charset=utf-8 for url encoded forms.
      # I don't think there is much we can do about that warning in this package.

      assert resp == %{
               "error" => "invalid_auth",
               "ok" => false,
               "response_metadata" => %{"warnings" => ["superfluous_charset"]},
               "warning" => "superfluous_charset"
             }
    end
  end
end
