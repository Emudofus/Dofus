package com.ankamagames.dofus.datacenter.interactives
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class SkillName extends Object implements IDataCenter
    {
        public var id:int;
        public var nameId:uint;
        private var _name:String;
        private static const MODULE:String = "SkillNames";

        public function SkillName()
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

        public static function getSkillNameById(param1:int) : SkillName
        {
            return GameData.getObject(MODULE, param1) as ;
        }// end function

    }
}
