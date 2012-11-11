package com.ankamagames.dofus.datacenter.npcs
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class NpcAction extends Object implements IDataCenter
    {
        public var id:int;
        public var nameId:uint;
        private var _name:String;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(NpcAction));
        private static const MODULE:String = "NpcActions";

        public function NpcAction()
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

        public static function getNpcActionById(param1:int) : NpcAction
        {
            return GameData.getObject(MODULE, param1) as NpcAction;
        }// end function

        public static function getNpcActions() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
