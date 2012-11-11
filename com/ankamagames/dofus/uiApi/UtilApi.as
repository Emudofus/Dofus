package com.ankamagames.dofus.uiApi
{
    import com.ankamagames.berilia.interfaces.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.dofus.misc.utils.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.utils.misc.*;
    import flash.geom.*;

    public class UtilApi extends Object implements IApi
    {
        private var _module:UiModule;

        public function UtilApi()
        {
            return;
        }// end function

        public function set module(param1:UiModule) : void
        {
            this._module = param1;
            return;
        }// end function

        public function destroy() : void
        {
            this._module = null;
            return;
        }// end function

        public function callWithParameters(param1:Function, param2:Array) : void
        {
            CallWithParameters.call(param1, param2);
            return;
        }// end function

        public function callConstructorWithParameters(param1:Class, param2:Array)
        {
            return CallWithParameters.callConstructor(param1, param2);
        }// end function

        public function callRWithParameters(param1:Function, param2:Array)
        {
            return CallWithParameters.callR(param1, param2);
        }// end function

        public function kamasToString(param1:Number, param2:String = "-") : String
        {
            if (param2 == "-")
            {
                param2 = I18n.getUiText("ui.common.short.kama", []);
            }
            var _loc_3:* = this.formateIntToString(param1);
            if (param2 == "")
            {
                return _loc_3;
            }
            return _loc_3 + " " + param2;
        }// end function

        public function formateIntToString(param1:Number) : String
        {
            return StringUtils.formateIntToString(param1);
        }// end function

        public function stringToKamas(param1:String, param2:String = "-") : int
        {
            var _loc_3:* = null;
            var _loc_4:* = param1;
            do
            {
                
                _loc_3 = _loc_4;
                _loc_4 = _loc_3.replace(" ", "");
            }while (_loc_3 != _loc_4)
            do
            {
                
                _loc_3 = _loc_4;
                _loc_4 = _loc_3.replace(" ", "");
            }while (_loc_3 != _loc_4)
            if (param2 == "-")
            {
                param2 = I18n.getUiText("ui.common.short.kama", []);
            }
            if (_loc_3.substr(_loc_3.length - param2.length) == param2)
            {
                _loc_3 = _loc_3.substr(0, _loc_3.length - param2.length);
            }
            return int(_loc_3);
        }// end function

        public function getTextWithParams(param1:int, param2:Array, param3:String = "%") : String
        {
            var _loc_4:* = I18n.getText(param1);
            if (I18n.getText(param1))
            {
                return ParamsDecoder.applyParams(_loc_4, param2, param3);
            }
            return "";
        }// end function

        public function noAccent(param1:String) : String
        {
            return StringUtils.noAccent(param1);
        }// end function

        public function changeColor(param1:Object, param2:Number, param3:int, param4:Boolean = false) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            if (param1 != null)
            {
                if (param4)
                {
                    _loc_5 = new ColorTransform(1, 1, 1, 1, 0, 0, 0);
                    param1.colorTransform(_loc_5, param3);
                }
                else
                {
                    _loc_6 = param2 >> 16 & 255;
                    _loc_7 = param2 >> 8 & 255;
                    _loc_8 = param2 >> 0 & 255;
                    _loc_9 = new ColorTransform(0, 0, 0, 1, _loc_6, _loc_7, _loc_8);
                    param1.colorTransform(_loc_9, param3);
                }
            }
            return;
        }// end function

    }
}
