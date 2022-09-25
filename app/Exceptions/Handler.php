<?php

namespace App\Exceptions;

use App\Enums\ErrorCodes;
use App\Libraries\Responder;
use http\Env\Request;
use Illuminate\Foundation\Exceptions\Handler as ExceptionHandler;
use Illuminate\Http\JsonResponse;
use Throwable;

class Handler extends ExceptionHandler
{
    /**
     * A list of exception types with their corresponding custom log levels.
     *
     * @var array<class-string<\Throwable>, \Psr\Log\LogLevel::*>
     */
    protected $levels = [
        //
    ];

    /**
     * A list of the exception types that are not reported.
     *
     * @var array<int, class-string<\Throwable>>
     */
    protected $dontReport = [
        //
    ];

    /**
     * A list of the inputs that are never flashed to the session on validation exceptions.
     *
     * @var array<int, string>
     */
    protected $dontFlash = [
        'current_password',
        'password',
        'password_confirmation',
    ];

    /**
     * Register the exception handling callbacks for the application.
     *
     * @return void
     */
    public function register()
    {

    }

    /**
     * @param \Illuminate\Http\Request $request
     * @param Throwable $e
     * @return JsonResponse
     * @throws Throwable
     */
    public function render($request,Throwable $e): JsonResponse
    {
        $render = parent::render($request, $e);
        $httpStatusCode = $render->getStatusCode();

        if (method_exists($e, 'getStatusCode')) {
            $httpStatusCode = $e->getStatusCode();
        }
        $errorCode = sprintf('%s::%s',ErrorCodes::class,$e->getMessage());
        if(defined($errorCode)){
            $errorCode = constant($errorCode);
            return Responder::error(
                errorCode: $errorCode['code'],
                errorMessage: $errorCode['message'],
                httpStatusCode: $httpStatusCode,
            );
        }
        return Responder::error(
            errorCode: $e->getCode(),
            errorMessage: $e->getMessage(),
            httpStatusCode: $httpStatusCode,
        );
    }
}
