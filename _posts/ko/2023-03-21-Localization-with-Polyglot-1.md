---
layout: post
date: 2023-03-21 14:00:46 +0900
title: "Polyglot을 사용해서 다국어 지원 블로그 만들기 1부"
description: "아쉽게도 원하는 대로는 잘 안 됐습니다"
categories: [Sapjil, Blog, Localization,]
---
일단 Jekyll-Polyglot을 사용해서 다국어 지원을 추가해 봤다.
깃헙 페이지에서 보안 문제로 Polyglot을 그냥 직접은 못 쓰게 한다는 얘기가 있던데, 일단 이 포스트를 수정된 블로그랑 같이 푸시해 보고 문제가 생기면 해결하는 과정을 2부로 쓸 생각이다.
어차피 2부에 다른 언어판 보기 버튼 구현하는 거 쓸 거라서 1부만 쓰고 2부가 안 나오는 일은 없을 것 같다.

### 설치
일단 `Gemfile`에 다음 줄을 추가했다.
```
group :jekyll_plugins do
  gem "jekyll-polyglot"
end
```

그 뒤 `_config.yml`에 다음 설정을 추가했다.
```yml
languages: ["en", "ko"]
exclude_from_localization: ["assets"]
lang_from_path: true
parallel_localization: false
```
`languages`에는 분리할 언어의 [ISO 639](https://ko.wikipedia.org/wiki/ISO_639) 코드를 입력하면 되고,
`execlude_from_localization`에는 다국어 버전으로 나누지 않을 파일들이 들어가 있는 디렉토리(JS 파일이라던가 이미지 파일이라던가 그런 거)를 지정하면 된다.
`lang_from_path`는 따로 설명하겠다.
`parallel_localization`은 `fork()`를 사용해 다국어 지원을 할지 여부인데, 현재 테스트 환경으로 쓰고 있는 Windows는 지원하지 않기 때문에 비활성화했다.
그 외에 `default_lang` 변수로 `languages`에서 지정한 언어 중 하나를 주 언어로 지정할 수 있는데, 기본값이 영어라서 추가하진 않았다.

Polyglot을 Jekyll 4에 사용할 경우 SCSS의 CSS 소스맵이 결과 CSS를 덮어씌워버리는 버그가 있어 다음 옵션이 필요하다.
```yml
sass:
  sourcemap: 'never'
  line_comments: true
```

테스트 환경에서 구동하기 위해 `bundle`을 실행시켜 `jekyll-polyglot` gem을 다운로드받았다.

### 폴더 구조
Polyglot 문서에서는 각 Post의 YAML frontmatter에 지정된 `lang` 변수를 기준으로 언어를 구분한다고 하던데, 그냥은 안 된다.
문서에는 `lang` 말고도 `permalink`를 지정해야 한다고 하던데, 매 포스트마다 `permalink` 넣는 건 좀 많이 귀찮기 때문에 다른 방법을 쓰기로 했다.
```yml
lang_from_path: true
```
`_config.yml`에 추가된 이 옵션이 그것인데, 첫번째나 두 번째 디렉토리 이름이 언어 코드로 되어 있으면 그걸 사용하는 옵션이다.
중요한 건 "첫 번째나 두 번째 디렉토리 이름"만 본다는 것이다.
이러면 두 가지 선택지밖에 안 남게 되는데, `/_posts` 폴더 안에 `./en`이랑 `./ko` 폴더를 만들거나, 아얘 루트 디렉토리에 `/en`과 `/ko` 디렉토리를 놓는 것이다.
원했던 형태는 `/_posts/doc-name/en.md` 같은 형태였는데, Polyglot을 수정하지 않고는 안 되더라.

언젠가 원하는 형태로 사용할 수 있도록 수정을 하려 하거나 할 것 같긴 한데, 언제가 될 지는 모르겠다.

### 그 외
Post의 Permalink에 Category가 주렁주렁 달려서 더러워지는 것을 막기 위해서 `_config.yml`에
```yml
permalink: /:year/:month/:title
```
를 추가했다. 아마 연도별, 월별 인덱스 페이지를 추가하게 될 것 같은데, 간단하게 됐으면 좋겠다만 아직 안 알아봐서 모르겠다.
그와는 별개로 Category별 인덱스 페이지를 만드는 플러그인은 [이미 있던데](https://github.com/field-theory/jekyll-category-pages), 아마 저것도 적용하는 방향으로 가지 않을까 싶다.

블로그 기본 언어가 영어로 되어 있어서 의미는 없겠지만, 이 블로그의 영어 버전은 <a {% static_href %}href="/blog/"{% endstatic_href %}>여기서</a> 접근할 수 있다.