defmodule SlackTest do
  use ExUnit.Case

  describe "simple error test" do
    test "simple error test" do
      options = %{
        token: "NOT_A_REAL_TOKEN"
        # team_id: team_id,
      }

      resp = SlackWeb.Users.list(options)

      assert resp == %{
               "error" => "invalid_auth",
               "ok" => false,
               "response_metadata" => %{"warnings" => ["superfluous_charset"]},
               "warning" => "superfluous_charset"
             }
    end
  end
end
