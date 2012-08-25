package com.ankamagames.jerakine.data
{
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.newCache.garbage.*;
    import com.ankamagames.jerakine.newCache.impl.*;
    import com.ankamagames.jerakine.utils.memory.*;
    import flash.utils.*;

    public class GameData extends AbstractDataManager
    {
        static const _log:Logger = Log.getLogger(getQualifiedClassName(GameData));
        private static const CACHE_SIZE_RATIO:Number = 0.1;
        private static var _directObjectCaches:Dictionary = new Dictionary();
        private static var _objectCaches:Dictionary = new Dictionary();
        private static var _objectsCaches:Dictionary = new Dictionary();
        private static var _overrides:Dictionary = new Dictionary();

        public function GameData()
        {
            return;
        }// end function

        public static function addOverride(param1:String, param2:int, param3:uint) : void
        {
            if (!_overrides[param1])
            {
                _overrides[param1] = [];
            }
            _overrides[param1][param2] = param3;
            return;
        }// end function

        public static function getObject(param1:String, param2:int) : Object
        {
            var _loc_3:Object = null;
            var _loc_4:WeakReference = null;
            if (_overrides[param1] && _overrides[param1][param2])
            {
                param2 = _overrides[param1][param2];
            }
            if (!_directObjectCaches[param1])
            {
                _directObjectCaches[param1] = new Dictionary();
            }
            else
            {
                _loc_4 = _directObjectCaches[param1][param2];
                if (_loc_4)
                {
                    _loc_3 = _loc_4.object;
                    if (_loc_3)
                    {
                        return _loc_3;
                    }
                }
            }
            if (!_objectCaches[param1])
            {
                _objectCaches[param1] = new Cache(GameDataFileAccessor.getInstance().getCount(param1) * CACHE_SIZE_RATIO, new LruGarbageCollector());
            }
            else
            {
                _loc_3 = (_objectCaches[param1] as Cache).peek(param2);
                if (_loc_3)
                {
                    return _loc_3;
                }
            }
            _loc_3 = GameDataFileAccessor.getInstance().getObject(param1, param2);
            _directObjectCaches[param1][param2] = new WeakReference(_loc_3);
            (_objectCaches[param1] as Cache).store(param2, _loc_3);
            return _loc_3;
        }// end function

        public static function getObjects(param1:String) : Array
        {
            var _loc_2:Array = null;
            if (_objectsCaches[param1])
            {
                _loc_2 = _objectsCaches[param1].object as Array;
                if (_loc_2)
                {
                    return _loc_2;
                }
            }
            _loc_2 = GameDataFileAccessor.getInstance().getObjects(param1);
            _objectsCaches[param1] = new SoftReference(_loc_2);
            return _loc_2;
        }// end function

    }
}
