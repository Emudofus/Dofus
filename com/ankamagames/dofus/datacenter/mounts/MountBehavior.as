package com.ankamagames.dofus.datacenter.mounts
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class MountBehavior extends Object implements IDataCenter
    {
        public var id:uint;
        public var nameId:uint;
        public var descriptionId:uint;
        private var _name:String;
        private var _description:String;
        public static const MODULE:String = "MountBehaviors";

        public function MountBehavior()
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

        public function get description() : String
        {
            if (!this._description)
            {
                this._description = I18n.getText(this.descriptionId);
            }
            return this._description;
        }// end function

        public static function getMountBehaviorById(param1:uint) : MountBehavior
        {
            return GameData.getObject(MODULE, param1) as MountBehavior;
        }// end function

        public static function getMountBehaviors() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
