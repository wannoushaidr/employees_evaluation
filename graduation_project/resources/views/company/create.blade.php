

@extends('company.layout')
@section('title')
اضافة وظيفة جديدة
@endsection

@section('content')

<form method="post" enctype="multipart/form-data" action="{{ route('companies.store') }}"  style="width: 80%; margin:0 auto;">
    @csrf
    <div class="form-group">
      <label for="name">name </label>
      <input type="text" class="form-control" id="name"  name="name" value="{{ old('name') }}">
    @error('name')
    <span class="text-danger"> {{ $message }}</span>
    @enderror
    </div>

    <div class="form-group">
        <label for="address"> address </label>
        <input type="text" class="form-control" id="address"  name="address" value="{{ old('address') }}">
      @error('address')
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
        <label for="email"> email </label>
        <input type="text" class="form-control" id="email"  name="email" value="{{ old('email') }}">
      @error('email')
      <span class="text-danger"> {{ $message }}</span>
      @enderror
      </div>


    <button type="submit" class="btn btn-primary">create </button>
  </form>


@endsection
