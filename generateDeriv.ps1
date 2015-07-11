# UC Libraries, DigitzeUC Spokes
# Generate derivatives for DRC using PowerShell and ImageMagick Portable
# Nathan Tallman, July 2015

Get-ChildItem "." -filter *.tif | `
	Foreach {
		$image = New-Object -ComObject Wia.ImageFile            
		$image.LoadFile($_.FullName)            

		If ($image.Width -gt 5000 -lt 20000 -Or $image.Height -gt 5000 -lt 20000)
			{
				.\ImageMagick\convert.exe $_.FullName -resample 300 -resize "5000x5000>" ($_.BaseName + ".jpg") 
				.\ImageMagick\convert.exe $_.Name ($_.BaseName + ".jp2") 
				.\ImageMagick\convert.exe $_.Name -resample 96 -resize "100x100>" ($_.BaseName + ".jpg.jpg") 
			}

		ElseIf ($image.Width -gt 20000 -Or $image.Height -gt 20000)
			{
				.\ImageMagick\convert.exe $_.FullName -resample 300 -resize "5000x5000>" ($_.BaseName + ".jpg") 
				.\ImageMagick\convert.exe -resize "20000x20000>" $_.Name ($_.BaseName + ".jp2") 
				.\ImageMagick\convert.exe $_.Name -resample 96 -resize "100x100>" ($_.BaseName + ".jpg.jpg") 
			}

		Else
			{
				.\ImageMagick\convert.exe $_.FullName -resample 300 ($_.BaseName + ".jpg") 
				.\ImageMagick\convert.exe $_.Name ($_.BaseName + ".jp2") 
				.\ImageMagick\convert.exe $_.Name -resample 96 -resize "100x100>" ($_.BaseName + ".jpg.jpg") 
			}
	}
