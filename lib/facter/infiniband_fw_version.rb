# Fact: infiniband_fw_version
#
# Purpose: Report the version of the InfiniBand hardware
#
# Resolution:
#   Returns the FW Version pulled from mstflint.
#
# Caveats:
#   Only tested on systems with a single InfiniBand device and
#   with mstflint 2.7.1-7 in EL6
#

require 'facter/util/infiniband'

Facter.add(:infiniband_fw_version) do
  confine :kernel => "Linux"
  confine :has_infiniband => true
  ports = Facter::Util::Infiniband.get_ports
  if ports
    fw_version = Facter::Util::Infiniband.get_port_fw_version(ports.first)
    if fw_version
      setcode do
        fw_version
      end
    end
  end
end