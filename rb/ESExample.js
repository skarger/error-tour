try {
  console.log(`Parsed ${parseInt('1000')}.`);
  console.log(`Parsed ${parseInt('A grand')}.`);
  console.log(`JSON ${JSON.parse('<DOCTYPE html>')}`);
} catch(e) {
  console.log(`Error: ${e}`);
} finally {
  console.log('Have a nice day.');
}
