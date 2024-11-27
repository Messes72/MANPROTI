<?php

namespace App\Http\Controllers;

use App\Models\Article;
use App\Http\Requests\ArticleRequest;
use Illuminate\Support\Facades\Storage;
use Illuminate\Http\Request;

class ArticleController extends Controller
{
    public function index()
    {
        $articles = Article::latest()->get();
        
        \Log::info('Fetching articles: ' . $articles->count());
        
        $articlesData = $articles->map(function ($article) {
            // Tambahkan full URL untuk gambar
            $imageUrl = $article->image;
            if (!filter_var($article->image, FILTER_VALIDATE_URL)) {
                $imageUrl = asset('storage/' . $article->image);
            }
            
            return [
                'title' => $article->title,
                'date' => $article->date->format('d F Y'),
                'image' => $imageUrl,
                'content' => $article->content,
                'isAsset' => 'false'
            ];
        });

        return response()->json([
            'message' => 'Articles retrieved successfully',
            'data' => $articlesData
        ]);
    }

    public function show(Article $article)
    {
        $imageUrl = $article->image;
        if (!filter_var($article->image, FILTER_VALIDATE_URL)) {
            $imageUrl = asset('storage/' . $article->image);
        }

        $articleData = [
            'title' => $article->title,
            'date' => $article->date->format('d F Y'),
            'image' => $imageUrl,
            'content' => $article->content,
            'isAsset' => 'false',
            'additionalImages' => $article->additional_images
        ];

        return response()->json([
            'message' => 'Article details retrieved successfully',
            'data' => $articleData
        ]);
    }

    public function store(Request $request)
    {
        $request->validate([
            'title' => 'required|string|max:255',
            'content' => 'required|string',
            'image' => 'required|image|mimes:jpeg,png,jpg,gif|max:2048',
            'date' => 'required|date'
        ]);

        try {
            // Simpan gambar
            $imagePath = $request->file('image')->store('articles', 'public');
            
            $article = Article::create([
                'title' => $request->title,
                'content' => $request->content,
                'image' => $imagePath,
                'date' => $request->date
            ]);

            return response()->json([
                'message' => 'Article created successfully',
                'data' => $article
            ], 201);
        } catch (\Exception $e) {
            \Log::error('Error creating article: ' . $e->getMessage());
            return response()->json([
                'message' => 'Error creating article',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}
