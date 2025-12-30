defmodule Boolix.Catalog do
  @moduledoc """
  The Catalog context.
  """

  import Ecto.Query, warn: false
  alias Boolix.Repo

  alias Boolix.Catalog.Book

  def list_books do
    Repo.all(Book)
  end

  def get_book!(id), do: Repo.get!(Book, id)

  def create_book(attrs) do
    %Book{}
    |> Book.changeset(attrs)
    |> Repo.insert()
  end

  def update_book(%Book{} = book, attrs) do
    book
    |> Book.changeset(attrs)
    |> Repo.update()
  end

  def delete_book(%Book{} = book) do
    Repo.delete(book)
  end

  def change_book(%Book{} = book, attrs \\ %{}) do
    Book.changeset(book, attrs)
  end

  def lend_book(id) do
    book = get_book!(id)

    case book do
      %Book{available: 0} -> {:error, "no books available"}
      %Book{available: available} -> update_book(book, %{available: available - 1})
    end
  end

  def return_book(id) do
    book = get_book!(id)
    qty = book.quantity

    case book do
      %Book{available: ^qty} -> {:error, "book is at capacity"}
      %Book{available: available} -> update_book(book, %{available: available + 1})
    end
  end
end
