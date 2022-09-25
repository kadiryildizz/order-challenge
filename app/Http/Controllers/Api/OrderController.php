<?php

namespace App\Http\Controllers\Api;

use App\DataTransferObjects\OrderData;
use App\Enums\CustomerRoles;
use App\Enums\ProductStatus;
use App\Enums\ShippingStatus;
use App\Http\Controllers\Controller;
use App\Http\Requests\GetOrderFilterRequest;
use App\Http\Requests\OrderRequest;
use App\Http\Requests\OrderUpdateRequest;
use App\Libraries\Order\OrderService;
use App\Libraries\Responder;
use App\Models\Order;
use App\Models\Product;
use Carbon\Carbon;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Auth;


class OrderController extends Controller
{
    /**
     * @return JsonResponse
     * @throws \Exception
     */
    public function index(GetOrderFilterRequest $request):JsonResponse
    {
        $data = (new OrderService())->getOrders($request);
        return Responder::success($data);
    }


    /**
     * @param OrderRequest $request
     * @return JsonResponse
     * @throws \Throwable
     */
    public function add(OrderRequest $request):JsonResponse
    {

        $this->productCheck($request->products ?? null);

        $data = (new OrderService())->create(new OrderData(
            customerId:$request->user()->id,
            companyId:$request->user()->company_id,
            shippingDate:Carbon::now()->addDays(1)->format('Y-m-d h:i:s'),
            customerAddressId:$request->customer_address_id,
            items: $request->products
        ));

        return Responder::success($data);
    }

    /**
     * @param OrderUpdateRequest $request
     * @return JsonResponse
     * @throws \Throwable
     */
    public function update(OrderUpdateRequest $request):JsonResponse
    {
        $customer = Auth::user();
        $orderShippingCheck = Order::where(function ($query) use ($customer) {
            if($customer->role !== CustomerRoles::ADMIN){
                $query->where('customer_id', '=', $customer->id);
            }
            $query->where('company_id', '=', $customer->company_id);
            })
            ->where('shipping_status', ShippingStatus::DELIVERED)
            ->orWhere('shipping_date', '<=' ,Carbon::now())
            ->where('id', $request->id)
            ->where('company_id', $request->user()->company_id)
            ->first();

        if (!empty($orderShippingCheck)) {
            throw new \Exception('VALIDATION_SHIPPING_DATE');
        }


        if (!empty($request->products))
            $this->productCheck($request->products);

        $data = (new OrderService())->update(new OrderData(
            id:$request->id,
            customerId:$request->user()->id,
            companyId:$request->user()->company_id,
            customerAddressId:$request->customer_address_id,
            items: $request->products
        ));

        return Responder::success($data);
    }

    /**
     * @param array $products
     * @throws \Exception
     */
    public function productCheck(array $products)
    {
        if (empty($products)) {
            throw new \Exception('VALIDATION_PRODUCT_EXISTS');
        }

        foreach ($products as $product)
        {
            $productId = $product['id'];
            $quantity  = $product['quantity'];

            $product = Product::where('status', ProductStatus::ACTIVE)
                ->where('id', $productId)->first();

            if (empty($product)) {
                throw new \Exception('VALIDATION_PRODUCT_EXISTS');
            }

            if ($product->stock < $quantity) {
                throw new \Exception('VALIDATION_PRODUCT_STOCK_EXISTS');
            }
        }
    }
}
