package com.ankamagames.dofus.types.sequences
{
    import com.ankamagames.atouin.enums.*;
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.dofus.types.entities.*;
    import com.ankamagames.jerakine.enum.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.sequencer.*;
    import com.ankamagames.jerakine.types.positions.*;
    import com.ankamagames.tiphon.events.*;
    import com.ankamagames.tiphon.types.look.*;
    import flash.events.*;
    import flash.utils.*;

    public class AddGfxEntityStep extends AbstractSequencable
    {
        private var _gfxId:uint;
        private var _cellId:uint;
        private var _entity:Projectile;
        private var _shot:Boolean = false;
        private var _angle:Number;
        private var _yOffset:int;
        private var _mode:uint;
        private var _startCell:MapPoint;
        private var _endCell:MapPoint;
        private var _popUnderPlayer:Boolean;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(AddGfxEntityStep));

        public function AddGfxEntityStep(param1:uint, param2:uint, param3:Number = 0, param4:int = 0, param5:uint = 0, param6:MapPoint = null, param7:MapPoint = null, param8:Boolean = false)
        {
            this._mode = param5;
            this._gfxId = param1;
            this._cellId = param2;
            this._angle = param3;
            this._yOffset = param4;
            this._startCell = param6;
            this._endCell = param7;
            this._popUnderPlayer = param8;
            return;
        }// end function

        override public function start() : void
        {
            var _loc_2:Array = null;
            var _loc_3:Array = null;
            var _loc_4:uint = 0;
            var _loc_1:* = EntitiesManager.getInstance().getFreeEntityId();
            this._entity = new Projectile(_loc_1, TiphonEntityLook.fromString("{" + this._gfxId + "}"), true);
            this._entity.addEventListener(TiphonEvent.ANIMATION_SHOT, this.shot);
            this._entity.addEventListener(TiphonEvent.ANIMATION_END, this.remove);
            this._entity.addEventListener(TiphonEvent.RENDER_FAILED, this.remove);
            this._entity.addEventListener(TiphonEvent.SPRITE_INIT_FAILED, this.remove);
            this._entity.rotation = this._angle;
            this._entity.mouseEnabled = false;
            this._entity.mouseChildren = false;
            switch(this._mode)
            {
                case AddGfxModeEnum.NORMAL:
                {
                    this._entity.init();
                    break;
                }
                case AddGfxModeEnum.RANDOM:
                {
                    _loc_2 = this._entity.getAvaibleDirection();
                    _loc_3 = new Array();
                    _loc_4 = 0;
                    while (_loc_4 < 8)
                    {
                        
                        if (_loc_2[_loc_4])
                        {
                            _loc_3.push(_loc_4);
                        }
                        _loc_4 = _loc_4 + 1;
                    }
                    this._entity.init(_loc_3[Math.floor(Math.random() * _loc_3.length)]);
                    break;
                }
                case AddGfxModeEnum.ORIENTED:
                {
                    this._entity.init(this._startCell.advancedOrientationTo(this._endCell, true));
                    break;
                }
                default:
                {
                    break;
                }
            }
            this._entity.position = MapPoint.fromCellId(this._cellId);
            if (this._popUnderPlayer)
            {
                this._entity.display(PlacementStrataEnums.STRATA_SPELL_BACKGROUND);
            }
            else
            {
                this._entity.display(PlacementStrataEnums.STRATA_SPELL_FOREGROUND);
            }
            this._entity.y = this._entity.y + this._yOffset;
            return;
        }// end function

        private function remove(event:Event) : void
        {
            this._entity.removeEventListener(TiphonEvent.ANIMATION_END, this.remove);
            this._entity.removeEventListener(TiphonEvent.ANIMATION_SHOT, this.shot);
            this._entity.removeEventListener(TiphonEvent.RENDER_FAILED, this.remove);
            this._entity.removeEventListener(TiphonEvent.SPRITE_INIT_FAILED, this.remove);
            this._entity.destroy();
            if (!this._shot)
            {
                this.shot(null);
            }
            return;
        }// end function

        private function shot(event:Event) : void
        {
            this._shot = true;
            this._entity.removeEventListener(TiphonEvent.ANIMATION_SHOT, this.shot);
            this.executeCallbacks();
            return;
        }// end function

        override protected function onTimeOut(event:TimerEvent) : void
        {
            if (this._entity)
            {
                this._entity.destroy();
            }
            super.onTimeOut(event);
            return;
        }// end function

        override protected function executeCallbacks() : void
        {
            super.executeCallbacks();
            return;
        }// end function

    }
}
