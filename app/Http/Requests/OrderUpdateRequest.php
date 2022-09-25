<?php

namespace App\Http\Requests;

use App\Enums\CustomerRoles;
use App\Enums\OrderStatus;
use App\Enums\ProductStatus;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\Auth;
use Illuminate\Validation\Rule;

class OrderUpdateRequest extends FormRequest
{

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, mixed>
     */
    public function rules()
    {
        $customer = Auth::user();

        return [
            'id' => [
                'required',
                'integer',
                Rule::exists('orders', 'id')->where(function ($query) use ($customer) {
                    if($customer->role !== CustomerRoles::ADMIN){
                        $query->where('customer_id', '=', $customer->id);
                    }
                }),
            ],
            'products.*.id' => [
                'nullable',
                'integer',
                Rule::exists('products', 'id')->where('status', ProductStatus::ACTIVE),
            ],
            'products.*.quantity' => [
                'nullable',
                'integer',
                'between: 0,5',
            ],
            'customer_address_id' => [
                'nullable',
                'integer',
                Rule::exists('customer_addresses', 'id')->where('customer_id',Auth::user()->id),
            ]
        ];
    }

    public function messages()
    {
        return [

        ];
    }
}
