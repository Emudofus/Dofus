package com.ankamagames.dofus.datacenter.mounts
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class RideFood extends Object implements IDataCenter
    {
        public var gid:uint;
        public var typeId:uint;
        public static var MODULE:String = "RideFood";

        public function RideFood()
        {
            return;
        }// end function

        public static function getRideFoods() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
