package com.ankamagames.dofus.datacenter.effects
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class Effect extends Object implements IDataCenter
    {
        public var id:int;
        public var descriptionId:uint;
        public var iconId:uint;
        public var characteristic:int;
        public var category:uint;
        public var operator:String;
        public var showInTooltip:Boolean;
        public var useDice:Boolean;
        public var forceMinMax:Boolean;
        public var boost:Boolean;
        public var active:Boolean;
        public var showInSet:Boolean;
        public var bonusType:int;
        public var useInFight:Boolean;
        public var effectPriority:uint;
        private var _description:String;
        private static const MODULE:String = "Effects";

        public function Effect()
        {
            return;
        }// end function

        public function get description() : String
        {
            if (!this._description)
            {
                this._description = I18n.getText(this.descriptionId);
            }
            return this._description;
        }// end function

        public static function getEffectById(param1:uint) : Effect
        {
            return GameData.getObject(MODULE, param1) as ;
        }// end function

    }
}
