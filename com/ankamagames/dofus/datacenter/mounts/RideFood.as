package com.ankamagames.dofus.datacenter.mounts
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.data.GameData;

    public class RideFood implements IDataCenter 
    {

        public static var MODULE:String = "RideFood";

        public var gid:uint;
        public var typeId:uint;


        public static function getRideFoods():Array
        {
            return (GameData.getObjects(MODULE));
        }


    }
}//package com.ankamagames.dofus.datacenter.mounts

