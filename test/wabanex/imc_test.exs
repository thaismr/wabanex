defmodule Wabanex.IMCTest do
  use ExUnit.Case, async: true

  alias Wabanex.IMC

  describe "calculate/1" do
    test "when file exists, returns data" do
      params = %{"filename" => "students.csv"}

      response = IMC.calculate(params)

      expected_response =
        {:ok,
          %{
            "Caco" => 10.204081632653063,
            "Marie" => 9.722222222222223,
            "Thais" => 21.484374999999996
          }}

      assert response == expected_response
    end

    test "when wrong filename given, returns error" do
      params = %{"filename" => "banana.csv"}

      response = IMC.calculate(params)

      expected_response = {:error, "Error while opening the file."}

      assert response == expected_response
    end
  end
end
