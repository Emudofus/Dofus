package com.ankamagames.dofus.datacenter.npcs
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class Npc extends Object implements IDataCenter
    {
        public var id:int;
        public var nameId:uint;
        public var dialogMessages:Vector.<Vector.<int>>;
        public var dialogReplies:Vector.<Vector.<int>>;
        public var actions:Vector.<uint>;
        public var gender:uint;
        public var look:String;
        public var tokenShop:int;
        public var animFunList:Vector.<AnimFunNpcData>;
        private var _name:String;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(Npc));
        private static const MODULE:String = "Npcs";

        public function Npc()
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

        public static function getNpcById(param1:int) : Npc
        {
            return GameData.getObject(MODULE, param1) as ;
        }// end function

        public static function getNpcs() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
