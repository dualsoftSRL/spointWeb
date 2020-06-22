<?php

namespace App;

use DB;
use Illuminate\Database\Eloquent\Model;

class Ncf extends Model
{
    /**
     * The attributes that aren't mass assignable.
     *
     * @var array
     */
    protected $guarded = ['id'];
    public $table = "ncf";

    /**
     * Return list of locations for a business
     *
     * @param int $business_id
     * @param boolean $show_all = false
     * @param array $receipt_printer_type_attribute =
     *
     * @return array
     */
   



    public static function forDropdown1()
    {
        $idncf = Ncf::get();

        $dropdown = [];

        
        
        foreach ($idncf as $idncf1) {
                $dropdown[$idncf1->idncf] = $idncf1->nombre;
            
        }
        return $dropdown;
    }
    public static function forDropdown2($business_id)
    {
        $idncf = Ncf::join(
            'ncf_secuencia AS pv',
            'ncf.idncf',
            '=',
            'pv.idncf'
        )
        ->whereIn('pv.status',[1,2])
        ->where('pv.business_id',$business_id)
        ->get();

        $dropdown = [];

        
        
        foreach ($idncf as $idncf1) {
                $dropdown[$idncf1->idncf] = $idncf1->nombre;
            
        }
        return $dropdown;
    }
    public function price_group()
    {
        return $this->belongsTo(\App\SellingPriceGroup::class, 'selling_price_group_id');
    }

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
