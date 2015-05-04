package com.ankamagames.dofus.types.characteristicContextual
{
   import flash.events.EventDispatcher;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.Dictionary;
   import flash.text.TextFormat;
   import com.ankamagames.jerakine.entities.interfaces.*;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.events.Event;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayContextFrame;
   import com.ankamagames.dofus.network.enums.GameContextEnum;
   import flash.utils.getTimer;
   import flash.display.DisplayObject;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public class CharacteristicContextualManager extends EventDispatcher
   {
      
      public function CharacteristicContextualManager()
      {
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
            this._statsIcons = new Dictionary(true);
            return;
         }
      }
      
      private static const MAX_ENTITY_HEIGHT:uint = 250;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(CharacteristicContextualManager));
      
      private static var _self:CharacteristicContextualManager;
      
      private static var _aEntitiesTweening:Array;
      
      public static function getInstance() : CharacteristicContextualManager
      {
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
      
      private var _statsIcons:Dictionary;
      
      public function addStatContextual(param1:String, param2:IEntity, param3:TextFormat, param4:uint, param5:uint, param6:Number = 1, param7:uint = 2500) : CharacteristicContextual
      {
         var _loc10_:TextContextual = null;
         var _loc11_:StyledTextContextual = null;
         var _loc12_:TweenData = null;
         if(!param2 || param2.position.cellId == -1)
         {
            return null;
         }
         this._type = param4;
         var _loc8_:Array = [Math.abs(16711680 - (param3.color as uint)),Math.abs(255 - (param3.color as uint)),Math.abs(26112 - (param3.color as uint)),Math.abs(10053324 - (param3.color as uint))];
         var _loc9_:uint = _loc8_.indexOf(Math.min(_loc8_[0],_loc8_[1],_loc8_[2],_loc8_[3]));
         switch(this._type)
         {
            case 1:
               _loc10_ = new TextContextual();
               _loc10_.referedEntity = param2;
               _loc10_.text = param1;
               _loc10_.textFormat = param3;
               _loc10_.gameContext = param5;
               _loc10_.finalize();
               if(!this._tweenByEntities[param2])
               {
                  this._tweenByEntities[param2] = new Array();
               }
               _loc12_ = new TweenData(_loc10_,param2,param6,param7);
               (this._tweenByEntities[param2] as Array).unshift(_loc12_);
               if((this._tweenByEntities[param2] as Array).length == 1)
               {
                  _aEntitiesTweening.push(_loc12_);
               }
               this._tweeningCount++;
               this.beginTween(_loc10_);
               break;
            case 2:
               _loc11_ = new StyledTextContextual(param1,_loc9_);
               _loc11_.referedEntity = param2;
               _loc11_.gameContext = param5;
               if(!this._tweenByEntities[param2])
               {
                  this._tweenByEntities[param2] = new Array();
               }
               _loc12_ = new TweenData(_loc11_,param2,param6,param7);
               (this._tweenByEntities[param2] as Array).unshift(_loc12_);
               if((this._tweenByEntities[param2] as Array).length == 1)
               {
                  _aEntitiesTweening.push(_loc12_);
               }
               this._tweeningCount++;
               this.beginTween(_loc11_);
               break;
         }
         return _loc10_?_loc10_:_loc11_;
      }
      
      public function addStatContextualWithIcon(param1:Texture, param2:String, param3:IEntity, param4:TextFormat, param5:uint, param6:uint, param7:Number = 1, param8:Number = 2500) : void
      {
         var _loc9_:Boolean = this._bEnterFrameNeeded;
         var _loc10_:CharacteristicContextual = this.addStatContextual(param2,param3,param4,param5,param6,param7,param8);
         if(_loc10_)
         {
            this._statsIcons[_loc10_] = param1;
            param1.height = param1.width = _loc10_.height;
            param1.alpha = 0;
            Berilia.getInstance().strataLow.addChild(param1);
            if(_loc9_)
            {
               EnterFrameDispatcher.addEventListener(this.onIconScroll,"CharacteristicContextManagerIcon");
            }
         }
      }
      
      private function isIconDisplayed(param1:Texture, param2:CharacteristicContextual) : Boolean
      {
         var _loc4_:* = undefined;
         var _loc3_:* = false;
         for(_loc4_ in this._statsIcons)
         {
            if(this._statsIcons[_loc4_] == param1 && !(_loc4_ == param2))
            {
               _loc3_ = true;
               break;
            }
         }
         return _loc3_;
      }
      
      private function removeStatContextual(param1:Number) : void
      {
         var _loc2_:CharacteristicContextual = null;
         if(_aEntitiesTweening[param1] != null)
         {
            _loc2_ = _aEntitiesTweening[param1].context;
            _loc2_.remove();
            Berilia.getInstance().strataLow.removeChild(_loc2_);
            _aEntitiesTweening[param1] = null;
            delete _aEntitiesTweening[param1];
            true;
            if(this._statsIcons[_loc2_])
            {
               if(!this.isIconDisplayed(this._statsIcons[_loc2_],_loc2_))
               {
                  Berilia.getInstance().strataLow.removeChild(this._statsIcons[_loc2_]);
               }
               delete this._statsIcons[_loc2_];
               true;
            }
         }
      }
      
      private function removeTween(param1:int) : void
      {
         this.removeStatContextual(param1);
         this._tweeningCount--;
         if(this._tweeningCount == 0)
         {
            this._bEnterFrameNeeded = true;
            EnterFrameDispatcher.removeEventListener(this.onScroll);
            EnterFrameDispatcher.removeEventListener(this.onIconScroll);
         }
      }
      
      private function beginTween(param1:CharacteristicContextual) : void
      {
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
      
      private function onScroll(param1:Event) : void
      {
         var _loc4_:String = null;
         var _loc5_:TweenData = null;
         var _loc6_:CharacteristicContextual = null;
         var _loc7_:Array = null;
         var _loc8_:IRectangle = null;
         var _loc2_:Array = [];
         var _loc3_:uint = Kernel.getWorker().getFrame(RoleplayContextFrame)?GameContextEnum.ROLE_PLAY:GameContextEnum.FIGHT;
         for(_loc4_ in _aEntitiesTweening)
         {
            _loc5_ = _aEntitiesTweening[_loc4_];
            if(_loc5_)
            {
               _loc6_ = _loc5_.context;
               _loc6_.y = _loc6_.y - _loc5_.scrollSpeed;
               _loc5_._tweeningCurrentDistance = (getTimer() - _loc5_.startTime) / _loc5_.scrollDuration;
               _loc7_ = this._tweenByEntities[_loc5_.entity];
               if((_loc7_) && (_loc7_[_loc7_.length - 1] == _loc5_) && _loc5_._tweeningCurrentDistance > 0.5)
               {
                  _loc7_.pop();
                  if(_loc7_.length)
                  {
                     _loc7_[_loc7_.length - 1].startTime = getTimer();
                     _loc2_.push(_loc7_[_loc7_.length - 1]);
                  }
                  else
                  {
                     delete this._tweenByEntities[_loc5_.entity];
                     true;
                  }
               }
               if(_loc6_.gameContext != _loc3_)
               {
                  this.removeTween(int(_loc4_));
               }
               else if(_loc5_._tweeningCurrentDistance < 1 / 8)
               {
                  _loc6_.alpha = _loc5_._tweeningCurrentDistance * 4;
                  if(this._type == 2)
                  {
                     _loc6_.scaleX = _loc5_._tweeningCurrentDistance * 24;
                     _loc6_.scaleY = _loc5_._tweeningCurrentDistance * 24;
                     _loc8_ = IDisplayable(_loc6_.referedEntity).absoluteBounds;
                     if(!(_loc6_.referedEntity is DisplayObject) || (DisplayObject(_loc6_.referedEntity).parent))
                     {
                        _loc6_.x = (_loc8_.x + _loc8_.width / 2 - _loc6_.width / 2 - StageShareManager.stageOffsetX) / StageShareManager.stageScaleX;
                     }
                  }
               }
               else if(_loc5_._tweeningCurrentDistance < 1 / 4)
               {
                  _loc6_.alpha = _loc5_._tweeningCurrentDistance * 4;
                  if(this._type == 2)
                  {
                     _loc6_.scaleX = 3 - _loc5_._tweeningCurrentDistance * 8;
                     _loc6_.scaleY = 3 - _loc5_._tweeningCurrentDistance * 8;
                     _loc8_ = IDisplayable(_loc6_.referedEntity).absoluteBounds;
                     if(!(_loc6_.referedEntity is DisplayObject) || (DisplayObject(_loc6_.referedEntity).parent))
                     {
                        _loc6_.x = (_loc8_.x + _loc8_.width / 2 - _loc6_.width / 2 - StageShareManager.stageOffsetX) / StageShareManager.stageScaleX;
                     }
                  }
               }
               else if(_loc5_._tweeningCurrentDistance >= 3 / 4 && _loc5_._tweeningCurrentDistance < 1)
               {
                  _loc6_.alpha = 1 - _loc5_._tweeningCurrentDistance;
               }
               else if(_loc5_._tweeningCurrentDistance >= 1)
               {
                  this.removeTween(int(_loc4_));
               }
               else
               {
                  _loc6_.alpha = 1;
               }
               
               
               
               
            }
         }
         _aEntitiesTweening = _aEntitiesTweening.concat(_loc2_);
      }
      
      private function onIconScroll(param1:Event) : void
      {
         var _loc2_:Texture = null;
         var _loc3_:CharacteristicContextual = null;
         var _loc4_:String = null;
         var _loc5_:TweenData = null;
         for(_loc4_ in _aEntitiesTweening)
         {
            _loc5_ = _aEntitiesTweening[_loc4_];
            if(_loc5_)
            {
               _loc3_ = _loc5_.context;
               _loc2_ = this._statsIcons[_loc3_];
               if(_loc2_)
               {
                  _loc2_.alpha = _loc3_.alpha;
                  _loc2_.y = _loc3_.y;
                  _loc2_.x = _loc3_.x - _loc2_.width;
               }
            }
         }
      }
   }
}
import com.ankamagames.jerakine.entities.interfaces.IEntity;
import com.ankamagames.dofus.types.characteristicContextual.CharacteristicContextual;
import flash.utils.getTimer;

class TweenData extends Object
{
   
   function TweenData(param1:CharacteristicContextual, param2:IEntity, param3:Number, param4:uint)
   {
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
