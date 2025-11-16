from constants.global_contexts import kite_context

def fetch_request_token(event, context):
    redirect_url = kite_context.login_url()
    return {
        "statusCode": 302,
        "headers": {
            "Location": redirect_url
        },
        "body": ""
    }
