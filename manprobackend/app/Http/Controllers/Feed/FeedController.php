<?php

namespace App\Http\Controllers\Feed;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Http\Requests\PostRequest;
use App\Models\Feed;
use App\Models\Like;
use App\Models\User;
use App\Models\Comment;


class FeedController extends Controller
{

    public function index(){
        $feeds = Feed::with('user')->latest()->get();
        return response([
            'feeds' => $feeds
        ], 200);
    }
    public function store(PostRequest $request){
        $request->validated();

        auth()->user()->feeds()->create([
            'content' => $request->content,
        ]);

        return response([
            'message' => 'Feed created successfully',
        ], 201);
    }

    public function likePost($feed_id) {
        // Debugging: Cek nilai feed_id
        // dd($feed_id);

        // Pastikan Anda mencari feed dengan benar
        $feed = Feed::find($feed_id);
        if (!$feed) {
            return response()->json(['message' => 'Feed not found'], 404);
        }

        // Unlike post
        $unlike_post = Like::where('user_id', auth()->user()->id)->where('feed_id', $feed_id)->delete();
        if($unlike_post){
            return response([
                'message' => 'Feed unliked successfully'
            ], 200);
        }

        // Like post
        $like_post = Like::create([
            'user_id' => auth()->id(),
            'feed_id' => $feed_id
        ]);
        if($like_post){
            return response([
                'message' => 'Feed liked successfully'
            ], 200);
        }
    }
    public function comment(Request $request, $feed_id){
        $request->validate([
            'body' => 'required'
        ]);

        $comment = Comment::create([
            'user_id' => auth()->id(),
            'feed_id' => $feed_id,
            'body' => $request->body
        ]);

        return response([
            'message' => 'Comment created successfully',
            
        ], 201);
    }
    public function getComments($feed_id)
    {
        $comments = Comment::with('feed')->with('user')->whereFeedId($feed_id)->latest()->get();
        
        return response([
            'comments' => $comments
        ], 200);
    }
}
