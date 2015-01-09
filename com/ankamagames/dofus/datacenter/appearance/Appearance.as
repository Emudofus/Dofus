package com.ankamagames.dofus.datacenter.appearance
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.data.GameData;

    public class Appearance implements IDataCenter 
    {

        public static const MODULE:String = "Appearances";

        public var id:uint;
        public var type:uint;
        public var data:String;


        public static function getAppearanceById(id:uint):Appearance
        {
            return ((GameData.getObject(MODULE, id) as Appearance));
        }


    }
}//package com.ankamagames.dofus.datacenter.appearance

