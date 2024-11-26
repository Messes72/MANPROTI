<?php

namespace App\Http\Controllers;

use App\Models\Event;
use App\Models\EventRegistration;
use App\Http\Requests\EventRequest;
use App\Http\Requests\EventRegistrationRequest;
use Illuminate\Support\Facades\Auth;
use App\Models\User;
use Illuminate\Http\Request;

class EventController extends Controller
{
    public function index()
    {
        $events = Event::latest()->get()->map(function ($event) {
            return [
                'id' => $event->id,
                'title' => $event->title,
                'content' => $event->content,
                'image' => $event->image,
                'date' => $event->date,
                'created_at' => $event->created_at->format('Y-m-d H:i:s')
            ];
        });
        return response()->json([
            'message' => 'Events retrieved successfully',
            'data' => $events
        ]);
    }

    public function show(Event $event)
    {
        return response()->json([
            'message' => 'Event details retrieved successfully',
            'data' => [
                'id' => $event->id,
                'title' => $event->title,
                'content' => $event->content,
                'image' => $event->image,
                'date' => $event->date,
                'created_at' => $event->created_at->format('Y-m-d H:i:s'),
                'registrations_count' => $event->registrations()->count()
            ]
        ]);
    }

    public function register(EventRegistrationRequest $request)
    {
        $registration = EventRegistration::create([
            'event_id' => $request->event_id,
            'user_id' => Auth::id(),
            'name' => $request->name,
            'email' => $request->email
        ]);

        return response()->json([
            'message' => 'Registration successful',
            'data' => $registration
        ], 201);
    }

    public function history()
    {
        $registrations = EventRegistration::with('event')
            ->where('user_id', Auth::id())
            ->latest()
            ->get();

        return response()->json(['data' => $registrations]);
    }

    // Admin only methods
    public function store(EventRequest $request)
    {
        $imagePath = $request->file('image')->store('events', 'public');

        $event = Event::create([
            'title' => $request->title,
            'content' => $request->content,
            'image' => $imagePath,
            'date' => $request->date
        ]);

        return response()->json([
            'message' => 'Event created successfully',
            'data' => $event
        ], 201);
    }

    public function validateEmail(Request $request)
    {
        $user = User::where('email', $request->email)->first();

        if ($user) {
            return response()->json([
                'message' => 'Email found',
                'valid' => true
            ], 200);
        }

        return response()->json([
            'message' => 'Email not found in database. Please use your registered email.',
            'valid' => false
        ], 404);
    }
}
