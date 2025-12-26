defmodule Boolix.CatalogTest do
  use Boolix.DataCase

  alias Boolix.Catalog

  describe "books" do
    alias Boolix.Catalog.Book

    import Boolix.CatalogFixtures

    @invalid_attrs %{title: nil, author: nil, available: nil, isbn: nil, quantity: nil}

    test "list_books/0 returns all books" do
      book = book_fixture()
      assert Catalog.list_books() == [book]
    end

    test "get_book!/1 returns the book with given id" do
      book = book_fixture()
      assert Catalog.get_book!(book.id) == book
    end

    test "create_book/1 with valid data creates a book" do
      valid_attrs = %{title: "some title", author: "some author", available: 42, isbn: "some isbn", quantity: 42}

      assert {:ok, %Book{} = book} = Catalog.create_book(valid_attrs)
      assert book.title == "some title"
      assert book.author == "some author"
      assert book.available == 42
      assert book.isbn == "some isbn"
      assert book.quantity == 42
    end

    test "create_book/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Catalog.create_book(@invalid_attrs)
    end

    test "update_book/2 with valid data updates the book" do
      book = book_fixture()
      update_attrs = %{title: "some updated title", author: "some updated author", available: 43, isbn: "some updated isbn", quantity: 43}

      assert {:ok, %Book{} = book} = Catalog.update_book(book, update_attrs)
      assert book.title == "some updated title"
      assert book.author == "some updated author"
      assert book.available == 43
      assert book.isbn == "some updated isbn"
      assert book.quantity == 43
    end

    test "update_book/2 with invalid data returns error changeset" do
      book = book_fixture()
      assert {:error, %Ecto.Changeset{}} = Catalog.update_book(book, @invalid_attrs)
      assert book == Catalog.get_book!(book.id)
    end

    test "delete_book/1 deletes the book" do
      book = book_fixture()
      assert {:ok, %Book{}} = Catalog.delete_book(book)
      assert_raise Ecto.NoResultsError, fn -> Catalog.get_book!(book.id) end
    end

    test "change_book/1 returns a book changeset" do
      book = book_fixture()
      assert %Ecto.Changeset{} = Catalog.change_book(book)
    end
  end
end
