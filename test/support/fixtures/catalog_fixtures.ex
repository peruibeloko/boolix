defmodule Boolix.CatalogFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Boolix.Catalog` context.
  """

  @doc """
  Generate a book.
  """
  def book_fixture(attrs \\ %{}) do
    {:ok, book} =
      attrs
      |> Enum.into(%{
        author: "some author",
        available: 42,
        isbn: "some isbn",
        quantity: 42,
        title: "some title"
      })
      |> Boolix.Catalog.create_book()

    book
  end
end
