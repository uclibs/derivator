# UC Libraries, DigitzeUC Spokes
# Generate derivatives for DRC

Get-ChildItem "." -filter *.tif | `
	Foreach {
		$image = New-Object -ComObject Wia.ImageFile            
		$image.LoadFile($_.FullName)            

		If ($image.Width -gt 5000 -lt 15000 -Or $image.Height -gt 5000 -lt 15000)
			{
				.\ImageMagick\convert.exe -resample 300 -resize "5000x5000>" $_.Name ($_.BaseName + ".jpg") 
				.\ImageMagick\convert.exe $_.Name ($_.BaseName + ".jp2") 
				.\ImageMagick\convert.exe -thumbnail 100x100 $_.Name ($_.BaseName + ".jpg.jpg") 
			}

		ElseIf ($image.Width -ge 15000 -Or $image.Height -ge 15000)
			{
				.\ImageMagick\convert.exe -resample 300 -resize "5000x5000>" $_.Name ($_.BaseName + ".jpg") 
				.\ImageMagick\convert.exe -resize "15000x15000>" $_.Name ($_.BaseName + ".jp2")  
				.\ImageMagick\convert.exe -thumbnail 100x100 $_.Name ($_.BaseName + ".jpg.jpg")  
			}

		Else
			{
				.\ImageMagick\convert.exe -resample 300 $_.Name ($_.BaseName + ".jpg") 
				.\ImageMagick\convert.exe $_.Name ($_.BaseName + ".jp2") 
				.\ImageMagick\convert.exe -thumbnail 100x100 $_.Name ($_.BaseName + ".jpg.jpg") 
			}
	}
