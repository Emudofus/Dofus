package com.ankamagames.berilia.components.gridRenderer
{
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.components.*;
    import com.ankamagames.berilia.interfaces.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.graphic.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.*;
    import flash.display.*;
    import flash.utils.*;

    public class EntityGridRenderer extends Object implements IGridRenderer
    {
        protected var _log:Logger;
        private var _grid:Grid;
        private var _emptyTexture:Uri;
        private var _mask:Sprite;

        public function EntityGridRenderer(param1:String)
        {
            this._log = Log.getLogger(getQualifiedClassName(EntityGridRenderer));
            var _loc_2:* = param1 ? (param1.split(",")) : ([]);
            this._emptyTexture = _loc_2[0] && _loc_2[0].length ? (new Uri(_loc_2[0])) : (null);
            this._mask = new Sprite();
            return;
        }// end function

        public function set grid(param1:Grid) : void
        {
            this._grid = param1;
            return;
        }// end function

        public function render(param1, param2:uint, param3:Boolean, param4:Boolean = true) : DisplayObject
        {
            var _loc_7:EntityDisplayer = null;
            var _loc_5:* = new GraphicContainer();
            new GraphicContainer().mouseEnabled = true;
            var _loc_6:* = new Texture();
            new Texture().width = this._grid.slotWidth;
            _loc_6.height = this._grid.slotHeight;
            _loc_6.uri = this._emptyTexture;
            _loc_6.finalize();
            _loc_5.addChild(_loc_6);
            _loc_5.width = this._grid.slotWidth;
            _loc_5.height = this._grid.slotHeight;
            if (param1)
            {
                _loc_7 = new EntityDisplayer();
                _loc_7.name = "entity";
                _loc_7.width = this._grid.slotWidth;
                _loc_7.height = this._grid.slotHeight;
                _loc_7.look = param1.entityLook;
                _loc_7.direction = 3;
                _loc_7.scale = 2;
                _loc_7.yOffset = 20;
                _loc_5.addChild(_loc_7);
                this._mask = new Sprite();
                this._mask.graphics.beginFill(16711680);
                this._mask.graphics.drawRoundRect(3, 3, _loc_5.width - 6, _loc_5.height - 6, 6, 6);
                this._mask.graphics.endFill();
                _loc_5.addChild(this._mask);
                _loc_7.mask = this._mask;
            }
            return _loc_5;
        }// end function

        public function update(param1, param2:uint, param3:DisplayObject, param4:Boolean, param5:Boolean = true) : void
        {
            var _loc_6:GraphicContainer = null;
            var _loc_7:EntityDisplayer = null;
            var _loc_8:EntityDisplayer = null;
            if (param3 is GraphicContainer)
            {
                _loc_6 = GraphicContainer(param3);
                _loc_6.mouseEnabled = true;
                _loc_7 = _loc_6.getChildByName("entity") as EntityDisplayer;
                if (param1)
                {
                    if (_loc_7)
                    {
                        if (_loc_7.look.toString() == param1.entityLook.toString())
                        {
                            return;
                        }
                        _loc_7.look = SecureCenter.unsecure(param1.entityLook);
                    }
                    else
                    {
                        _loc_8 = new EntityDisplayer();
                        _loc_8.name = "entity";
                        _loc_8.width = this._grid.slotWidth;
                        _loc_8.height = this._grid.slotHeight;
                        _loc_8.look = SecureCenter.unsecure(param1.entityLook);
                        _loc_8.direction = 3;
                        _loc_8.scale = 2;
                        _loc_8.yOffset = 20;
                        _loc_6.addChild(_loc_8);
                        this._mask = new Sprite();
                        this._mask.graphics.beginFill(255);
                        this._mask.graphics.drawRoundRect(3, 3, _loc_6.width - 6, _loc_6.height - 6, 6, 6);
                        this._mask.graphics.endFill();
                        _loc_6.addChild(this._mask);
                        _loc_8.mask = this._mask;
                    }
                }
                else if (_loc_7)
                {
                    _loc_6.removeChild(_loc_7);
                    if (this._mask && _loc_6.getChildByName(this._mask.name))
                    {
                        _loc_6.removeChild(this._mask);
                    }
                    _loc_7.remove();
                }
            }
            return;
        }// end function

        public function remove(param1:DisplayObject) : void
        {
            var _loc_2:EntityDisplayer = null;
            var _loc_3:DisplayObject = null;
            if (param1 is GraphicContainer)
            {
                _loc_2 = GraphicContainer(param1).getChildByName("entity") as EntityDisplayer;
                if (_loc_2)
                {
                    _loc_2.remove();
                }
                _loc_3 = GraphicContainer(param1).getChildByName(this._mask.name);
                if (_loc_3)
                {
                    GraphicContainer(param1).removeChild(_loc_3);
                }
                GraphicContainer(param1).remove();
            }
            return;
        }// end function

        public function destroy() : void
        {
            this._grid = null;
            this._emptyTexture = null;
            this._mask = null;
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

    }
}
