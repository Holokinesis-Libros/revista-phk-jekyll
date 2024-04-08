---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

layout: page
title: Psicología Holokinética
subtitle: Revista Oficial
# Para SEO
# subtitle: The page subtitle
# description: This is the meta description for this page and will help it appear in search engines
# image: /img/page-image.jpg
# hero_height: is-fullwidth
hero_link: /volumenes/volumen-059
hero_link_text: Número 59
---

# Volúmenes anteriores


<div class="grid">
    {% assign revistas = site.volumenes | sort: "issue_number" | reverse %}
    {% for revista in revistas %}
    <div class="cell">
        <a href="{{revista.url}}">
        <div class="card">
            <div class="card-image">
                <figure class="image is-4by3">
                <img class="pdf-thumbnail-clip"
                    src="{{revista.pdf_file | pdf_thumbnail}}"
                    alt="Placeholder image"
                />
                </figure>
            </div>
            <div class="card-content">
                <div class="media">
                    <div class="media-left">
                        <figure class="image is-48x48">
                        <img
                            src="/assets/img/navbar-logo-plain.svg"
                            alt="Placeholder image"
                        />
                        </figure>
                    </div>
                    <div class="media-content">
                        <p class="title is-4">{{revista.issue_number}}</p>
                    </div>
                </div>
            </div>
        </div>
        </a>
</div>
{% endfor %}
</div>
