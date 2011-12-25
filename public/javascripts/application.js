// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
Object.extend(Array.prototype,{
  inArray: function(value) {
  for (var i = 0, item; item = this[i]; i++) if (item === value) return
true;
  return false;
  }
});

Object.extend(Event,{
  isKey: function(event, key, modifiers) {
    var KeyCode = function(event) {
      return Try.these(
        function() { return event.keyCode },
        function() { return event.which },
        function() { return event.charCode }
      ) || false
    }
    var withModifiers = function(event, keys) {
      if (!keys) return true
      var modifiers = ['shift','ctrl','alt'], check = []
      modifiers.each(function(key, index){
        if (keys.inArray(key)) check[check.length] = event[key+'Key']
      })
      return check.all()
    }
    if ( (KeyCode(event) == key) && (!modifiers ? true :
withModifiers(event, modifiers)) ) return true
    return false
  }
});