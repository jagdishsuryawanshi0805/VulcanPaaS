$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:5000/")
$listener.Start()
Write-Host "Listening on http://localhost:5000/"

while ($listener.IsListening) {
    $context = $listener.GetContext()

    $body = "Vulcan backend OK"
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($body)

    $context.Response.StatusCode = 200
    $context.Response.ContentType = "text/plain"
    $context.Response.OutputStream.Write($bytes, 0, $bytes.Length)
    $context.Response.Close()
}
