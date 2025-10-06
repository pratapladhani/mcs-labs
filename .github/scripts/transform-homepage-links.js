#!/usr/bin/env node

/**
 * Transform Homepage Links - Final Working Version
 */

const fs = require('fs');

function transformHomepageLinks(inputPath, outputPath) {
  console.log('🔄 Transforming homepage links using robust regex patterns...');
  
  try {
    // Read the input file
    let content = fs.readFileSync(inputPath, 'utf8');
    
    console.log('📝 Processing README content for web display...');
    
    // Step 1: Update table headers
    console.log('📊 Updating table headers for download functionality...');
    content = content.replace(/\|\s*Title\s*\|\s*Download\s*\|\s*Overview\s*\|/g, '| Title | Download | Overview |');
    content = content.replace(/\|\s*-+\s*\|\s*-+\s*\|\s*-+\s*\|/g, '|-------|----------|----------|');
    
    // Step 2: Find and transform each line that contains lab links
    console.log('🔗 Creating clickable lab titles and PDF download links...');
    
    let transformationCount = 0;
    
    // Split content into lines for processing
    const lines = content.split('\n');
    
    for (let i = 0; i < lines.length; i++) {
      const line = lines[i];
      
      // Skip empty lines and headers
      if (!line.trim() || line.includes('----') || line.includes('Title | Download | Overview')) {
        continue;
      }
      
      // Check if this line contains any kind of link (internal lab or external)
      if ((line.includes('./labs/') || line.includes('https://')) && line.startsWith('|') && line.includes('|', line.length - 10)) {
        // Extract the parts using a simpler approach
        const parts = line.split('|').map(part => part.trim()).filter(part => part);
        
        if (parts.length === 3) {
          const titleCol = parts[0];
          const linkCol = parts[1];
          const overviewCol = parts[2];
          
          // Check if the link column contains a lab link first
          const labLinkMatch = linkCol.match(/\[([^\]]+)\]\(\.\/labs\/([^)]+)\)/);
          
          if (labLinkMatch) {
            const [, linkText, labName] = labLinkMatch;
            transformationCount++;
            console.log(`  ✓ Transformed: ./labs/${labName} → HTML + PDF links`);
            
            // Create new row with clickable title and PDF download
            lines[i] = `| [${titleCol}](labs/${labName}/${labName}.html) | [📋 PDF](labs/${labName}/${labName}.pdf) | ${overviewCol} |`;
            continue;
          }
          
          // Check for external links
          const externalLinkMatch = linkCol.match(/\[([^\]]+)\]\((https?:\/\/[^)]+)\)/);
          if (externalLinkMatch) {
            const [, linkText, url] = externalLinkMatch;
            console.log(`  → Kept external link: ${url}`);
            // Keep the original title, but link the download column to the external URL
            lines[i] = `| ${titleCol} | [🔗 ${linkText}](${url}) | ${overviewCol} |`;
          }
        }
      }
    }
    
    // Reconstruct content from lines
    content = lines.join('\n');
    
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