package com.ankamagames.dofus.datacenter.appearance
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import __AS3__.vec.Vector;
    import com.ankamagames.tiphon.types.TransformData;
    import com.ankamagames.jerakine.data.GameData;

    public class SkinPosition implements IDataCenter 
    {

        private static const MODULE:String = "SkinPositions";

        public var id:uint;
        public var transformation:Vector.<TransformData>;
        public var clip:Vector.<String>;
        public var skin:Vector.<uint>;


        public static function getSkinPositionById(id:int):SkinPosition
        {
            return ((GameData.getObject(MODULE, id) as SkinPosition));
        }

        public static function getAllSkinPositions():Array
        {
            return (GameData.getObjects(MODULE));
        }


    }
}//package com.ankamagames.dofus.datacenter.appearance

