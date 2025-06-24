@echo off

rem values
reg delete "HKEY_CLASSES_ROOT\*\shell\ForeverCompressModule\shell\CompressZTimestampExtreme00" /f
reg delete "HKEY_CLASSES_ROOT\*\shell\ForeverCompressModule\shell\CompressZTimestampExtreme0" /f
reg delete "HKEY_CLASSES_ROOT\*\shell\ForeverCompressModule\shell\CompressZTimestampExtreme" /f
reg delete "HKEY_CLASSES_ROOT\*\shell\ForeverCompressModule\shell\CompressZTimestamp" /f
reg delete "HKEY_CLASSES_ROOT\*\shell\ForeverCompressModule\shell\CompressZip" /f
reg delete "HKEY_CLASSES_ROOT\*\shell\ForeverCompressModule\shell\CompressZHigh" /f
reg delete "HKEY_CLASSES_ROOT\*\shell\ForeverCompressModule\shell\CompressZExtreme" /f
reg delete "HKEY_CLASSES_ROOT\*\shell\ForeverCompressModule\shell\CompressExtract" /f
reg delete "HKEY_CLASSES_ROOT\*\shell\ForeverCompressModule\shell" /f
reg delete "HKEY_CLASSES_ROOT\*\shell\ForeverCompressModule" /f

rem keys
reg delete "HKEY_CLASSES_ROOT\Folder\shell\ForeverCompressModule\shell\CompressZTimestampExtreme00" /f
reg delete "HKEY_CLASSES_ROOT\Folder\shell\ForeverCompressModule\shell\CompressZTimestampExtreme0" /f
reg delete "HKEY_CLASSES_ROOT\Folder\shell\ForeverCompressModule\shell\CompressZTimestampExtreme" /f
reg delete "HKEY_CLASSES_ROOT\Folder\shell\ForeverCompressModule\shell\CompressZTimestamp" /f
reg delete "HKEY_CLASSES_ROOT\Folder\shell\ForeverCompressModule\shell\CompressZip" /f
reg delete "HKEY_CLASSES_ROOT\Folder\shell\ForeverCompressModule\shell\CompressZHigh" /f
reg delete "HKEY_CLASSES_ROOT\Folder\shell\ForeverCompressModule\shell\CompressZExtreme" /f
reg delete "HKEY_CLASSES_ROOT\Folder\shell\ForeverCompressModule\shell\CompressExtract" /f
reg delete "HKEY_CLASSES_ROOT\Folder\shell\ForeverCompressModule\shell" /f
reg delete "HKEY_CLASSES_ROOT\Folder\shell\ForeverCompressModule" /f


echo Registry keys and values have been successfully removed.
pause
