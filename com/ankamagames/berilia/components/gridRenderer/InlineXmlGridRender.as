package com.ankamagames.berilia.components.gridRenderer
{
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.components.*;
    import com.ankamagames.berilia.interfaces.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.graphic.*;
    import com.ankamagames.berilia.types.uiDefinition.*;
    import com.ankamagames.berilia.utils.errors.*;
    import com.ankamagames.jerakine.messages.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.utils.*;

    public class InlineXmlGridRender extends Object implements IGridRenderer
    {
        private var _grid:Grid;
        private var _nameReferences:Array;
        private var _componentReferences:Dictionary;
        private var _componentReferencesByInstance:Dictionary;
        private var _bgColor1:ColorTransform;
        private var _bgColor2:ColorTransform;
        private var _color1:Number = -1;
        private var _color2:Number = -1;
        private var _bgElements:Array;
        private var _updateFunctionName:String;
        private static var _slotCount:uint = 0;

        public function InlineXmlGridRender(param1:String)
        {
            var _loc_2:* = param1.split(",");
            this._updateFunctionName = _loc_2[0];
            if (_loc_2[1])
            {
                this._bgColor1 = new ColorTransform();
                this._color1 = parseInt(_loc_2[1], 16);
                this._bgColor1.color = this._color1;
            }
            if (_loc_2[2])
            {
                this._bgColor2 = new ColorTransform();
                this._color2 = parseInt(_loc_2[2], 16);
                this._bgColor2.color = this._color2;
            }
            this._bgElements = new Array();
            this._nameReferences = new Array();
            this._componentReferences = new Dictionary();
            this._componentReferencesByInstance = new Dictionary(true);
            return;
        }// end function

        public function set grid(param1:Grid) : void
        {
            this._grid = param1;
            param1.mouseEnabled = true;
            return;
        }// end function

        public function render(param1, param2:uint, param3:Boolean, param4:Boolean = true) : DisplayObject
        {
            var _loc_8:String = null;
            var _loc_5:* = this._grid.getUi();
            var _loc_6:* = this._nameReferences.shift() as String;
            var _loc_7:* = new Object();
            for (_loc_8 in this._componentReferences[_loc_6])
            {
                
                _loc_7[_loc_8] = _loc_5.getElement(this._componentReferences[_loc_6][_loc_8]);
            }
            this._componentReferences[_loc_6] = SecureCenter.secure(_loc_7);
            this._componentReferencesByInstance[_loc_5.getElement(_loc_6)] = this._componentReferences[_loc_6];
            if (_loc_5.uiClass.hasOwnProperty(this._updateFunctionName))
            {
                var _loc_9:* = Object(_loc_5.uiClass);
                _loc_9.Object(_loc_5.uiClass)[this._updateFunctionName](param1, this._componentReferences[_loc_6], param3);
            }
            return _loc_5.getElement(_loc_6);
        }// end function

        public function update(param1, param2:uint, param3:DisplayObject, param4:Boolean, param5:Boolean = true) : void
        {
            var _loc_6:* = this._grid.getUi();
            param3.visible = true;
            if (param2 % 2 == 0 && param3 is GraphicContainer)
            {
                GraphicContainer(param3).bgColor = this._color1;
            }
            if (param2 % 2 == 1 && param3 is GraphicContainer)
            {
                GraphicContainer(param3).bgColor = this._color2;
            }
            if (_loc_6.uiClass.hasOwnProperty(this._updateFunctionName))
            {
                var _loc_7:* = Object(_loc_6.uiClass);
                _loc_7.Object(_loc_6.uiClass)[this._updateFunctionName](SecureCenter.secure(param1), this._componentReferencesByInstance[param3], param4);
            }
            return;
        }// end function

        public function remove(param1:DisplayObject) : void
        {
            param1.visible = false;
            return;
        }// end function

        public function destroy() : void
        {
            var _loc_1:Object = null;
            var _loc_2:Object = null;
            var _loc_3:Object = null;
            for each (_loc_1 in this._componentReferences)
            {
                
                _loc_2 = SecureCenter.unsecure(_loc_1);
                for each (_loc_3 in _loc_2)
                {
                    
                    if (_loc_3 is GraphicContainer)
                    {
                        _loc_3.remove();
                    }
                }
            }
            this._nameReferences = null;
            this._componentReferences = null;
            this._componentReferencesByInstance = null;
            this._grid = null;
            return;
        }// end function

        public function renderModificator(param1:Array) : Array
        {
            var _loc_4:Object = null;
            var _loc_5:BasicElement = null;
            if (param1.length != 1)
            {
                throw new BeriliaError("Grid declaration cannot handle more than one container and support Container tag only.");
            }
            var _loc_2:* = new Array();
            var _loc_3:uint = 0;
            while (_loc_3 < this._grid.slotByCol * this._grid.slotByRow)
            {
                
                _loc_4 = new Object();
                _loc_5 = this.copyElement(param1[0], _loc_4);
                if (_loc_3 % 2 == 0 && this._bgColor1)
                {
                    _loc_5.properties["bgColor"] = this._color1;
                    this._bgElements[_loc_3] = _loc_5.name;
                }
                if (_loc_3 % 2 == 1 && this._bgColor2)
                {
                    _loc_5.properties["bgColor"] = this._color2;
                    this._bgElements[_loc_3] = _loc_5.name;
                }
                _loc_2.push(_loc_5);
                this._nameReferences.push(_loc_5.name);
                this._componentReferences[_loc_5.name] = _loc_4;
                var _loc_7:* = _slotCount + 1;
                _slotCount = _loc_7;
                _loc_3 = _loc_3 + 1;
            }
            return _loc_2;
        }// end function

        public function eventModificator(param1:Message, param2:String, param3:Array, param4:UIComponent) : String
        {
            return param2;
        }// end function

        private function copyElement(param1:BasicElement, param2:Object) : BasicElement
        {
            var _loc_4:Array = null;
            var _loc_5:BasicElement = null;
            var _loc_6:StateContainerElement = null;
            var _loc_7:StateContainerElement = null;
            var _loc_8:Array = null;
            var _loc_9:uint = 0;
            var _loc_10:String = null;
            var _loc_11:String = null;
            var _loc_3:* = new (getDefinitionByName(getQualifiedClassName(param1)) as Class)();
            param1.copy(_loc_3);
            if (_loc_3.name)
            {
                _loc_3.setName(_loc_3.name + "_" + _slotCount);
                param2[param1.name] = _loc_3.name;
            }
            else
            {
                _loc_3.setName("elem_" + Math.floor(Math.random() * 100000000));
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
                        _loc_8[_loc_9][_loc_11 + "_" + _slotCount] = _loc_7.stateChangingProperties[_loc_9][_loc_11];
                    }
                }
                _loc_6.stateChangingProperties = _loc_8;
            }
            if (_loc_3 is ButtonElement)
            {
                if (_loc_3.properties["linkedTo"])
                {
                    _loc_3.properties["linkedTo"] = _loc_3.properties["linkedTo"] + "_" + _slotCount;
                }
            }
            return _loc_3;
        }// end function

    }
}
