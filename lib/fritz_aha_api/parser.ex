defmodule FritzAhaApi.Parser do
  def parse_session_info(xml) do
    elements =
      case :xmerl_scan.string(xml) do
        {{:xmlElement, :SessionInfo, :SessionInfo, [], {:xmlNamespace, [], []}, [], 1, [],
          elements, [], _path, :undeclared}, []} ->
          {:ok, elements}

        _ ->
          :error
      end

    contents =
      case elements do
        {:ok, elements} ->
          for element <- elements do
            with {:xmlElement, fieldname, fieldname, [], {:xmlNamespace, [], []},
                  [SessionInfo: 1], _position, [], [content], [], _path, :undeclared} <- element,
                 {:xmlText, _, 1, [], value, _type} <- content do
              {fieldname, value}
            else
              _ -> :no_content
            end
          end

        _ ->
          :error
      end

    {:ok,
     %FritzAhaApi.SessionInfo{
       sid: contents[:SID],
       challenge: contents[:Challenge],
       blockTime: List.to_integer(contents[:BlockTime])
     }}
  end
end

# inneres element:
