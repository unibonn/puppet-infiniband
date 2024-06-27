# == Class: infiniband::service
#
class infiniband::service {

  unless ($facts['os']['family'] == 'RedHat') and (versioncmp($facts['os']['release']['major'], '8') >= 0) {
    service { 'rdma':
      ensure     => $infiniband::rdma_service_ensure,
      enable     => $infiniband::rdma_service_enable,
      name       => $infiniband::rdma_service_name,
      hasstatus  => $infiniband::rdma_service_has_status,
      hasrestart => $infiniband::rdma_service_has_restart,
      before     => Service['ibacm'],
    }
  }

  service { 'ibacm':
    ensure     => $infiniband::ibacm_service_ensure,
    enable     => $infiniband::ibacm_service_enable,
    name       => $infiniband::ibacm_service_name,
    hasstatus  => $infiniband::ibacm_service_has_status,
    hasrestart => $infiniband::ibacm_service_has_restart,
  }

}
