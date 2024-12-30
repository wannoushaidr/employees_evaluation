<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;

class UpdateJobs extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'updatebranches';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'update each branch make it no eamil';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
    {
        $branch=get_cols_where_limit(new Branches(),array("*"),array('id'=>1),'id','ASC',3);
        if(!empty($branch)){
            foreach($branch as $info ){
                $dataUpdate['email']="email is deleted";
                update(new Branches(),$dataUpdate,array('id'=>$info->id));
            }
        }
        return 0;
    }
}
