package com.ankamagames.dofus.datacenter.misc
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class TypeAction extends Object implements IDataCenter
    {
        public var id:int;
        public var elementName:String;
        public var elementId:int;
        public static const MODULE:String = "TypeActions";

        public function TypeAction()
        {
            return;
        }// end function

        public static function getTypeActionById(param1:int) : TypeAction
        {
            return GameData.getObject(MODULE, param1) as TypeAction;
        }// end function

        public static function getAllTypeAction() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
