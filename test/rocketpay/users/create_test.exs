defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase

  alias Rocketpay.User
  alias Rocketpay.Users.Create

  describe "call/1" do
    test "When all params are valid, returns an user" do
      params = %{
        name: "Rodrigo",
        password: "123456",
        nickname: "rodrigo",
        email: "rodrigo@gmail.com",
        age: 21,
      }

      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)

      assert %User{name: "Rodrigo", age: 21, id: ^user_id} = user
    end

    test "When there are invalid params, returns an error" do
      params = %{
        name: "Rodrigo",
        nickname: "rodrigo",
        email: "rodrigo@gmail.com",
        age: 21,
      }

      {:error, changeset} = Create.call(params)

      expected_response = %{password: ["can't be blank"]}

      assert errors_on(changeset) == expected_response
    end
  end
end
