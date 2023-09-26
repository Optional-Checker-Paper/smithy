$version: "2.0"

namespace example

use smithy.rules#endpointRuleSet
use smithy.rules#endpointTests

@endpointRuleSet({
    "parameters": {
        "Region": {
            "type": "string",
            "builtIn": "AWS::Region",
            "documentation": "The region to dispatch this request, eg. `us-east-1`."
        }
    },
    "rules": [
        {
            "documentation": "Template the region into the URI when region is set",
            "conditions": [
                {
                    "fn": "isSet",
                    "argv": [
                        {
                            "ref": "Region"
                        }
                    ]
                },
                {
                    "fn": "stringEquals",
                    "argv": [
                        {
                            "ref": "Region"
                        },
                        "a"
                    ]
                }
            ],
            "endpoint": {
                "url": "https://{Region}.amazonaws.com",
                "properties": {
                    "authSchemes": [
                        {
                            "name": "sigv4",
                        }
                    ]
                }
            },
            "type": "endpoint"
        },
        {
            "documentation": "Template the region into the URI when region is set",
            "conditions": [
                {
                    "fn": "isSet",
                    "argv": [
                        {
                            "ref": "Region"
                        }
                    ]
                },
            ],
            "endpoint": {
                "url": "https://{Region}.amazonaws.com",
                "properties": {
                    "authSchemes": [
                        {
                            "name": "sigv4a",
                            "signingRegionSet": ["*"]
                        }
                    ]
                }
            },
            "type": "endpoint"
        },
        {
            "documentation": "fallback when region is unset",
            "conditions": [],
            "error": "Region must be set to resolve a valid endpoint",
            "type": "error"
        }
    ],
    "version": "1.3"
})
service FizzBuzz {}