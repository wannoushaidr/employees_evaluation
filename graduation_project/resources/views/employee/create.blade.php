
<h1>employee create </h1>


@extends('employee.layout')
@section('title')
اضافة وظيفة جديدة
@endsection

@section('content')

{{-- @php
    // Initialize the selected position variable
    $selectedPosition = old('position'); // This will maintain the old input value after form submission
@endphp --}}

<form method="post" enctype="multipart/form-data" action="{{ route('employees.store') }}"  style="width: 80%; margin:0 auto;">
    @csrf
    <div class="form-group">
      <label for="name">name </label>
      <input type="text" class="form-control" id="name"  name="name" value="{{ old('name') }}">
    @error('name')
    <span class="text-danger"> {{ $message }}</span>
    @enderror
    </div>

    <div class="form-group">
        <label for="number"> number </label>
        <input type="text" class="form-control" id="number"  name="number" value="{{ old('number') }}">
      @error('number')
      <span class="text-danger"> {{ $message }}</span>
      @enderror
      </div>

      <div class="form-group">
        <label for="description"> description </label>
        <input type="text" class="form-control" id="description"  name="description" value="{{ old('description') }}">
      @error('description')
      <span class="text-danger"> {{ $message }}</span>
      @enderror
      </div>


      <div>
      <label for="gender">Gender </label>
    <select name="gender" id="gender" required>
        <option value="">Select Gender</option>
        <option value="male" {{ old('gender') == 'male' ? 'selected' : '' }}>Male</option>
        <option value="female" {{ old('gender') == 'male' ? 'female' : '' }}>Female</option>
    </select>
    </div>




    <div>
        <label for="position">position </label>
      <select name="position" id="position" required>
          <option value="">Select position</option>
          <option value="manager" {{ old('position') == 'manager' ? 'selected' : '' }}>manager</option>
          <option value="supervisor" {{ old('position') == 'supervisor' ? 'selected' : '' }}>supervisor</option>
          <option value="customer_service" {{ old('position') == 'customer_service' ? 'selected' : '' }}>customer_service</option>
      </select>
      </div>


      <div class="image">
        <label for="image"> image </label>
        <input type="file" class="form-control" id="image"  name="image" value="{{ old('image') }}">
      </div>

      <div>
        <label for="branch_id">branch</label>
      <select name="branch_id" id="branch_id" class="form-control" required>
        {{-- <option value="">Choose a company</option> --}}
        @foreach($data2 as $branch)
            <option value="{{ $branch->id }}">{{ $branch->name }}</option>
        @endforeach
        </select>
        </div>

        <div>

            <label for="leader_id">leader_id</label>

          <select name="leader_id" id="leader_id" class="form-control" required>
            <option value=""></option>

            @foreach($data as $leader)
                <option value="{{ $leader->id }}">{{ $leader->name }}</option>
            @endforeach
            <option value="">Null</option>
            </select>
            </div>

    <button type="submit" class="btn btn-primary">create </button>
  </form>


@endsection
