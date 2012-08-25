package com.ankamagames.dofus.datacenter.misc
{
    import com.ankamagames.dofus.logic.common.managers.*;
    import com.ankamagames.dofus.logic.connection.managers.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.managers.*;
    import flash.net.*;

    public class Url extends Object implements IDataCenter
    {
        public var id:int;
        public var browserId:int;
        public var url:String;
        public var param:String;
        public var method:String;
        private static const MODULE:String = "Url";

        public function Url()
        {
            return;
        }// end function

        public function get variables() : Object
        {
            var _loc_3:Array = null;
            var _loc_4:String = null;
            var _loc_1:* = new URLVariables();
            var _loc_2:* = this.param.split(",");
            for each (_loc_4 in _loc_2)
            {
                
                if (_loc_4 == null || _loc_4 == "null")
                {
                    continue;
                }
                _loc_3 = _loc_4.split(":");
                if (_loc_3[1].charAt(0) == "#")
                {
                    switch(String(_loc_3[1]).toUpperCase().substr(1))
                    {
                        case "TOKEN":
                        {
                            _loc_3[1] = AuthentificationManager.getInstance().ankamaPortalKey;
                            break;
                        }
                        case "LOGIN":
                        {
                            _loc_3[1] = AuthentificationManager.getInstance().username;
                            break;
                        }
                        case "NICKNAME":
                        {
                            _loc_3[1] = PlayerManager.getInstance().nickname;
                            break;
                        }
                        case "GAME":
                        {
                            _loc_3[1] = 1;
                            break;
                        }
                        case "ACCOUNT_ID":
                        {
                            _loc_3[1] = PlayerManager.getInstance().accountId;
                            break;
                        }
                        case "PLAYER_ID":
                        {
                            _loc_3[1] = PlayedCharacterManager.getInstance().id;
                            break;
                        }
                        case "SERVER_ID":
                        {
                            _loc_3[1] = PlayerManager.getInstance().server.id;
                            break;
                        }
                        case "LANG":
                        {
                            _loc_3[1] = XmlConfig.getInstance().getEntry("config.lang.current");
                            break;
                        }
                        case "THEME":
                        {
                            _loc_3[1] = OptionManager.getOptionManager("dofus").switchUiSkin;
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                }
                _loc_1[_loc_3[0]] = _loc_3[1];
            }
            return _loc_1;
        }// end function

        public static function getUrlById(param1:int) : Url
        {
            return GameData.getObject(MODULE, param1) as Url;
        }// end function

        public static function getAllUrl() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
