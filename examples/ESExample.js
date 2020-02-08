try {
  console.log(`Parsed ${parseInt('1000')}.`);

  let grand = 'A grand';
  let parsed = parseInt(grand);
  console.log(`Parsed ${parsed}.`);
  if (isNaN(grand)) {
    throw `Could not parse "${grand}"`;
  }
} catch(e) {
  console.log(`Error: ${e}`);
} finally {
  console.log('Have a nice day.');
}
