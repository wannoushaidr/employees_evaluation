
<!-- kesson 27 helper function -->
<?php
function helper_function(){
    echo "how use helper function ";
}

// lesson 28 using helper for controller

function get_cols_where_p($model=null,$columns=array(),$where=array(),$orderbyfilled='id',$orderbytype='ASC',$paginationcounter=3){
        $data=$model::select($columns)->where($where)->orderby($orderbyfilled,$orderbytype)->paginate($paginationcounter);
        return $data;
}

function get_cols_where_limit($model=null,$columns=array(),$where=array(),$orderbyfilled='id',$orderbytype='ASC',$limit=5){
    $data=$model::select($columns)->where($where)->orderby($orderbyfilled,$orderbytype)->paginate($limit)->get();
    return $data;
}


function insert($model=null,$dataToinsert=array()){
    $flag=$model::create($dataToinsert);
    return $flag;

}

function update($model=null,$datatoinsert=array(),$where=array()){
    $flag=$model::where($where)->update($datatoinsert);
    return $flag;

}





function get_cols_where_row($model=null,$columns=array(),$where=array()){
    $flag=$model::select($columns)->where($where)->first();
    return $flag;

}

function delete($model=null,$where=array()){
    $flag=$model::where($where)->delete();
    return $flag;

}





?>