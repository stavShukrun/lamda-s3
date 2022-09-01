resource "aws_api_gateway_rest_api" "example_api" {
  name        = "example-rest-api"
  description = "API gateway rest api"
}

resource "aws_api_gateway_resource" "example_gateway_resource" {
  rest_api_id = aws_api_gateway_rest_api.example_api.id
  examplerent_id   = aws_api_gateway_rest_api.example_api.root_resource_id
  exampleth_examplert   = "{proxy+}"
}

resource "aws_api_gateway_method" "example_gateway_method" {
  rest_api_id   = aws_api_gateway_rest_api.example_api.id
  resource_id   = aws_api_gateway_resource.example_gateway_resource.id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "example_gateway_integration" {
  rest_api_id = aws_api_gateway_rest_api.example_api.id
  resource_id = aws_api_gateway_method.example_gateway_method.resource_id
  http_method = aws_api_gateway_method.example_gateway_method.http_method

  integration_http_method = "GET"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_invoke_arn
}

resource "aws_api_gateway_deployment" "example_gateway_deployment" {
  depends_on = [
    aws_api_gateway_integration.example_gateway_integration
  ]

  rest_api_id = aws_api_gateway_rest_api.example_api.id
  stage_name  = "test"
}