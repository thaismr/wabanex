defmodule Wabanex.UserTest do
  use Wabanex.DataCase, async: true

  alias Wabanex.User

  describe "changeset/1" do
    test "when all params valid, returns valid changeset" do
      params = %{name: "JDoe", email: "joe@example.com", password: "password"}

      response = User.changeset(params)

      assert %Ecto.Changeset{
          valid?: true,
          changes: %{email: "joe@example.com", name: "JDoe", password: "password"},
          errors: []
        } = response
    end

    test "when there are invalid params, returns invalid changeset" do
      params = %{name: "J", email: "joe@example.com"}

      response = User.changeset(params)

      expected_response = %{
        name: ["should be at least 2 character(s)"],
        password: ["can't be blank"]
      }

      assert errors_on(response) == expected_response
    end
  end
end
