import { readFileSync } from 'fs';

function readJsonFile(filePath) {
  try {
    // Read the file synchronously
    const jsonString = readFileSync(filePath, 'utf-8');
    // Parse the JSON string
    const jsonData = JSON.parse(jsonString);
    return jsonData;
  } catch (error) {
    console.error('Error reading or parsing JSON file:', error);
    return null;
  }
}

const __dirname = import.meta.dirname;
function main() {
  const jsonFilePath = __dirname + "/keebs/iris_rev__7.layout_right.json"; // Replace with your JSON file path
  const jsonData = readJsonFile(jsonFilePath);
  
  if (!jsonData) process.exit(1)
  const { layers } = jsonData
  
  const COL = 6
  const ROW = 5
  const LASTROW_COL = 4
  const HALF_NUMOFKEYS = (COL-1) * ROW  + LASTROW_COL

  const newLayer = []
  for (const layer of layers) {
    const firstHalf = []
    const secondHalf = []

    for (let i = 0; i < layer.length; i++) {
      let key = layer[i]
      if (key === "KC_NO") key = "KC_XXX"
      if (key.startsWith("FN_")) key = "KC_A"

      if (i <= HALF_NUMOFKEYS) {
        firstHalf.push(key)
      } else {
        secondHalf.push(key)
      }
    }

    const x = []
    for (let i = 0; i < firstHalf.length; i+=COL) {
      x.push(firstHalf.slice(i, i+COL))
      x.push(secondHalf.slice(i, i+COL).reverse())
    }

    newLayer.push(x.flat().filter(x => x !== "KC_XXX"))
  }

  console.log(newLayer)
}

main()
