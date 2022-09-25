<?php

namespace App\Libraries\Order;

use App\DataTransferObjects\OrderData;
use App\Enums\CustomerRoles;
use App\Enums\OrderStatus;
use App\Enums\ShippingStatus;
use App\Filters\OrderGetFilters;
use App\Http\Requests\GetOrderFilterRequest;
use App\Models\Order;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Throwable;

class OrderService
{
    /**
     * @return array
     * @throws \Exception
     */
    public function getOrders(GetOrderFilterRequest $request): array
    {
        $customer = Auth::user();

        $orders = Order::where(function ($query) use ($customer) {
            if($customer->role !== CustomerRoles::ADMIN){
                $query->where('customer_id', '=', $customer->id);
            }
            $query->where('company_id', '=', $customer->company_id);
        })->filter(new OrderGetFilters($request))->get();
        $orderData = [];
        foreach ($orders as $order)
        {
            $orderData[] = (new OrderProductService())->all(new OrderData(
                id: $order->id,
                customerId: $order->customer_id,
                companyId: $order->company_id,
                status: $order->status,
                shippingStatus: $order->shipping_status,
                shippingDate: $order->shipping_date,
                customerAddressId: $order->customer_address_id,
                code: $order->code,
                total: $order->total,
                address: $order->customerAddress->address_text
            ))->toModelArray();

        }
        return $orderData;
    }



    /**
     * @param OrderData $orderData
     * @return OrderData
     * @throws Throwable
     */
    public function create(OrderData $orderData): array
    {
        DB::beginTransaction();
        try {
            $data = [
                'customer_id' => $orderData->customerId,
                'shipping_status' => ShippingStatus::PENDING,
                'company_id' => $orderData->companyId,
                'customer_address_id' => $orderData->customerAddressId,
                'shipping_date' => $orderData->shippingDate,
                'status' => OrderStatus::APPROVED,
                'code' => $this->orderCode()
            ];
            $order = Order::create($data);
            $orderData->id = $order->id;
            $orderData->address = $order->customerAddress->address_text ?? null;
            $orderData->status = $order->status;
            $orderData->shippingStatus = $order->shipping_status;
            $orderData->code = $order->code;

            $orderProductService = (new OrderProductService());
            $orderProductService->create($orderData);
            $orderData = $orderProductService->all($orderData);
            DB::commit();
            return $orderData->toModelArray();
        } catch (\Throwable $th) {
            DB::rollback();
            Log::error('OrderDataFindOrCreateError', [
                'exception' => $th,
            ]);

            throw $th;
        }
    }

    /**
     * @param OrderData $orderData
     * @return array
     * @throws Throwable
     */
    public function update(OrderData $orderData): array
    {
        DB::beginTransaction();
        try {
            $order = Order::find($orderData->id);
            $addressId = $orderData->customerAddressId;
            if( !empty($addressId) && $addressId != $order->customer_address_id ){
                $order->update([
                    'customer_address_id'=> $addressId
                ]);
            }
            $orderData->id = $order->id;
            $orderData->address = $order->customerAddress->address_text ?? null;
            $orderData->status = $order->status;
            $orderData->shippingStatus = $order->shipping_status;
            $orderData->code = $order->code;
            $orderData->customerAddressId = $order->customer_address_id;
            $orderData->shippingDate = $order->shipping_date;

            $orderProductService = (new OrderProductService());
            $orderProductService->update($orderData);
            $orderData = $orderProductService->all($orderData);

            DB::commit();
            return $orderData->toModelArray();
        } catch (\Throwable $th) {
            DB::rollback();
            Log::error('OrderDataFindOrCreateError', [
                'exception' => $th,
            ]);

            throw $th;
        }
    }

    /**
     * @param string $prefix
     * @return string
     */
    private function orderCode(string $prefix = 'ABC'):string
    {
        return $prefix.rand(1000, 9999);
    }

}
