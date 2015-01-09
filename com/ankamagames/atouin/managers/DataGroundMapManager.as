package com.ankamagames.atouin.managers
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import flash.display.Shape;
    import com.ankamagames.jerakine.utils.misc.AsyncJPGEncoder;
    import flash.filesystem.FileStream;
    import flash.filesystem.File;
    import flash.display.BitmapData;
    import flash.geom.Matrix;
    import com.ankamagames.jerakine.types.CustomSharedObject;
    import flash.geom.Point;
    import com.ankamagames.atouin.AtouinConstants;
    import com.ankamagames.atouin.enums.GroundCache;
    import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManager;
    import com.ankamagames.atouin.data.map.Map;
    import flash.filesystem.FileMode;
    import com.ankamagames.atouin.utils.GroundMapLoader;
    import flash.errors.IOError;
    import flash.utils.ByteArray;
    import flash.utils.getTimer;
    import by.blooddy.crypto.image.JPEGEncoder;

    public class DataGroundMapManager 
    {

        private static const _log:Logger = Log.getLogger(getQualifiedClassName(DataGroundMapManager));
        private static const MAPS_DIRECTORY:String = "./maps";
        private static const JPEG_HIGH_QUALITY:uint = 80;
        private static const JPEG_MEDIUM_QUALITY:uint = 70;
        private static const JPEG_LOW_QUALITY:uint = 60;
        private static var _currentQuality:uint;
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


        public static function mapsCurrentlyRendered():int
        {
            return (_bitmapDataList.length);
        }

        public static function getCurrentDiskUsed():Number
        {
            var _local_1:Number;
            var _local_2:File;
            var _local_3:Array;
            var _local_4:int;
            var _local_5:int;
            var map:File;
            if (_currentDiskUsed)
            {
                return (_currentDiskUsed);
            };
            _local_1 = 0;
            _local_2 = new File((CustomSharedObject.getCustomSharedObjectDirectory() + MAPS_DIRECTORY));
            if (((!(_local_2.exists)) || (!(_local_2.isDirectory))))
            {
                return (0);
            };
            _local_3 = _local_2.getDirectoryListing();
            _local_4 = _local_3.length;
            _local_5 = 0;
            while (_local_5 < _local_4)
            {
                map = _local_3[_local_5];
                _local_1 = (_local_1 + map.size);
                _local_5++;
            };
            _currentDiskUsed = _local_1;
            return (_local_1);
        }

        public static function clearGroundCache():void
        {
            var directory:File = new File((CustomSharedObject.getCustomSharedObjectDirectory() + MAPS_DIRECTORY));
            if (((directory.exists) && (directory.isDirectory)))
            {
                directory.deleteDirectory(true);
                _directory = null;
                _currentDiskUsed = 0;
            };
        }

        public static function saveGroundMap(ground:BitmapData, map:Map):void
        {
            var cacheSize:Point;
            _m.identity();
            switch (map.groundCacheCurrentlyUsed)
            {
                case GroundCache.GROUND_CACHE_LOW_QUALITY:
                    cacheSize = AtouinConstants.RESOLUTION_LOW_QUALITY;
                    _m.scale(0.5, 0.5);
                    break;
                case GroundCache.GROUND_CACHE_MEDIUM_QUALITY:
                    cacheSize = AtouinConstants.RESOLUTION_MEDIUM_QUALITY;
                    _m.scale(0.75, 0.75);
                    break;
                case GroundCache.GROUND_CACHE_HIGH_QUALITY:
                    cacheSize = AtouinConstants.RESOLUTION_HIGH_QUALITY;
                    break;
            };
            FpsManager.getInstance().startTracking("groundMap", 10621692);
            if (((!((ground.width == cacheSize.x))) || (!((ground.height == cacheSize.y)))))
            {
                if ((((((buffer == null)) || (!((buffer.width == cacheSize.x))))) || (!((buffer.height == cacheSize.y)))))
                {
                    buffer = new BitmapData(cacheSize.x, cacheSize.y, false, 0xFF0000);
                };
                buffer.draw(ground, _m);
                _bitmapDataList.push(buffer, map);
            }
            else
            {
                _bitmapDataList.push(ground, map);
            };
            process();
            FpsManager.getInstance().stopTracking("groundMap");
        }

        public static function loadGroundMap(map:Map, callBack:Function, errorCallBack:Function):int
        {
            var numMap:int;
            var i:int;
            var waitingMap:Map;
            var file:File;
            var fileStream:FileStream;
            var fileCRC:int;
            try
            {
                FpsManager.getInstance().startTracking("groundMap", 10621692);
                if (!(_directory))
                {
                    _directory = new File((CustomSharedObject.getCustomSharedObjectDirectory() + MAPS_DIRECTORY));
                    if (!(_directory.exists))
                    {
                        _directory.createDirectory();
                    };
                };
                if (_currentMapId == map.id)
                {
                    return (GroundCache.GROUND_CACHE_SKIP);
                };
                numMap = _bitmapDataList.length;
                i = 0;
                while (i < numMap)
                {
                    waitingMap = _bitmapDataList[(i + 1)];
                    if (waitingMap.id == map.id)
                    {
                        return (GroundCache.GROUND_CACHE_SKIP);
                    };
                    i = (i + 2);
                };
                if (_directory.spaceAvailable > AtouinConstants.MIN_DISK_SPACE_AVAILABLE)
                {
                    file = new File(((((CustomSharedObject.getCustomSharedObjectDirectory() + MAPS_DIRECTORY) + "/") + map.id) + ".bg"));
                    if (file.exists)
                    {
                        fileStream = new FileStream();
                        try
                        {
                            fileStream.open(file, FileMode.READ);
                            if (fileStream.readInt() == AtouinConstants.GROUND_MAP_VERSION)
                            {
                                if (fileStream.readByte() <= map.groundCacheCurrentlyUsed)
                                {
                                    fileCRC = fileStream.readInt();
                                    if (fileCRC == map.groundCRC)
                                    {
                                        GroundMapLoader.loadGroundMap(map, file, callBack, errorCallBack);
                                        return (GroundCache.GROUND_CACHE_AVAILABLE);
                                    };
                                };
                            };
                            fileStream.close();
                        }
                        catch(e:IOError)
                        {
                            _log.error(e);
                            return (GroundCache.GROUND_CACHE_SKIP);
                        };
                    };
                }
                else
                {
                    _log.info("On ne fait rien, il n'y a plus assez d'espace disque.");
                    return (GroundCache.GROUND_CACHE_ERROR);
                };
                FpsManager.getInstance().stopTracking("groundMap");
            }
            catch(e:Error)
            {
                _log.fatal(e.getStackTrace());
                return (GroundCache.GROUND_CACHE_ERROR);
            };
            return (GroundCache.GROUND_CACHE_NOT_AVAILABLE);
        }

        private static function process():void
        {
            var bitmapData:BitmapData;
            var map:Map;
            var file:File;
            var t:uint;
            var res:ByteArray;
            if (((!(_processing)) && (_bitmapDataList.length)))
            {
                _processing = true;
                bitmapData = _bitmapDataList.shift();
                map = _bitmapDataList.shift();
                _currentMapId = map.id;
                initEncoder(map.groundCacheCurrentlyUsed);
                try
                {
                    file = new File(((((CustomSharedObject.getCustomSharedObjectDirectory() + MAPS_DIRECTORY) + "/") + map.id) + ".bg"));
                    _currentOutputFileStream = new FileStream();
                    _currentOutputFileStream.open(file, FileMode.WRITE);
                }
                catch(e:Error)
                {
                    _log.info(("Le fichier est locké " + file.nativePath));
                };
                t = getTimer();
                res = JPEGEncoder.encode(bitmapData, _currentQuality);
                trace((((((("Encodage " + bitmapData.width) + " x ") + bitmapData.height) + " : ") + (getTimer() - t)) + " ms"));
                jpgGenerated(res, map);
            };
        }

        private static function initEncoder(qualityEnum:uint):void
        {
            var quality:uint;
            if (_currentEncoderQuality != qualityEnum)
            {
                switch (true)
                {
                    case (qualityEnum == GroundCache.GROUND_CACHE_HIGH_QUALITY):
                        quality = JPEG_HIGH_QUALITY;
                        break;
                    case (qualityEnum == GroundCache.GROUND_CACHE_MEDIUM_QUALITY):
                        quality = JPEG_MEDIUM_QUALITY;
                        break;
                    case (qualityEnum == GroundCache.GROUND_CACHE_LOW_QUALITY):
                        quality = JPEG_LOW_QUALITY;
                        break;
                    default:
                        quality = JPEG_MEDIUM_QUALITY;
                        _log.error("Attention Enum d'encodage pour la qualité JPG non valide, utisation d'une qualité moyenne");
                };
                _currentQuality = quality;
            };
        }

        private static function jpgGenerated(rawJPG:ByteArray, map:Map):void
        {
            try
            {
                _currentOutputFileStream.writeInt(AtouinConstants.GROUND_MAP_VERSION);
                _currentOutputFileStream.writeByte(map.groundCacheCurrentlyUsed);
                _currentOutputFileStream.writeInt(map.groundCRC);
                _currentDiskUsed = (_currentDiskUsed + rawJPG.length);
                _currentOutputFileStream.writeBytes(rawJPG);
                _processing = false;
                _currentMapId = -1;
            }
            catch(e:IOError)
            {
                _log.error("Impossible de sauvegarder le background de la map ");
            };
            try
            {
                _currentOutputFileStream.close();
            }
            catch(e:Error)
            {
            };
            process();
        }


    }
}//package com.ankamagames.atouin.managers

