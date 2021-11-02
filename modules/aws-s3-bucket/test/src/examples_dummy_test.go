package test

import (
    "fmt"
    "strings"
    "testing"

    "github.com/gruntwork-io/terratest/modules/aws"
    "github.com/gruntwork-io/terratest/modules/random"
    "github.com/gruntwork-io/terratest/modules/terraform"
    "github.com/stretchr/testify/assert"
)

// Test the Terraform module in examples/dummy using Terratest
func TestExamplesComplete(t *testing.T) {
    t.Parallel()

    // Give a S3 Bucket unique ID
    expectedS3BucketId := strings.ToLower(random.UniqueId())

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
        // Variables to pass through the -var options
        Vars: map[string]interface{}{
            "bucket_name": expectedS3BucketId,
        },
    }

    // Teardown: at the end of the test, destroy any resources that were created
    defer terraform.Destroy(t, terraformOptions)

    // This will setup the test and fail if there are any errors
    terraform.InitAndApply(t, terraformOptions)

    // Run terraform output to get the value of an output variable
    s3BucketId := terraform.Output(t, terraformOptions, "dummy_s3_bucket_id")

    // Verify we're getting back the outputs we expect
    assert.Equal(t, fmt.Sprintf("am-euw1-bk-poc-%s-s301-epd", expectedS3BucketId), s3BucketId)

    // Verify that a S3 Bucket has versioning enabled
    actualVersioning := aws.GetS3BucketVersioning(t, awsRegion, s3BucketId)
    assert.Equal(t, "Enabled", actualVersioning)

    // Verify that a S3 Bucket has a policy attached
    aws.AssertS3BucketPolicyExists(t, awsRegion, s3BucketId)
}
