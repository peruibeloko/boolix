defmodule Boolix.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Boolix.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some email",
        is_employee: true,
        name: "some name"
      })
      |> Boolix.Users.create_user()

    user
  end
end
