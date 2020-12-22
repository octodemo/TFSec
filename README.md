# TFSec-Test

This Repository is used to demonstrate the capabilities of TFSEC https://github.com/tfsec/tfsec and how it can be integrated as part of a GitHub Action.

# Terraform main.tf file
The terraform main.tf file calls @kleeadrians terraform cloud workspace which is set as a secret. 

It creates 2 NEtwork security rules which allows all where tfsec will block the PR if it happens.

