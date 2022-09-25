<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use App\Enums\CompanyStatus;
use App\Enums\CustomerStatus;
use App\Enums\ProductStatus;
use App\Enums\AddressStatus;
use App\Enums\OrderStatus;
use App\Enums\CustomerRoles;
use App\Enums\ShippingStatus;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('companies', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->string('name', 180);
            $table->tinyInteger('status')->default(CompanyStatus::ACTIVE)->index()->comment(implode(',', CompanyStatus::values()));
            $table->timestamps();
        });

        Schema::create('customers', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('company_id')->unsigned();
            $table->string('name');
            $table->string('email');
            $table->timestamp('email_verified_at')->nullable();
            $table->string('password');
            $table->rememberToken();
            $table->tinyInteger('status')->default(CustomerStatus::ACTIVE)->index()->comment(implode(',', CustomerStatus::values()));
            $table->tinyInteger('role')->default(CustomerRoles::CUSTOMER)->index()->comment(implode(',', CustomerRoles::values()));
            $table->timestamps();
        });

        Schema::create('products', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->string('name', 180);
            $table->string('slug', 180)->unique();
            $table->bigInteger('company_id')->unsigned();
            $table->float('price');
            $table->integer('stock');
            $table->tinyInteger('status')->default(ProductStatus::ACTIVE)->index()->comment(implode(',', ProductStatus::values()));
            $table->timestamps();
        });

        Schema::create('customer_addresses', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->bigInteger('customer_id')->unsigned();
            $table->string('name', 180);
            $table->text('address_text');
            $table->tinyInteger('status')->default(AddressStatus::ACTIVE)->index()->comment(implode(',', AddressStatus::values()));
            $table->timestamps();
        });

        Schema::create('orders', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->bigInteger('customer_id')->unsigned();
            $table->bigInteger('company_id')->nullable()->unsigned();
            $table->tinyInteger('status')->default(OrderStatus::DRAFT)->index()->comment(implode(',', OrderStatus::values()));
            $table->enum('shipping_status', ShippingStatus::values())->default(ShippingStatus::PENDING);
            $table->dateTime('shipping_date')->nullable();
            $table->bigInteger('customer_address_id')->nullable()->unsigned();
            $table->float('total');
            $table->string('code', 8);
            $table->timestamps();
        });

        Schema::create('order_products', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->bigInteger('product_id')->unsigned();
            $table->bigInteger('order_id')->unsigned();
            $table->bigInteger('company_id')->unsigned();
            $table->integer('quantity');
            $table->float('unit_price');
            $table->float('total_price');
            $table->timestamps();
        });
        Schema::table('products', function (Blueprint $table) {
            $table->foreign(['company_id'])->references(['id'])->on('companies')->onDelete('cascade');
        });
        Schema::table('orders', function (Blueprint $table) {
            $table->foreign(['customer_id'])->references(['id'])->on('customers')->onDelete('cascade');
            $table->foreign(['company_id'])->references(['id'])->on('companies')->onDelete('cascade');
            $table->foreign(['customer_address_id'])->references(['id'])->on('customer_addresses')->onDelete('cascade');
        });
        Schema::table('order_products', function (Blueprint $table) {
            $table->foreign(['product_id'])->references(['id'])->on('products')->onDelete('cascade');
            $table->foreign(['order_id'])->references(['id'])->on('orders')->onDelete('cascade');
            $table->foreign(['company_id'])->references(['id'])->on('companies')->onDelete('cascade');

        });
        Schema::table('customers', function (Blueprint $table) {
            $table->foreign(['company_id'])->references(['id'])->on('companies')->onDelete('cascade');
        });
        Schema::table('customer_addresses', function (Blueprint $table) {
            $table->foreign(['customer_id'])->references(['id'])->on('customers')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('customers', function (Blueprint $table) {
            $table->dropForeign('customers_company_id_foreign');
        });
        Schema::table('companies', function (Blueprint $table) {
            $table->dropIndex('companies_status_index');
        });
        Schema::table('products', function (Blueprint $table) {
            $table->dropForeign('products_company_id_foreign');
            $table->dropIndex('products_status_index');
        });
        Schema::table('orders', function (Blueprint $table) {
            $table->dropForeign('orders_customer_id_foreign');
            $table->dropIndex('orders_status_index');
            $table->dropForeign('orders_company_id_foreign');
            $table->dropForeign('orders_customer_address_id_foreign');
        });
        Schema::table('order_products', function (Blueprint $table) {
            $table->dropForeign('order_products_product_id_foreign');
            $table->dropForeign('order_products_order_id_foreign');
            $table->dropForeign('order_products_company_id_foreign');
        });
        Schema::table('customer_addresses', function (Blueprint $table) {
            $table->dropForeign('customer_addresses_customer_id_foreign');
            $table->dropIndex('customer_addresses_status_index');
        });
        Schema::dropIfExists('customers');
        Schema::dropIfExists('companies');
        Schema::dropIfExists('products');
        Schema::dropIfExists('orders');
        Schema::dropIfExists('order_products');
        Schema::dropIfExists('customer_addresses');
    }
};
