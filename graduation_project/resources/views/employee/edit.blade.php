

<h1>edit create </h1>

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
   <form action="{{route('branches.update',$branches->id)}}" method='post' enctype="multipart/form-data">
    @csrf
    @method('PUT')

<div class="mb-3"  >
  <label for="" class="form-label">Name </label>
  <input type="text"
    class="form-control" name="name" value="{{ $branches->name }}" >
</div>

<div class="mb-3"  >
  <label for="" class="form-label">phone  </label>
  <input type="text"
    class="form-control" name="phone" value="{{ $branches->phone}}" >
</div>

<div class="mb-3"  >
  <label for="" class="form-label">exit_image </label>
  <input type="file"
    class="form-control" name="exit_image" >
</div>

<div class="mb-3"  >
    <label for="" class="form-label">table_image </label>
    <input type="file"
      class="form-control" name="table_image" >
  </div>

  <div class="mb-3"  >
    <label for="" class="form-label">fit_clothes_image </label>
    <input type="file"
      class="form-control" name="fit_clothes_image" >
  </div>

  <div class="mb-3"  >
    <label for="" class="form-label">address </label>
    <input type="text"
      class="form-control" name="address" value="{{ $branches->address}}">
  </div>
  div class="mb-3"  >
    <label for="" class="form-label">email </label>
    <input type="text"
      class="form-control" name="email" value="{{ $branches->email}}">
  </div>

  <button type="submit" class="btn btn-primary">Submit</button>

</form>

</div>


@endsection --}}


{{-- ********************************************************************************************************************************** --}}
{{-- ********************************************************************************************************************************** --}}
{{-- ********************************************************************************************************************************** --}}

@extends('employee.layout')
@section('title')
تعديل وظيفة
@endsection

@section('content')

<form method="post" enctype="multipart/form-data" action="{{ route('employees.update',$data['id'] )}}"  style="width: 80%; margin:0 auto;">
    @csrf
    @method('PUT')

    <div class="form-group">
        <label for="name">name </label>
        <input type="text" class="form-control" id="name"  name="name" value="{{ old('name',$data['name']) }}">
      @error('name')
      <span class="text-danger"> {{ $message }}</span>
      @enderror
      </div>

      <div class="form-group">
          <label for="number"> number </label>
          <input type="text" class="form-control" id="number"  name="number" value="{{ old('number',$data['number']) }}">
        @error('number')
        <span class="text-danger"> {{ $message }}</span>
        @enderror
        </div>

        <div class="form-group">
          <label for="description"> description </label>
          <input type="text" class="form-control" id="description"  name="description" value="{{ old('description',$data['description']) }}">
        @error('description')
        <span class="text-danger"> {{ $message }}</span>
        @enderror
        </div>


        <div>
        <label for="gender">Gender:</label>
      <select name="gender" id="gender"  required>
          <option value="">Select Gender</option>
          <option value="male" {{ old('gender') == 'male' ? 'selected' : '' }}>Male</option>
          <option value="female" {{ old('gender') == 'male' ? 'female' : '' }}>Female</option>
      </select>
      </div>

      
      <div>
        <label for="active">active:</label>
      <select name="active" id="active"  required>
          <option value="">Select Gender</option>
          <option value="true" {{ old('active') == 'true' ? 'selected' : '' }}>true</option>
          <option value="false" {{ old('active') == 'true' ? 'false' : '' }}>false</option>
      </select>
      </div>

      <div>
        <label for="position">position:</label>
      <select name="position" id="position"  required>
          <option value="">Select position</option>
          <option value="manager" {{ old('position') == 'manager' ? 'selected' : '' }}>manager</option>
          <option value="supervisor" {{ old('position') == 'supervisor' ? 'selected' : '' }}>supervisor</option>
          <option value="customer_service" {{ old('position') == 'customer_service' ? 'selected' : '' }}>customer_service</option>

      </select>
      </div>


      <div class="form-group">
        <label for="branch_id">branch_id:</label>
      <select name="branch_id" id="branch_id" required>
        @foreach($data2 as $branch)
        <option value="{{ $branch->id }}" {{ old($branch->name) == $branch->name ? 'selected' : '' }}>{{ $branch->name }}</option>
        @endforeach
        </select>
      </div>


      <div class="form-group">
        <label for="leader_id">leader_id :</label>
      <select name="leader_id" id="leader_id" required>
        @foreach($data3 as $employee)
        <option value="{{ $employee->leader_id }}" {{ old($employee->name) == $employee->name ? 'selected' : '' }}>{{ $employee->name }}</option>
        @endforeach
        <option value="">Null</option>




        <div class="image">
          <label for="image"> image </label>
          <div><img src="{{asset($data->image)}}" alt="Description of image" class="img-fluid" style="max-width: 100px; height: auto;">> <div>{{$data->image}}</div>
        </div>
          <input type="file" class="form-control" id="image"  name="image" value="{{ old('image',$data['image']) }}">

        </div>


    <button type="submit" class="btn btn-primary">edit </button>
  </form>


@endsection
