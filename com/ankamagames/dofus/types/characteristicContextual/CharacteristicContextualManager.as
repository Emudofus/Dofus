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
      
      protected static const _log:Logger;
      
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
      
      public function addStatContextual(sText:String, oEntity:IEntity, format:TextFormat, type:uint, pScrollSpeed:Number = 1, pScrollDuration:uint = 2500) : CharacteristicContextual {
         var txtCxt:TextContextual = null;
         var txtSCxt:StyledTextContextual = null;
         var data:TweenData = null;
         if((!oEntity) || (oEntity.position.cellId == -1))
         {
            return null;
         }
         this._type = type;
         var dist:Array = [Math.abs(16711680 - (format.color as uint)),Math.abs(255 - (format.color as uint)),Math.abs(26112 - (format.color as uint)),Math.abs(10053324 - (format.color as uint))];
         var style:uint = dist.indexOf(Math.min(dist[0],dist[1],dist[2],dist[3]));
         switch(this._type)
         {
            case 1:
               txtCxt = new TextContextual();
               txtCxt.referedEntity = oEntity;
               txtCxt.text = sText;
               txtCxt.textFormat = format;
               txtCxt.finalize();
               if(!this._tweenByEntities[oEntity])
               {
                  this._tweenByEntities[oEntity] = new Array();
               }
               data = new TweenData(txtCxt,oEntity,pScrollSpeed,pScrollDuration);
               (this._tweenByEntities[oEntity] as Array).unshift(data);
               if((this._tweenByEntities[oEntity] as Array).length == 1)
               {
                  _aEntitiesTweening.push(data);
               }
               this._tweeningCount++;
               this.beginTween(txtCxt);
               break;
            case 2:
               txtSCxt = new StyledTextContextual(sText,style);
               txtSCxt.referedEntity = oEntity;
               if(!this._tweenByEntities[oEntity])
               {
                  this._tweenByEntities[oEntity] = new Array();
               }
               data = new TweenData(txtSCxt,oEntity,pScrollSpeed,pScrollDuration);
               (this._tweenByEntities[oEntity] as Array).unshift(data);
               if((this._tweenByEntities[oEntity] as Array).length == 1)
               {
                  _aEntitiesTweening.push(data);
               }
               this._tweeningCount++;
               this.beginTween(txtSCxt);
               break;
         }
         return txtCxt?txtCxt:txtSCxt;
      }
      
      private function removeStatContextual(nIndex:Number) : void {
         var entity:CharacteristicContextual = null;
         if(_aEntitiesTweening[nIndex] != null)
         {
            entity = _aEntitiesTweening[nIndex].context;
            entity.remove();
            Berilia.getInstance().strataLow.removeChild(entity);
            _aEntitiesTweening[nIndex] = null;
            delete _aEntitiesTweening[nIndex];
         }
      }
      
      private function beginTween(oEntity:CharacteristicContextual) : void {
         Berilia.getInstance().strataLow.addChild(oEntity);
         var display:IRectangle = IDisplayable(oEntity.referedEntity).absoluteBounds;
         oEntity.x = (display.x + display.width / 2 - oEntity.width / 2 - StageShareManager.stageOffsetX) / StageShareManager.stageScaleX;
         oEntity.y = (display.y - oEntity.height - StageShareManager.stageOffsetY) / StageShareManager.stageScaleY;
         oEntity.alpha = 0;
         if(this._bEnterFrameNeeded)
         {
            EnterFrameDispatcher.addEventListener(this.onScroll,"CharacteristicContextManager");
            this._bEnterFrameNeeded = false;
         }
      }
      
      private function onScroll(e:Event) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
   }
}
import com.ankamagames.jerakine.entities.interfaces.IEntity;
import com.ankamagames.dofus.types.characteristicContextual.CharacteristicContextual;
import flash.utils.getTimer;

class TweenData extends Object
{
   
   function TweenData(oEntity:CharacteristicContextual, entity:IEntity, pScrollSpeed:Number, pScrollDuration:uint) {
      this.startTime = getTimer();
      super();
      this.context = oEntity;
      this.entity = entity;
      this.scrollSpeed = pScrollSpeed;
      this.scrollDuration = pScrollDuration;
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
