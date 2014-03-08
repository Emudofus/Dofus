package com.ankamagames.dofus.types.characteristicContextual
{
   import flash.events.EventDispatcher;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.Dictionary;
   import flash.text.TextFormat;
   import com.ankamagames.jerakine.entities.interfaces.*;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import flash.events.Event;
   import flash.utils.getTimer;
   import flash.display.DisplayObject;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public class CharacteristicContextualManager extends EventDispatcher
   {
      
      public function CharacteristicContextualManager() {
         super();
         if(_self)
         {
            throw new SingletonError("Warning : CharacteristicContextualManager is a singleton class and shoulnd\'t be instancied directly!");
         }
         else
         {
            _aEntitiesTweening = new Array();
            this._bEnterFrameNeeded = true;
            this._tweeningCount = 0;
            this._tweenByEntities = new Dictionary(true);
            return;
         }
      }
      
      private static const MAX_ENTITY_HEIGHT:uint = 250;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(CharacteristicContextualManager));
      
      private static var _self:CharacteristicContextualManager;
      
      private static var _aEntitiesTweening:Array;
      
      public static function getInstance() : CharacteristicContextualManager {
         if(_self == null)
         {
            _self = new CharacteristicContextualManager();
         }
         return _self;
      }
      
      private var _bEnterFrameNeeded:Boolean;
      
      private var _tweeningCount:uint;
      
      private var _tweenByEntities:Dictionary;
      
      private var _type:uint = 1;
      
      public function addStatContextual(param1:String, param2:IEntity, param3:TextFormat, param4:uint, param5:Number=1, param6:uint=2500) : CharacteristicContextual {
         var _loc9_:TextContextual = null;
         var _loc10_:StyledTextContextual = null;
         var _loc11_:TweenData = null;
         if(!param2 || param2.position.cellId == -1)
         {
            return null;
         }
         this._type = param4;
         var _loc7_:Array = [Math.abs(16711680 - (param3.color as uint)),Math.abs(255 - (param3.color as uint)),Math.abs(26112 - (param3.color as uint)),Math.abs(10053324 - (param3.color as uint))];
         var _loc8_:uint = _loc7_.indexOf(Math.min(_loc7_[0],_loc7_[1],_loc7_[2],_loc7_[3]));
         switch(this._type)
         {
            case 1:
               _loc9_ = new TextContextual();
               _loc9_.referedEntity = param2;
               _loc9_.text = param1;
               _loc9_.textFormat = param3;
               _loc9_.finalize();
               if(!this._tweenByEntities[param2])
               {
                  this._tweenByEntities[param2] = new Array();
               }
               _loc11_ = new TweenData(_loc9_,param2,param5,param6);
               (this._tweenByEntities[param2] as Array).unshift(_loc11_);
               if((this._tweenByEntities[param2] as Array).length == 1)
               {
                  _aEntitiesTweening.push(_loc11_);
               }
               this._tweeningCount++;
               this.beginTween(_loc9_);
               break;
            case 2:
               _loc10_ = new StyledTextContextual(param1,_loc8_);
               _loc10_.referedEntity = param2;
               if(!this._tweenByEntities[param2])
               {
                  this._tweenByEntities[param2] = new Array();
               }
               _loc11_ = new TweenData(_loc10_,param2,param5,param6);
               (this._tweenByEntities[param2] as Array).unshift(_loc11_);
               if((this._tweenByEntities[param2] as Array).length == 1)
               {
                  _aEntitiesTweening.push(_loc11_);
               }
               this._tweeningCount++;
               this.beginTween(_loc10_);
               break;
         }
         return _loc9_?_loc9_:_loc10_;
      }
      
      private function removeStatContextual(param1:Number) : void {
         var _loc2_:CharacteristicContextual = null;
         if(_aEntitiesTweening[param1] != null)
         {
            _loc2_ = _aEntitiesTweening[param1].context;
            _loc2_.remove();
            Berilia.getInstance().strataLow.removeChild(_loc2_);
            _aEntitiesTweening[param1] = null;
            delete _aEntitiesTweening[[param1]];
         }
      }
      
      private function beginTween(param1:CharacteristicContextual) : void {
         Berilia.getInstance().strataLow.addChild(param1);
         var _loc2_:IRectangle = IDisplayable(param1.referedEntity).absoluteBounds;
         param1.x = (_loc2_.x + _loc2_.width / 2 - param1.width / 2 - StageShareManager.stageOffsetX) / StageShareManager.stageScaleX;
         param1.y = (_loc2_.y - param1.height - StageShareManager.stageOffsetY) / StageShareManager.stageScaleY;
         param1.alpha = 0;
         if(this._bEnterFrameNeeded)
         {
            EnterFrameDispatcher.addEventListener(this.onScroll,"CharacteristicContextManager");
            this._bEnterFrameNeeded = false;
         }
      }
      
      private function onScroll(param1:Event) : void {
         var _loc3_:String = null;
         var _loc4_:TweenData = null;
         var _loc5_:CharacteristicContextual = null;
         var _loc6_:Array = null;
         var _loc7_:IRectangle = null;
         var _loc2_:Array = [];
         for (_loc3_ in _aEntitiesTweening)
         {
            _loc4_ = _aEntitiesTweening[_loc3_];
            if(_loc4_)
            {
               _loc5_ = _loc4_.context;
               _loc5_.y = _loc5_.y - _loc4_.scrollSpeed;
               _loc4_._tweeningCurrentDistance = (getTimer() - _loc4_.startTime) / _loc4_.scrollDuration;
               _loc6_ = this._tweenByEntities[_loc4_.entity];
               if((_loc6_) && (_loc6_[_loc6_.length-1] == _loc4_) && _loc4_._tweeningCurrentDistance > 0.5)
               {
                  _loc6_.pop();
                  if(_loc6_.length)
                  {
                     _loc6_[_loc6_.length-1].startTime = getTimer();
                     _loc2_.push(_loc6_[_loc6_.length-1]);
                  }
                  else
                  {
                     delete this._tweenByEntities[[_loc4_.entity]];
                  }
               }
               if(_loc4_._tweeningCurrentDistance < 1 / 8)
               {
                  _loc5_.alpha = _loc4_._tweeningCurrentDistance * 4;
                  if(this._type == 2)
                  {
                     _loc5_.scaleX = _loc4_._tweeningCurrentDistance * 24;
                     _loc5_.scaleY = _loc4_._tweeningCurrentDistance * 24;
                     _loc7_ = IDisplayable(_loc5_.referedEntity).absoluteBounds;
                     if(!(_loc5_.referedEntity is DisplayObject) || (DisplayObject(_loc5_.referedEntity).parent))
                     {
                        _loc5_.x = (_loc7_.x + _loc7_.width / 2 - _loc5_.width / 2 - StageShareManager.stageOffsetX) / StageShareManager.stageScaleX;
                     }
                  }
               }
               else
               {
                  if(_loc4_._tweeningCurrentDistance < 1 / 4)
                  {
                     _loc5_.alpha = _loc4_._tweeningCurrentDistance * 4;
                     if(this._type == 2)
                     {
                        _loc5_.scaleX = 3 - _loc4_._tweeningCurrentDistance * 8;
                        _loc5_.scaleY = 3 - _loc4_._tweeningCurrentDistance * 8;
                        _loc7_ = IDisplayable(_loc5_.referedEntity).absoluteBounds;
                        if(!(_loc5_.referedEntity is DisplayObject) || (DisplayObject(_loc5_.referedEntity).parent))
                        {
                           _loc5_.x = (_loc7_.x + _loc7_.width / 2 - _loc5_.width / 2 - StageShareManager.stageOffsetX) / StageShareManager.stageScaleX;
                        }
                     }
                  }
                  else
                  {
                     if(_loc4_._tweeningCurrentDistance >= 3 / 4 && _loc4_._tweeningCurrentDistance < 1)
                     {
                        _loc5_.alpha = 1 - _loc4_._tweeningCurrentDistance;
                     }
                     else
                     {
                        if(_loc4_._tweeningCurrentDistance >= 1)
                        {
                           this.removeStatContextual(int(_loc3_));
                           this._tweeningCount--;
                           if(this._tweeningCount == 0)
                           {
                              this._bEnterFrameNeeded = true;
                              EnterFrameDispatcher.removeEventListener(this.onScroll);
                           }
                        }
                        else
                        {
                           _loc5_.alpha = 1;
                        }
                     }
                  }
               }
            }
         }
         _aEntitiesTweening = _aEntitiesTweening.concat(_loc2_);
      }
   }
}
import com.ankamagames.jerakine.entities.interfaces.IEntity;
import com.ankamagames.dofus.types.characteristicContextual.CharacteristicContextual;
import flash.utils.getTimer;

class TweenData extends Object
{
   
   function TweenData(param1:CharacteristicContextual, param2:IEntity, param3:Number, param4:uint) {
      this.startTime = getTimer();
      super();
      this.context = param1;
      this.entity = param2;
      this.scrollSpeed = param3;
      this.scrollDuration = param4;
   }
   
   public var entity:IEntity;
   
   public var context:CharacteristicContextual;
   
   public var scrollSpeed:Number;
   
   public var scrollDuration:uint;
   
   public var _tweeningTotalDistance:uint = 40;
   
   public var _tweeningCurrentDistance:Number = 0;
   
   public var alpha:Number = 0;
   
   public var startTime:int;
}
