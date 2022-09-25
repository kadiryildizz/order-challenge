<?php

namespace App\Libraries\Order;

use App\DataTransferObjects\OrderData;
use App\DataTransferObjects\OrderProductData;
use App\Enums\ErrorCodes;
use App\Enums\ProductStatus;
use App\Models\OrderProduct;
use App\Models\Product;
use Exception;
use Throwable;
use Illuminate\Support\Facades\Log;

class OrderProductService
{
    /**
     * @param OrderData $orderData
     * @return OrderData
     * @throws Exception
     */
    public function all(OrderData $orderData): OrderData
    {
        $orderProduct = OrderProduct::where('order_id', $orderData->id)->with('product')->get();
        $orderData->total = $orderProduct->sum('total_price');
        $orderData->items = $orderProduct->map(function ($item) {
            return (new OrderProductData(
                productId: $item->product_id,
                orderId: $item->order_id,
                companyId: $item->company_id,
                quantity: $item->quantity,
                unitPrice: $item->unit_price,
                totalPrice: $item->total_price
            ));
        })->toArray();

        return $orderData;

    }

    /**
     * @param OrderData $orderData
     * @return OrderData
     * @throws Throwable
     */
    public function create(OrderData $orderData): OrderData
    {

        $products = $orderData->items;

        foreach ($products as $product)
        {
            $productId = $product['id'];
            $quantity  = $product['quantity'];

            $product = Product::where('status', ProductStatus::ACTIVE)
                ->where('id', $productId)->first();

            $orderProductData = new OrderProductData(
                productId:$productId,
                orderId:$orderData->id,
                companyId:$orderData->companyId,
                quantity:$quantity,
                unitPrice: $product->price,
                totalPrice: ($product->price*$quantity)
            );

            $this->createProduct($orderProductData);

        }
        return $orderData;
    }

    /**
     * @param OrderData $orderData
     * @return OrderData
     * @throws Throwable
     */
    public function update(OrderData $orderData): OrderData
    {
        $products = $orderData->items;

        if (!empty($products))
        {
            foreach ($products as $product)
            {
                $productId = $product['id'];
                $quantity  = $product['quantity'];

                $product = Product::where('status', ProductStatus::ACTIVE)
                    ->where('id', $productId)->first();

                $orderProductData = new OrderProductData(
                    productId:$productId,
                    orderId:$orderData->id,
                    companyId:$orderData->companyId,
                    quantity:$quantity,
                    unitPrice: $product->price,
                    totalPrice: ($product->price*$quantity)
                );

                $this->findCreateOrUpdate($orderProductData);

            }
        }


        return $orderData;
    }

    /**
     * @param OrderProductData $orderProductData
     * @return OrderProductData
     * @throws Throwable
     */
    public function createProduct(OrderProductData $orderProductData):OrderProductData
    {
        try {
            $productStockCheck = Product::where('id', $orderProductData->productId)->where('status', ProductStatus::ACTIVE)->where('stock', '>=', $orderProductData->quantity)->exists();
            if (!$productStockCheck) {
                throw new Exception(ErrorCodes::VALIDATION_PRODUCT_STOCK_EXISTS['message'], ErrorCodes::VALIDATION_PRODUCT_STOCK_EXISTS['code']);
            }
            $data = [
                'product_id' => $orderProductData->productId,
                'company_id' => $orderProductData->companyId,
                'order_id' => $orderProductData->orderId,
                'quantity' => $orderProductData->quantity,
                'unit_price' => $orderProductData->unitPrice,
                'total_price' => $orderProductData->totalPrice,
            ];
            $order = OrderProduct::create($data);
            return $orderProductData;
        } catch (\Throwable $th) {
            Log::error('OrderProductDataUpdateOrCreateError', [
                'exception' => $th,
            ]);

            throw $th;
        }
    }

    /**
     * @param OrderProductData $orderProductData
     * @return OrderProductData
     * @throws Throwable
     */
    public function findCreateOrUpdate(OrderProductData $orderProductData):OrderProductData
    {
        try {

            $order = OrderProduct::where('product_id', $orderProductData->productId)
                ->where('order_id', $orderProductData->orderId)
                ->first();

            if (!empty($order)) {
                $orderProductData->quantity   =  $orderProductData->quantity;
                $orderProductData->totalPrice = (($orderProductData->quantity * $orderProductData->unitPrice) );
            }


            $productStockCheck = Product::where('id', $orderProductData->productId)->where('status', ProductStatus::ACTIVE)->where('stock', '>=', $orderProductData->quantity)->exists();
            if (!$productStockCheck) {
                throw new Exception(ErrorCodes::VALIDATION_PRODUCT_STOCK_EXISTS['message'], ErrorCodes::VALIDATION_PRODUCT_STOCK_EXISTS['code']);
            }

            if($orderProductData->quantity < 1){
                OrderProduct::where('product_id',$orderProductData->productId)->where('order_id',$orderProductData->orderId)->delete();
                return $orderProductData;
            }

            $data = [
                'product_id' => $orderProductData->productId,
                'company_id' => $orderProductData->companyId,
                'order_id' => $orderProductData->orderId,
                'quantity' => $orderProductData->quantity,
                'unit_price' => $orderProductData->unitPrice,
                'total_price' => $orderProductData->totalPrice,
            ];
            $whr = [
                'product_id' => $orderProductData->productId,
                'company_id' => $orderProductData->companyId,
                'order_id' => $orderProductData->orderId,
            ];

            $order = OrderProduct::updateOrCreate($whr,$data);
            return $orderProductData;
        } catch (\Throwable $th) {
            Log::error('OrderProductDataUpdateOrCreateError', [
                'exception' => $th,
            ]);

            throw $th;
        }
    }
}
