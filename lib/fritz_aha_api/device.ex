defmodule FritzAhaApi.Device do
  defstruct [
    #attributes
    identifier: nil,
    id: nil,
    fwversion: nil,
    manufacturer: "AVM",
    productname: nil,
    functionbitmask: nil,

    #values
    present: 0,
    txbusy: 0,
    name: nil,

    #optional
    batterylow: 0,
    battery: nil
 ]
end
