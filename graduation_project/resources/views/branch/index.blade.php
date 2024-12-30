

<h1>branches index </h1>

@extends('branch.layout')

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
<a style="margin:50px;" class="btn btn-sm btn-success" href="{{route('branches.create')}}">add new bracnh </a>
<br>
<a style="margin:50px;" class="btn btn-sm btn-success" href="{{route('accessories.index')}}">go  to accessories </a>

<a style="margin:50px;" class="btn btn-sm btn-success" href="{{route('employees.index')}}">go to empoyees </a>

<a style="margin:50px;" class="btn btn-sm btn-success" href="{{route('companies.index')}}">go to  companies </a>
<a style="margin:50px;" class="btn btn-sm btn-success" href="{{route('points.index')}}">go to points </a>




<table class="table">
    <thead>
      <tr>
        <th scope="col">#</th>
        <th scope="col">name</th>
        <th scope="col">phone</th>
        <!-- <th scope="col">exit_image</th> -->
        <!-- <th scope="col">table_image</th> -->
        <!-- <th scope="col">fit_clothes_image </th> -->

        <th scope="col">address</th>
        <th scope="col">email</th>
        <th scope="col">company_id</th>

        <th scope="col">edit </th>
        <th scope="col">delete</th>



      </tr>
    </thead>
    <tbody>
        @foreach ($data as $info)
      <tr>
        <td>{{$info->id}}</td>
        <td>{{$info->name}}</td>
        <td>{{$info->phone}}</td>
        
        <!-- <td><img src="{{$info->exit_image}}" alt="Description of image" class="img-fluid" style="max-width: 100px; height: auto;">><div>{{$info->exit_image}}</div></td>
        <td><img src="{{$info->table_image}}" alt="Description of image" class="img-fluid" style="max-width: 100px; height: auto;">><div>{{$info->table_image}}</div></td>
        <td><img src="{{$info->fit_clothes_image}}" alt="Description of image" class="img-fluid" style="max-width: 100px; height: auto;">> <div>{{$info->fit_clothes_image}}</div></td> -->

        <td>{{$info->address}}</td>
        <td>{{$info->email}}</td>company_id
        <td>{{$info->company_id}}</td>

        <td><a style="color:white" class="btn btn-sm btn-danger" href="{{route('branches.edit',$info->id)}}">edit</a></td>
        <td><form action="{{route('branches.destroy',$info->id)}}" method="POST">
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

