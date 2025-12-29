$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:5000/")
$listener.Start()
Write-Host "Listening on http://localhost:5000/  (Ctrl+C to stop)"

while ($listener.IsListening) {
    $context = $listener.GetContext()
    $path = $context.Request.Url.AbsolutePath

    if ($path -eq "/health") {
        $text = "Vulcan backend OK"
    } else {
        $text = "Vulcan backend says hello. Try /health"
    }

    $bytes = [System.Text.Encoding]::UTF8.GetBytes($text)
    $context.Response.StatusCode = 200
    $context.Response.ContentType = "text/plain"
    $context.Response.OutputStream.Write($bytes, 0, $bytes.Length)
    $context.Response.Close()
}
