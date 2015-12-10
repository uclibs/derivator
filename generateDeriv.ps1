# UC Libraries, DigitzeUC Spokes
# Generate derivatives for DRC
# 2015-07-17, Nathan Tallman

Get-ChildItem "." -recurse -filter *.tif | `
	Foreach {
		$image = New-Object -ComObject Wia.ImageFile            
		$image.LoadFile($_.FullName)            

		If ($image.Width -gt 5000 -lt 15000 -Or $image.Height -gt 5000 -lt 15000)
			{
				.\ImageMagick\convert.exe -resample 300 -resize "5000x5000>" $_.FullName ($_.DirectoryName + "\" + $_.BaseName + ".jpg") 
				.\ImageMagick\convert.exe $_.FullName ($_.DirectoryName + "\" + $_.BaseName + ".jp2") 
				.\ImageMagick\convert.exe -thumbnail 100x100 $_.FullName ($_.DirectoryName + "\" + $_.BaseName + ".jpg.jpg") 
				Copy-Item -Path ($_.BaseName + ".jpg.jpg") -Destination ".\$($_.BaseName).jp2.jpg"
			}

		ElseIf ($image.Width -ge 15000 -Or $image.Height -ge 15000)
			{
				.\ImageMagick\convert.exe -resample 300 -resize "5000x5000>" $_.FullName ($_.DirectoryName + "\" + $_.BaseName + ".jpg") 
				.\ImageMagick\convert.exe -resize "15000x15000>" $_.FullName ($_.DirectoryName + "\" + $_.BaseName + ".jp2")  
				.\ImageMagick\convert.exe -thumbnail 100x100 $_.FullName ($_.DirectoryName + "\" + $_.BaseName + ".jpg.jpg")  
				Copy-Item -Path ($_.BaseName + ".jpg.jpg") -Destination ".\$($_.BaseName).jp2.jpg"
			}

		Else
			{
				.\ImageMagick\convert.exe -resample 300 $_.FullName ($_.DirectoryName + "\" + $_.BaseName + ".jpg") 
				.\ImageMagick\convert.exe $_.FullName ($_.DirectoryName + "\" + $_.BaseName + ".jp2") 
				.\ImageMagick\convert.exe -thumbnail 100x100 $_.FullName ($_.DirectoryName + "\" + $_.BaseName + ".jpg.jpg") 
				Copy-Item -Path ($_.BaseName + ".jpg.jpg") -Destination ".\$($_.BaseName).jp2.jpg"
			}
        
	}
