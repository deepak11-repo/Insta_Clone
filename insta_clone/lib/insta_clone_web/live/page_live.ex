defmodule InstaCloneWeb.PageLive do
  use InstaCloneWeb, :live_view
  alias InstaClone.Accounts
  alias InstaClone.Accounts.User

  @impl true
  def mount(_params, _session, socket) do
    changeset = Accounts.change_user_registration(%User{})
    {:ok, socket  |> assign(changeset: changeset)}
  end
end
