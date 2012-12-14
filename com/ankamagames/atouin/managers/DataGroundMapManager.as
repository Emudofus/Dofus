package com.ankamagames.atouin.managers
{
    import by.blooddy.crypto.image.*;
    import com.ankamagames.atouin.*;
    import com.ankamagames.atouin.data.map.*;
    import com.ankamagames.atouin.enums.*;
    import com.ankamagames.atouin.utils.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.benchmark.monitoring.*;
    import com.ankamagames.jerakine.utils.misc.*;
    import flash.display.*;
    import flash.errors.*;
    import flash.filesystem.*;
    import flash.geom.*;
    import flash.utils.*;

    public class DataGroundMapManager extends Object
    {
        private static const _log:Logger = Log.getLogger(getQualifiedClassName(DataGroundMapManager));
        private static const MAPS_DIRECTORY:String = "./maps";
        private static const JPEG_HIGH_QUALITY:uint = 80;
        private static const JPEG_MEDIUM_QUALITY:uint = 70;
        private static const JPEG_LOW_QUALITY:uint = 60;
        private static var _currentQuality:Object;
        private static var _mask:Shape;
        private static var _currentDiskUsed:Number = 0;
        private static var _jpgEncoder:AsyncJPGEncoder;
        private static const _currentEncoderQuality:int = -1;
        private static var _currentOutputFileStream:FileStream;
        private static var _bitmapDataList:Array = new Array();
        private static var _processing:Boolean = false;
        private static var _directory:File;
        private static var _currentMapId:int = -1;
        private static var buffer:BitmapData;
        private static var _m:Matrix = new Matrix();

        public function DataGroundMapManager()
        {
            return;
        }// end function

        public static function mapsCurrentlyRendered() : int
        {
            return _bitmapDataList.length;
        }// end function

        public static function getCurrentDiskUsed() : Number
        {
            var _loc_1:* = NaN;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            if (_currentDiskUsed)
            {
                return _currentDiskUsed;
            }
            _loc_1 = 0;
            _loc_2 = new File(CustomSharedObject.getCustomSharedObjectDirectory() + MAPS_DIRECTORY);
            if (!_loc_2.exists || !_loc_2.isDirectory)
            {
                return 0;
            }
            _loc_3 = _loc_2.getDirectoryListing();
            _loc_4 = _loc_3.length;
            _loc_5 = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_6 = _loc_3[_loc_5];
                _loc_1 = _loc_1 + _loc_6.size;
                _loc_5++;
            }
            _currentDiskUsed = _loc_1;
            return _loc_1;
        }// end function

        public static function clearGroundCache() : void
        {
            var _loc_1:* = new File(CustomSharedObject.getCustomSharedObjectDirectory() + MAPS_DIRECTORY);
            if (_loc_1.exists && _loc_1.isDirectory)
            {
                _loc_1.deleteDirectory(true);
                _directory = null;
                _currentDiskUsed = 0;
            }
            return;
        }// end function

        public static function saveGroundMap(param1:BitmapData, param2:Map) : void
        {
            var _loc_3:* = null;
            _m.identity();
            switch(param2.groundCacheCurrentlyUsed)
            {
                case GroundCache.GROUND_CACHE_LOW_QUALITY:
                {
                    _loc_3 = AtouinConstants.RESOLUTION_LOW_QUALITY;
                    _m.scale(0.5, 0.5);
                    break;
                }
                case GroundCache.GROUND_CACHE_MEDIUM_QUALITY:
                {
                    _loc_3 = AtouinConstants.RESOLUTION_MEDIUM_QUALITY;
                    _m.scale(0.75, 0.75);
                    break;
                }
                case GroundCache.GROUND_CACHE_HIGH_QUALITY:
                {
                    _loc_3 = AtouinConstants.RESOLUTION_HIGH_QUALITY;
                    break;
                }
                default:
                {
                    break;
                }
            }
            FpsManager.getInstance().startTracking("groundMap", 10621692);
            if (param1.width != _loc_3.x || param1.height != _loc_3.y)
            {
                if (buffer == null || buffer.width != AtouinConstants.RESOLUTION_HIGH_QUALITY.x || buffer.height != AtouinConstants.RESOLUTION_HIGH_QUALITY.y)
                {
                    buffer = new BitmapData(_loc_3.x, _loc_3.y, false, 16711680);
                }
                buffer.draw(param1, _m);
                _bitmapDataList.push(buffer, param2);
            }
            else
            {
                _bitmapDataList.push(param1, param2);
            }
            process();
            FpsManager.getInstance().stopTracking("groundMap");
            return;
        }// end function

        public static function loadGroundMap(param1:Map, param2:Function, param3:Function) : int
        {
            var numMap:int;
            var i:int;
            var waitingMap:Map;
            var file:File;
            var fileStream:FileStream;
            var fileCRC:int;
            var map:* = param1;
            var callBack:* = param2;
            var errorCallBack:* = param3;
            try
            {
                FpsManager.getInstance().startTracking("groundMap", 10621692);
                _log.info("On se prépare à charger le jpeg d\'une map : " + map.id);
                if (!_directory)
                {
                    _directory = new File(CustomSharedObject.getCustomSharedObjectDirectory() + MAPS_DIRECTORY);
                    if (!_directory.exists)
                    {
                        _directory.createDirectory();
                    }
                }
                if (_currentMapId == map.id)
                {
                    _log.info("On ne fait rien, la map est en train d\'être générée.");
                    return GroundCache.GROUND_CACHE_SKIP;
                }
                numMap = _bitmapDataList.length;
                i;
                while (i < numMap)
                {
                    
                    waitingMap = _bitmapDataList[(i + 1)];
                    if (waitingMap.id == map.id)
                    {
                        _log.info("On ne fait rien, la map est en file d\'attente pour être générée.");
                        return GroundCache.GROUND_CACHE_SKIP;
                    }
                    i = i + 2;
                }
                if (_directory.spaceAvailable > AtouinConstants.MIN_DISK_SPACE_AVAILABLE)
                {
                    file = new File(CustomSharedObject.getCustomSharedObjectDirectory() + MAPS_DIRECTORY + "/" + map.id + ".bg");
                    if (file.exists)
                    {
                        _log.info("Le fichier existe bien.");
                        fileStream = new FileStream();
                        try
                        {
                            fileStream.open(file, FileMode.READ);
                            if (fileStream.readInt() == AtouinConstants.GROUND_MAP_VERSION)
                            {
                                _log.info("La version globale est bonne.");
                                if (fileStream.readByte() <= map.groundCacheCurrentlyUsed)
                                {
                                    _log.info("La qualité est correcte.");
                                    fileCRC = fileStream.readInt();
                                    if (fileCRC == map.groundCRC)
                                    {
                                        _log.info("Le CRC est bon.");
                                        GroundMapLoader.loadGroundMap(map, file, callBack, errorCallBack);
                                        return GroundCache.GROUND_CACHE_AVAILABLE;
                                    }
                                }
                            }
                            fileStream.close();
                        }
                        catch (e:IOError)
                        {
                            _log.error(e);
                            return GroundCache.GROUND_CACHE_SKIP;
                        }
                    }
                }
                else
                {
                    _log.info("On ne fait rien, il n\'y a plus assez d\'espace disque.");
                    return GroundCache.GROUND_CACHE_ERROR;
                }
                FpsManager.getInstance().stopTracking("groundMap");
            }
            catch (e:Error)
            {
                _log.fatal(e.getStackTrace());
                return GroundCache.GROUND_CACHE_ERROR;
            }
            return GroundCache.GROUND_CACHE_NOT_AVAILABLE;
        }// end function

        private static function process() : void
        {
            var bitmapData:BitmapData;
            var map:Map;
            var file:File;
            var t:uint;
            var res:ByteArray;
            if (!_processing && _bitmapDataList.length)
            {
                _processing = true;
                bitmapData = _bitmapDataList.shift();
                map = _bitmapDataList.shift();
                _currentMapId = map.id;
                initEncoder(map.groundCacheCurrentlyUsed);
                try
                {
                    file = new File(CustomSharedObject.getCustomSharedObjectDirectory() + MAPS_DIRECTORY + "/" + map.id + ".bg");
                    _currentOutputFileStream = new FileStream();
                    _currentOutputFileStream.open(file, FileMode.WRITE);
                }
                catch (e:Error)
                {
                    _log.info("Le fichier est locké " + file.nativePath);
                }
                t = getTimer();
                res = JPEGEncoder.encode(bitmapData, _currentQuality);
                trace("Encodage " + bitmapData.width + " x " + bitmapData.height + " : " + (getTimer() - t) + " ms");
                jpgGenerated(res, map);
            }
            return;
        }// end function

        private static function initEncoder(param1:uint) : void
        {
            var _loc_2:* = 0;
            if (_currentEncoderQuality != param1)
            {
                switch(true)
                {
                    case param1 == GroundCache.GROUND_CACHE_HIGH_QUALITY:
                    {
                        _loc_2 = JPEG_HIGH_QUALITY;
                        break;
                    }
                    case param1 == GroundCache.GROUND_CACHE_MEDIUM_QUALITY:
                    {
                        _loc_2 = JPEG_MEDIUM_QUALITY;
                        break;
                    }
                    case param1 == GroundCache.GROUND_CACHE_LOW_QUALITY:
                    {
                        _loc_2 = JPEG_LOW_QUALITY;
                        break;
                    }
                    default:
                    {
                        _loc_2 = JPEG_MEDIUM_QUALITY;
                        _log.error("Attention Enum d\'encodage pour la qualité JPG non valide, utisation d\'une qualité moyenne");
                        break;
                    }
                }
                _currentQuality = _loc_2;
            }
            return;
        }// end function

        private static function jpgGenerated(param1:ByteArray, param2:Map) : void
        {
            var rawJPG:* = param1;
            var map:* = param2;
            try
            {
                _currentOutputFileStream.writeInt(AtouinConstants.GROUND_MAP_VERSION);
                _currentOutputFileStream.writeByte(map.groundCacheCurrentlyUsed);
                _currentOutputFileStream.writeInt(map.groundCRC);
                _currentDiskUsed = _currentDiskUsed + rawJPG.length;
                _currentOutputFileStream.writeBytes(rawJPG);
                _processing = false;
                _currentMapId = -1;
            }
            catch (e:IOError)
            {
                _log.error("Impossible de sauvegarder le background de la map ");
                try
                {
                }
                _currentOutputFileStream.close();
            }
            catch (e:Error)
            {
            }
            process();
            return;
        }// end function

    }
}
