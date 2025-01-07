<?php

namespace App\Http\Controllers;

use App\Models\Points;
use Illuminate\Http\Request;
use App\Models\Employees;
use Illuminate\Support\Facades\Validator;


class PointsController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $data=Points::select('*')->orderby("id","ASC")->paginate(4);
            return view('point.index',['data'=>$data]);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    
    {
        $data=Points::select('*')->orderby("id","ASC")->paginate(100);
        $data2=Employees::select('*')->orderby("id","ASC")->paginate(100);


        return view('point.create',['data'=>$data,'data2'=>$data2]);

        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $datatoinsert['points_count'] = $request->points_count;
        $datatoinsert['description'] = $request->description;
        $datatoinsert['employee_id'] = $request->employee_id;

        // Create a new Branches record
        Points::create($datatoinsert);

        // Redirect with success message
        return redirect()->route('points.index')->with('success', 'employees stored successfully');



    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Points  $points
     * @return \Illuminate\Http\Response
     */
    public function show(Points $points)
    {
        
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Points  $points
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $data=Points::select("*")->find($id);
        $data2=Employees::select('*')->orderby("id","ASC")->paginate(100);


        return view('point.edit',['data'=>$data,'data2'=>$data2]);

    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Points  $points
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $datatoinsert['points_count'] = $request->points_count;
        $datatoinsert['description'] = $request->description;
        $datatoinsert['employee_id'] = $request->employee_id;
        Points::where(['id'=>$id])->update($datatoinsert);


        // Redirect with success message
        return redirect()->route('points.index')->with('success', 'points updated successfully');

    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Points  $points
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        Points::where(['id'=>$id])->delete();
        return redirect()->route('points.index');
    }
}
