package com.ankamagames.berilia.api
{
    import __AS3__.vec.*;
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.components.*;
    import com.ankamagames.berilia.enums.*;
    import com.ankamagames.berilia.interfaces.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.berilia.types.event.*;
    import com.ankamagames.berilia.types.graphic.*;
    import com.ankamagames.berilia.types.listener.*;
    import com.ankamagames.berilia.types.shortcut.*;
    import com.ankamagames.berilia.types.tooltip.*;
    import com.ankamagames.berilia.utils.*;
    import com.ankamagames.berilia.utils.errors.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.handlers.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.display.*;
    import com.ankamagames.jerakine.utils.memory.*;
    import com.ankamagames.jerakine.utils.misc.*;
    import com.ankamagames.jerakine.utils.pattern.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.utils.*;

    public class UiApi extends Object implements IApi
    {
        private var _module:UiModule;
        private var _currentUi:UiRootContainer;
        public static var MEMORY_LOG:Dictionary = new Dictionary(true);
        public static const _log:Logger = Log.getLogger(getQualifiedClassName(UiApi));

        public function UiApi()
        {
            MEMORY_LOG[this] = 1;
            return;
        }// end function

        public function set module(param1:UiModule) : void
        {
            if (!this._module)
            {
                this._module = param1;
            }
            return;
        }// end function

        public function set currentUi(param1:UiRootContainer) : void
        {
            if (!this._currentUi)
            {
                this._currentUi = param1;
            }
            return;
        }// end function

        public function destroy() : void
        {
            this._currentUi = null;
            this._module = null;
            return;
        }// end function

        public function loadUi(param1:String, param2:String = null, param3 = null, param4:uint = 1, param5:String = null) : Object
        {
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_6:* = this._module;
            var _loc_7:* = param1;
            if (!this._module.uis[param1])
            {
                if (param1.indexOf("::") != -1)
                {
                    _loc_8 = param1.split("::");
                    _loc_6 = UiModuleManager.getInstance().getModule(_loc_8[0]);
                    if (!_loc_6)
                    {
                        throw new BeriliaError("Module [" + _loc_8[0] + "] does not exist");
                    }
                    if (_loc_6.trusted && !this._module.trusted)
                    {
                        throw new ApiError("You cannot load trusted UI");
                    }
                    _loc_7 = _loc_8[1];
                }
                else
                {
                    throw new BeriliaError(param1 + " not found in module " + this._module.name);
                }
            }
            if (!param2)
            {
                param2 = _loc_7;
            }
            if (_loc_6.uis[_loc_7])
            {
                _loc_9 = Berilia.getInstance().loadUi(_loc_6, _loc_6.uis[_loc_7], param2, param3, false, param4, false, param5);
                if (_loc_7 != "tips" && _loc_7 != "buffUi")
                {
                    FocusHandler.getInstance().setFocus(_loc_9);
                }
                return SecureCenter.secure(_loc_9, _loc_6.trusted);
            }
            return null;
        }// end function

        public function loadUiInside(param1:String, param2:GraphicContainer, param3:String = null, param4 = null) : Object
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_5:* = this._module;
            var _loc_6:* = param1;
            if (!this._module.uis[param1])
            {
                if (param1.indexOf("::") != -1)
                {
                    _loc_7 = param1.split("::");
                    _loc_5 = UiModuleManager.getInstance().getModule(_loc_7[0]);
                    if (!_loc_5)
                    {
                        throw new BeriliaError("Module [" + _loc_7[0] + "] does not exist");
                    }
                    if (_loc_5.trusted && !this._module.trusted)
                    {
                        throw new ApiError("You cannot load trusted UI");
                    }
                    _loc_6 = _loc_7[1];
                }
                else
                {
                    throw new BeriliaError(param1 + " not found in module " + this._module.name);
                }
            }
            if (!param3)
            {
                param3 = _loc_6;
            }
            if (_loc_5.uis[_loc_6])
            {
                _loc_8 = new UiRootContainer(StageShareManager.stage, _loc_5.uis[_loc_6]);
                _loc_8.uiModule = _loc_5;
                _loc_8.strata = param2.getUi().strata;
                _loc_8.depth = param2.getUi().depth + 1;
                Berilia.getInstance().loadUiInside(_loc_5.uis[_loc_6], param3, _loc_8, param4, false);
                param2.addChild(_loc_8);
                return SecureCenter.secure(_loc_8, _loc_5.trusted);
            }
            return null;
        }// end function

        public function unloadUi(param1:String) : void
        {
            Berilia.getInstance().unloadUi(param1);
            return;
        }// end function

        public function getUi(param1:String)
        {
            var _loc_2:* = Berilia.getInstance().getUi(param1);
            if (!_loc_2)
            {
                return null;
            }
            if (_loc_2.uiModule != this._module && !this._module.trusted)
            {
                throw new ArgumentError("Cannot get access to an UI owned by another module.");
            }
            return SecureCenter.secure(_loc_2, this._module.trusted);
        }// end function

        public function getUiInstances() : Vector.<UiRootContainer>
        {
            var _loc_3:* = null;
            var _loc_1:* = Berilia.getInstance().uiList;
            var _loc_2:* = new Vector.<UiRootContainer>;
            for each (_loc_3 in _loc_1)
            {
                
                if (_loc_3.uiModule == this._module)
                {
                    _loc_2.push(_loc_3);
                }
            }
            return _loc_2;
        }// end function

        public function getModuleList() : Array
        {
            var _loc_3:* = null;
            var _loc_1:* = [];
            var _loc_2:* = UiModuleManager.getInstance().getModules();
            for each (_loc_3 in _loc_2)
            {
                
                _loc_1.push(_loc_3);
            }
            _loc_1 = _loc_1.concat(UiModuleManager.getInstance().disabledModule);
            _loc_1.sortOn(["trusted", "name"], [Array.NUMERIC | Array.DESCENDING, 0]);
            return _loc_1;
        }// end function

        public function setModuleEnable(param1:String, param2:Boolean) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (param2)
            {
                _loc_3 = UiModuleManager.getInstance().disabledModule;
            }
            else
            {
                _loc_3 = UiModuleManager.getInstance().getModules();
            }
            for each (_loc_4 in _loc_3)
            {
                
                if (_loc_4.id == param1 && _loc_4.enable == !param2)
                {
                    _loc_4.enable = param2;
                }
            }
            return;
        }// end function

        public function addChild(param1:Object, param2:Object) : void
        {
            SecureCenter.unsecure(param1).addChild(SecureCenter.unsecure(param2));
            return;
        }// end function

        public function me()
        {
            return SecureCenter.secure(this._currentUi, this._module.trusted);
        }// end function

        public function initDefaultBinds() : void
        {
            BindsManager.getInstance();
            return;
        }// end function

        public function addShortcutHook(param1:String, param2:Function, param3:Boolean = false) : void
        {
            var _loc_4:* = Shortcut.getShortcutByName(param1);
            if (!Shortcut.getShortcutByName(param1) && param1 != "ALL")
            {
                throw new ApiError("Shortcut [" + param1 + "] does not exist");
            }
            var _loc_5:* = this._currentUi ? (this._currentUi.depth) : (0);
            if (param3)
            {
                _loc_5 = 1;
            }
            var _loc_6:* = new GenericListener(param1, this._currentUi ? (this._currentUi.name) : ("__module_" + this._module.id), param2, _loc_5, this._currentUi ? (GenericListener.LISTENER_TYPE_UI) : (GenericListener.LISTENER_TYPE_MODULE), this._currentUi ? (new WeakReference(this._currentUi)) : (null));
            BindsManager.getInstance().registerEvent(_loc_6);
            return;
        }// end function

        public function addComponentHook(param1:GraphicContainer, param2:String) : void
        {
            var _loc_4:* = null;
            var _loc_3:* = this.getEventClassName(param2);
            if (!_loc_3)
            {
                throw new ApiError("Hook [" + param2 + "] does not exist");
            }
            if (!UIEventManager.getInstance().instances[param1])
            {
                _loc_4 = new InstanceEvent(param1, this._currentUi.uiClass);
                UIEventManager.getInstance().registerInstance(_loc_4);
            }
            else
            {
                _loc_4 = UIEventManager.getInstance().instances[param1];
            }
            _loc_4.events[_loc_3] = _loc_3;
            return;
        }// end function

        public function bindApi(param1:Texture, param2:String, param3) : Boolean
        {
            var targetTexture:* = param1;
            var propertyName:* = param2;
            var value:* = param3;
            var internalContent:* = ComponentInternalAccessor.access(targetTexture, "_child");
            if (!internalContent)
            {
                return false;
            }
            try
            {
                internalContent[propertyName] = value;
            }
            catch (e:Error)
            {
                return false;
            }
            return true;
        }// end function

        public function createComponent(param1:String, ... args) : GraphicContainer
        {
            return CallWithParameters.callConstructor(getDefinitionByName("com.ankamagames.berilia.components::" + param1) as Class, args);
        }// end function

        public function createContainer(param1:String, ... args)
        {
            return CallWithParameters.callConstructor(getDefinitionByName("com.ankamagames.berilia.types.graphic::" + param1) as Class, args);
        }// end function

        public function createInstanceEvent(param1:DisplayObject, param2) : InstanceEvent
        {
            return new InstanceEvent(param1, param2);
        }// end function

        public function getEventClassName(param1:String) : String
        {
            switch(param1)
            {
                case EventEnums.EVENT_ONPRESS:
                {
                    return EventEnums.EVENT_ONPRESS_MSG;
                }
                case EventEnums.EVENT_ONRELEASE:
                {
                    return EventEnums.EVENT_ONRELEASE_MSG;
                }
                case EventEnums.EVENT_ONROLLOUT:
                {
                    return EventEnums.EVENT_ONROLLOUT_MSG;
                }
                case EventEnums.EVENT_ONROLLOVER:
                {
                    return EventEnums.EVENT_ONROLLOVER_MSG;
                }
                case EventEnums.EVENT_ONRELEASEOUTSIDE:
                {
                    return EventEnums.EVENT_ONRELEASEOUTSIDE_MSG;
                }
                case EventEnums.EVENT_ONDOUBLECLICK:
                {
                    return EventEnums.EVENT_ONDOUBLECLICK_MSG;
                }
                case EventEnums.EVENT_ONRIGHTCLICK:
                {
                    return EventEnums.EVENT_ONRIGHTCLICK_MSG;
                }
                case EventEnums.EVENT_ONTEXTCLICK:
                {
                    return EventEnums.EVENT_ONTEXTCLICK_MSG;
                }
                case EventEnums.EVENT_ONCOLORCHANGE:
                {
                    return EventEnums.EVENT_ONCOLORCHANGE_MSG;
                }
                case EventEnums.EVENT_ONENTITYREADY:
                {
                    return EventEnums.EVENT_ONENTITYREADY_MSG;
                }
                case EventEnums.EVENT_ONSELECTITEM:
                {
                    return EventEnums.EVENT_ONSELECTITEM_MSG;
                }
                case EventEnums.EVENT_ONSELECTEMPTYITEM:
                {
                    return EventEnums.EVENT_ONSELECTEMPTYITEM_MSG;
                }
                case EventEnums.EVENT_ONCREATETAB:
                {
                    return EventEnums.EVENT_ONCREATETAB_MSG;
                }
                case EventEnums.EVENT_ONDELETETAB:
                {
                    return EventEnums.EVENT_ONDELETETAB_MSG;
                }
                case EventEnums.EVENT_ONRENAMETAB:
                {
                    return EventEnums.EVENT_ONRENAMETAB_MSG;
                }
                case EventEnums.EVENT_ONITEMROLLOUT:
                {
                    return EventEnums.EVENT_ONITEMROLLOUT_MSG;
                }
                case EventEnums.EVENT_ONITEMROLLOVER:
                {
                    return EventEnums.EVENT_ONITEMROLLOVER_MSG;
                }
                case EventEnums.EVENT_ONITEMRIGHTCLICK:
                {
                    return EventEnums.EVENT_ONITEMRIGHTCLICK_MSG;
                }
                case EventEnums.EVENT_ONDROP:
                {
                    return EventEnums.EVENT_ONDROP_MSG;
                }
                case EventEnums.EVENT_ONTEXTUREREADY:
                {
                    return EventEnums.EVENT_ONTEXTUREREADY_MSG;
                }
                case EventEnums.EVENT_ONMAPELEMENTROLLOUT:
                {
                    return EventEnums.EVENT_ONMAPELEMENTROLLOUT_MSG;
                }
                case EventEnums.EVENT_ONMAPELEMENTROLLOVER:
                {
                    return EventEnums.EVENT_ONMAPELEMENTROLLOVER_MSG;
                }
                case EventEnums.EVENT_ONMAPELEMENTRIGHTCLICK:
                {
                    return EventEnums.EVENT_ONMAPELEMENTRIGHTCLICK_MSG;
                }
                case EventEnums.EVENT_ONMAPMOVE:
                {
                    return EventEnums.EVENT_ONMAPMOVE_MSG;
                }
                case EventEnums.EVENT_ONMAPROLLOVER:
                {
                    return EventEnums.EVENT_ONMAPROLLOVER_MSG;
                }
                case EventEnums.EVENT_ONVIDEOCONNECTFAILED:
                {
                    return EventEnums.EVENT_ONVIDEOCONNECTFAILED_MSG;
                }
                case EventEnums.EVENT_ONVIDEOCONNECTSUCCESS:
                {
                    return EventEnums.EVENT_ONVIDEOCONNECTSUCCESS_MSG;
                }
                case EventEnums.EVENT_ONVIDEOBUFFERCHANGE:
                {
                    return EventEnums.EVENT_ONVIDEOBUFFERCHANGE_MSG;
                }
                case EventEnums.EVENT_ONCOMPONENTREADY:
                {
                    return EventEnums.EVENT_ONCOMPONENTREADY_MSG;
                }
                case EventEnums.EVENT_ONWHEEL:
                {
                    return EventEnums.EVENT_ONWHEEL_MSG;
                }
                case EventEnums.EVENT_ONMOUSEUP:
                {
                    return EventEnums.EVENT_ONMOUSEUP_MSG;
                }
                case EventEnums.EVENT_ONCHANGE:
                {
                    return EventEnums.EVENT_ONCHANGE_MSG;
                }
                case EventEnums.EVENT_ONBROWSER_SESSION_TIMEOUT:
                {
                    return EventEnums.EVENT_ONBROWSER_SESSION_TIMEOUT_MSG;
                }
                case EventEnums.EVENT_ONBROWSER_DOM_READY:
                {
                    return EventEnums.EVENT_ONBROWSER_DOM_READY_MSG;
                }
                case EventEnums.EVENT_MIDDLECLICK:
                {
                    return EventEnums.EVENT_MIDDLECLICK_MSG;
                }
                default:
                {
                    break;
                }
            }
            return null;
        }// end function

        public function addInstanceEvent(event:InstanceEvent) : void
        {
            UIEventManager.getInstance().registerInstance(event);
            return;
        }// end function

        public function createUri(param1:String) : Uri
        {
            if (param1 && param1.indexOf(":") == -1 && param1.indexOf("./") != 0 && param1.indexOf("\\\\") != 0)
            {
                param1 = "mod://" + this._module.id + "/" + param1;
            }
            return new Uri(param1);
        }// end function

        public function showTooltip(param1, param2, param3:Boolean = false, param4:String = "standard", param5:uint = 0, param6:uint = 2, param7:int = 3, param8:String = null, param9:Class = null, param10:Object = null, param11:String = null, param12:Boolean = false, param13:int = 4) : void
        {
            var _loc_14:* = null;
            if (this._currentUi)
            {
                _loc_14 = TooltipManager.show(param1, param2, this._module, param3, param4, param5, param6, param7, true, param8, param9, param10, param11, param12, param13);
                if (_loc_14)
                {
                    _loc_14.uiModuleName = this._currentUi.name;
                }
            }
            return;
        }// end function

        public function hideTooltip(param1:String = null) : void
        {
            TooltipManager.hide(param1);
            return;
        }// end function

        public function textTooltipInfo(param1:String, param2:String = null, param3:String = null, param4:int = 400) : Object
        {
            return new TextTooltipInfo(param1, param2, param3, param4);
        }// end function

        public function getRadioGroupSelectedItem(param1:String, param2:UiRootContainer) : IRadioItem
        {
            var _loc_3:* = param2.getRadioGroup(param1);
            return _loc_3.selectedItem;
        }// end function

        public function setRadioGroupSelectedItem(param1:String, param2:IRadioItem, param3:UiRootContainer) : void
        {
            var _loc_4:* = param3.getRadioGroup(param1);
            param3.getRadioGroup(param1).selectedItem = param2;
            return;
        }// end function

        public function keyIsDown(param1:uint) : Boolean
        {
            return KeyPoll.getInstance().isDown(param1);
        }// end function

        public function keyIsUp(param1:uint) : Boolean
        {
            return KeyPoll.getInstance().isUp(param1);
        }// end function

        public function convertToTreeData(param1) : Vector.<TreeData>
        {
            return TreeData.fromArray(param1);
        }// end function

        public function setFollowCursorUri(param1, param2:Boolean = false, param3:Boolean = false, param4:int = 0, param5:int = 0, param6:Number = 1) : void
        {
            var _loc_7:* = null;
            if (param1)
            {
                _loc_7 = new LinkedCursorData();
                _loc_7.sprite = new Texture();
                Texture(_loc_7.sprite).uri = param1 is String ? (new Uri(param1)) : (param1);
                _loc_7.sprite.scaleX = param6;
                _loc_7.sprite.scaleY = param6;
                Texture(_loc_7.sprite).finalize();
                _loc_7.lockX = param2;
                _loc_7.lockY = param3;
                _loc_7.offset = new Point(param4, param5);
                LinkedCursorSpriteManager.getInstance().addItem("customUserCursor", _loc_7);
            }
            else
            {
                LinkedCursorSpriteManager.getInstance().removeItem("customUserCursor");
            }
            return;
        }// end function

        public function getFollowCursorUri() : Object
        {
            return LinkedCursorSpriteManager.getInstance().getItem("customUserCursor");
        }// end function

        public function endDrag() : void
        {
            var _loc_1:* = LinkedCursorSpriteManager.getInstance().getItem("DragAndDrop");
            if (_loc_1 && _loc_1.data is SlotDragAndDropData)
            {
                LinkedCursorSpriteManager.getInstance().removeItem("DragAndDrop");
                KernelEventsManager.getInstance().processCallback(BeriliaHookList.DropEnd, SecureCenter.secure(SlotDragAndDropData(_loc_1.data).currentHolder));
            }
            return;
        }// end function

        public function preloadCss(param1:String) : void
        {
            CssManager.getInstance().preloadCss(param1);
            return;
        }// end function

        public function getMouseX() : int
        {
            return StageShareManager.mouseX;
        }// end function

        public function getMouseY() : int
        {
            return StageShareManager.mouseY;
        }// end function

        public function getStageWidth() : int
        {
            return StageShareManager.startWidth;
        }// end function

        public function getStageHeight() : int
        {
            return StageShareManager.startHeight;
        }// end function

        public function getWindowWidth() : int
        {
            return StageShareManager.stage.stageWidth;
        }// end function

        public function getWindowHeight() : int
        {
            return StageShareManager.stage.stageHeight;
        }// end function

        public function getWindowScale() : Number
        {
            return StageShareManager.windowScale;
        }// end function

        public function setFullScreen(param1:Boolean, param2:Boolean = false) : void
        {
            StageShareManager.setFullScreen(param1, param2);
            return;
        }// end function

        public function useIME() : Boolean
        {
            return Berilia.getInstance().useIME;
        }// end function

        public function replaceParams(param1:String, param2:Array, param3:String = "%") : String
        {
            return I18n.replaceParams(param1, param2, param3);
        }// end function

        public function replaceKey(param1:String) : String
        {
            return LangManager.getInstance().replaceKey(param1, true);
        }// end function

        public function getText(param1:String, ... args) : String
        {
            return I18n.getUiText(param1, args);
        }// end function

        public function getTextFromKey(param1:uint, param2:String = "%", ... args) : String
        {
            return I18n.getText(param1, args, param2);
        }// end function

        public function processText(param1:String, param2:String, param3:Boolean = true) : String
        {
            return PatternDecoder.combine(param1, param2, param3);
        }// end function

        public function decodeText(param1:String, param2:Array) : String
        {
            return PatternDecoder.decode(param1, param2);
        }// end function

    }
}
