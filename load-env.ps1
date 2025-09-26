Write-Host "Loading .env file..." -ForegroundColor Green

if (Test-Path ".env") {
    $lines = Get-Content ".env"
    foreach ($line in $lines) {
        if ($line -and $line.Contains("=") -and !$line.StartsWith("#")) {
            $parts = $line.Split("=", 2)
            $name = $parts[0].Trim()
            $value = $parts[1].Trim()
            
            if ($value.StartsWith('"') -and $value.EndsWith('"')) {
                $value = $value.Substring(1, $value.Length - 2)
            }
            
            Set-Item -Path "env:$name" -Value $value
            Write-Host "Set $name" -ForegroundColor Gray
        }
    }
    Write-Host "Done!" -ForegroundColor Green
} else {
    Write-Host ".env file not found" -ForegroundColor Red
}