package com.ankamagames.dofus.logic.common.frames
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.datacenter.misc.*;
    import com.ankamagames.dofus.logic.common.managers.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.messages.game.script.*;
    import com.ankamagames.dofus.network.messages.secure.*;
    import com.ankamagames.dofus.network.messages.security.*;
    import com.ankamagames.dofusModuleLibrary.enum.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.enums.*;
    import com.ankamagames.jerakine.utils.system.*;
    import flash.display.*;
    import flash.net.*;
    import flash.system.*;

    public class ServerControlFrame extends Object implements Frame
    {

        public function ServerControlFrame()
        {
            return;
        }// end function

        public function pushed() : Boolean
        {
            return true;
        }// end function

        public function pulled() : Boolean
        {
            return true;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            switch(true)
            {
                case param1 is RawDataMessage:
                {
                    _loc_2 = param1 as RawDataMessage;
                    _loc_3 = new Loader();
                    _loc_4 = new LoaderContext(false, ApplicationDomain.currentDomain);
                    AirScanner.allowByteCodeExecution(_loc_4, true);
                    _loc_3.loadBytes(_loc_2.content, _loc_4);
                    return true;
                }
                case param1 is URLOpenMessage:
                {
                    _loc_5 = param1 as URLOpenMessage;
                    _loc_6 = Url.getUrlById(_loc_5.urlId);
                    switch(_loc_6.browserId)
                    {
                        case 1:
                        {
                            _loc_8 = new URLRequest(_loc_6.url);
                            _loc_8.method = _loc_6.method == "" ? ("GET") : (_loc_6.method.toUpperCase());
                            _loc_8.data = _loc_6.variables;
                            navigateToURL(_loc_8);
                            return true;
                        }
                        case 2:
                        {
                            KernelEventsManager.getInstance().processCallback(HookList.OpenWebPortal, WebLocationEnum.WEB_LOCATION_OGRINE);
                            return true;
                        }
                        case 3:
                        {
                            return true;
                        }
                        case 4:
                        {
                            if (HookList[_loc_6.url])
                            {
                                KernelEventsManager.getInstance().processCallback(HookList[_loc_6.url]);
                            }
                            return true;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    return true;
                }
                case param1 is TrustStatusMessage:
                {
                    _loc_7 = param1 as TrustStatusMessage;
                    SecureModeManager.getInstance().active = !_loc_7.trusted;
                    return true;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        public function get priority() : int
        {
            return Priority.NORMAL;
        }// end function

    }
}
