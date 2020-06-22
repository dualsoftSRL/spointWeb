<?php

namespace App;

use DB;
use Illuminate\Database\Eloquent\Model;
class Ncfsecuencia extends Model
{
    /**
     * The attributes that aren't mass assignable.
     *
     * @var array
     */
    protected $primaryKey = 'idncfsecuencia';

    protected $guarded = ['idncfsecuencia'];
    public $table = "ncf_secuencia";

    /**
     * Return list of locations for a business
     *
     * @param int $business_id
     * @param boolean $show_all = false
     * @param array $receipt_printer_type_attribute =
     *
     * @return array
     */
   



   
   

    /**
     * Scope a query to only include active location.
     *
     * @param \Illuminate\Database\Eloquent\Builder $query
     * @return \Illuminate\Database\Eloquent\Builder
     */
    public function scopeActive($query)
    {
        return $query->where('is_active', 1);
    }
}
