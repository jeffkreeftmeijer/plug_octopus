defmodule Plug.Octopus do
  use Plug.Router
  use Plug.Debugger

  @octopus ~S'''
                        ___
                     .-'   `'.
                    /         \
                    |         ;
                    |         |           ___.--,
           _.._     |0) ~ (0) |    _.---'`__.-( (_.
    __.--'`_.. '.__.\    '--. \_.-' ,.--'`     `""`
   ( ,.--'`   ',__ /./;   ;, '.__.'`    __
   _`) )  .---.__.' / |   |\   \__..--""  """--.,_
  `---' .'.''-._.-'`_./  /\ '.  \ _.-~~~````~~~-._`-.__.'
        | |  .' _.-' |  |  \  \  '.               `~---`
         \ \/ .'     \  \   '. '-._)
          \/ /        \  \    `=.__`~-.
     jgs  / /\         `) )    / / `"".`\
    , _.-'.'\ \        / /    ( (     / /
     `--~`   ) )    .-'.'      '.'.  | (
            (/`    ( (`          ) )  '-;
             `      '-;         (-'
  '''

  @flipped ~S'''
                                ___
                             .'`   '-.
                            /         \
                            ;         |
          ,--.___           |         |
        ._) )-.__`'---._    | (0) ~ (0|     _.._
        `""`     `'--., '-._/ .--'    /.__.' .._`'--.__
                 __    `'.__.' ,;   ;\.\ __,'   `'--., )
         _,.--"""  ""--..__/   /|   | \ '.__.---.  ( (`_
  '.__.-`_.-~~~````~~~-._ /  .' /\  \._`'-._.-''.'. '---`
   `---~`               .'  /  /  |  | '-._ '.  | |
                       (_.-' .'   /  /     '. \/ /
                    .-~`__.=`    /  /        \ \/
     jgs          /`.""` \ \    ( (`         /\ \
                  \ \     ) )    \ \        / /'.'-._ ,
                   ) |  .'.'      '.'-.    ( (   `~--`
                  ;-'  ( (          `) )    `\)
                        '-)         ;-'      `
  '''

  plug(:match)
  plug(:dispatch)

  match _ do
    case Plug.Conn.fetch_query_params(conn) do
      %{query_params: %{"flip" => "crash"}} ->
        raise "Octopus crashed"

      %{query_params: params} = conn ->
        conn
        |> put_resp_content_type("text/html")
        |> send_resp(200, body(params["flip"]))
    end
  end

  defp body("right"), do: body(@flipped, "/?flip=left")
  defp body(_), do: body(@octopus, "/?flip=right")

  defp body(octopus, href) do
    """
    <title>Octolicious!</title>
    <pre>#{octopus}</pre>
    <p><a href="#{href}">flip!</a></p>
    <p><a href="/?flip=crash">crash!</a></p>
    """
  end
end
