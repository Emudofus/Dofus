package com.ankamagames.dofus.console.debug
{
    import com.ankamagames.dofus.kernel.sound.*;
    import com.ankamagames.dofus.kernel.sound.manager.*;
    import com.ankamagames.jerakine.console.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.protocolAudio.*;
    import flash.utils.*;

    public class SoundInstructionHandler extends Object implements ConsoleInstructionHandler
    {
        static const _log:Logger = Log.getLogger(getQualifiedClassName(SoundInstructionHandler));

        public function SoundInstructionHandler()
        {
            return;
        }// end function

        public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void
        {
            var _loc_4:String = null;
            var _loc_5:String = null;
            var _loc_6:Number = NaN;
            var _loc_7:Boolean = false;
            var _loc_8:String = null;
            var _loc_9:Number = NaN;
            var _loc_10:Boolean = false;
            var _loc_11:uint = 0;
            var _loc_12:uint = 0;
            var _loc_13:uint = 0;
            switch(param2)
            {
                case "playmusic":
                {
                    if (param3.length != 2)
                    {
                        param1.output("COMMAND FAILED ! playmusic must have followings parameters : \n-id\n-volume");
                        return;
                    }
                    _loc_5 = param3[0];
                    _loc_6 = param3[1];
                    _loc_7 = true;
                    SoundManager.getInstance().manager.playAdminSound(_loc_5, _loc_6, _loc_7, 0);
                    break;
                }
                case "stopmusic":
                {
                    SoundManager.getInstance().manager.removeAllSounds();
                    break;
                }
                case "playambiance":
                {
                    if (param3.length != 2)
                    {
                        param1.output("COMMAND FAILED ! playambiance must have followings parameters : \n-id\n-volume");
                        return;
                    }
                    _loc_8 = param3[0];
                    _loc_9 = param3[1];
                    _loc_10 = true;
                    SoundManager.getInstance().manager.playAdminSound(_loc_8, _loc_9, _loc_10, 1);
                    break;
                }
                case "stopambiance":
                {
                    SoundManager.getInstance().manager.stopAdminSound(1);
                    break;
                }
                case "addsoundinplaylist":
                {
                    if (param3.length != 4)
                    {
                        param1.output("addSoundInPLaylist must have followings parameters : \n-id\n-volume\n-silenceMin\n-SilenceMax");
                        return;
                    }
                    _loc_4 = param3[0];
                    _loc_11 = param3[1];
                    _loc_12 = param3[2];
                    _loc_13 = param3[3];
                    if (!SoundManager.getInstance().manager.addSoundInPlaylist(_loc_4, _loc_11, _loc_12, _loc_13))
                    {
                        param1.output("addSoundInPLaylist failed !");
                    }
                    break;
                }
                case "stopplaylist":
                {
                    if (param3.length != 0)
                    {
                        param1.output("stopplaylist doesn\'t accept any paramter");
                        return;
                    }
                    SoundManager.getInstance().manager.stopPlaylist();
                    break;
                }
                case "playplaylist":
                {
                    if (param3.length != 0)
                    {
                        param1.output("removeSoundInPLaylist doesn\'t accept any paramter");
                        return;
                    }
                    SoundManager.getInstance().manager.playPlaylist();
                    break;
                }
                case "activesounds":
                {
                    if (SoundManager.getInstance().manager is ClassicSoundManager)
                    {
                        (SoundManager.getInstance().manager as ClassicSoundManager).forceSoundsDebugMode = true;
                    }
                    if (SoundManager.getInstance().manager is RegSoundManager)
                    {
                        (SoundManager.getInstance().manager as RegSoundManager).forceSoundsDebugMode = true;
                    }
                    break;
                }
                case "clearsoundcache":
                {
                    RegConnectionManager.getInstance().send(ProtocolEnum.CLEAR_CACHE);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function getHelp(param1:String) : String
        {
            switch(param1)
            {
                case "playsound":
                {
                    return "Play a sound";
                }
                case "clearsoundcache":
                {
                    return "Nettoye les fichiers pré-cachés pour le son afin de les relire directement depuis le disque lors de la prochaine demande de lecture";
                }
                default:
                {
                    break;
                }
            }
            return "Unknown command \'" + param1 + "\'.";
        }// end function

        public function getParamPossibilities(param1:String, param2:uint = 0, param3:Array = null) : Array
        {
            return [];
        }// end function

        private function getParams(param1:Array, param2:Array) : Array
        {
            var _loc_4:String = null;
            var _loc_5:uint = 0;
            var _loc_6:String = null;
            var _loc_7:String = null;
            var _loc_3:Array = [];
            for (_loc_4 in param1)
            {
                
                _loc_5 = parseInt(_loc_4);
                _loc_6 = param1[_loc_5];
                _loc_7 = param2[_loc_5];
                _loc_3[_loc_5] = this.getParam(_loc_6, _loc_7);
            }
            return _loc_3;
        }// end function

        private function getParam(param1:String, param2:String)
        {
            switch(param2)
            {
                case "String":
                {
                    return param1;
                }
                case "Boolean":
                {
                    return param1 == "true" || param1 == "1";
                }
                case "int":
                case "uint":
                {
                    return parseInt(param1);
                }
                default:
                {
                    _log.warn("Unsupported parameter type \'" + param2 + "\'.");
                    return param1;
                    break;
                }
            }
        }// end function

    }
}
