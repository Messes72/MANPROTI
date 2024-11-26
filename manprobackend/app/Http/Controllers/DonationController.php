<?php

namespace App\Http\Controllers;

use App\Http\Requests\DonationRequest;
use App\Models\Donation;
use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;

class DonationController extends Controller
{
    public function donasi(DonationRequest $request)
    {
        $validated = $request->validated();
        
        $donation = Donation::create([
            'user_id' => Auth::id(),
            'type' => $validated['type'],
            'quantity' => $validated['quantity'],
            'shipping_method' => $validated['shipping_method'],
            'status' => 'pending',
            'notes' => $validated['notes'] ?? null
        ]);

        return response()->json([
            'message' => 'Donation created successfully',
            'data' => $donation
        ], 201);
    }

    public function history()
    {
        $donations = Donation::where('user_id', Auth::id())
            ->orderBy('created_at', 'desc')
            ->get()
            ->map(function ($donation) {
                return [
                    'id' => $donation->id,
                    'type' => $donation->type,
                    'quantity' => $donation->quantity,
                    'shippingMethod' => $donation->shipping_method,
                    'notes' => $donation->notes ?? '-',
                    'status' => $donation->status,
                    'created_at' => $donation->created_at->format('Y-m-d H:i:s')
                ];
            });

        return response()->json([
            'message' => 'Donation history retrieved successfully',
            'data' => $donations
        ]);
    }

    public function updateStatus(Request $request, Donation $donation)
    {
        $request->validate([
            'status' => 'required|in:pending,success,failed'
        ]);

        $donation->status = $request->status;
        $donation->save();

        return response()->json([
            'message' => 'Status updated successfully',
            'data' => $donation
        ]);
    }
}
