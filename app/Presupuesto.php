<?php

namespace App;
use DB;
use Illuminate\Database\Eloquent\Model;

class Presupuesto extends Model
{
    protected $primaryKey = 'id ';

    protected $guarded = ['id '];
    public $table = "presupuesto";
}
