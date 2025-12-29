# backend-5000.ps1
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:5000/")
$listener.Start()
Write-Host "Listening on http://localhost:5000/"

while ($listener.IsListening) {
  $context = $listener.GetContext()
  $path = $context.Request.Url.AbsolutePath

  if ($path -eq "/health") {
    $msg = "OK"
  } else {
    $msg = "Vulcan backend OK"
  }

  $bytes = [System.Text.Encoding]::UTF8.GetBytes($msg)
  $context.Response.StatusCode = 200
  $context.Response.ContentType = "text/plain"
  $context.Response.OutputStream.Write($bytes, 0, $bytes.Length)
  $context.Response.Close()
}
