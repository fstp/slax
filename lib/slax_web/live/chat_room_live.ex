defmodule SlaxWeb.ChatRoomLive do
  require Logger
  use SlaxWeb, :live_view

  alias Slax.Repo
  alias Slax.Chat.Room

  def render(assigns) do
    # Logger.debug("rendering")
    ~H"""
    <div class="flex flex-col flex-grow shadow-lg">
      <%= if @room do %>
        <div class="flex justify-between items-center flex-shrink-0 h-16 bg-white border-b border-slate-300 px-4">
          <div class="flex flex-col gap-1.5">
            <h1 class="text-sm font-bold leading-none">#<%= @room.name %></h1>
            <div class="text-xs leading-none h-3.5" phx-click="toggle-topic">
              <%= if @hide_topic? do %>
                <span class="text-slate-600">[Topic hidden]</span>
              <% else %>
                <%= @room.topic %>
              <% end %>
            </div>
          </div>
        </div>
      <% end %>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    # Logger.debug("mounting")
    room = Room |> Repo.all() |> List.first()
    {:ok, assign(socket, room: room, hide_topic?: false)}
  end

  def handle_event("toggle-topic", _, socket) do
    # Logger.debug("toggling topic")
    {:noreply, assign(socket, hide_topic?: !socket.assigns.hide_topic?)}
  end
end
