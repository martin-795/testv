defmodule CacheUtilityService.Test.Helpers.Adapters.TestStubs do
  @moduledoc """
    Helper "factory" module.
    It helps to remove boilerplate about response, request, etc. that are needed in other test modules.
  """

  def event_info_map do
    %{
      "operation" => "RegisterUser",
      "operationDescription" => "Registro de un usuario en AlphaPoint",
      "consumer" => "WeniaApp",
      "requestData" => "{\"userInfo\":{\"username\":\"deloro7592@irebah.com\",\"passwordHash\":\"Test1234.\",\"email\":\"deloro7592@irebah.com\"},\"userConfig\":[],\"affiliateTag\":null,\"operatorId\":1}",
      "responseData" => "{\"code\":\"APP-0002\",\"detail\":null,\"message\":\"Username already exists\"}",
      "status" => "successful",
      "statusCode" => 200,
      "startTimeStamp" => 1672309781,
      "endTimeStamp" => 1672310021,
      "messageId" => "lsdjdsj8s-jhds8lsdjl-ljdhsd9s"
    }
  end
end
