package com.ankamagames.dofus.types.characteristicContextual
{
    import com.ankamagames.berilia.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.utils.display.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    public class CharacteristicContextualManager extends EventDispatcher
    {
        private var _bEnterFrameNeeded:Boolean;
        private var _tweeningCount:uint;
        private var _scrollSpeed:Number = 1;
        private var _scrollDuration:uint = 1500;
        private var _heightMax:uint = 50;
        private var _tweenByEntities:Dictionary;
        private var _type:uint = 1;
        private static const MAX_ENTITY_HEIGHT:uint = 250;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(CharacteristicContextualManager));
        private static var _self:CharacteristicContextualManager;
        private static var _aEntitiesTweening:Array;

        public function CharacteristicContextualManager()
        {
            if (_self)
            {
                throw new SingletonError("Warning : CharacteristicContextualManager is a singleton class and shoulnd\'t be instancied directly!");
            }
            _aEntitiesTweening = new Array();
            this._bEnterFrameNeeded = true;
            this._tweeningCount = 0;
            this._tweenByEntities = new Dictionary(true);
            return;
        }// end function

        public function get scrollSpeed() : Number
        {
            return this._scrollSpeed;
        }// end function

        public function set scrollSpeed(param1:Number) : void
        {
            this._scrollSpeed = param1;
            return;
        }// end function

        public function get scrollDuration() : uint
        {
            return this._scrollDuration;
        }// end function

        public function set scrollDuration(param1:uint) : void
        {
            this._scrollDuration = param1;
            return;
        }// end function

        public function addStatContextual(param1:String, param2:IEntity, param3:TextFormat, param4:uint) : CharacteristicContextual
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            if (!param2 || param2.position.cellId == -1)
            {
                return null;
            }
            this._type = param4;
            var _loc_5:* = [Math.abs(16711680 - (param3.color as uint)), Math.abs(255 - (param3.color as uint)), Math.abs(26112 - (param3.color as uint)), Math.abs(10053324 - (param3.color as uint))];
            var _loc_6:* = [Math.abs(16711680 - (param3.color as uint)), Math.abs(255 - (param3.color as uint)), Math.abs(26112 - (param3.color as uint)), Math.abs(10053324 - (param3.color as uint))].indexOf(Math.min(_loc_5[0], _loc_5[1], _loc_5[2], _loc_5[3]));
            switch(this._type)
            {
                case 1:
                {
                    _loc_7 = new TextContextual();
                    _loc_7.referedEntity = param2;
                    _loc_7.text = param1;
                    _loc_7.textFormat = param3;
                    _loc_7.finalize();
                    if (!this._tweenByEntities[param2])
                    {
                        this._tweenByEntities[param2] = new Array();
                    }
                    _loc_9 = new TweenData(_loc_7, param2);
                    (this._tweenByEntities[param2] as Array).unshift(_loc_9);
                    if ((this._tweenByEntities[param2] as Array).length == 1)
                    {
                        _aEntitiesTweening.push(_loc_9);
                    }
                    var _loc_10:* = this;
                    var _loc_11:* = this._tweeningCount + 1;
                    _loc_10._tweeningCount = _loc_11;
                    this.beginTween(_loc_7);
                    break;
                }
                case 2:
                {
                    _loc_8 = new StyledTextContextual(param1, _loc_6);
                    _loc_8.referedEntity = param2;
                    if (!this._tweenByEntities[param2])
                    {
                        this._tweenByEntities[param2] = new Array();
                    }
                    _loc_9 = new TweenData(_loc_8, param2);
                    (this._tweenByEntities[param2] as Array).unshift(_loc_9);
                    if ((this._tweenByEntities[param2] as Array).length == 1)
                    {
                        _aEntitiesTweening.push(_loc_9);
                    }
                    var _loc_10:* = this;
                    var _loc_11:* = this._tweeningCount + 1;
                    _loc_10._tweeningCount = _loc_11;
                    this.beginTween(_loc_8);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_7 ? (_loc_7) : (_loc_8);
        }// end function

        private function removeStatContextual(param1:Number) : void
        {
            var _loc_2:* = null;
            if (_aEntitiesTweening[param1] != null)
            {
                _loc_2 = _aEntitiesTweening[param1].context;
                _loc_2.remove();
                Berilia.getInstance().strataLow.removeChild(_loc_2);
                _aEntitiesTweening[param1] = null;
                delete _aEntitiesTweening[param1];
            }
            return;
        }// end function

        private function beginTween(param1:CharacteristicContextual) : void
        {
            Berilia.getInstance().strataLow.addChild(param1);
            var _loc_2:* = IDisplayable(param1.referedEntity).absoluteBounds;
            param1.x = (_loc_2.x + _loc_2.width / 2 - param1.width / 2 - StageShareManager.stageOffsetX) / StageShareManager.stageScaleX;
            param1.y = (_loc_2.y - param1.height - StageShareManager.stageOffsetY) / StageShareManager.stageScaleY;
            param1.alpha = 0;
            if (this._bEnterFrameNeeded)
            {
                EnterFrameDispatcher.addEventListener(this.onScroll, "CharacteristicContextManager");
                this._bEnterFrameNeeded = false;
            }
            return;
        }// end function

        private function onScroll(event:Event) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_2:* = [];
            for (_loc_3 in _aEntitiesTweening)
            {
                
                _loc_4 = _aEntitiesTweening[_loc_3];
                if (!_loc_4)
                {
                    continue;
                }
                _loc_5 = _loc_4.context;
                _loc_4.context.y = _loc_5.y - this._scrollSpeed;
                _loc_4._tweeningCurrentDistance = (getTimer() - _loc_4.startTime) / this._scrollDuration;
                _loc_6 = this._tweenByEntities[_loc_4.entity];
                if (_loc_6 && _loc_6[(_loc_6.length - 1)] == _loc_4 && _loc_4._tweeningCurrentDistance > 0.5)
                {
                    _loc_6.pop();
                    if (_loc_6.length)
                    {
                        _loc_6[(_loc_6.length - 1)].startTime = getTimer();
                        _loc_2.push(_loc_6[(_loc_6.length - 1)]);
                    }
                    else
                    {
                        delete this._tweenByEntities[_loc_4.entity];
                    }
                }
                if (_loc_4._tweeningCurrentDistance < 1 / 8)
                {
                    _loc_5.alpha = _loc_4._tweeningCurrentDistance * 4;
                    if (this._type == 2)
                    {
                        _loc_5.scaleX = _loc_4._tweeningCurrentDistance * 24;
                        _loc_5.scaleY = _loc_4._tweeningCurrentDistance * 24;
                        _loc_7 = IDisplayable(_loc_5.referedEntity).absoluteBounds;
                        if (!(_loc_5.referedEntity is DisplayObject) || DisplayObject(_loc_5.referedEntity).parent)
                        {
                            _loc_5.x = (_loc_7.x + _loc_7.width / 2 - _loc_5.width / 2 - StageShareManager.stageOffsetX) / StageShareManager.stageScaleX;
                        }
                    }
                    continue;
                }
                if (_loc_4._tweeningCurrentDistance < 1 / 4)
                {
                    _loc_5.alpha = _loc_4._tweeningCurrentDistance * 4;
                    if (this._type == 2)
                    {
                        _loc_5.scaleX = 3 - _loc_4._tweeningCurrentDistance * 8;
                        _loc_5.scaleY = 3 - _loc_4._tweeningCurrentDistance * 8;
                        _loc_7 = IDisplayable(_loc_5.referedEntity).absoluteBounds;
                        if (!(_loc_5.referedEntity is DisplayObject) || DisplayObject(_loc_5.referedEntity).parent)
                        {
                            _loc_5.x = (_loc_7.x + _loc_7.width / 2 - _loc_5.width / 2 - StageShareManager.stageOffsetX) / StageShareManager.stageScaleX;
                        }
                    }
                    continue;
                }
                if (_loc_4._tweeningCurrentDistance >= 3 / 4 && _loc_4._tweeningCurrentDistance < 1)
                {
                    _loc_5.alpha = 1 - _loc_4._tweeningCurrentDistance;
                    continue;
                }
                if (_loc_4._tweeningCurrentDistance >= 1)
                {
                    this.removeStatContextual(int(_loc_3));
                    var _loc_10:* = this;
                    var _loc_11:* = this._tweeningCount - 1;
                    _loc_10._tweeningCount = _loc_11;
                    if (this._tweeningCount == 0)
                    {
                        this._bEnterFrameNeeded = true;
                        EnterFrameDispatcher.removeEventListener(this.onScroll);
                    }
                    continue;
                }
                _loc_5.alpha = 1;
            }
            _aEntitiesTweening = _aEntitiesTweening.concat(_loc_2);
            return;
        }// end function

        public static function getInstance() : CharacteristicContextualManager
        {
            if (_self == null)
            {
                _self = new CharacteristicContextualManager;
            }
            return _self;
        }// end function

    }
}

import com.ankamagames.berilia.*;

import com.ankamagames.jerakine.entities.interfaces.*;

import com.ankamagames.jerakine.interfaces.*;

import com.ankamagames.jerakine.logger.*;

import com.ankamagames.jerakine.utils.display.*;

import com.ankamagames.jerakine.utils.errors.*;

import flash.display.*;

import flash.events.*;

import flash.text.*;

import flash.utils.*;

class TweenData extends Object
{
    public var entity:IEntity;
    public var context:CharacteristicContextual;
    public var _tweeningTotalDistance:uint = 40;
    public var _tweeningCurrentDistance:Number = 0;
    public var alpha:Number = 0;
    public var startTime:int;

    function TweenData(param1:CharacteristicContextual, param2:IEntity)
    {
        this.startTime = getTimer();
        this.context = param1;
        this.entity = param2;
        return;
    }// end function

}

