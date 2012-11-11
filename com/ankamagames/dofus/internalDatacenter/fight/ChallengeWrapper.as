package com.ankamagames.dofus.internalDatacenter.fight
{
    import com.ankamagames.dofus.datacenter.challenges.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.fight.frames.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.types.*;
    import flash.utils.*;

    public class ChallengeWrapper extends Proxy implements IDataCenter
    {
        private var _challenge:Challenge;
        private var _id:uint;
        private var _targetId:int;
        private var _targetName:String;
        private var _targetLevel:int;
        private var _baseXpBonus:uint;
        private var _extraXpBonus:uint;
        private var _baseDropBonus:uint;
        private var _extraDropBonus:uint;
        private var _result:uint;
        private var _uri:Uri;

        public function ChallengeWrapper()
        {
            return;
        }// end function

        public function set id(param1:uint) : void
        {
            this._challenge = Challenge.getChallengeById(param1);
            this._id = param1;
            return;
        }// end function

        public function set targetId(param1:int) : void
        {
            this._targetId = param1;
            this._targetName = this.getFightFrame().getFighterName(param1);
            this._targetLevel = this.getFightFrame().getFighterLevel(param1);
            return;
        }// end function

        public function set baseXpBonus(param1:uint) : void
        {
            this._baseXpBonus = param1;
            return;
        }// end function

        public function set extraXpBonus(param1:uint) : void
        {
            this._extraXpBonus = param1;
            return;
        }// end function

        public function set baseDropBonus(param1:uint) : void
        {
            this._baseDropBonus = param1;
            return;
        }// end function

        public function set extraDropBonus(param1:uint) : void
        {
            this._extraDropBonus = param1;
            return;
        }// end function

        public function set result(param1:uint) : void
        {
            this._result = param1;
            return;
        }// end function

        public function get id() : uint
        {
            return this._id;
        }// end function

        public function get targetId() : int
        {
            return this._targetId;
        }// end function

        public function get targetName() : String
        {
            return this._targetName;
        }// end function

        public function get targetLevel() : int
        {
            return this._targetLevel;
        }// end function

        public function get baseXpBonus() : uint
        {
            return this._baseXpBonus;
        }// end function

        public function get extraXpBonus() : uint
        {
            return this._extraXpBonus;
        }// end function

        public function get totalXpBonus() : uint
        {
            return this._baseXpBonus + this._extraXpBonus;
        }// end function

        public function get baseDropBonus() : uint
        {
            return this._baseDropBonus;
        }// end function

        public function get extraDropBonus() : uint
        {
            return this._extraDropBonus;
        }// end function

        public function get totalDropBonus() : uint
        {
            return this._baseDropBonus + this._extraDropBonus;
        }// end function

        public function get result() : uint
        {
            return this._result;
        }// end function

        public function get iconUri() : Uri
        {
            if (!this._uri)
            {
                this._uri = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path.challenges").concat(this.id).concat(".png"));
            }
            return this._uri;
        }// end function

        public function get description() : String
        {
            return this._challenge.description;
        }// end function

        public function get name() : String
        {
            return this._challenge.name;
        }// end function

        override function getProperty(param1)
        {
            var l:*;
            var r:*;
            var name:* = param1;
            if (isAttribute(name))
            {
                return this[name];
            }
            l = Challenge.getChallengeById(this.id);
            if (!l)
            {
                r;
            }
            try
            {
                return l[name];
            }
            catch (e:Error)
            {
                return "Error_on_challenge_" + name;
            }
            return;
        }// end function

        private function getFightFrame() : FightContextFrame
        {
            return Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
        }// end function

        public static function create() : ChallengeWrapper
        {
            return new ChallengeWrapper;
        }// end function

    }
}
