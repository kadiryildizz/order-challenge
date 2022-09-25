<?php

namespace App\Filters;

use Illuminate\Database\Eloquent\Builder;

class OrderGetFilters extends Filters
{
    /**
     * @var array
     */
    protected array $filters = ['code','id'];

    /**
     * @return Builder
     */
    protected function code(): Builder
    {
        return $this->builder->where('code',$this->request->code);
    }

    /**
     * @return Builder
     */
    protected function id(): Builder
    {
        return $this->builder->where('id',$this->request->id);
    }
}
