defmodule BoolixWeb.BookController do
  use BoolixWeb, :controller

  alias Boolix.Catalog
  alias Boolix.Catalog.Book

  action_fallback BoolixWeb.FallbackController

  def index(conn, _params) do
    books = Catalog.list_books()
    json(conn, %{"books" => books})
  end

  def create(conn, %{"book" => book_params}) do
    with {:ok, %Book{} = book} <- Catalog.create_book(book_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/books/#{book}")
      |> json(book)
    end
  end

  def show(conn, %{"id" => id}) do
    book = Catalog.get_book!(id)
    json(conn, book)
  end

  def update(conn, %{"id" => id, "book" => book_params}) do
    book = Catalog.get_book!(id)

    with {:ok, %Book{} = book} <- Catalog.update_book(book, book_params) do
      json(conn, book)
    end
  end

  def delete(conn, %{"id" => id}) do
    book = Catalog.get_book!(id)

    with {:ok, %Book{}} <- Catalog.delete_book(book) do
      send_resp(conn, :no_content, "")
    end
  end

  def lend(conn, %{"id" => id}) do
    book = Catalog.get_book!(id)

    if book.available == 0 do
      send_resp(conn, 409, "no books available")
    end

    updated_book = %{book | available: book.available - 1}

    with {:ok, %Book{} = book} <-
           Catalog.update_book(book, updated_book) do
      json(conn, book)
    end
  end

  def return(conn, %{"id" => id}) do
    book = Catalog.get_book!(id)

    if book.available == book.quantity do
      send_resp(conn, 409, "all books have been returned")
    end

    updated_book = %{book | available: book.available + 1}

    with {:ok, %Book{} = book} <-
           Catalog.update_book(book, updated_book) do
      json(conn, book)
    end
  end

  def donate(conn, %{"id" => id}) do
    book = Catalog.get_book!(id)

    updated_book = %{
      book
      | quantity: book.quantity + 1,
        available: book.available + 1
    }

    with {:ok, %Book{} = book} <-
           Catalog.update_book(book, updated_book) do
      json(conn, book)
    end
  end
end
