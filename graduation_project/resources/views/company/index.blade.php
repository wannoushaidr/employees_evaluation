

<h1>company index </h1>

@extends('company.layout')

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
<a style="margin:50px;" class="btn btn-sm btn-success" href="{{route('companies.create')}}">add new companies </a>
<br>
<a style="margin:50px;" class="btn btn-sm btn-success" href="{{route('accessories.index')}}">go  to accessories </a>

<a style="margin:50px;" class="btn btn-sm btn-success" href="{{route('employees.index')}}">go to empoyees </a>

<a style="margin:50px;" class="btn btn-sm btn-success" href="{{route('branches.index')}}">go to branches </a>
<a style="margin:50px;" class="btn btn-sm btn-success" href="{{route('points.index')}}">go to points </a>


<table class="table">
    <thead>
      <tr>
        <th scope="col">#</th>
        <th scope="col">name</th>
        <th scope="col">address</th>
        <th scope="col">number</th>
        <th scope="col">number_of_branches</th>
        <th scope="col">email </th>

      </tr>
    </thead>
    <tbody>
        @foreach ($data as $info)
      <tr>
        <td>{{$info->id}}</td>
        <td>{{$info->name}}</td>
        <td>{{$info->address}}</td>
        <td>{{$info->number}}</td>
        <td>{{$info->number_of_branches}}</td>
        <td>{{$info->email}}</td>

        <td><a style="color:white" class="btn btn-sm btn-danger" href="{{route('companies.edit',$info->id)}}">edit</a></td>
        <td><form action="{{route('companies.destroy',$info->id)}}" method="POST">
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

