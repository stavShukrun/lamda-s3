resource "aws_api_gateway_rest_api" "pa_api" {
  name        = "pa-rest-api"
  description = "API gateway rest api"
}

resource "aws_api_gateway_resource" "pa_gateway_resource" {
  rest_api_id = aws_api_gateway_rest_api.pa_api.id
  parent_id   = aws_api_gateway_rest_api.pa_api.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "pa_gateway_method" {
  rest_api_id   = aws_api_gateway_rest_api.pa_api.id
  resource_id   = aws_api_gateway_resource.pa_gateway_resource.id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "pa_gateway_integration" {
  rest_api_id = aws_api_gateway_rest_api.pa_api.id
  resource_id = aws_api_gateway_method.pa_gateway_method.resource_id
  http_method = aws_api_gateway_method.pa_gateway_method.http_method

  integration_http_method = "GET"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_invoke_arn
}

resource "aws_api_gateway_deployment" "pa_gateway_deployment" {
  depends_on = [
    aws_api_gateway_integration.pa_gateway_integration
  ]

  rest_api_id = aws_api_gateway_rest_api.pa_api.id
  stage_name  = "test"
}