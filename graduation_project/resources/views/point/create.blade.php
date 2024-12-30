

@extends('point.layout')
@section('title')
اضافة ponus  جديدة
@endsection

@section('content')

<form method="post" enctype="multipart/form-data" action="{{ route('points.store') }}"  style="width: 80%; margin:0 auto;">
    @csrf


   

    <div class="form-group">
        <label for="employee_id">Select employee id </label>
        <select name="employee_id" id="employee_id" class="form-control" required>
            {{-- <option value="">Choose a employee_id</option> --}}
            @foreach($data2 as $branch)
                <option value="{{ $branch->id }}">{{ $branch->name }}</option>
            @endforeach
        </select>
        <!-- @error('branch_id') -->
      <!-- <span class="text-danger"> {{ $message }}</span> -->
      <!-- @enderror -->
      </div>

      <div class="form-group">
        <label for="points_count"> points_count </label>
        <input type="number" class="form-control" id="points_count"  name="points_count" value="{{ old('points_count') }}">
      <!-- @error('description')
      <span class="text-danger"> {{ $message }}</span>
      @enderror -->
      </div>
    <!-- </div> -->

    <div class="form-group">
        <label for="description"> description </label>
        <input type="text" class="form-control" id="description"  name="description" value="{{ old('description') }}">
      <!-- @error('description')
      <span class="text-danger"> {{ $message }}</span>
      @enderror -->
      </div>
    <!-- </div> -->



    <button type="submit" class="btn btn-primary">create </button>
  </form>


@endsection
