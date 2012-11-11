package com.ankamagames.berilia.managers
{
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.components.params.*;
    import com.ankamagames.berilia.enums.*;
    import com.ankamagames.berilia.factories.*;
    import com.ankamagames.berilia.interfaces.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.berilia.types.event.*;
    import com.ankamagames.berilia.types.graphic.*;
    import com.ankamagames.berilia.types.tooltip.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.display.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.utils.*;

    public class TooltipManager extends Object
    {
        static var _log:Logger = Log.getLogger(getQualifiedClassName(TooltipManager));
        private static var _tooltips:Array = new Array();
        private static var _tooltipsStrata:Array = new Array();
        private static const TOOLTIP_UI_NAME_PREFIX:String = "tooltip_";
        public static const TOOLTIP_STANDAR_NAME:String = "standard";
        public static var _tooltipCache:Dictionary = new Dictionary();
        public static var _tooltipCacheParam:Dictionary = new Dictionary();
        public static var defaultTooltipUiScript:Class;
        private static var _isInit:Boolean = false;

        public function TooltipManager()
        {
            return;
        }// end function

        public static function show(param1, param2, param3:UiModule, param4:Boolean = true, param5:String = "standard", param6:uint = 0, param7:uint = 2, param8:int = 3, param9:Boolean = true, param10:String = null, param11:Class = null, param12:Object = null, param13:String = null, param14:Boolean = false, param15:int = 4, param16:Number = 1) : Tooltip
        {
            var _loc_18:* = null;
            var _loc_19:* = null;
            if (!_isInit)
            {
                Berilia.getInstance().addEventListener(UiRenderEvent.UIRenderComplete, onUiRenderComplete);
                Berilia.getInstance().addEventListener(UiUnloadEvent.UNLOAD_UI_STARTED, onUiUnloadStarted);
                _isInit = true;
            }
            param5 = (param9 ? (TOOLTIP_UI_NAME_PREFIX) : ("")) + param5;
            if (param11 == null)
            {
                param11 = defaultTooltipUiScript;
            }
            if (_tooltips[param5])
            {
                hide(param5);
            }
            if (param13)
            {
                _loc_18 = param13.split("#");
                if (_tooltipCache[_loc_18[0]] && _loc_18.length == 1 || _tooltipCache[_loc_18[0]] && _loc_18.length > 1 && _tooltipCacheParam[_loc_18[0]] == _loc_18[1])
                {
                    _loc_19 = _tooltipCache[_loc_18[0]] as Tooltip;
                    _tooltips[param5] = param1;
                    _tooltipsStrata[param5] = _loc_19.display.strata;
                    Berilia.getInstance().uiList[param5] = _loc_19.display;
                    DisplayObjectContainer(Berilia.getInstance().docMain.getChildAt((StrataEnum.STRATA_TOOLTIP + 1))).addChild(_loc_19.display);
                    _loc_19.display.x = 0;
                    _loc_19.display.y = 0;
                    _loc_19.display.scaleX = param16;
                    _loc_19.display.scaleY = param16;
                    _loc_19.display.uiClass.main(new TooltipProperties(_loc_19, param4, getTargetRect(param2), param6, param7, param8, SecureCenter.secure(param1), param12, param16));
                    return _loc_19;
                }
            }
            var _loc_17:* = TooltipsFactory.create(param1, param10, param11, param12);
            if (!TooltipsFactory.create(param1, param10, param11, param12))
            {
                _log.error("Erreur lors du rendu du tooltip de " + param1 + " (" + getQualifiedClassName(param1) + ")");
                return null;
            }
            if (param3)
            {
                _loc_17.uiModuleName = param3.id;
            }
            _tooltips[param5] = param1;
            if (param14)
            {
                param15 = StrataEnum.STRATA_TOP;
            }
            _loc_17.askTooltip(new Callback(onTooltipReady, _loc_17, param3, param5, param1, param2, param4, param6, param7, param8, param13, param15, param12, param16));
            return _loc_17;
        }// end function

        public static function hide(param1:String = "standard") : void
        {
            if (param1 == null)
            {
                param1 = TOOLTIP_STANDAR_NAME;
            }
            if (param1.indexOf(TOOLTIP_UI_NAME_PREFIX) == -1)
            {
                param1 = TOOLTIP_UI_NAME_PREFIX + param1;
            }
            if (_tooltips[param1])
            {
                Berilia.getInstance().unloadUi(param1);
                delete _tooltips[param1];
            }
            return;
        }// end function

        public static function isVisible(param1:String) : Boolean
        {
            if (param1.indexOf(TOOLTIP_UI_NAME_PREFIX) == -1)
            {
                param1 = TOOLTIP_UI_NAME_PREFIX + param1;
            }
            return _tooltips[param1] != null;
        }// end function

        public static function updateContent(param1:String, param2:String, param3:Object) : void
        {
            var _loc_4:* = null;
            if (isVisible(param2))
            {
                _loc_4 = _tooltipCache[param1] as Tooltip;
                if (_loc_4)
                {
                    _loc_4.display.uiClass.updateContent(new TooltipProperties(_loc_4, false, null, 0, 0, 0, param3, null));
                }
            }
            return;
        }// end function

        public static function hideAll() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            for (_loc_1 in _tooltips)
            {
                
                _loc_2 = _tooltipsStrata[_loc_1];
                if (_loc_2 == StrataEnum.STRATA_TOOLTIP || _loc_2 == StrataEnum.STRATA_WORLD)
                {
                    hide(_loc_1);
                }
            }
            return;
        }// end function

        public static function clearCache() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = Berilia.getInstance();
            for each (_loc_2 in _tooltipCache)
            {
                
                _loc_2.display.cached = false;
                _loc_1.uiList[_loc_2.display.name] = _loc_2.display;
                _loc_1.unloadUi(_loc_2.display.name);
            }
            _tooltipCache = new Dictionary();
            _tooltipCacheParam = new Dictionary();
            return;
        }// end function

        private static function onTooltipReady(param1:Tooltip, param2:UiModule, param3:String, param4, param5, param6:Boolean, param7:uint, param8:uint, param9:int, param10:String, param11:int, param12:Object, param13:int) : void
        {
            var _loc_16:* = null;
            var _loc_17:* = null;
            var _loc_14:* = param10 != null;
            var _loc_15:* = _tooltips[param3] && _tooltips[param3] === param4;
            _tooltipsStrata[param3] = param11;
            if (_loc_15 || param10)
            {
                _loc_16 = new UiData(param2, param3, null, null);
                _loc_16.xml = param1.content;
                _loc_16.uiClass = param1.scriptClass;
                param1.display = Berilia.getInstance().loadUi(param2, _loc_16, param3, new TooltipProperties(param1, param6, getTargetRect(param5), param7, param8, param9, SecureCenter.secure(param4), param12, param13), true, param11, !_loc_15, null);
                if (param10)
                {
                    _loc_17 = param10.split("#");
                    _tooltipCache[_loc_17[0]] = param1;
                    if (_loc_17.length > 0)
                    {
                        _tooltipCacheParam[_loc_17[0]] = _loc_17[1];
                    }
                    param1.display.cached = true;
                    param1.display.cacheAsBitmap = true;
                }
            }
            return;
        }// end function

        private static function getTargetRect(param1) : TooltipRectangle
        {
            var _loc_2:* = null;
            var _loc_4:* = null;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = false;
            var _loc_8:* = null;
            var _loc_3:* = SecureCenter.unsecure(param1);
            if (_loc_3)
            {
                if (_loc_3 is Rectangle)
                {
                    _loc_2 = new Point(_loc_3.x, _loc_3.y);
                }
                else
                {
                    _loc_2 = _loc_3.localToGlobal(new Point(_loc_3.x, _loc_3.y));
                }
                _loc_4 = Berilia.getInstance().strataTooltip.globalToLocal(_loc_2);
                _loc_5 = StageShareManager.stageScaleX;
                _loc_6 = StageShareManager.stageScaleY;
                _loc_7 = _loc_3 is DisplayObject ? (Berilia.getInstance().docMain.contains(_loc_3)) : (false);
                _loc_8 = new TooltipRectangle(_loc_4.x * (_loc_7 ? (_loc_5) : (1)), _loc_4.y * (_loc_7 ? (_loc_6) : (1)), _loc_3.width / _loc_5, _loc_3.height / _loc_6);
                return _loc_8;
            }
            return null;
        }// end function

        private static function localToGlobal(param1:Object, param2:Point = null) : Point
        {
            if (!param2)
            {
                param2 = new Point();
            }
            if (!param1.hasOwnProperty("parent"))
            {
                return param1.localToGlobal(new Point(param1.x, param1.y));
            }
            param2.x = param2.x + param1.x;
            param2.y = param2.y + param1.y;
            if (param1.parent && !(param1.parent is IApplicationContainer))
            {
                param2.x = param2.x * param1.parent.scaleX;
                param2.y = param2.y * param1.parent.scaleY;
                param2 = localToGlobal(param1.parent, param2);
            }
            return param2;
        }// end function

        private static function onUiRenderComplete(event:UiRenderEvent) : void
        {
            TooltipManager.removeTooltipsHiddenByUi(event.uiTarget.name);
            return;
        }// end function

        private static function onUiUnloadStarted(event:UiUnloadEvent) : void
        {
            TooltipManager.removeTooltipsHiddenByUi(event.name);
            return;
        }// end function

        private static function removeTooltipsHiddenByUi(param1:String) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_2:* = Berilia.getInstance();
            var _loc_3:* = _loc_2.getUi(param1);
            if (!_loc_3)
            {
                return;
            }
            var _loc_4:* = _loc_3.getBounds(StageShareManager.stage);
            for (_loc_5 in _tooltips)
            {
                
                _loc_6 = _tooltipsStrata[_loc_5];
                if (_loc_6 == StrataEnum.STRATA_TOOLTIP || _loc_6 == StrataEnum.STRATA_WORLD)
                {
                    if (!_loc_2.getUi(_loc_5))
                    {
                        continue;
                    }
                    _loc_7 = _loc_2.getUi(_loc_5).getBounds(StageShareManager.stage);
                    if (_loc_7.x > _loc_4.x && _loc_7.x + _loc_7.width < _loc_4.x + _loc_4.width && _loc_7.y > _loc_4.y && _loc_7.y + _loc_7.height < _loc_4.x + _loc_4.height)
                    {
                        hide(_loc_5);
                    }
                }
            }
            return;
        }// end function

    }
}
