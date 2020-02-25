export function promiseExample(shouldSucceed = true) {
  let promise = new Promise((resolve, reject) => {
    // attempt some useful tåsk...
    try {
      if (shouldSucceed) {
        resolve("It worked!");
      } else {
        throw "an error";
      }
    } catch (e) {
      // but we detect that it failed, so we reject
      reject(new Error(e));
    }
  });

  // approach 1: then with two arguments
  promise
    .then(
      result => {
        // do something with result
        alert(`Approach 1 success: then first argument handler: ${result}`);
      },
      error => {
        // handle error
        alert(`Approach 1 error: then second argument handler: ${error}`);
      }
    )
    .finally(() => { alert('finally 1'); });

  // approach 2: then and catch
  promise
    .then(
      result => {
        // do something with result
        alert(`Approach 2 success: then handler: ${result}`);
      })
    .catch(
      error => {
        // handle error
        alert(`Approach 2 error: catch handler: ${error}`);
      }
    )
    .finally(() => { alert('finally 2'); });

  // approach 3: ignore successful result, only catch error
  promise
    .catch(
      error => { alert(`Approach 3 error: only catch handler: ${error}`); }
    )
    .finally(() => { alert('finally 3'); });
}
