/**
 * index
 */

/* Node modules */

/* Third-party modules */
const getStdin = require('get-stdin');

/* Files */
const handler = require('./function/handler');

// const isArray = a => (!!a) && (Array.isArray(a));
//
// const isObject = a => (!!a) && a.constructor === Object;

getStdin().then(val => {
  handler(val, (err, res) => {
    if (err) {
      return console.error(err);
    }
    if(isArray(res) || isObject(res)) {
      console.log(JSON.stringify(res));
    } else {
      process.stdout.write(res);
    }
  });
}).catch(e => {
  console.error(e.stack);
});

let isArray = (a) => {
  return (!!a) && (a.constructor === Array);
};

let isObject = (a) => {
  return (!!a) && (a.constructor === Object);
};
