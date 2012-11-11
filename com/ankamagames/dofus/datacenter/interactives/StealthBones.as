package com.ankamagames.dofus.datacenter.interactives
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class StealthBones extends Object implements IDataCenter
    {
        public var id:uint;
        private static const MODULE:String = "StealthBones";

        public function StealthBones()
        {
            return;
        }// end function

        public static function getStealthBonesById(param1:int) : StealthBones
        {
            return GameData.getObject(MODULE, param1) as ;
        }// end function

    }
}
