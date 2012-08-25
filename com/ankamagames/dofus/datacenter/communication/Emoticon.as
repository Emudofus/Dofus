package com.ankamagames.dofus.datacenter.communication
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.tiphon.types.look.*;
    import flash.utils.*;

    public class Emoticon extends Object implements IDataCenter
    {
        public var id:uint;
        public var nameId:uint;
        public var shortcutId:uint;
        public var order:uint;
        public var defaultAnim:String;
        public var persistancy:Boolean;
        public var eight_directions:Boolean;
        public var aura:Boolean;
        public var anims:Vector.<String>;
        public var cooldown:uint = 1000;
        public var duration:uint = 0;
        public var weight:uint;
        private var _name:String;
        private var _shortcut:String;
        private static const MODULE:String = "Emoticons";
        static const _log:Logger = Log.getLogger(getQualifiedClassName(Emoticon));

        public function Emoticon()
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

        public function get shortcut() : String
        {
            return this.defaultAnim;
        }// end function

        public function getAnimName(param1:TiphonEntityLook) : String
        {
            var _loc_2:String = null;
            var _loc_3:String = null;
            var _loc_4:Array = null;
            var _loc_5:uint = 0;
            var _loc_6:Array = null;
            var _loc_7:uint = 0;
            var _loc_8:String = null;
            var _loc_9:uint = 0;
            var _loc_10:* = undefined;
            if (param1)
            {
                for each (_loc_3 in this.anims)
                {
                    
                    _loc_4 = _loc_3.split(";");
                    _loc_5 = parseInt(_loc_4[0]);
                    if (param1 && _loc_5 == param1.getBone())
                    {
                        _loc_6 = _loc_4[1].split(",");
                        _loc_7 = 0;
                        for each (_loc_8 in _loc_6)
                        {
                            
                            _loc_9 = parseInt(_loc_8);
                            for each (_loc_10 in param1.skins)
                            {
                                
                                if (_loc_9 == _loc_10)
                                {
                                    _loc_7 = _loc_7 + 1;
                                }
                            }
                        }
                        if (_loc_7 > 0)
                        {
                            _loc_2 = "AnimEmote" + _loc_4[2];
                        }
                    }
                }
            }
            if (!_loc_2)
            {
                _loc_2 = "AnimEmote" + this.defaultAnim.charAt(0).toUpperCase() + this.defaultAnim.substr(1).toLowerCase() + "_0";
            }
            return _loc_2;
        }// end function

        public static function getEmoticonById(param1:int) : Emoticon
        {
            return GameData.getObject(MODULE, param1) as ;
        }// end function

        public static function getEmoticons() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
