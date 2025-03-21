
    

    <div class="posts-container">
        <h2>{{ $title }}</h2>
        <ul class="posts-list">
            {% foreach $posts as $index => $post %}
                <li>
                    <a href="#" class="post-link" data-post-id="{{ $post['id'] }}">{{ $post['titulo'] }}</a>
                </li>
            {% endforeach; %}
        </ul>
    </div>
     <div class="main-content" id="preview-{{ $post['id'] }}"></div>
