resource "aws_api_gateway_rest_api" "example" {
  name        = "ServerlessApplication"
  description = "Terraform Serverless Application for BridgeCrew Assessment"
}
output "base_url" {
  value = aws_api_gateway_deployment.example.invoke_url
} 
