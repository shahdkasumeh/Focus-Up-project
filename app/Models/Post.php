<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Post extends Model
{
    /** @use HasFactory<\Database\Factories\PostFactory> */
    use HasFactory;
    protected $table = 'Posts';

    protected $fillable = [
        'title',
        'content',
        'userid',
        'likes_count',
    ];

    public function user()
    {
        return $this->belongsTo(User::class,'userid');
    }

    public function comments()
    {
        return $this->hasMany(Comment::class);
    }


}
