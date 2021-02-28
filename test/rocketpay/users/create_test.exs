defmodule Rocketpay.Users.CreateTest do
  # async: true -> faz todos os testes rodarem em paralelo
  use Rocketpay.DataCase, async: true

  alias Rocketpay.User
  alias Rocketpay.Users.Create

  describe "call/1" do
    test "when all params are valid, returns an user" do
      params = %{
        name: "Gabi",
        password: "123456",
        nickname: "gabi",
        email: "gabi@gmail.com",
        age: 19
      }

      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)

      assert %User{
               name: "Gabi",
               nickname: "gabi",
               email: "gabi@gmail.com",
               age: 19,
               # ^ -> pin operator: pega um valor pré estabelecido e fixa esse valor
               id: ^user_id
             } = user
    end

    test "when there are invalid params, returns an error" do
      params = %{
        name: "Gabi",
        password: "1256",
        nickname: "gabi",
        email: "gabi@gmail.com",
        age: 10
      }

      {:error, changeset} = Create.call(params)

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        password: ["should be at least 6 character(s)"]
      }

      assert expected_response == errors_on(changeset)
    end
  end
end
