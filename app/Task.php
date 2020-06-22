<?php

namespace App;
use DB;
use Illuminate\Database\Eloquent\Model;

class Task extends Model
{
    protected $primaryKey = 'idtask';

    protected $guarded = ['idtask'];
    public $table = "task";
}
