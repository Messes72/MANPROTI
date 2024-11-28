<?php

namespace App\Http\Controllers\Feed;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Http\Requests\PostRequest;
use App\Models\Feed;
use App\Models\Like;
class FeedController extends Controller
{
    public function store(PostRequest $request){
        $request->validated();

        auth()->user()->feeds()->create([
            'content' => $request->content,
        ]);

        return response([
            'message' => 'Feed created successfully',
        ], 201);
    }

    public function likePost($feed_id){
        $feed = Feed::where($feed_id)->first();
        if(!$feed){
            return response([
                'message' => 'Feed not found'
            ], 500);
        }

        //Unlike post
        $unlike_post = Like::where('user_id', auth()->user()->id)->where('feed_id', $feed_id)->delete();
        if($unlike_post){
            return response([
                'message' => 'Feed unliked successfully'
            ], 200);
        }

        //Like post
        $like_post = Like::create([
            'user_id' => auth()->id(),
            'feed_id' => $feed_id
        ]);
        if($like_post){
            return response([
                'message' => 'Feed liked successfully'
            ], 200);
        }


        // if($feed->user_id == auth()->user()->id){
        //     Like::whereFeedId($feed_id)->delete();
        //     return response([
        //         'message' => 'Feed unliked successfully'
        //     ], 200);
        // }else{
        //     Like::create([
        //         'user_id' => auth()->user()->id,
        //         'feed_id' => $feed_id
        //     ]);
        //     return response([
        //         'message' => 'Feed liked successfully'
        //     ], 200);
        // }
    }
}
