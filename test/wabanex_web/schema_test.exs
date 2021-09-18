defmodule WabanexWeb.SchemaTest do
  use WabanexWeb.ConnCase, async: true

  alias Wabanex.User
  alias Wabanex.Users.Create

  describe "users queries" do
    test "when valid id given, returns user", %{conn: conn} do
      params = %{name: "JDoe", email: "test@test.com", password: "testpassword"}

      {:ok, %User{id: user_id}} = Create.call(params)

      query = """
        {
          getUser(id: "#{user_id}"){
            id
            name
            email
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      expected_response = %{
        "data" => %{
          "getUser" => %{
            "email" => "test@test.com",
            "id" => "#{user_id}",
            "name" => "JDoe"
          }
        }
      }

      assert response == expected_response
    end
  end

  describe "users mutations" do
    test "when all params valid, creates user", %{conn: conn} do
      mutation = """
        mutation {
          createUser(input: {
            name: "Thais", email: "teste3@teste.com", password: "123456"
          }){
            id
            name
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: mutation})
        |> json_response(:ok)

      assert %{"data" => %{"createUser" => %{"id" => _id, "name" => "Thais"}}} = response
    end
  end
end
