Elm.Native.WebBindings = {};
Elm.Native.WebBindings.make = function(localRuntime) {
  localRuntime.Native = localRuntime.Native || {};
  localRuntime.Native.WebBindings = localRuntime.Native.WebBindings || {};

  if (localRuntime.Native.WebBindings.values) {
    return localRuntime.Native.WebBindings.values;
  }

  var Result = Elm.Result.make(localRuntime);

  return localRuntime.Native.WebBindings.values = {
    toFixed: F2(function(digits, number) {
      try {
        return Result.Ok(number.toFixed(digits));
      } catch (ex) {
        return Result.Err(ex.message);
      }
    }),
  };
};

