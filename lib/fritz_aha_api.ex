defmodule FritzAhaApi do
  def call_api(cmd, session, device \\ nil) do

      url = case device do
        nil -> "http://fritz.box/webservices/homeautoswitch.lua?switchcmd=#{cmd}&sid=#{session.sid}"
        _ -> "http://fritz.box/webservices/homeautoswitch.lua?ain=#{device.identifier}&switchcmd=#{cmd}&sid=#{session.sid}"
      end
      IO.inspect url
      case :httpc.request(url) do
        {:ok, {{_type, 200, _reason}, _headers, body}} -> {:ok, body}
        {:ok, {{_type, statuscode, reason}, _headers, _body}} -> {:error, statuscode, reason}
        something -> something
        #_ -> {:error, :unknown}
      end
  end

  def get_switch_list(session) do
    call_api("getswitchlist",session)
  end

  def set_switch(session,device,state) when is_atom(state) do
    case state do
      :on -> call_api("setswitchon",session,device)
      :off -> call_api("setswitchoff",session,device)
      _ -> {:error, :invalid_state}
    end
  end

  def toggle_switch(session, device) do
    call_api("setswitchtoggle",session,device)
  end

  def get_switch_state(session, device) do
    call_api("getswitchstate",session,device)
  end

  def get_switch_present(session, device) do
    call_api("getswitchpresent",session,device)
  end

  def get_switch_power(session, device) do
    call_api("getswitchpower",session,device)
  end

  def get_switch_energy(session, device) do
    call_api("getswitchenergy",session,device)
  end

  def get_switch_name(session, device) do
    call_api("getswitchname",session,device)
  end

  def get_device_list_infos(session) do
    call_api("getdevicelistinfos",session)
  end

  def get_temperature(session, device) do
    call_api("gettemperature",session,device)
  end

  def get_hkr_soll(session, device) do
    call_api("gethkrsoll",session,device)
  end

  def get_hkr_komfort(session, device) do
    call_api("gethkrkomfort",session,device)
  end

  def get_hkr_absenk(session, device) do
    call_api("gethkrabsenk",session,device)
  end

  #todo add param
  #def set_hkr_soll(session, device) do
  #  call_api("",session,device)
  #end

  def get_basic_device_stats(session, device) do
    call_api("getbasicdevicestats",session,device)
  end

  def get_template_list_infos (session, device) do
    call_api("gettemplatelistinfos",session,device)
  end

  def apply_template(session, device) do
    call_api("applytemplate",session,device)
  end

  #todo params
  #def setsimpleonoff(session, device) do
  #  call_api("setsimpleonoff",session,device)
  #end

  #todo params
  #def set_level(session, device) do
  #  call_api("setlevel",session,device)
  #end

  #todo params
  #def set_level_percentage(session, device) do
  #  call_api("setlevelpercentage",session,device)
  #end

  #todo params
  #def set_color(session, device) do
  #  call_api("setcolor",session,device)
  #end

  #todo params
  #def set_color_temperature(session, device) do
  #  call_api("setcolortemperature",session,device)
  #end

  def get_color_defaults(session, device) do
    call_api("getcolordefaults",session,device)
  end

  #todo params
  #def set_hkr_boost(session, device) do
  #  call_api("sethkrboost",session,device)
  #end

  #todo params
  #def set_hkr_window_open(session, device) do
  #  call_api("sethkrwindowopen",session,device)
  #end

  #todo params
  #def set_blind(session, device) do
  #  call_api("setblind",session,device)
  #end




end
