---
layout: post
date: 2023-03-21 14:00:46 +0900
title: "Localize blog with Polyglot Pt.1"
description: "Didn't worked as expected."
categories: [Sapjil, Blog, Localization,]
---
Started using Jekyll-Polyglot to add localization to my blog.

I heard that github page does not allow to use Polyglot directly because of security.
Just decided to push this post with edited blog. Problem-solving thingy will be the main part of Pt.2 if there's any problem.
If not, Pt.2 will be about implementing button for language switching. Pt.2 will be added anyway.

### Installation
This lines were added to `Gemfile`,
```
group :jekyll_plugins do
  gem "jekyll-polyglot"
end
```

and this lines were added to `_config.yml`.
```yml
languages: ["en", "ko"]
exclude_from_localization: ["assets"]
lang_from_path: true
parallel_localization: false
```
On `languages`, target languages in format of [ISO 639](https://en.wikipedia.org/wiki/ISO_639) code was listed.
On `execlude_from_localization`, I listed out the name of directories which contains files not intended to be localized(like JS files, or images, etc.).
`lang_from_path` will be explained later.
`parallel_localization` is a boolean variable about using `fork()` for localization support.
Windows, which is my current test environment, does not support it, so it was disabled.
`default_lang` can decide which language in `languages` list is main language. Its default value is english, so it was not added.

There is a bug on Polyglot with Jekyll 4 which overwrite the actuall CSS file with SCSS sourcemap.
It can be evaded by following lines.
```yml
sass:
  sourcemap: 'never'
  line_comments: true
```

To run on test environment, I executed `bundle` to download `jekyll-polyglot` gem.

### Directory structure
Polyglot recognize document langauge with `lang` variable written in post's YAML frontmatter, according to their readme document.
To use that, the post should also contains `permalink` in its frontmatter.
Adding it to every current and future post is kind of bothersome. so I took the other approach.
```yml
lang_from_path: true
```
This line added in `_config.yml` is it. When it is set, first or second section of path can be used to indicate the posts' target language.
The problem is, only the first or second section can be used.
It can only be used in a two form; `/_posts/[language]/postname.md` or `/en/postname.md`.
My intension was to use `/_posts/doc-name/[language].md` kind of form, but it cannot be achieved without modifying Polyglot.
I think I will try modyfying it someday, but will be in low priority.

### Misc.
I added
```yml
permalink: /:year/:month/:title
```
to `_config.yml` to prevent Categories dangling around on Permalink.
It would be a good idea to add yearly/monthly index list. I will try it afterwords.
There is already a [plugin](https://github.com/field-theory/jekyll-category-pages) which groups out posts in categories.
Highly chance that I will use it in next modification of my blog.

You can access korean version of this blog <a {% static_href %}href="/blog/ko/"{% endstatic_href %}>here</a> for now.
