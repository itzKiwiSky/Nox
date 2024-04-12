# Nox
![alt text](assets/nox.png)

A static declarative language designed to be a wrapper with the loveframes GUI library for love.
Implementing features like, object management with tags and element declarations.

Was originally used on VisualNova Game engine to manage their screens, using a simple and declarative language to describe the UI same as HTML.

It also work as string based events, which means you will need a event handler to handle the connection between the UI and lua.

## Features
- Support special tags to manage data (for example translation, see documentation to see more about the tags.)
- Support for nested elements, so elements can be inside other element if it supports (see documentation to know more.)

Not implemented features:
- Error handling
- Parser need more working I guess..

## Example

```nox
(frame) {
    (!button) text="this is button"
}
```

Elements is defined by words inside parenthesis, like this: `(element)`, also Nox support self close element, something like this in html: `<element/>`. You can use self close element by adding `!` at the start of the element name. `(!closeelement)`

The valid elements are the same as described by the loveframes library.