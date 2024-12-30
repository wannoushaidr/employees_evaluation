{{--
<h1>branch edit </h1>

<h1>branch craete  </h1>

@extends('branch.layout')


@section('content')

<br>
<div class="container text-center">
    <div class="row">

      <div class="col align-self-start">
        <a class='btn btn-primary'  href="{{route('branches.index')}}">all process </a>
    </div>

    </div>
  </div>
  <br>

  @if($errors->any())
  <div class="alert alert-danger" role="alert">
        <ul>
            @foreach($errors->all() as $item)
                <li>{{$item}}</li>
            @endforeach

        </ul>
  </div>



  @endif


<div class="container p-5">
   <form action="{{route('points.update',$branches->id)}}" method='post' enctype="multipart/form-data">
    @csrf
    @method('PUT')


  <button type="submit" class="btn btn-primary">Submit</button>

</form>

</div>


@endsection --}}


{{-- ********************************************************************************************************************************** --}}
{{-- ********************************************************************************************************************************** --}}
{{-- ********************************************************************************************************************************** --}}

@extends('accessory.layout')
@section('title')
تعديل وظيفة
@endsection

@section('content')

<form method="post" enctype="multipart/form-data" action="{{ route('points.update',$data['id'] )}}"  style="width: 80%; margin:0 auto;">
    @csrf
    @method('PUT')



     



    <div class="form-group">
        <label for="employee_id">employee_id</label>
      <select name="employee_id" id="employee_id" required>
        @foreach($data2 as $employee)
        <option value="{{ $employee->id }}" {{ old($employee->name) == $employee->name ? 'selected' : '' }}>{{ $employee->name }}</option>
        @endforeach
        </select>
      </div>


      <div class="form-group">
        <label for="points_count"> points </label>
        <input type="number" class="form-control" id="points_count"  name="points_count" value="{{ old('points_count',$data['points_count'])  }}">
      </div>

      <div class="form-group">
        <label for="description"> description </label>
        <input type="text" class="form-control" id="description"  name="description" value="{{ old('description',$data['description'])  }}">
      </div>

    <button type="submit" class="btn btn-primary">edit </button>
  </form>


@endsection
