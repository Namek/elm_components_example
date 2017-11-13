Example of component architecture in Elm

The main issue here is how to build a component-based architecture with functional approach where the only allowed state is the global state. In this situation components have to indicrectly rely on global `update` function and global `Msg` type. It's all about passing messages up and passing models down.

# That's it?

If you're looking for a more complete examples take a look at these:
* https://github.com/simon-larsson/elm-spa-template
* https://github.com/rtfeldman/elm-spa-example
* http://package.elm-lang.org/packages/emtenet/elm-component-support/latest