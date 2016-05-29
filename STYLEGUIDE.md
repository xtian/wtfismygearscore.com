# CSS

On the face of it, CSS seems like a simple little language to add pretty colors to HTML elements. In practice, however, poorly-structured CSS will gradually slow the pace of change in a project until it grinds to a halt. Even small changes become difficult, and the scope of effect that a change will have becomes unclear. Every change is accompanied by a slew of styling bugs, and because automated visual testing is typically impractical, these breakages are difficult to find and often accrete in dark corners of the application. This happens because CSS makes it easy to introduce coupling and side-effects into the codebase without realizing it.

What follows is a set of guidelines designed to stave off that miserable fate for as long as possible.

## Syntax

Syntax preferences are mostly arbitrary, but using a consistent style throughout a project lightens the cognitive load for both reading and writing code. Let's get it out of the way up front.

Here's a snippet of idiomatic CSS for this project:

```scss
.Foo-heading,
.Foo-subHeading {
  color: rgba($black, 0.9);
}

.Foo-heading {
  @extend %heading;
  @include some-mixin(10px);

  align-items: center;
  background-color: $blue;
  display: flex;
  margin: 18px 0;
}

```

Note the following characteristics:
- One selector per line
- One declaration per line
- One line between blocks
- One space between properties and values
- One space between selector and opening bracket
- Zero lines between nested closing brackets
- Declarations sorted alphabetically (ProTip: Sublime Text has a "Sort Lines" command in the Command Palette)
- `@extend` directives at the beginning of a block
- `@include` directives after `@extend`, but also at beginning of block
- Colors in variables
- Hex colors with `rgba` instead of digits

Vendor prefixes do not need to be added as they are automatically inserted by [autoprefixer-rails](https://github.com/ai/autoprefixer-rails) at compile time.

## Structure

This is the real nut. Good structure enables change by making existing code easy to reason about. Bad structure requires you to model a high percentage of the project in your mind in order to make a correct change. While these rules aren't perfect, they do avoid the most common pitfalls of bad structure.

### Naming

This project follows the [SUITCSS naming conventions](https://github.com/suitcss/suit/blob/master/doc/naming-conventions.md), which means that every selector looks like this:

```scss
.ComponentName
.ComponentName.is-animating
.ComponentName--modifier
.ComponentName-partName
```

Styles for each component or reusable block must be seperated into their own files in `app/assets/stylesheets/components`. What these constraints ensure is that each identifier is unique within the project.

It can be tempting to write less verbose selectors like this:

```scss
.article {
  .title {}
}

.widget {
  .title {}
}
```

However because `.title` is not unique, this creates problems if a `.widget` ever needs to be used inside of an `.article` or vice-versa. Likewise, styling multiple blocks in one file opens up the possibility that the same identifier could be used elsewhere in the project.

For a more detailed explanation of the benefits of these conventions, check out "[Side Effects in CSS](http://philipwalton.com/articles/side-effects-in-css/)" by Philip Walton.

### Nesting
Avoid nesting whenever possible and never exceed three levels of nesting.

It can be tempting to mirror the structure of your HTML using SCSS, but since our naming conventions guarantee that every identifier will be unique, the extra specificity introduces coupling to that structure without conferring any benefits. The longer selectors nesting creates are also more difficult to debug and increase file size.

### Page-specific styles
Page-specific styles should be placed in individual files in `app/assets/stylesheets` and added to the `manifest.js`. Include them at the end of the relevent page using the `async_stylesheet_link_tag` helper. Since we are serving the site over HTTP/2, there is no penalty for splitting styles into as many files as necessary.

### Element selectors
Element selectors should almost never be used. They codify a set of assumptions about the ways in which a tag will be used that nearly always end up being incorrect over time.

While avoiding element selectors can be tedious in the short term, it is much more frustrating to try to strip an element of unwanted styles that you're inheriting from a parent component or the global context.

### ID selectors
IDs should never be used to apply styling; they should only be used for navigational purposes.

ID selectors hinder reuse because their behavior is undefined when multiple instances of the same ID are present on one page. Furthermore, because they have a higher level of precedence than class selectors, they make code more difficult to reason about and extend.

### JavaScript and test dependencies
If an identifier is needed for integrating with a JavaScript plugin, use a new class prefixed with `.js-`. This makes the use of the class clear and prevents breakages when refactoring either the CSS or HTML.

Likewise, if an identifier is needed for an acceptance test, use a new class prefixed with `.t-`.
