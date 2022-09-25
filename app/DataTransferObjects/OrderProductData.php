<?php

namespace App\DataTransferObjects;

use App\DataTransferObjects\DataTransferObject;

class OrderProductData extends DataTransferObject
{
    /**
     * Constructs a new wallet data instance.
     *
     */
    public function __construct(
        protected ?int $productId = null,
        protected ?int $orderId = null,
        protected ?int $companyId = null,
        protected ?int $quantity = null,
        protected ?float $unitPrice = null,
        protected ?float $totalPrice = null,
    ) {
        $this->modifyEmptyStringsToNull();
    }
}
