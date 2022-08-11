## Global tagging strategy

locals {
  # Tags for all modules
  default_tags = {
    ManagedBy = "terraform"
    OwnerName = "Razvan"
  }
}
