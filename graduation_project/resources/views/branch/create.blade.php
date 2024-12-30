

@extends('branch.layout')
@section('title')
اضافة وظيفة جديدة
@endsection

@section('content')

<form method="post" enctype="multipart/form-data" action="{{ route('branches.store') }}"  style="width: 80%; margin:0 auto;">
    @csrf
    <div class="form-group">
      <label for="name">name </label>
      <input type="text" class="form-control" id="name"  name="name" value="{{ old('name') }}">
    @error('name')
    <span class="text-danger"> {{ $message }}</span>
    @enderror
    </div>

    <div class="form-group">
        <label for="phone"> phone </label>
        <input type="text" class="form-control" id="phone"  name="phone" value="{{ old('phone') }}">
      @error('phone')
      <span class="text-danger"> {{ $message }}</span>
      @enderror
      </div>

      <!-- <div class="form-group">
        <label for="exit_image"> exit_image </label>
        <input type="file" class="form-control" id="exit_image"  name="exit_image" value="{{ old('exit_image') }}">

      </div>

      <div class="form-group">
        <label for="table_image"> table_image </label>
        <input type="file" class="form-control" id="table_image"  name="table_image" value="{{ old('table_image') }}">

      </div>

      <div class="form-group">
        <label for="fit_clothes_image"> fit_clothes_image </label>
        <input type="file" class="form-control" id="fit_clothes_image"  name="fit_clothes_image" value="{{ old('fit_clothes_image') }}">

      </div> -->

      <div class="form-group">
        <label for="company_id">Select User</label>
        <select name="company_id" id="company_id" class="form-control" required>
            {{-- <option value="">Choose a company</option> --}}
            @foreach($data as $company)
                <option value="{{ $company->id }}">{{ $company->name }}</option>
            @endforeach
        </select>
    </div>

      <div class="form-group">
        <label for="address"> address </label>
        <input type="text" class="form-control" id="address"  name="address" value="{{ old('address') }}">

      </div>

      <div class="form-group">
        <label for="email"> email </label>
        <input type="text" class="form-control" id="email"  name="email" value="{{ old('email') }}">
      </div>




    {{-- <div>
        <label for="position">Gender:</label>
      <select name="position" id="position" required>
          <option value="">Select Gender</option>
          <option value="manager" {{ old('position') == 'manager' ? 'selected' : '' }}>manager</option>
          <option value="supervisor" {{ old('position') == 'supervisor' ? 'selected' : '' }}>supervisor</option>
          <option value="customer_service" {{ old('position') == 'customer_service' ? 'selected' : '' }}>customer_service</option>
      </select>
      </div>
 --}}


    <button type="submit" class="btn btn-primary">create </button>
  </form>


@endsection
