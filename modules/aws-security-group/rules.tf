
######
# Default Rules
######

variable "rules" {
  description = "Map of known security group rules ('name' = ['from port', 'to port', 'protocol', 'description'])"
  type        = map(list(any))

  default = {
    # HTTP
    http-80-tcp   = [80, 80, "tcp", "HTTP"]
    http-8080-tcp = [8080, 8080, "tcp", "HTTP"]
    # HTTPS
    https-443-tcp = [443, 443, "tcp", "HTTPS"]
    # NFS/EFS
    nfs-tcp = [2049, 2049, "tcp", "NFS/EFS"]
    # SSH
    ssh-tcp = [22, 22, "tcp", "SSH"]
    # Open all ports & protocols
    all-all = [-1, -1, "-1", "All protocols"]
    # Fallback rule
    _ = ["", "", "", ""]
  }
}
