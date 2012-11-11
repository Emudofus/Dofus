package com.ankamagames.dofus.datacenter.mounts
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class Mount extends Object implements IDataCenter
    {
        public var id:uint;
        public var nameId:uint;
        public var look:String;
        private var _name:String;
        private static var MODULE:String = "Mounts";

        public function Mount()
        {
            return;
        }// end function

        public function get name() : String
        {
            if (!this._name)
            {
                this._name = I18n.getText(this.nameId);
            }
            return this._name;
        }// end function

        public static function getMountById(param1:uint) : Mount
        {
            return GameData.getObject(MODULE, param1) as Mount;
        }// end function

        public static function getMounts() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
