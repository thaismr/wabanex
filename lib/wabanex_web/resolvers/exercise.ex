defmodule WabanexWeb.Resolvers.Exercise do
  def create(%{input: params}, _context), do: Wabanex.Users.Create.call(params)
end
