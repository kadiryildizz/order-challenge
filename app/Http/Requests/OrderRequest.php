<?php

namespace App\Http\Requests;

use App\Enums\ProductStatus;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class OrderRequest extends FormRequest
{

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, mixed>
     */
    public function rules()
    {
        return [
            'products' => [
                'required',
                'array'
            ],
            'products.*.id' => [
                'required',
                'integer',
                Rule::exists('products', 'id')->where('status', ProductStatus::ACTIVE),
            ],
            'products.*.quantity' => [
                'required',
                'integer',
                'between: 1,5',
            ],
            'customer_address_id' => [
                'required',
                'integer',
                Rule::exists('customer_addresses', 'id'),
            ]
        ];
    }
}
