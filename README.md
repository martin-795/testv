# CacheUtilityService

**TODO: Add description**
This service allows to publish the information of an event from an orchestrator in dynamoDB

## Event data
     "operation"->String
     "operationDescription"->String
     "consumer"->String
     "requestData" ->String
     "responseData" ->String
     "status"->String
     "statusCode"-> numeric
     "startTimeStamp"-> numeric
     "endTimeStamp"-> numeric
     "messageId" ->String

## Example of consumption

```
curl --location --request POST 'localhost:8083/event_publish' \
--header 'Content-Type: application/json' \
--data-raw '{
     "operation": "RegisterUser",
     "operationDescription": "User registration in AlphaPoint",
     "consumer": "WeniaApp",
     "requestData": "{\"userInfo\":{\"username\":\"deloro7592@irebah.com\",\"passwordHash\":\"Test1234.\",\"email\":\" deloro7592@irebah.com\"},\"userConfig\":[],\"affiliateTag\":null,\"operatorId\":1}",
     "responseData": "{\"code\":\"APP-0002\",\"detail\":null,\"message\":\"Username already exists\"}",
     "status": "successful",
     "statusCode": 200,
     "startTimeStamp": 1672309781,
     "endTimeStamp": 1672310021,
     "messageId": "lsdjdsj8s-jhds8lsdjl-ljdhsd9s"
}
'
```
## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `cache_utility_service` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:cache_utility_service, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/cache_utility_service>.

