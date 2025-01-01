@component('mail::message')
# Introduction

The body of your message.

@component('mail::button', ['url' => ''])
   Rest password
@endcomponent

Thanks,<br>
{{ config('app.name') }}
@endcomponent
