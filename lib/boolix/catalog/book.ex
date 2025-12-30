defmodule Boolix.Catalog.Book do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  schema "books" do
    field :title, :string
    field :author, :string
    field :isbn, :string
    field :quantity, :integer
    field :available, :integer

    timestamps(type: :utc_datetime)
  end

  def changeset_info(book, attrs) do
    book
    |> cast(attrs, [:title, :author, :isbn])
  end

  def changeset_inventory(book, attrs) do
    book
    |> cast(attrs, [:quantity, :available])
    |> validate_number(:quantity, greater_than: 0)
    |> validate_number(:available, greater_than: 0)
  end
end
