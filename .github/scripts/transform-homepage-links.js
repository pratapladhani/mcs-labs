#!/usr/bin/env node

/**
 * Transform Homepage Links - Robust Markdown Link Transformer
 * 
 * This script robustly transforms links in the README.md table using regex patterns
 * that are more robust than the previous sed transformations.
 * 
 * This replaces fragile sed transformations with a more robust approach that:
 * - Uses regex patterns designed to handle various whitespace patterns
 * - Performs structured transformations of table rows
 * - Handles both internal lab links and external links properly
 * 
 * Transformation examples:
 * - "[agent-builder-web](./labs/agent-builder-web)" → "[agent-builder-web](labs/agent-builder-web/agent-builder-web.html)"
 * - Adds PDF links: "[📋 PDF](labs/agent-builder-web/agent-builder-web.pdf)"
 */

const fs = require('fs');
const path = require('path');

/**
 * Transform README.md links for GitHub Pages deployment using robust regex patterns
 * @param {string} inputPath - Path to input README.md
 * @param {string} outputPath - Path to output processed README.md
 */
function transformHomepageLinks(inputPath, outputPath) {
  console.log('🔄 Transforming homepage links using robust regex patterns...');
  
  try {
    // Read the input file
    let content = fs.readFileSync(inputPath, 'utf8');
    
    console.log('📝 Processing README content for web display...');
    
    // Step 1: Update table headers
    console.log('📊 Updating table headers for download functionality...');
    content = content.replace(/\|\s*Title\s*\|\s*URL\s*\|\s*Overview\s*\|/g, '| Title | Download | Overview |');
    content = content.replace(/\|\s*-+\s*\|\s*-+\s*\|\s*-+\s*\|/g, '|-------|----------|----------|');
    
    // Step 2: Transform lab table rows - more robust pattern matching
    console.log('� Creating clickable lab titles and PDF download links...');
    
    let transformationCount = 0;
    
    // Pattern to match table rows with lab links, handling various whitespace patterns
    // Matches: | Title | [Link Text](./labs/lab-name) | Overview |
    const labRowPattern = /\|\s*([^|]+?)\s*\|\s*\[([^\]]+?)\]\(\.\/labs\/([^)\/]+)\)\s*\|\s*([^|]+?)\s*\|/g;
    
    content = content.replace(labRowPattern, (match, titleCol, linkText, labName, overviewCol) => {
      transformationCount++;
      console.log(`  ✓ Transformed: ./labs/${labName} → HTML + PDF links`);
      
      // Create new row with clickable title and PDF download
      return `| [${titleCol.trim()}](labs/${labName}/${labName}.html) | [📋 PDF](labs/${labName}/${labName}.pdf) | ${overviewCol.trim()} |`;
    });
    
    // Step 3: Handle external links (keep them as-is)
    const externalLinkPattern = /\|\s*([^|]+?)\s*\|\s*\[([^\]]+?)\]\((https?:\/\/[^)]+)\)\s*\|\s*([^|]+?)\s*\|/g;
    content = content.replace(externalLinkPattern, (match, titleCol, linkText, url, overviewCol) => {
      console.log(`  → Kept external link: ${url}`);
      return `| [${titleCol.trim()}](${url}) | [🔗 External](${url}) | ${overviewCol.trim()} |`;
    });
    
    // Step 4: Clean up any irregular whitespace in table cells
    content = content.replace(/\|\s{2,}/g, '| ');
    content = content.replace(/\s{2,}\|/g, ' |');
    
    // Write the output file
    fs.writeFileSync(outputPath, content);
    
    console.log(`✅ Homepage transformation complete!`);
    console.log(`   📊 Transformed ${transformationCount} lab links`);
    console.log(`   📄 Output: ${outputPath}`);
    
    return true;
    
  } catch (error) {
    console.error('❌ Error transforming homepage links:', error.message);
    console.error(error.stack);
    return false;
  }
}

// Command line usage
if (require.main === module) {
  const args = process.argv.slice(2);
  
  if (args.length < 2) {
    console.error('Usage: node transform-homepage-links.js <input.md> <output.md>');
    process.exit(1);
  }
  
  const [inputPath, outputPath] = args;
  
  const success = transformHomepageLinks(inputPath, outputPath);
  process.exit(success ? 0 : 1);
}

module.exports = { transformHomepageLinks };