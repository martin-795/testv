defmodule CacheUtilityService.Test.EntryPoint.Http.ErrorMapperTest do
  @moduledoc """
  Test Module for CacheUtilityService.EntryPoint.Http.ErrorMapper
  """
  use ExUnit.Case

  require CacheUtilityService.Domain.Error.DomainErrors
  require CacheUtilityService.EntryPoint.Http.HttpErrors

  alias CacheUtilityService.Domain.Error.DomainErrors
  alias CacheUtilityService.EntryPoint.Http.HttpErrors
  alias CacheUtilityService.EntryPoint.Http.ErrorMapper

  describe "map_error" do
    test "should return a fiendly error response and the corresponding status code" do
      assert {500, %{"code" => "EUS-0000", "detail" => nil, "message" => "Generic error"}} =
               ErrorMapper.map_error(:unkown_error)

      assert {400, %{"code" => "EUS-0001", "message" => "Invalid request body"}} =
               ErrorMapper.map_error(HttpErrors.invalid_req_body_code())

      assert {404, %{"code" => "EUS-0004", "message" => "Resource Not Found"}} =
               ErrorMapper.map_error(HttpErrors.resource_not_found())

      assert {500, %{"code" => "EUS-0002", "message" => "Event not found"}} =
               ErrorMapper.map_error(DomainErrors.cache_not_found_error())

      assert {500, %{"code" => "EUS-0003", "message" => "Unknown Event Repository Error"}} =
               ErrorMapper.map_error(DomainErrors.unknown_key_redis())

    end
  end
end
