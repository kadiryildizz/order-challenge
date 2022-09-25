<?php

namespace App\Http\Controllers\Api\Auth;

use App\Http\Controllers\Controller;
use App\Http\Requests\LoginPostRequest;
use App\Libraries\Responder;
use App\Models\Customer;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Hash;




class LoginController extends Controller
{
    /**
     * @param LoginPostRequest $request
     * @return JsonResponse
     * @throws \Exception
     */
    public function login(LoginPostRequest $request): JsonResponse
    {
        $customer = Customer::where('company_id', $request->company_id)
            ->where('email', $request->email)->first();

        if (empty($customer)) {
            throw new \Exception('VALIDATION_USER_EXISTS');
        }

        if(Hash::check($request->password, $customer->password)){
            $customer->setToken();
            return Responder::success(['token'=>$customer->getToken()]);
        }else{
            throw new \Exception('VALIDATION_WRONG_PASSWORD');
        }

    }
}
