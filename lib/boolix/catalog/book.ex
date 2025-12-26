defmodule Boolix.Catalog.Book do
  use Ecto.Schema
  import Ecto.Changeset

  schema "books" do
    field :title, :string
    field :author, :string
    field :isbn, :string
    field :quantity, :integer
    field :available, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:title, :author, :isbn, :quantity, :available])
    |> validate_required([:title, :author, :isbn, :quantity, :available])
  end
end
