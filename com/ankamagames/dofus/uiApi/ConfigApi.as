package com.ankamagames.dofus.uiApi
{
    import com.ankamagames.atouin.*;
    import com.ankamagames.atouin.types.*;
    import com.ankamagames.berilia.interfaces.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.berilia.utils.errors.*;
    import com.ankamagames.dofus.externalnotification.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.common.frames.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.misc.options.*;
    import com.ankamagames.dofus.types.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.types.events.*;
    import com.ankamagames.tiphon.engine.*;
    import com.ankamagames.tiphon.types.*;
    import com.ankamagames.tubul.types.*;
    import flash.display.*;
    import flash.utils.*;

    public class ConfigApi extends Object implements IApi
    {
        private var _module:UiModule;
        private static var _init:Boolean = false;

        public function ConfigApi()
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

        public function getConfigProperty(param1:String, param2:String)
        {
            var _loc_3:* = OptionManager.getOptionManager(param1);
            if (!_loc_3)
            {
                throw new ApiError("Config module [" + param1 + "] does not exist.");
            }
            if (_loc_3 && this.isSimpleConfigType(_loc_3[param2]))
            {
                return _loc_3[param2];
            }
            return null;
        }// end function

        public function setConfigProperty(param1:String, param2:String, param3) : void
        {
            var _loc_4:* = OptionManager.getOptionManager(param1);
            if (!OptionManager.getOptionManager(param1))
            {
                throw new ApiError("Config module [" + param1 + "] does not exist.");
            }
            if (this.isSimpleConfigType(_loc_4.getDefaultValue(param2)))
            {
                _loc_4[param2] = param3;
            }
            else
            {
                throw new ApiError(param2 + " cannot be set in config module " + param1 + ".");
            }
            return;
        }// end function

        public function resetConfigProperty(param1:String, param2:String) : void
        {
            if (!OptionManager.getOptionManager(param1))
            {
                throw ApiError("Config module [" + param1 + "] does not exist.");
            }
            OptionManager.getOptionManager(param1).restaureDefaultValue(param2);
            return;
        }// end function

        public function createOptionManager(param1:String) : OptionManager
        {
            var _loc_2:* = new OptionManager(param1);
            return _loc_2;
        }// end function

        public function getAllThemes() : Array
        {
            return ThemeManager.getInstance().getThemes();
        }// end function

        public function getCurrentTheme() : String
        {
            return ThemeManager.getInstance().currentTheme;
        }// end function

        public function isOptionalFeatureActive(param1:int) : Boolean
        {
            var _loc_2:* = Kernel.getWorker().getFrame(MiscFrame) as MiscFrame;
            return _loc_2.isOptionalFeatureActive(param1);
        }// end function

        public function getExternalNotificationValue(param1:int) : int
        {
            return ExternalNotificationManager.getInstance().getNotificationValue(param1);
        }// end function

        public function setExternalNotificationValue(param1:int, param2:int) : void
        {
            ExternalNotificationManager.getInstance().setNotificationValue(param1, param2);
            return;
        }// end function

        private function init() : void
        {
            if (_init)
            {
                return;
            }
            _init = true;
            Atouin.getInstance().options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED, this.onPropertyChanged);
            Dofus.getInstance().options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED, this.onPropertyChanged);
            Tiphon.getInstance().options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED, this.onPropertyChanged);
            return;
        }// end function

        private function isSimpleConfigType(param1) : Boolean
        {
            switch(true)
            {
                case param1 is int:
                case param1 is uint:
                case param1 is Number:
                case param1 is Boolean:
                case param1 is String:
                {
                    return true;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        private function onPropertyChanged(event:PropertyChangeEvent) : void
        {
            var _loc_4:* = null;
            var _loc_2:* = event.propertyValue;
            if (_loc_2 is DisplayObject)
            {
                _loc_2 = SecureCenter.secure(_loc_2, this._module.trusted);
            }
            var _loc_3:* = event.propertyOldValue;
            if (_loc_3 is DisplayObject)
            {
                _loc_2 = SecureCenter.secure(_loc_2, this._module.trusted);
            }
            switch(true)
            {
                case event.watchedClassInstance is AtouinOptions:
                {
                    _loc_4 = "atouin";
                    break;
                }
                case event.watchedClassInstance is DofusOptions:
                {
                    _loc_4 = "dofus";
                    break;
                }
                case event.watchedClassInstance is BeriliaOptions:
                {
                    _loc_4 = "berilia";
                    break;
                }
                case event.watchedClassInstance is TiphonOptions:
                {
                    _loc_4 = "tiphon";
                    break;
                }
                case event.watchedClassInstance is TubulOptions:
                {
                    _loc_4 = "soundmanager";
                    break;
                }
                case event.watchedClassInstance is ChatOptions:
                {
                    _loc_4 = "chat";
                    break;
                }
                default:
                {
                    _loc_4 = getQualifiedClassName(event.watchedClassInstance);
                    break;
                    break;
                }
            }
            KernelEventsManager.getInstance().processCallback(HookList.ConfigPropertyChange, _loc_4, event.propertyName, _loc_2, _loc_3);
            return;
        }// end function

    }
}
