# Demo Terraform Template Module

This is a terraform module and is only meant for consumption as a module. For validating behavior either make sure to write good tests or create the infrastructure repository that consumes this module.

# Deploying

## Prerequisites

### Tools

- `docker` (with Compose)
- `localstack` (need an API key to have full test usage - see [here](#localstack) for what systems provide false positives)
- `go-task`
- `aws-cli`
- `terraform`

# Contributing

The recommended organization of infrastructure code is to group resources into their intended solutions and assign files to containing solutions.

e.g. The [`network.tf`](./network.tf) file contains VPC and related configuration. A `database.tf` file would contain database configuration.

All variables and output that pertain to an infrastructure solution should be scoped to that file when appropriate. This ensures that if the infrastructure ever needs disposed of the entire file can be removed without any worry of miscellaneous and unmaintained variables or outputs sitting around.

Expose module behavior through feature flags as input variables.

## Testing

Testing is accomplished through `terraform test` and `localstack` (via Docker Compose).

### Running tests

Run

- `docker compose up -d`
- `terraform test`

### Writing tests

Good test-driven development starts with writing the test module before writing the code that should be tested. Then iterate between implementing tests to pass and modifying test assertions to cause them to fail until the desired assertion is reached.

See [here](https://developer.hashicorp.com/terraform/language/modules/testing-experiment#sending-feedback) for general information on writing tests.

See the [`default`](./tests/default) test suite for an example on how to configure the modules and AWS provider such that `terraform test`s are performed locally with `localstack`.

- Create a new test suite if needed for your work.

- Create new files for infrastructure solutions desired (`server.tf`, `database.tf`, etc.).

- Write in `terraform` resources or modules to get tests passing.

# Localstack

Without a pro license these are the known systems that will exhibit false positives for passing tests

- `compute`/EC2 Instances
- `sftp`/Amazon Transfer Family
