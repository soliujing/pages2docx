-- This script recursively traverses a directory and converts all .key documents to .pdf documents
-- Tested on Mac OS Sierra
-- Command line usage: osascript xx.applescript ~/Documents/
on run inputFolder
	
	tell application "Finder" to set theFiles to every file in the entire contents of folder inputFolder
	
	repeat with theFile in theFiles
		
		set fExt to name extension of theFile as text
		set fName to name of theFile as text
		set fDir to folder of theFile as text
		
		if fExt is "key" then
			using terms from application "Keynote"
				convert(fDir, fName, "Keynote", PDF, "pdf")
			end using terms from
		end if
		
	end repeat
	
end run

on convert(dirName, fileName, appName, exportFormat, exportExtension)
	
	tell application appName
		set fullPath to (dirName & fileName)
		set doc to open fullPath
		set docName to name of doc
		set exportFileName to (dirName & docName & "." & exportExtension) as text
		close access (open for access exportFileName)
		
		if appName is "Keynote" then
			tell application "Keynote"
				export doc to file exportFileName as exportFormat
			end tell
		end if
		
		close doc
		
	end tell
	
	tell application "Finder"
		move file exportFileName to folder dirName with replacing
	end tell
	
end convert
