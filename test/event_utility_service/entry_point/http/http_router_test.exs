defmodule CacheUtilityService.Test.EntryPoint.Http.HttpRouterTest do
  @moduledoc """
  Test module for implementing HTTPRouter tests
  """
  use ExUnit.Case
  use Plug.Test

  import Mock

  alias CacheUtilityService.EntryPoint.Http.HttpRouter
  alias CacheUtilityService.Test.Helpers.Adapters.TestStubs

  @opts HttpRouter.init([])

  describe "/event_publish" do
    test "should return status code 200 Created when an user event is published successfully" do
      request_body = TestStubs.event_info_map()

      conn =
        conn(
          :post,
          "/event_publish",
          request_body
        )
        |> Plug.Conn.put_req_header("content-type", "application/json")

      result = HttpRouter.call(conn, @opts)
      {:ok, response_body} = result.resp_body |> Jason.decode()

      assert request_body == response_body
    end

    test "should return an error when event information is missing" do
      request_body = %{
        "operation" => "",
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

      conn =
        conn(
          :post,
          "/event_publish",
          request_body
        )
        |> Plug.Conn.put_req_header("content-type", "application/json")

      result = HttpRouter.call(conn, @opts)
      {:ok, response_body} = result.resp_body |> Jason.decode()

      assert %{
            "code" => "EUS-0001",
            "detail" => [ "Invalid value for operation"],
            "message" =>"Invalid request body"
             } == response_body
    end

    test "return an error with status code 404 Not Found when an non-existing resource is consumed" do
      request_body = TestStubs.event_info_map()

      conn =
        conn(
          :post,
          "/not_existin_resource",
          request_body
        )
        |> Plug.Conn.put_req_header("content-type", "application/json")

      result = HttpRouter.call(conn, @opts)
      {:ok, response_body} = result.resp_body |> Jason.decode()

      assert %{"code" => "EUS-0004", "detail" => nil, "message" => "Resource Not Found"} == response_body
    end

  end

  describe "/health" do
    test("should return a message probing the api rest is ok") do
      conn = conn(:get, "/health")

      result = HttpRouter.call(conn, @opts)
      {:ok, %{"health" => "OK"}} = result.resp_body |> Jason.decode()
    end
  end
end
