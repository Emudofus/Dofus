package com.ankamagames.dofus.datacenter.misc
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.data.GameData;

    public class TypeAction implements IDataCenter 
    {

        public static const MODULE:String = "TypeActions";

        public var id:int;
        public var elementName:String;
        public var elementId:int;


        public static function getTypeActionById(id:int):TypeAction
        {
            return ((GameData.getObject(MODULE, id) as TypeAction));
        }

        public static function getAllTypeAction():Array
        {
            return (GameData.getObjects(MODULE));
        }


    }
}//package com.ankamagames.dofus.datacenter.misc

