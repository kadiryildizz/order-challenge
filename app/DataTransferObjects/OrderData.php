<?php

namespace App\DataTransferObjects;

use App\DataTransferObjects\DataTransferObject;

class OrderData extends DataTransferObject
{
    /**
     * Constructs a new wallet data instance.
     *
     */
    public function __construct(
        protected ?int $id = null,
        protected ?int $customerId = null,
        protected ?int $companyId = null,
        protected ?int $status = null,
        protected ?string $shippingStatus = null,
        protected ?string $shippingDate = null,
        protected ?int $customerAddressId = null,
        protected ?string $code = null,
        protected ?float $total = null,
        protected ?string $address = null,
        protected ?array $items = null
    ) {
        $this->modifyEmptyStringsToNull();
    }
}

