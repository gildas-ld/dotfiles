// Import required modules
const fs = require('fs');
const zlib = require('zlib');
const path = require('path');

// Define the input directory to scan
const inputDir = './files'; // Replace with your directory

// Read all files in the directory
fs.readdir(inputDir, (err, files) => {
  if (err) {
    // Log error reading directory
    console.error(`Error reading directory "${inputDir}":`, err.message);
    return;
  }

  // Filter out already compressed files
  const targets = files.filter(file =>
    !file.endsWith('.gz') && !file.endsWith('.br')
  );

  // Compress each file with Brotli and Gzip
  targets.forEach(file => {
    const inputFilePath = path.join(inputDir, file);

    // Skip directories
    if (fs.statSync(inputFilePath).isDirectory()) {
      return;
    }

    // Brotli compression
    compressFile(inputFilePath, `${inputFilePath}.br`, zlib.createBrotliCompress({
      params: {
        [zlib.constants.BROTLI_PARAM_QUALITY]: 11, // Set Brotli compression level to max
      },
    }), 'Brotli');

    // Gzip compression
    compressFile(inputFilePath, `${inputFilePath}.gz`, zlib.createGzip({
      level: zlib.constants.Z_BEST_COMPRESSION, // Set Gzip compression level to max
    }), 'Gzip');
  });
});

/**
 * Compress a file using the specified compression stream
 * @param {string} inputPath - Path to input file
 * @param {string} outputPath - Path to output compressed file
 * @param {stream.Transform} compressor - Compression stream
 * @param {string} type - Compression type for logging
 */
function compressFile(inputPath, outputPath, compressor, type) {
  const inputStream = fs.createReadStream(inputPath);
  const outputStream = fs.createWriteStream(outputPath);

  inputStream.on('error', (err) => {
    // Log read error
    console.error(`Error reading file "${inputPath}":`, err.message);
  });

  outputStream.on('error', (err) => {
    // Log write error
    console.error(`Error writing file "${outputPath}":`, err.message);
  });

  compressor.on('error', (err) => {
    // Log compression error
    console.error(`${type} compression error for "${inputPath}":`, err.message);
  });

  outputStream.on('finish', () => {
    // Log success
    console.log(`${type} compressed: ${outputPath}`);
  });

  // Pipe: input -> compressor -> output
  inputStream.pipe(compressor).pipe(outputStream);
}

