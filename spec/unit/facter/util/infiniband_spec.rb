require 'spec_helper'
require 'facter/util/infiniband'

describe Facter::Util::Infiniband do

  before :each do
    Facter.clear
  end

  describe 'get_device_id' do
    it "should return a device ID" do
      Facter::Util::Resolution.stubs(:exec).with("lspci -d 15b3:").returns(my_fixture_read('mellanox_lspci'))
      Facter::Util::Infiniband.get_device_id.should == '03:00.0'
    end
    
    it "should return nil if no device ID found" do
      Facter::Util::Resolution.stubs(:exec).with("lspci -d 15b3:").returns(nil)
      Facter::Util::Infiniband.get_device_id.should be_nil
    end
  end

  describe 'get_fw_version' do
    it "should return a FW Version" do
      Facter::Util::Resolution.stubs(:exec).with("mstflint -device 03:00.0 -qq query").returns(my_fixture_read('mellanox_mstflint'))
      Facter::Util::Infiniband.get_fw_version.should == '2.9.1200'
    end
=begin
    # This doesn't work...WHY?
    it "should return nil if device_id is nil" do
      Facter::Util::Infiniband.stubs(:get_device_id).with().returns(nil)
      Facter::Util::Infiniband.get_fw_version().should be_nil
    end
=end
  end
end
