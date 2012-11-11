package com.ankamagames.dofus.datacenter.challenges
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class Challenge extends Object implements IDataCenter
    {
        public var id:int;
        public var nameId:uint;
        public var descriptionId:uint;
        private var _name:String;
        private var _description:String;
        private static const MODULE:String = "Challenge";
        static const _log:Logger = Log.getLogger(getQualifiedClassName(Challenge));

        public function Challenge()
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

        public static function getChallengeById(param1:int) : Challenge
        {
            return GameData.getObject(MODULE, param1) as ;
        }// end function

        public static function getChallenges() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
