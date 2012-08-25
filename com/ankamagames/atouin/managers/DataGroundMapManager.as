package com.ankamagames.atouin.managers
{
    import com.ankamagames.atouin.*;
    import com.ankamagames.atouin.data.map.*;
    import com.ankamagames.atouin.enums.*;
    import com.ankamagames.atouin.utils.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.benchmark.monitoring.*;
    import com.ankamagames.jerakine.utils.misc.*;
    import flash.display.*;
    import flash.filesystem.*;
    import flash.geom.*;
    import flash.utils.*;

    public class DataGroundMapManager extends Object
    {
        private static const _log:Logger = Log.getLogger(getQualifiedClassName(DataGroundMapManager));
        private static const MAPS_DIRECTORY:String = "./maps";
        private static var _mask:Shape;
        private static var _currentDiskUsed:Number = 0;
        private static const _highJpgEncoder:AsyncJPGEncoder = new AsyncJPGEncoder(60);
        private static const _mediumJpgEncoder:AsyncJPGEncoder = new AsyncJPGEncoder(70);
        private static const _lowJpgEncoder:AsyncJPGEncoder = new AsyncJPGEncoder(80);
        private static var _bitmapDataList:Array = new Array();
        private static var _processing:Boolean = false;
        private static var _directory:File;
        private static var _currentMapId:int = -1;

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
            var _loc_1:Number = NaN;
            var _loc_2:File = null;
            var _loc_3:Array = null;
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_6:File = null;
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

        public static function saveGroundMap(param1:DisplayObjectContainer, param2:Map) : void
        {
            var _loc_4:BitmapData = null;
            FpsManager.getInstance().startTracking("groundMap", 10621692);
            var _loc_3:* = new Matrix();
            if (param2.groundCacheCurrentlyUsed == GroundCache.GROUND_CACHE_MEDIUM_QUALITY)
            {
                _loc_4 = new BitmapData(AtouinConstants.RESOLUTION_MEDIUM_QUALITY.x, AtouinConstants.RESOLUTION_MEDIUM_QUALITY.y, false, 0);
                _loc_3.tx = 20;
                _loc_3.scale(0.75, 0.75);
            }
            else if (param2.groundCacheCurrentlyUsed == GroundCache.GROUND_CACHE_LOW_QUALITY)
            {
                _loc_4 = new BitmapData(AtouinConstants.RESOLUTION_LOW_QUALITY.x, AtouinConstants.RESOLUTION_LOW_QUALITY.y, false, 0);
                _loc_3.tx = 20;
                _loc_3.scale(0.5, 0.5);
            }
            else
            {
                _loc_4 = new BitmapData(AtouinConstants.RESOLUTION_HIGH_QUALITY.x, AtouinConstants.RESOLUTION_HIGH_QUALITY.y, false, 0);
                _loc_3.tx = 20;
            }
            if (!_mask)
            {
                _mask = new Shape();
                _mask.graphics.beginFill(16711680, 0);
                _mask.graphics.drawRect(-20, -20, 1320, 1064);
                _mask.graphics.endFill();
            }
            param1.addChildAt(_mask, 0);
            _loc_4.draw(param1, _loc_3);
            param1.removeChild(_mask);
            _bitmapDataList.push(_loc_4, param2);
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
            var _loc_1:BitmapData = null;
            var _loc_2:Map = null;
            if (!_processing && _bitmapDataList.length)
            {
                _processing = true;
                _loc_1 = _bitmapDataList.shift();
                _loc_2 = _bitmapDataList.shift();
                _currentMapId = _loc_2.id;
                if (_loc_2.groundCacheCurrentlyUsed == GroundCache.GROUND_CACHE_LOW_QUALITY)
                {
                    _lowJpgEncoder.encode(_loc_1, jpgGenerated, _loc_2);
                }
                else if (_loc_2.groundCacheCurrentlyUsed == GroundCache.GROUND_CACHE_MEDIUM_QUALITY)
                {
                    _mediumJpgEncoder.encode(_loc_1, jpgGenerated, _loc_2);
                }
                else if (_loc_2.groundCacheCurrentlyUsed == GroundCache.GROUND_CACHE_HIGH_QUALITY)
                {
                    _highJpgEncoder.encode(_loc_1, jpgGenerated, _loc_2);
                }
            }
            return;
        }// end function

        private static function jpgGenerated(param1:ByteArray, param2:Map) : void
        {
            var _loc_3:* = new File(CustomSharedObject.getCustomSharedObjectDirectory() + MAPS_DIRECTORY + "/" + param2.id + ".bg");
            var _loc_4:* = new FileStream();
            new FileStream().openAsync(_loc_3, FileMode.WRITE);
            _loc_4.writeInt(AtouinConstants.GROUND_MAP_VERSION);
            _loc_4.writeByte(param2.groundCacheCurrentlyUsed);
            _loc_4.writeInt(param2.groundCRC);
            _currentDiskUsed = _currentDiskUsed + param1.length;
            _loc_4.writeBytes(param1);
            _loc_4.close();
            _processing = false;
            _currentMapId = -1;
            process();
            return;
        }// end function

    }
}
