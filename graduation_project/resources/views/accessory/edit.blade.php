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

@extends('accessory.layout')
@section('title')
تعديل وظيفة
@endsection

@section('content')

<form method="post" enctype="multipart/form-data" action="{{ route('accessories.update',$data['id'] )}}"  style="width: 80%; margin:0 auto;">
    @csrf
    @method('PUT')



     <div>
        <label for="type">type</label>
      <select name="type" id="type" required>
          <option value="exit_door" {{ old('type') == 'exit_door' ? 'selected' : '' }}>exit_door</option>
          <option value="dressing_roomd q" {{ old('type') == 'dressing_room' ? 'selected' : '' }}>dressing_room</option>
      </select>
      @error('type')
    <span class="text-danger"> {{ $message }}</span>
    @enderror
      </div>




    <div class="form-group">
        <label for="branch_id">branch_id</label>
      <select name="branch_id" id="branch_id" required>
        @foreach($data2 as $branch)
        <option value="{{ $branch->id }}" {{ old($branch->name) == $branch->name ? 'selected' : '' }}>{{ $branch->name }}</option>
        @endforeach
        </select>
      </div>


      <div class="form-group">
        <label for="image"> image </label>
        <input type="file" class="form-control" id="image"  name="image" value="{{ old('image',$data['image'])  }}">
      </div>

    <button type="submit" class="btn btn-primary">edit </button>
  </form>


@endsection
