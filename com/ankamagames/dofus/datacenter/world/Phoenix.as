package com.ankamagames.dofus.datacenter.world
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.data.GameData;

    public class Phoenix implements IDataCenter 
    {

        public static const MODULE:String = "Phoenixes";

        public var mapId:uint;


        public static function getAllPhoenixes():Array
        {
            return (GameData.getObjects(MODULE));
        }


    }
}//package com.ankamagames.dofus.datacenter.world

