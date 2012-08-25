package com.ankamagames.berilia.components.gridRenderer
{
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.components.*;
    import com.ankamagames.berilia.components.params.*;
    import com.ankamagames.berilia.interfaces.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.berilia.types.event.*;
    import com.ankamagames.berilia.types.graphic.*;
    import com.ankamagames.berilia.utils.errors.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.utils.display.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.utils.*;

    public class XmlUiGridRenderer extends Object implements IGridRenderer
    {
        protected var _log:Logger;
        private var _sUiName:String;
        private var _sUiModule:String;
        private var _ctr:Sprite;
        private var _berilia:Berilia;
        private var _uiCtr:UiRootContainer;
        private var _grid:Grid;
        private var _bgColor1:ColorTransform;
        private var _bgColor2:ColorTransform;
        private var _shapeIndex:Dictionary;
        private var _dWaitingUpdate:Dictionary;

        public function XmlUiGridRenderer(param1:String)
        {
            var _loc_4:Array = null;
            this._log = Log.getLogger(getQualifiedClassName(XmlUiGridRenderer));
            this._berilia = Berilia.getInstance();
            this._shapeIndex = new Dictionary(true);
            this._dWaitingUpdate = new Dictionary(true);
            var _loc_2:* = param1.split(",");
            var _loc_3:* = _loc_2[0];
            if (_loc_2[1])
            {
                this._bgColor1 = new ColorTransform();
                this._bgColor1.color = parseInt(_loc_2[1], 16);
            }
            if (_loc_2[2])
            {
                this._bgColor2 = new ColorTransform();
                this._bgColor2.color = parseInt(_loc_2[2], 16);
            }
            if (_loc_3.indexOf("::") != -1)
            {
                _loc_4 = _loc_3.split("::");
                if (UiModuleManager.getInstance().getModules()[_loc_4[0]])
                {
                    this._sUiModule = _loc_4[0];
                    if (UiModule(UiModuleManager.getInstance().getModules()[_loc_4[0]]).uis[_loc_4[1]])
                    {
                        this._sUiName = _loc_4[1];
                    }
                    else
                    {
                        throw new BeriliaError("Ui [" + _loc_4[1] + "] does not exit in module [" + _loc_4[0] + "] (grid parameter name [" + _loc_3 + "])");
                    }
                }
                else
                {
                    throw new BeriliaError("Module [" + _loc_4[0] + "] does not exit (grid parameter name [" + _loc_3 + "])");
                }
            }
            else
            {
                this._sUiName = _loc_3;
            }
            return;
        }// end function

        public function set grid(param1:Grid) : void
        {
            this._grid = param1;
            return;
        }// end function

        public function render(param1, param2:uint, param3:Boolean, param4:Boolean = true) : DisplayObject
        {
            var _loc_5:* = this._grid.getUi();
            this._uiCtr = new UiRootContainer(StageShareManager.stage, _loc_5.uiModule.uis[this._sUiName], this._ctr);
            this._uiCtr.uiModule = _loc_5.uiModule;
            this._uiCtr.addEventListener(UiRenderEvent.UIRenderComplete, this.onItemUiLoaded);
            this._uiCtr.mouseEnabled = true;
            if (!_loc_5.uiModule.uis[this._sUiName])
            {
                throw new BeriliaError("Ui [" + this._sUiName + "] does not exit in module [" + this._uiCtr.uiModule.id + "] (grid parameter name [" + this._sUiName + "])");
            }
            if (param4)
            {
                this.updateBackground(this._uiCtr, param2);
            }
            this._berilia.loadUiInside(_loc_5.uiModule.uis[this._sUiName], this._uiCtr.name, this._uiCtr, new GridScriptProperties(param1, param3, this._grid));
            return this._uiCtr;
        }// end function

        public function update(param1, param2:uint, param3:DisplayObject, param4:Boolean, param5:Boolean = true) : void
        {
            if (param3 is UiRootContainer)
            {
                if (UiRootContainer(param3).ready && Object(UiRootContainer(param3).uiClass))
                {
                    if (Object(UiRootContainer(param3).uiClass).data != null || param1 != null)
                    {
                        if (param5)
                        {
                            this.updateBackground(UiRootContainer(param3), param2);
                        }
                        Object(UiRootContainer(param3).uiClass).update(SecureCenter.secure(param1), param4);
                    }
                }
                else
                {
                    this._dWaitingUpdate[param3] = new WaitingUpdate(param1, param2, param3, param4, param5);
                }
            }
            else
            {
                this._log.warn("Can\'t update, " + param3.name + " is not a SecureUi");
            }
            return;
        }// end function

        public function remove(param1:DisplayObject) : void
        {
            if (param1 is UiRootContainer)
            {
                Berilia.getInstance().unloadUi(UiRootContainer(param1).name);
            }
            return;
        }// end function

        public function destroy() : void
        {
            this._berilia = null;
            this._uiCtr = null;
            this._grid = null;
            return;
        }// end function

        public function renderModificator(param1:Array) : Array
        {
            return param1;
        }// end function

        public function eventModificator(param1:Message, param2:String, param3:Array, param4:UIComponent) : String
        {
            return param2;
        }// end function

        private function onItemUiLoaded(event:UiRenderEvent) : void
        {
            var _loc_2:WaitingUpdate = null;
            if (this._dWaitingUpdate[event.uiTarget])
            {
                _loc_2 = this._dWaitingUpdate[event.uiTarget];
                this.update(_loc_2.data, _loc_2.index, _loc_2.dispObj, _loc_2.selected);
                this._dWaitingUpdate[event.uiTarget] = null;
            }
            return;
        }// end function

        private function updateBackground(param1:UiRootContainer, param2:uint) : void
        {
            var _loc_3:ColorTransform = null;
            var _loc_4:Shape = null;
            if (this._bgColor1 || this._bgColor2)
            {
                if (!this._shapeIndex[param1])
                {
                    _loc_4 = new Shape();
                    _loc_4.graphics.beginFill(16777215);
                    _loc_4.graphics.drawRect(0, 0, this._grid.slotWidth, this._grid.slotHeight);
                    this._uiCtr.getStrata(0).addChild(_loc_4);
                    this._shapeIndex[param1] = {trans:new Transform(_loc_4), shape:_loc_4};
                }
                _loc_3 = param2 % 2 ? (this._bgColor1) : (this._bgColor2);
                DisplayObject(this._shapeIndex[param1].shape).visible = _loc_3 != null;
                if (_loc_3)
                {
                    Transform(this._shapeIndex[param1].trans).colorTransform = _loc_3;
                }
            }
            return;
        }// end function

    }
}

class WaitingUpdate extends Object
{
    public var data:Object;
    public var index:Object;
    public var selected:Boolean;
    public var drawBackground:Boolean;
    public var dispObj:DisplayObject;

    function WaitingUpdate(param1, param2:uint, param3:DisplayObject, param4:Boolean, param5:Boolean)
    {
        this.data = param1;
        this.selected = param4;
        this.drawBackground = param5;
        this.dispObj = param3;
        this.index = param2;
        return;
    }// end function

}

