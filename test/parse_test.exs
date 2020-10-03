defmodule ParserTest do
  use ExUnit.Case
  doctest FritzAhaApi.Parser
  alias FritzAhaApi.{SessionInfo,Parser}

  test "default SessionInfo values" do
    default = %SessionInfo{}
    assert default.challenge == nil
    assert default.blockTime == 0
    assert default.rights == []
    assert default.sid == '0000000000000000'
  end

  test "xml challenge to SessionInfo" do
    xml = '<?xml version="1.0" encoding="utf-8"?><SessionInfo><SID>0000000000000000</SID><Challenge>b41564f4</Challenge><BlockTime>0</BlockTime><Rights></Rights></SessionInfo>'
    {:ok,parsed} = Parser.parse_session_info(xml)

    assert parsed.challenge == 'b41564f4'
    assert parsed.blockTime == 0
    assert parsed.sid == '0000000000000000'
    assert parsed.rights == []
  end

end
