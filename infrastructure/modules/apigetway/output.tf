output "apigw_invoke_url" {
  value = "http://localhost:4566/restapis/${aws_api_gateway_deployment.example_gateway_deployment.rest_api_id}/local/_user_request_"
}