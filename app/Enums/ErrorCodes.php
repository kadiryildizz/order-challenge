<?php

namespace App\Enums;

class ErrorCodes extends Enum
{
    const VALIDATION_FAILED = [
        'code' => 422,
        'message' => 'validation failed.'
    ];

    const SERVER_FAILED = [
        'code' => 500,
        'message' => 'server not access.'
    ];

    const VALIDATION_USER_EXISTS = [
        'code' => 5001,
        'message' => "user not exist",
    ];

    const VALIDATION_WRONG_PASSWORD = [
        'code' => 5002,
        'message' => "user in wrong password",
    ];

    const VALIDATION_PRODUCT_EXISTS = [
        'code' => 5003,
        'message' => "product not exist",
    ];

    const VALIDATION_PRODUCT_STOCK_EXISTS  = [
        'code' => 5004,
        'message' => "stock availability",
    ];
    const VALIDATION_SHIPPING_DATE  = [
        'code' => 5005,
        'message' => "in transit order",
    ];

}
