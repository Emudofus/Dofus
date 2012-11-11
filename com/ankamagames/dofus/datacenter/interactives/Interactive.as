package com.ankamagames.dofus.datacenter.interactives
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class Interactive extends Object implements IDataCenter
    {
        public var id:int;
        public var nameId:uint;
        public var actionId:int;
        public var displayTooltip:Boolean;
        private var _name:String;
        private static const MODULE:String = "Interactives";

        public function Interactive()
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

        public static function getInteractiveById(param1:int) : Interactive
        {
            return GameData.getObject(MODULE, param1) as Interactive;
        }// end function

        public static function getInteractives() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
