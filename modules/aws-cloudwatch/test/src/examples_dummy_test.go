package test

import (
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
    dummyAlarmName := terraform.Output(t, terraformOptions, "dummy_metric_alarm_id")

    // Verify we're getting back the outputs we expect
    assert.Equal(t, "am-euw1-bk-poc-dummy-alarm01-epd", dummyAlarmName)

    // Run terraform output to get the value of an output variable
    dummyFilterName := terraform.Output(t, terraformOptions, "dummy_metric_filter_id")

    // Verify we're getting back the outputs we expect
    assert.Equal(t, "am-euw1-bk-poc-dummy-filter01-epd", dummyFilterName)

    // Run terraform output to get the value of an output variable
    dummyEventName := terraform.Output(t, terraformOptions, "dummy_event_rule_arn")

    // Verify we're getting back the outputs we expect
    assert.Contains(t, dummyEventName, "am-euw1-bk-poc-dummy-event01-epd")
}
