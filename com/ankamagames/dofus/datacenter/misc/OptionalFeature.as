package com.ankamagames.dofus.datacenter.misc
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import flash.utils.*;

    public class OptionalFeature extends Object implements IDataCenter
    {
        public var id:int;
        public var keyword:String;
        public static const MODULE:String = "OptionalFeatures";
        private static var _keywords:Dictionary;

        public function OptionalFeature()
        {
            return;
        }// end function

        public static function getOptionalFeatureById(param1:int) : OptionalFeature
        {
            return GameData.getObject(MODULE, param1) as OptionalFeature;
        }// end function

        public static function getOptionalFeatureByKeyword(param1:String) : OptionalFeature
        {
            var _loc_2:* = null;
            if (!_keywords || !_keywords[param1])
            {
                _keywords = new Dictionary();
                for each (_loc_2 in getAllOptionalFeatures())
                {
                    
                    _keywords[_loc_2.keyword] = _loc_2;
                }
            }
            return _keywords[param1];
        }// end function

        public static function getAllOptionalFeatures() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
