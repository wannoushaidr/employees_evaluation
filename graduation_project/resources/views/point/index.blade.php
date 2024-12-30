

<h1>PointsController index </h1>

@extends('point.layout')

@section('title')
accessory
@endsection

@section('content')
@if(Session::has('success'))
<div class="alert alert-success" role="alert">
   {{ Session::get('success') }}
</div>
@endif



@section('content')

<a style="margin:50px;" class="btn btn-sm btn-success" href="{{route('points.create')}}">create  point </a>
<br>
<a style="margin:50px;" class="btn btn-sm btn-success" href="{{route('companies.index')}}">go  to companies </a>

<a style="margin:50px;" class="btn btn-sm btn-success" href="{{route('employees.index')}}">go to empoyees </a>

<a style="margin:50px;" class="btn btn-sm btn-success" href="{{route('branches.index')}}">go to branches </a>
<a style="margin:50px;" class="btn btn-sm btn-success" href="{{route('accessories.index')}}">go  to accessories </a>


<table class="table">
    <thead>
      <tr>
        <th scope="col">#</th>
        <th scope="col">points_count</th>
        <th scope="col">description</th>
        <th scope="col">employee_id</th>
        <th scope="col">update</th>
        <th scope="col">delete</th>

      </tr>
    </thead>
    <tbody>
        @foreach ($data as $info)
      <tr>
        <td>{{$info->id}}</td>
        <td>{{$info->points_count}}</td>
        <td>{{$info->description}}</td>
        <td>{{$info->employee_id}}</td>


        

        <td><a style="color:white" class="btn btn-sm btn-danger" href="{{route('points.edit',$info->id)}}">edit</a></td>
        <td><form action="{{route('points.destroy',$info->id)}}" method="POST">
            @csrf
            @method('DELETE')
            <button type="submit" class="btn btn-danger">Delete </button>
            </form></td>

    </tr>
        @endforeach
    </tbody>
  </table>
  <br>
  {{-- in this root  Providers /AppServicePrivider.php --}}
  {{ $data->links()}}

@endsection

