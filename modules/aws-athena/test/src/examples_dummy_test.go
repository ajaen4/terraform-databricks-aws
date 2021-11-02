package test

import (
    "fmt"
    "testing"

    "github.com/gruntwork-io/terratest/modules/terraform"
    "github.com/stretchr/testify/assert"
)

// Test the Terraform module in examples/dummy using Terratest
func TestExamplesComplete(t *testing.T) {
    t.Parallel()

    awsRegion := "eu-west-1"

    terraformOptions := &terraform.Options{
        // The path to where our Terraform code is defined
        TerraformDir: "../../examples/dummy",
        // The max line size of stdout and stderr
        OutputMaxLineSize: 128 * 1024,
        // Opt to upgrade modules and plugins as part of init step
        Upgrade: true,
        // Variables to pass through the -var-file option
        VarFiles: []string{"fixtures.eu-west-1.tfvars"},
        // Environment variables to set when running Terraform
        EnvVars: map[string]string{
            "AWS_DEFAULT_REGION": awsRegion,
        },
    }

    // Teardown: at the end of the test, destroy any resources that were created
    defer terraform.Destroy(t, terraformOptions)

    // This will setup the test and fail if there are any errors
    terraform.InitAndApply(t, terraformOptions)

    // Run terraform output to get the value of an output variable
    athenaId := terraform.Output(t, terraformOptions, "dummy_athena_wg_id")
    // Verify we're getting back the outputs we expect
    assert.Equal(t, "am-euw1-bk-poc-test-athena01-epd", athenaId)

    // Run terraform output to get the value of an output variable
    glueId := terraform.Output(t, terraformOptions, "dummy_athena_crawler_id")
    // Verify we're getting back the outputs we expect
    assert.Equal(t, "am-euw1-bk-poc-test-glue01-epd", glueId)

    // Run terraform output to get the value of an output variable
    athenaArn := terraform.Output(t, terraformOptions, "dummy_athena_wg_arn")
    // Verify we're getting back the outputs we expect
    assert.Contains(t, athenaArn, fmt.Sprintf("arn:aws:athena:%s:", awsRegion))
}
