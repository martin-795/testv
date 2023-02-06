import Config
require Logger

Logger.info("Env: #{config_env()}")

import_config "#{config_env()}.exs"
