variable "vpc_cidr" {
  type = string
}
variable "ports" {
    type = list(number)
    default = []
}
variable "image_id" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "instance_name" {
  type = string
}
variable "storage_size" {
  type    = number
}

module "vpc-module" {
  source               = "./vpc-module"
  vpc_cidr             = var.vpc_cidr
}

module "s3-module" {
  source               = "./s3-module"
}

module "ec2-module" {
  source           = "./ec2-module"
  ports            = var.ports
  image_id         = var.image_id
  instance_type    = var.instance_type
  instance_name    = var.instance_name
  storage_size     = var.storage_size
  vpc_id           = module.vpc-module.vpc_id
  public_subnet_id = module.vpc-module.public_subnet_id
  depends_on       = [module.vpc-module]
}


# Outputs 

output "bucket_details" {
  value = {
    bucket_name = module.s3-module.bucket_name
    bucket_arn  = module.s3-module.bucket_arn
    s3_endpoint = module.s3-module.s3_endpoint
  }
}

output "vpc_details" {
  value = {
    vpc_id             = module.vpc-module.vpc_id
    public_subnet_id   = module.vpc-module.public_subnet_id
    public_subnet_id1   = module.vpc-module.public_subnet_id1
    private_subnet_id  = module.vpc-module.private_subnet_id
    private_subnet_id1 = module.vpc-module.private_subnet_id1
  }
}


