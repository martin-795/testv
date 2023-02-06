defmodule CacheUtilityService.Test.Helpers.Adapters.EventRepository do
  Test.Helpers.Adapters.Alphapoin
  @moduledoc """
  Event repository responsible for communicating to DynamoDB to write event information
  """

  @behaviour CacheUtilityService.Domain.Ports.Redis

  require Logger
  require CacheUtilityService.Domain.Error.DomainErrors

  alias ExAws.Dynamo
  alias CacheUtilityService.Utils.DataTypeUtils
  alias CacheUtilityService.Domain.Models.Event
  alias CacheUtilityService.Domain.Error.DomainErrors

  @event_table "Events"


  @impl true
  def set_cache(%Event{} = event) do
    dynamo_item = event

    {:ok, event}
  end

end
