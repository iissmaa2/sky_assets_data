# Script to update all JSON files in the final_data directory
# Replace "https://cdn.jsdelivr.net/gh/iissmaa2/sky_assets_data@main/" with "https://iissmaa2.github.io/sky_assets_data/"

$oldUrl = "https://cdn.jsdelivr.net/gh/iissmaa2/sky_assets_data@main/"
$newUrl = "https://iissmaa2.github.io/sky_assets_data/"
$directory = "final_data"

# Get all JSON files in the directory
$jsonFiles = Get-ChildItem -Path $directory -Filter "*.json"

$totalFiles = $jsonFiles.Count
$processedFiles = 0

foreach ($file in $jsonFiles) {
    $filePath = $file.FullName
    $content = Get-Content -Path $filePath -Raw
    
    # Check if the file contains the old URL
    if ($content -match $oldUrl) {
        # Replace the old URL with the new URL
        $updatedContent = $content -replace [regex]::Escape($oldUrl), $newUrl
        
        # Write the updated content back to the file
        Set-Content -Path $filePath -Value $updatedContent
        
        Write-Host "Updated $($file.Name)"
    } else {
        Write-Host "No changes needed for $($file.Name)"
    }
    
    $processedFiles++
    Write-Host "Progress: $processedFiles / $totalFiles"
}

Write-Host "URL replacement complete. All files processed."
