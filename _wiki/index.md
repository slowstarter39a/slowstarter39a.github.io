---
layout  : wikiindex
title   : wiki
date    : 2017-11-26 21:38:36 +0900
updated : 2019-10-30 08:36:56 +0900
tags    : index
toc     : true
public  : true
comment : false
---

* [[vim]]
    * [[vim_command]]



--- 
# blog
<div>
    <ul>
{% for post in site.posts %}
    {% if post.public != false %}
        <li>
            <a class="post-link" href="{{ post.url | prepend: site.baseurl }}">
                {{ post.title }}
            </a>
        </li>
    {% endif %}
{% endfor %}
    </ul>
</div>
