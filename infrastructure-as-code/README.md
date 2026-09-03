# Infrastructure as Code

Standards and guidance for deploying Azure infrastructure through code.

## Documented Implementation

Our [Terraform Platform](terraform-platform.md) uses:

- Artifactory as the Terraform registry
- Azure Storage Accounts for Terraform state files
- GitHub Actions for workflows

The technologies are confirmed. Their detailed configuration, access model, ownership, and operating procedures remain to be documented.

## Additional Content to Document

- Terraform standards
- Approved module and provider inventory and publication process
- Repository structure
- State conventions and operations
- Provider standards
- Versioning
- Testing
- Deployment patterns
- GitHub Actions workflow patterns and runner configuration

## Related Sections

- [Terraform Command Cheat Sheet](../command-cheat-sheets/terraform.md)
- [CI/CD](../ci-cd/README.md)
- [Resource Security Baseline](../security/resource-security-baseline.md)
- [Standards and Guidelines](../standards-and-guidelines/README.md)

[Home](../Home.md)
