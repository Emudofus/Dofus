package com.ankamagames.dofus.datacenter.misc
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import flash.utils.Dictionary;
    import com.ankamagames.jerakine.data.GameData;

    public class OptionalFeature implements IDataCenter 
    {

        public static const MODULE:String = "OptionalFeatures";
        private static var _keywords:Dictionary;

        public var id:int;
        public var keyword:String;


        public static function getOptionalFeatureById(id:int):OptionalFeature
        {
            return ((GameData.getObject(MODULE, id) as OptionalFeature));
        }

        public static function getOptionalFeatureByKeyword(key:String):OptionalFeature
        {
            var feature:OptionalFeature;
            if (((!(_keywords)) || (!(_keywords[key]))))
            {
                _keywords = new Dictionary();
                for each (feature in getAllOptionalFeatures())
                {
                    _keywords[feature.keyword] = feature;
                };
            };
            return (_keywords[key]);
        }

        public static function getAllOptionalFeatures():Array
        {
            return (GameData.getObjects(MODULE));
        }


    }
}//package com.ankamagames.dofus.datacenter.misc

