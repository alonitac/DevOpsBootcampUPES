# Getting started with Firebase using Terraform

Reference guide: https://firebase.google.com/docs/projects/terraform/get-started

1. Install `gcloud` (google cloud cli) - https://cloud.google.com/sdk/docs/install-sdk
2. Configure your user locally by: `gcloud auth application-default login`
3. Use the `tf_firebase/main.tf` file as a starting point for your project:
   ```bash
   cd tf_firebase
   terraform init
   terraform apply 
   ```