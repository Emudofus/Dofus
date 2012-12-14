package com.ankamagames.atouin.managers
{
    import com.ankamagames.atouin.*;
    import com.ankamagames.atouin.data.map.*;
    import com.ankamagames.atouin.messages.*;
    import com.ankamagames.atouin.renderers.*;
    import com.ankamagames.atouin.types.*;
    import com.ankamagames.atouin.utils.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.events.*;
    import com.ankamagames.jerakine.types.positions.*;
    import com.ankamagames.jerakine.types.zones.*;
    import com.ankamagames.jerakine.utils.display.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class InteractiveCellManager extends Object
    {
        private var _cellOverEnabled:Boolean = false;
        private var _aCells:Array;
        private var _aCellPool:Array;
        private var _bShowGrid:Boolean;
        private var _interaction_click:Boolean;
        private var _interaction_out:Boolean;
        private var _trapZoneRenderer:TrapZoneRenderer;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(InteractiveCellManager));
        private static var _self:InteractiveCellManager;

        public function InteractiveCellManager()
        {
            this._aCellPool = new Array();
            this._bShowGrid = Atouin.getInstance().options.alwaysShowGrid;
            if (_self)
            {
                throw new SingletonError();
            }
            this.init();
            return;
        }// end function

        public function get cellOverEnabled() : Boolean
        {
            return this._cellOverEnabled;
        }// end function

        public function set cellOverEnabled(param1:Boolean) : void
        {
            this.overStateChanged(this._cellOverEnabled, param1);
            this._cellOverEnabled = param1;
            return;
        }// end function

        public function get cellOutEnabled() : Boolean
        {
            return this._interaction_out;
        }// end function

        public function get cellClickEnabled() : Boolean
        {
            return this._interaction_click;
        }// end function

        public function initManager() : void
        {
            this._aCells = new Array();
            Atouin.getInstance().options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED, this.onPropertyChanged);
            return;
        }// end function

        public function setInteraction(param1:Boolean = true, param2:Boolean = false, param3:Boolean = false) : void
        {
            var _loc_4:* = null;
            this._interaction_click = param1;
            this._cellOverEnabled = param2;
            this._interaction_out = param3;
            for each (_loc_4 in this._aCells)
            {
                
                if (param1)
                {
                    _loc_4.addEventListener(MouseEvent.CLICK, this.mouseClick);
                }
                else
                {
                    _loc_4.removeEventListener(MouseEvent.CLICK, this.mouseClick);
                }
                if (param2)
                {
                    _loc_4.addEventListener(MouseEvent.MOUSE_OVER, this.mouseOver);
                }
                else
                {
                    _loc_4.removeEventListener(MouseEvent.MOUSE_OVER, this.mouseOver);
                }
                if (param3)
                {
                    _loc_4.addEventListener(MouseEvent.MOUSE_OUT, this.mouseOut);
                }
                else
                {
                    _loc_4.removeEventListener(MouseEvent.MOUSE_OUT, this.mouseOut);
                }
                _loc_4.mouseEnabled = param1 || param2 || param3;
            }
            return;
        }// end function

        public function getCell(param1:uint) : GraphicCell
        {
            this._aCells[param1] = this._aCellPool[param1];
            return this._aCells[param1];
        }// end function

        public function updateInteractiveCell(param1:DataMapContainer) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (!param1)
            {
                _log.error("Can\'t update interactive cell of a NULL container");
                return;
            }
            this.setInteraction(true, Atouin.getInstance().options.showCellIdOnOver, Atouin.getInstance().options.showCellIdOnOver);
            var _loc_2:* = param1.getCell();
            var _loc_6:* = Atouin.getInstance().options.showTransitions;
            var _loc_7:* = this._bShowGrid || Atouin.getInstance().options.alwaysShowGrid ? (1) : (0);
            var _loc_8:* = param1.getLayer(Layer.LAYER_DECOR);
            var _loc_9:* = 0;
            var _loc_10:* = this._aCells.length;
            var _loc_11:* = 0;
            var _loc_12:* = this._aCells[0];
            if (!this._aCells[0])
            {
                while (!_loc_12 && _loc_9 < _loc_10)
                {
                    
                    _loc_12 = this._aCells[_loc_9++];
                }
                _loc_9 = _loc_9 - 1;
            }
            while (_loc_11 < _loc_8.numChildren && ++_loc_9 < _loc_10)
            {
                
                if (_loc_12 != null && _loc_12.cellId <= CellContainer(_loc_8.getChildAt(_loc_11)).cellId)
                {
                    _loc_3 = _loc_2[_loc_9];
                    _loc_4 = this._aCells[_loc_9];
                    _loc_4.y = _loc_3.elevation;
                    _loc_4.visible = _loc_3.mov && !_loc_3.isDisabled;
                    _loc_4.alpha = _loc_7;
                    _loc_8.addChildAt(_loc_4, _loc_11);
                    _loc_12 = this._aCells[++_loc_9];
                }
                _loc_11 = _loc_11 + 1;
            }
            return;
        }// end function

        public function updateCell(param1:uint, param2:Boolean) : Boolean
        {
            DataMapProvider.getInstance().updateCellMovLov(param1, param2);
            if (this._aCells[param1] != null)
            {
                this._aCells[param1].visible = param2;
            }
            else
            {
                return false;
            }
            return true;
        }// end function

        public function show(param1:Boolean) : void
        {
            var _loc_3:* = null;
            this._bShowGrid = param1;
            var _loc_2:* = this._bShowGrid || Atouin.getInstance().options.alwaysShowGrid ? (1) : (0);
            var _loc_4:* = 0;
            while (_loc_4 < this._aCells.length)
            {
                
                _loc_3 = GraphicCell(this._aCells[_loc_4]);
                if (_loc_3)
                {
                    _loc_3.alpha = _loc_2;
                }
                _loc_4 = _loc_4 + 1;
            }
            return;
        }// end function

        public function clean() : void
        {
            var _loc_1:* = 0;
            if (this._aCells)
            {
                _loc_1 = 0;
                while (_loc_1 < this._aCells.length)
                {
                    
                    if (!this._aCells[_loc_1] || !this._aCells[_loc_1].parent)
                    {
                    }
                    else
                    {
                        this._aCells[_loc_1].parent.removeChild(this._aCells[_loc_1]);
                    }
                    _loc_1 = _loc_1 + 1;
                }
            }
            return;
        }// end function

        private function init() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = 0;
            while (_loc_1 < AtouinConstants.MAP_CELLS_COUNT)
            {
                
                _loc_2 = new GraphicCell(_loc_1);
                _loc_2.mouseEnabled = false;
                _loc_2.mouseChildren = false;
                this._aCellPool[_loc_1] = _loc_2;
                _loc_1 = _loc_1 + 1;
            }
            return;
        }// end function

        private function overStateChanged(param1:Boolean, param2:Boolean) : void
        {
            if (param1 == param2)
            {
                return;
            }
            if (!param1 && param2)
            {
                this.registerOver(true);
            }
            else if (param1 && !param2)
            {
                this.registerOver(false);
            }
            return;
        }// end function

        private function registerOver(param1:Boolean) : void
        {
            var _loc_2:* = 0;
            while (_loc_2 < AtouinConstants.MAP_CELLS_COUNT)
            {
                
                if (!this._aCells[_loc_2])
                {
                }
                else if (param1)
                {
                    this._aCells[_loc_2].addEventListener(MouseEvent.ROLL_OVER, this.mouseOver);
                    this._aCells[_loc_2].addEventListener(MouseEvent.ROLL_OUT, this.mouseOut);
                }
                else
                {
                    this._aCells[_loc_2].removeEventListener(MouseEvent.ROLL_OVER, this.mouseOver);
                    this._aCells[_loc_2].removeEventListener(MouseEvent.ROLL_OUT, this.mouseOut);
                }
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        private function mouseClick(event:MouseEvent) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_2:* = Sprite(event.target);
            if (!_loc_2.parent)
            {
                return;
            }
            var _loc_3:* = _loc_2.parent.getChildIndex(_loc_2);
            var _loc_4:* = CellIdConverter.cellIdToCoord(parseInt(_loc_2.name));
            if (!DataMapProvider.getInstance().pointCanStop(_loc_4.x, _loc_4.y))
            {
                _log.info("Cannot move to this cell in RP");
                return;
            }
            if (Atouin.getInstance().options.virtualPlayerJump)
            {
                _loc_5 = EntitiesManager.getInstance().entities;
                for each (_loc_6 in _loc_5)
                {
                    
                    if (_loc_6 is IMovable)
                    {
                        IMovable(_loc_6).jump(MapPoint.fromCellId(parseInt(_loc_2.name)));
                        break;
                    }
                }
            }
            else
            {
                _loc_7 = new CellClickMessage();
                _loc_7.cellContainer = _loc_2;
                _loc_7.cellDepth = _loc_3;
                _loc_7.cell = MapPoint.fromCoords(_loc_4.x, _loc_4.y);
                _loc_7.cellId = parseInt(_loc_2.name);
                Atouin.getInstance().handler.process(_loc_7);
            }
            return;
        }// end function

        private function mouseOver(event:MouseEvent) : void
        {
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_2:* = Sprite(event.target);
            if (!_loc_2.parent)
            {
                return;
            }
            var _loc_3:* = _loc_2.parent.getChildIndex(_loc_2);
            var _loc_4:* = CellIdConverter.cellIdToCoord(parseInt(_loc_2.name));
            if (Atouin.getInstance().options.showCellIdOnOver)
            {
                _loc_6 = 0;
                _loc_7 = _loc_2.name + " (" + _loc_4.x + "/" + _loc_4.y + ")";
                _loc_8 = MapPoint.fromCoords(_loc_4.x, _loc_4.y);
                _loc_7 = _loc_7 + ("\nLigne de vue : " + !DataMapProvider.getInstance().pointLos(_loc_8.x, _loc_8.y));
                _loc_7 = _loc_7 + ("\nBlocage éditeur : " + !DataMapProvider.getInstance().pointMov(_loc_8.x, _loc_8.y));
                _loc_7 = _loc_7 + ("\nBlocage entitée : " + !DataMapProvider.getInstance().pointMov(_loc_8.x, _loc_8.y, false));
                _loc_9 = CellData(MapDisplayManager.getInstance().getDataMapContainer().dataMap.cells[parseInt(_loc_2.name)]);
                _loc_7 = _loc_7 + ("\nID de zone : " + _loc_9.moveZone);
                _loc_7 = _loc_7 + ("\nHauteur : " + _loc_9.floor + " px");
                _loc_7 = _loc_7 + ("\nSpeed : " + _loc_9.speed);
                DebugToolTip.getInstance().text = _loc_7;
                _loc_10 = SelectionManager.getInstance().getSelection("infoOverCell");
                if (!_loc_10)
                {
                    _loc_10 = new Selection();
                    _loc_10.color = new Color(_loc_6);
                    _loc_10.renderer = new ZoneDARenderer();
                    _loc_10.zone = new Lozenge(0, 0, DataMapProvider.getInstance());
                    SelectionManager.getInstance().addSelection(_loc_10, "infoOverCell", parseInt(_loc_2.name));
                }
                else
                {
                    SelectionManager.getInstance().update("infoOverCell", parseInt(_loc_2.name));
                }
                StageShareManager.stage.addChild(DebugToolTip.getInstance());
            }
            var _loc_5:* = new CellOverMessage();
            new CellOverMessage().cellContainer = _loc_2;
            _loc_5.cellDepth = _loc_3;
            _loc_5.cell = MapPoint.fromCoords(_loc_4.x, _loc_4.y);
            _loc_5.cellId = parseInt(_loc_2.name);
            Atouin.getInstance().handler.process(_loc_5);
            return;
        }// end function

        private function mouseOut(event:MouseEvent) : void
        {
            var _loc_2:* = Sprite(event.target);
            if (!_loc_2.parent)
            {
                return;
            }
            var _loc_3:* = _loc_2.parent.getChildIndex(_loc_2);
            var _loc_4:* = CellIdConverter.cellIdToCoord(parseInt(_loc_2.name));
            if (Atouin.getInstance().worldContainer.contains(DebugToolTip.getInstance()))
            {
                Atouin.getInstance().worldContainer.removeChild(DebugToolTip.getInstance());
            }
            var _loc_5:* = new CellOutMessage();
            new CellOutMessage().cellContainer = _loc_2;
            _loc_5.cellDepth = _loc_3;
            _loc_5.cell = MapPoint.fromCoords(_loc_4.x, _loc_4.y);
            _loc_5.cellId = parseInt(_loc_2.name);
            Atouin.getInstance().handler.process(_loc_5);
            return;
        }// end function

        private function onPropertyChanged(event:PropertyChangeEvent) : void
        {
            if (event.propertyName == "alwaysShowGrid")
            {
                this.show(event.propertyValue);
            }
            return;
        }// end function

        public static function getInstance() : InteractiveCellManager
        {
            if (!_self)
            {
                _self = new InteractiveCellManager;
            }
            return _self;
        }// end function

    }
}
