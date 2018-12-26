# Plug.Octopus

Rack has a [lobster](https://github.com/rack/rack/blob/master/lib/rack/lobster.rb), Plug has an octopus!

## Usage

``` elixir
# mix.exs
defmodule MyApp.MixProject do
  # ...

  defp deps do
    [
      {:plug_octopus, github: "jeffkreeftmeijer/plug_octopus"},
    ]
end
```

``` elixir
# lib/my_app/application.ex
defmodule MyApp.Application do
  @moduledoc false

  use Application
  def start(_type, _args) do
    children = [
      Plug.Cowboy.child_spec(scheme: :http, plug: Plug.Octopus, options: [port: 4000])
    ]

    opts = [strategy: :one_for_one, name: Plug.Octopus.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
```

```
$ mix run --no-halt
```

![Plug.Octopus running in a browser, showing an ASCII octopus that can flip and crash.](plug_octopus.gif)
