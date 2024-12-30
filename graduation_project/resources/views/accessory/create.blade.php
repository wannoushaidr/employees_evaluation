

@extends('accessory.layout')
@section('title')
اضافة وظيفة جديدة
@endsection

@section('content')

<form method="post" enctype="multipart/form-data" action="{{ route('accessories.store') }}"  style="width: 80%; margin:0 auto;">
    @csrf


    <div class="form-group">
        <label for="type">type</label>
    <select name="type" id="type" required>
        <option value="exit_door" {{ old('type') == 'exit_door' ? 'selected' : '' }}>exit_door</option>
        <option value="dressing_room" {{ old('type') == 'dressing_room' ? 'selected' : '' }}>dressing_room</option>
    </select>
    @error('type')
    <span class="text-danger"> {{ $message }}</span>
    @enderror
    </div>

    <div class="form-group">
        <label for="branch_id">Select branch_id</label>
        <select name="branch_id" id="branch_id" class="form-control" required>
            {{-- <option value="">Choose a company</option> --}}
            @foreach($data as $branch)
                <option value="{{ $branch->id }}">{{ $branch->name }}</option>
            @endforeach
        </select>
        @error('branch_id')
      <span class="text-danger"> {{ $message }}</span>
      @enderror
      </div>

    </div>


      <div class="form-group">
        <label for="image"> image </label>
        <input type="file" class="form-control" id="image"  name="image" value="{{ old('image') }}">
      @error('image')
      <span class="text-danger"> {{ $message }}</span>
      @enderror
      </div>


    <button type="submit" class="btn btn-primary">create </button>
  </form>


@endsection
