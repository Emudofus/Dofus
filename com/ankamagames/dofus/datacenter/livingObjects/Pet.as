package com.ankamagames.dofus.datacenter.livingObjects
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.data.GameData;

    public class Pet implements IDataCenter 
    {

        public static const MODULE:String = "Pets";
        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Pet));

        public var id:int;
        public var foodItems:Vector.<int>;
        public var foodTypes:Vector.<int>;


        public static function getPetById(id:int):Pet
        {
            return ((GameData.getObject(MODULE, id) as Pet));
        }

        public static function getPets():Array
        {
            return (GameData.getObjects(MODULE));
        }


    }
}//package com.ankamagames.dofus.datacenter.livingObjects

