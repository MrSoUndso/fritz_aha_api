defmodule FritzAhaApi.Auth do
  def login(password) do
    :inets.start()

    session =
      with {:ok, {{_type, _statuscode, _reason}, _headers, body}} <-
             :httpc.request('http://fritz.box/login_sid.lua'),
           {:ok, session} <- FritzAhaApi.Parser.parse_session_info(body) do
        session
      else
        _ -> nil
      end

    if session.blockTime > 0 do
      IO.puts("sleeping for #{session.blockTime} seconds")
      Process.sleep(session.blockTime * 1000)
    end

    responseUri =
      'http://fritz.box/login_sid.lua?response=' ++
        calculate_response(password, session.challenge)

    {:ok, {{_type, _statuscode, _reason}, _headers, body}} = :httpc.request(responseUri)

    case FritzAhaApi.Parser.parse_session_info(body) do
      {:ok, session} -> session
      _ -> :parser_failed
    end
  end

  def calculate_response(password, challenge) do
    encoded =
      :unicode.characters_to_binary(challenge ++ '-' ++ password, :utf8, {:utf16, :little})

    hash = :crypto.hash(:md5, encoded) |> Base.encode16(case: :lower)
    challenge ++ '-' ++ String.to_charlist(hash)
  end
end
