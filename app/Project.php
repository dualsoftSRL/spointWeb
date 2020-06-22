<?php

namespace App;
use DB;
use Illuminate\Database\Eloquent\Model;

class Project extends Model
{
    protected $primaryKey = 'p_id';

    protected $guarded = ['p_id'];
    public $table = "project";

 public static function forDropdown($business_id, $prepend_none = true, $prepend_all = false)
    {
        $query = Project::where('business_id', $business_id);
      
        $all_project = $query->select('p_id', 'name');

        $project = $all_project->pluck('name', 'p_id');

        //Prepend none
        if ($prepend_none) {
            $project = $project->prepend(__('lang_v1.none'), '');
        }

        //Prepend all
        if ($prepend_all) {
            $project = $project->prepend(__('lang_v1.all'), '');
        }
        
        return $project;
    }

}
