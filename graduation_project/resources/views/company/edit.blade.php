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

@extends('company.layout')
@section('title')
تعديل وظيفة
@endsection

@section('content')

<form method="post" enctype="multipart/form-data" action="{{ route('companies.update',$data['id'] )}}"  style="width: 80%; margin:0 auto;">
    @csrf
    @method('PUT')

    <div class="form-group">
      <label for="name">  name </label>
      <input type="text" class="form-control" id="name"  name="name" value="{{ old('name',$data['name']) }}">
    @error('name')
    <span class="text-danger"> {{ $message }}</span>
    @enderror
    </div>

    <div class="form-group">
        <label for="address"> address </label>
        <input type="text" class="form-control" id="address"  name="address" value="{{ old('address',$data['address'] ) }}">
      @error('address')
      <span class="text-danger"> {{ $message }}</span>
      @enderror
      </div>

      <div class="form-group">
        <label for="number"> number </label>
        <input type="text" class="form-control" id="number"  name="number" value="{{  old('number',$data['number']) }}">
      </div>

      <div class="form-group">
        <label for="number_of_branches"> number_of_branches </label>
        <input type="number" class="form-control" id="number_of_branches"  name="number_of_branches" value="{{  old('number_of_branches',$data['number_of_branches']) }}">
      </div>

      <div class="form-group">
        <label for="email"> email </label>
        <input type="text" class="form-control" id="email"  name="email" value="{{ old('email',$data['email'])  }}">
      </div>

    <button type="submit" class="btn btn-primary">edit </button>
  </form>


@endsection
