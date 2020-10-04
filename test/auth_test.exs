defmodule AuthTest do
  use ExUnit.Case
  doctest FritzAhaApi.Auth
  alias FritzAhaApi.{Auth, SessionInfo}

  test "check password hash" do
    assert Auth.calculate_response('.bc', '1234567z') ==
             '1234567z-4d422a0edeeded87635c6de7ff5857e2'

    # test bash oneliner: echo -n "1234567z-.bc" | iconv -t UTF16LE | md5sum
  end
end
