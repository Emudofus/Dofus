package com.ankamagames.dofus.types.sequences
{
    import __AS3__.vec.*;
    import com.ankamagames.atouin.enums.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.types.entities.*;
    import com.ankamagames.jerakine.enum.*;
    import com.ankamagames.jerakine.sequencer.*;
    import com.ankamagames.jerakine.types.positions.*;
    import com.ankamagames.jerakine.utils.display.*;
    import com.ankamagames.tiphon.events.*;
    import com.ankamagames.tiphon.types.look.*;
    import flash.geom.*;

    public class AddGfxInLineStep extends AbstractSequencable
    {
        private var _gfxId:uint;
        private var _startCell:MapPoint;
        private var _endCell:MapPoint;
        private var _addOnStartCell:Boolean;
        private var _addOnEndCell:Boolean;
        private var _yOffset:int;
        private var _mode:uint;
        private var _shot:Boolean = false;
        private var _scale:Number;
        private var _showUnder:Boolean;
        private var _useOnlyAddedCells:Boolean;
        private var _addedCells:Vector.<uint>;
        private var _cells:Array;

        public function AddGfxInLineStep(param1:uint, param2:MapPoint, param3:MapPoint, param4:int, param5:uint = 0, param6:Number = 0, param7:Boolean = false, param8:Boolean = false, param9:Vector.<uint> = null, param10:Boolean = false, param11:Boolean = false)
        {
            this._gfxId = param1;
            this._startCell = param2;
            this._endCell = param3;
            this._addOnStartCell = param7;
            this._addOnEndCell = param8;
            this._yOffset = param4;
            this._mode = param5;
            this._scale = param6;
            this._addedCells = param9;
            this._useOnlyAddedCells = param10;
            this._showUnder = param11;
            return;
        }// end function

        override public function start() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = false;
            var _loc_5:* = 0;
            if (!this._useOnlyAddedCells)
            {
                _loc_1 = Dofus1Line.getLine(this._startCell.x, this._startCell.y, 0, this._endCell.x, this._endCell.y, 0);
            }
            else
            {
                _loc_1 = [];
            }
            this._cells = new Array();
            if (this._addOnStartCell)
            {
                this._cells.push(this._startCell);
            }
            _loc_3 = 0;
            while (_loc_3 < _loc_1.length)
            {
                
                _loc_2 = _loc_1[_loc_3];
                if (this._addOnEndCell && _loc_3 == (_loc_1.length - 1) || _loc_3 >= 0 && _loc_3 < (_loc_1.length - 1))
                {
                    this._cells.push(MapPoint.fromCoords(_loc_2.x, _loc_2.y));
                }
                _loc_3 = _loc_3 + 1;
            }
            if (this._addedCells)
            {
                _loc_3 = 0;
                while (_loc_3 < this._addedCells.length)
                {
                    
                    _loc_4 = true;
                    _loc_5 = 0;
                    while (_loc_5 < this._cells.length)
                    {
                        
                        if (this._addedCells[_loc_3] == MapPoint(this._cells[_loc_5]).cellId)
                        {
                            _loc_4 = false;
                            break;
                        }
                        _loc_5 = _loc_5 + 1;
                    }
                    if (_loc_4)
                    {
                        this._cells.push(MapPoint.fromCellId(this._addedCells[_loc_3]));
                    }
                    _loc_3 = _loc_3 + 1;
                }
            }
            this.addNextGfx();
            return;
        }// end function

        private function addNextGfx() : void
        {
            if (!this._cells.length)
            {
                executeCallbacks();
                return;
            }
            var _loc_1:* = -10000;
            while (DofusEntities.getEntity(_loc_1))
            {
                
                _loc_1 = -10000 + Math.random() * 10000;
            }
            var _loc_2:* = new Projectile(_loc_1, TiphonEntityLook.fromString("{" + this._gfxId + "}"));
            _loc_2.addEventListener(TiphonEvent.ANIMATION_SHOT, this.shot);
            _loc_2.addEventListener(TiphonEvent.ANIMATION_END, this.remove);
            _loc_2.addEventListener(TiphonEvent.RENDER_FAILED, this.remove);
            _loc_2.position = this._cells.shift();
            if (!_loc_2.libraryIsAvaible)
            {
                _loc_2.addEventListener(TiphonEvent.SPRITE_INIT, this.startDisplay);
                _loc_2.addEventListener(TiphonEvent.SPRITE_INIT_FAILED, this.remove);
                _loc_2.init();
            }
            else
            {
                _loc_2.init();
                this.startDisplay(new TiphonEvent(TiphonEvent.SPRITE_INIT, _loc_2));
            }
            return;
        }// end function

        private function startDisplay(event:TiphonEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            _loc_2 = Projectile(event.sprite);
            switch(this._mode)
            {
                case AddGfxModeEnum.NORMAL:
                {
                    break;
                }
                case AddGfxModeEnum.RANDOM:
                {
                    _loc_3 = _loc_2.getAvaibleDirection("FX");
                    _loc_4 = new Array();
                    _loc_5 = 0;
                    while (_loc_5 < 8)
                    {
                        
                        if (_loc_3[_loc_5])
                        {
                            _loc_4.push(_loc_5);
                        }
                        _loc_5 = _loc_5 + 1;
                    }
                    _loc_2.setDirection(_loc_4[Math.floor(Math.random() * _loc_4.length)]);
                    break;
                }
                case AddGfxModeEnum.ORIENTED:
                {
                    _loc_2.setDirection(this._startCell.advancedOrientationTo(this._endCell, true));
                    break;
                }
                default:
                {
                    break;
                }
            }
            _loc_2.display(this._showUnder ? (PlacementStrataEnums.STRATA_SPELL_BACKGROUND) : (PlacementStrataEnums.STRATA_SPELL_FOREGROUND));
            _loc_2.y = _loc_2.y + this._yOffset;
            var _loc_6:* = this._scale;
            _loc_2.scaleY = this._scale;
            _loc_2.scaleX = _loc_6;
            return;
        }// end function

        private function remove(event:TiphonEvent) : void
        {
            event.sprite.removeEventListener(TiphonEvent.ANIMATION_END, this.remove);
            event.sprite.removeEventListener(TiphonEvent.ANIMATION_SHOT, this.shot);
            event.sprite.removeEventListener(TiphonEvent.RENDER_FAILED, this.remove);
            event.sprite.removeEventListener(TiphonEvent.SPRITE_INIT, this.startDisplay);
            event.sprite.removeEventListener(TiphonEvent.SPRITE_INIT_FAILED, this.remove);
            Projectile(event.sprite).remove();
            if (!this._shot)
            {
                this.shot(null);
            }
            return;
        }// end function

        private function shot(event:TiphonEvent) : void
        {
            if (event)
            {
                event.sprite.removeEventListener(TiphonEvent.ANIMATION_SHOT, this.shot);
            }
            this._shot = true;
            this.addNextGfx();
            return;
        }// end function

    }
}
