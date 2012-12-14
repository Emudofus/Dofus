package com.ankamagames.berilia.components.gridRenderer
{
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.components.*;
    import com.ankamagames.berilia.interfaces.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.graphic.*;
    import com.ankamagames.berilia.types.uiDefinition.*;
    import com.ankamagames.berilia.uiRender.*;
    import com.ankamagames.berilia.utils.errors.*;
    import com.ankamagames.jerakine.messages.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.utils.*;

    public class MultiGridRenderer extends Object implements IGridRenderer
    {
        private var _grid:Grid;
        private var _cptNameReferences:Dictionary;
        private var _componentReferences:Dictionary;
        private var _componentReferencesByInstance:Dictionary;
        private var _elemID:uint;
        private var _containerCache:Dictionary;
        private var _uiRenderer:UiRenderer;
        private var _containerDefinition:Dictionary;
        private var _bgColor1:ColorTransform;
        private var _bgColor2:ColorTransform;
        private var _color1:Number = -1;
        private var _color2:Number = -1;
        private var _updateFunctionName:String;
        private var _getLineTypeFunctionName:String;
        private var _getDataLengthFunctionName:String;

        public function MultiGridRenderer(param1:String)
        {
            var _loc_2:* = param1.split(",");
            this._updateFunctionName = _loc_2[0];
            this._getLineTypeFunctionName = _loc_2[1];
            this._getDataLengthFunctionName = _loc_2[2];
            if (_loc_2[3])
            {
                this._bgColor1 = new ColorTransform();
                this._color1 = parseInt(_loc_2[3], 16);
                this._bgColor1.color = this._color1;
            }
            if (_loc_2[4])
            {
                this._bgColor2 = new ColorTransform();
                this._color2 = parseInt(_loc_2[4], 16);
                this._bgColor2.color = this._color2;
            }
            this._cptNameReferences = new Dictionary();
            this._componentReferences = new Dictionary();
            this._containerDefinition = new Dictionary();
            this._componentReferencesByInstance = new Dictionary(true);
            this._uiRenderer = new UiRenderer();
            this._containerCache = new Dictionary();
            return;
        }// end function

        public function set grid(param1:Grid) : void
        {
            if (!this._grid)
            {
                this._grid = param1;
            }
            var _loc_2:* = this._grid.getUi();
            this._uiRenderer.postInit(_loc_2);
            return;
        }// end function

        public function render(param1, param2:uint, param3:Boolean, param4:uint = 0) : DisplayObject
        {
            var _loc_5:* = new Sprite();
            this.update(param1, param2, _loc_5, param3, param4);
            return _loc_5;
        }// end function

        public function update(param1, param2:uint, param3:DisplayObject, param4:Boolean, param5:uint = 0) : void
        {
            var _loc_8:* = null;
            var _loc_6:* = this._grid.getUi();
            if (!this._grid.getUi().uiClass.hasOwnProperty(this._getLineTypeFunctionName) || !_loc_6.uiClass.hasOwnProperty(this._updateFunctionName))
            {
                throw new BeriliaError("GetLineType function or update function is not define.");
            }
            var _loc_9:* = _loc_6.uiClass;
            var _loc_7:* = _loc_9._loc_6.uiClass[this._getLineTypeFunctionName](SecureCenter.secure(param1), param5);
            if (param3.name != _loc_7)
            {
                this.buildLine(param3 as Sprite, _loc_7);
            }
            if (param3 is Sprite)
            {
                _loc_8 = param3 as Sprite;
                if (param2 % 2 == 0 && this._color1)
                {
                    _loc_8.graphics.clear();
                    _loc_8.graphics.beginFill(this._color1);
                    _loc_8.graphics.drawRect(0, 0, this._grid.slotWidth, this._grid.slotHeight);
                    _loc_8.graphics.endFill();
                }
                if (param2 % 2 == 1 && this._color2)
                {
                    _loc_8.graphics.clear();
                    _loc_8.graphics.beginFill(this._color2);
                    _loc_8.graphics.drawRect(0, 0, this._grid.slotWidth, this._grid.slotHeight);
                    _loc_8.graphics.endFill();
                }
            }
            if (DisplayObjectContainer(param3).numChildren)
            {
                var _loc_9:* = _loc_6.uiClass;
                _loc_9._loc_6.uiClass[this._updateFunctionName](SecureCenter.secure(param1), this._cptNameReferences[DisplayObjectContainer(param3).getChildAt(0)], param4, param5);
            }
            return;
        }// end function

        public function remove(param1:DisplayObject) : void
        {
            return;
        }// end function

        public function destroy() : void
        {
            return;
        }// end function

        public function getDataLength(param1, param2:Boolean) : uint
        {
            var _loc_3:* = this._grid.getUi();
            if (_loc_3.uiClass.hasOwnProperty(this._getDataLengthFunctionName))
            {
                var _loc_4:* = _loc_3.uiClass;
                return _loc_4._loc_3.uiClass[this._getDataLengthFunctionName](param1, param2);
            }
            return 1;
        }// end function

        public function renderModificator(param1:Array) : Array
        {
            var _loc_2:* = null;
            for each (_loc_2 in param1)
            {
                
                this._containerDefinition[_loc_2.name] = _loc_2;
            }
            return [];
        }// end function

        public function eventModificator(param1:Message, param2:String, param3:Array, param4:UIComponent) : String
        {
            return param2;
        }// end function

        private function buildLine(param1:Sprite, param2:String) : void
        {
            var _loc_7:* = null;
            if (param1.name == param2)
            {
                return;
            }
            if (!this._containerCache[param2])
            {
                this._containerCache[param2] = [];
            }
            if (this._containerDefinition[param1.name])
            {
                if (!this._containerCache[param1.name])
                {
                    this._containerCache[param1.name] = [];
                }
                if (param1.numChildren)
                {
                    this._containerCache[param1.name].push(param1.getChildAt(0));
                    param1.removeChildAt(0);
                }
            }
            param1.name = param2 ? (param2) : ("#########EMPTY");
            if (!param2)
            {
                return;
            }
            if (this._containerCache[param2].length)
            {
                param1.addChild(this._containerCache[param2].pop());
                return;
            }
            var _loc_3:* = new GraphicContainer();
            param1.addChild(_loc_3);
            var _loc_4:* = [];
            this._uiRenderer.makeChilds([this.copyElement(this._containerDefinition[param2], _loc_4)], _loc_3);
            this._grid.getUi().render();
            var _loc_5:* = {};
            var _loc_6:* = this._grid.getUi();
            for (_loc_7 in _loc_4)
            {
                
                _loc_5[_loc_7] = _loc_6.getElement(_loc_4[_loc_7]);
            }
            this._cptNameReferences[_loc_3] = _loc_5;
            var _loc_8:* = this;
            var _loc_9:* = this._elemID + 1;
            _loc_8._elemID = _loc_9;
            return;
        }// end function

        private function copyElement(param1:BasicElement, param2:Object) : BasicElement
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_3:* = new (getDefinitionByName(getQualifiedClassName(param1)) as Class)();
            param1.copy(_loc_3);
            if (_loc_3.name)
            {
                _loc_3.setName(_loc_3.name + "_m_" + this._elemID);
                param2[param1.name] = _loc_3.name;
            }
            else
            {
                _loc_3.setName("elem_m_" + Math.random() * 10000000000);
            }
            if (_loc_3 is ContainerElement)
            {
                _loc_4 = new Array();
                for each (_loc_5 in ContainerElement(param1).childs)
                {
                    
                    _loc_4.push(this.copyElement(_loc_5, param2));
                }
                ContainerElement(_loc_3).childs = _loc_4;
            }
            if (_loc_3 is StateContainerElement)
            {
                _loc_6 = _loc_3 as StateContainerElement;
                _loc_7 = param1 as StateContainerElement;
                _loc_8 = new Array();
                for (_loc_10 in _loc_7.stateChangingProperties)
                {
                    
                    _loc_9 = parseInt(_loc_10);
                    for (_loc_11 in _loc_7.stateChangingProperties[_loc_9])
                    {
                        
                        if (!_loc_8[_loc_9])
                        {
                            _loc_8[_loc_9] = [];
                        }
                        _loc_8[_loc_9][_loc_11 + "_m_" + this._elemID] = _loc_7.stateChangingProperties[_loc_9][_loc_11];
                    }
                }
                _loc_6.stateChangingProperties = _loc_8;
            }
            if (_loc_3 is ButtonElement)
            {
                if (_loc_3.properties["linkedTo"])
                {
                    _loc_3.properties["linkedTo"] = _loc_3.properties["linkedTo"] + "_" + this._elemID;
                }
            }
            return _loc_3;
        }// end function

    }
}
