
<h1>employee index </h1>

@extends('employee.layout')

@section('title')
index
@endsection

@section('content')
@if(Session::has('success'))
<div class="alert alert-success" role="alert">
   {{ Session::get('success') }}
</div>
@endif



@section('content')
<a style="margin:50px;" class="btn btn-sm btn-success" href="{{route('employees.create')}}">add new employee </a>
<br>
<a style="margin:50px;" class="btn btn-sm btn-success" href="{{route('accessories.index')}}">go  to accessories </a>

<a style="margin:50px;" class="btn btn-sm btn-success" href="{{route('companies.index')}}">go to companies </a>

<a style="margin:50px;" class="btn btn-sm btn-success" href="{{route('branches.index')}}">go to branches </a>
<a style="margin:50px;" class="btn btn-sm btn-success" href="{{route('points.index')}}">go to points </a>

<table class="table">
    <thead>
      <tr>
        <th scope="col">#</th>
        <th scope="col">name</th>
        <th scope="col">number</th>
        <th scope="col">description</th>
        <th scope="col">gender</th>
        <th scope="col">position </th>
        <th scope="col">leader_id</th>
        <th scope="col">branch_name</th>
        <th scope="col">image</th>
        <th scope="col">edit</th>
        <th scope="col">delete</th>





      </tr>
    </thead>
    <tbody>


        @foreach ($data as $info)
      <tr>
        <td>{{$info->id}}</td>
        <td>{{$info->name}}</td>
        <td>{{$info->number}}</td>
        <td>{{$info->description}}</td>
        <td>{{$info->gender}}</td>
        <td>{{$info->position}}</td>
        <td>{{$info->leader_id}}</td>
    <td>{{$info->branch_id}}</td>

        <td><img src="{{$info->image}}" alt="Description of image" class="img-fluid" style="max-width: 100px; height: auto;">> <div>{{$info->image}}</div></td>


        <td><a style="color:white" class="btn btn-sm btn-danger" href="{{route('employees.edit',$info->id)}}">edit</a></td>
        <td><form action="{{route('employees.destroy',$info->id)}}" method="POST">
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

