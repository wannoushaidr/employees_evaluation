

<h1>accessory index </h1>

@extends('accessory.layout')

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

<a style="margin:50px;" class="btn btn-sm btn-success" href="{{route('accessories.create')}}">create  accessory </a>
<br>
<a style="margin:50px;" class="btn btn-sm btn-success" href="{{route('companies.index')}}">go  to companies </a>

<a style="margin:50px;" class="btn btn-sm btn-success" href="{{route('employees.index')}}">go to empoyees </a>

<a style="margin:50px;" class="btn btn-sm btn-success" href="{{route('branches.index')}}">go to branches </a>

<table class="table">
    <thead>
      <tr>
        <th scope="col">#</th>
        <th scope="col">type</th>
        <th scope="col">image</th>
        <th scope="col">branch_id</th>
      </tr>
    </thead>
    <tbody>
        @foreach ($data as $info)
      <tr>
        <td>{{$info->id}}</td>
        <td>{{$info->type}}</td>
        <td><img src="{{$info->image}}" alt="Description of image" class="img-fluid" style="max-width: 100px; height: auto;">> <div>{{$info->image}}</div></td>
        <td>{{$info->branch_id}}</td>


        <td><a style="color:white" class="btn btn-sm btn-danger" href="{{route('accessories.edit',$info->id)}}">edit</a></td>
        <td><form action="{{route('accessories.destroy',$info->id)}}" method="POST">
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

