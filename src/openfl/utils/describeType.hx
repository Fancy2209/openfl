package openfl.utils;
//Based on JooFlash https://github.com/CoreMedia/jangaroo-libs/blob/jooflash-4.1/jooflash/src/main/joo/flash/utils/describeType.as
public function describeType(value:*):XML {
  var type:Class = value.$isClass ? value : value.self;
  // fake collection:
  var len:uint = 0;
  var methods:Object = {
    length: function():uint {
      return len;
    }
  };
  if (type && type.prototype) {
    var propertyNames:Array = Object.getOwnPropertyNames(type.prototype);
    for each (var p:String in propertyNames) {
      if (p.match(/^[a-zA-Z_]/)) {
        var descriptor:* = Object.getOwnPropertyDescriptor(type.prototype, p);
        if (typeof descriptor.value === "function") {
          methods[len++] = p;
        }
      }
    }
  }
  var result:* = {
    attribute: function(attr:String):String {
      return attr == "name" ? getQualifiedClassName(value) : null;
    },
    method: {
      "@name": methods
    }
  };
  return result;
}
