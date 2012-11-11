package com.ankamagames.dofus.datacenter.livingObjects
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class Pet extends Object implements IDataCenter
    {
        public var id:int;
        public var foodItems:Vector.<int>;
        public var foodTypes:Vector.<int>;
        private static const MODULE:String = "Pets";
        static const _log:Logger = Log.getLogger(getQualifiedClassName(Pet));

        public function Pet()
        {
            return;
        }// end function

        public static function getPetById(param1:int) : Pet
        {
            return GameData.getObject(MODULE, param1) as Pet;
        }// end function

        public static function getPets() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
