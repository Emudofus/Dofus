package com.ankamagames.dofus.scripts.api
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.dofus.scripts.FxRunner;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.dofus.scripts.SpellFxRunner;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.atouin.utils.CellUtil;
   import flash.display.DisplayObject;
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.types.entities.Projectile;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import com.ankamagames.dofus.types.entities.TailEntity;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.dofus.types.entities.ParticuleEmitterEntity;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.tiphon.events.TiphonEvent;
   
   public class FxApi extends Object
   {
      
      public function FxApi() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(FxApi));
      
      public static const ANIMEVENT_SHOT:String = TiphonEvent.ANIMATION_SHOT;
      
      public static function GetCurrentTargetedCell(param1:FxRunner) : MapPoint {
         return param1.target;
      }
      
      public static function GetCurrentCaster(param1:SpellFxRunner) : IEntity {
         return param1.caster;
      }
      
      public static function IsCasterPlayer(param1:SpellFxRunner) : Boolean {
         return param1.caster.id == PlayedCharacterManager.getInstance().id;
      }
      
      public static function GetOrientationTo(param1:MapPoint, param2:MapPoint, param3:Boolean=true) : uint {
         return param1.advancedOrientationTo(param2,param3);
      }
      
      public static function GetAngleTo(param1:MapPoint, param2:MapPoint) : Number {
         var _loc3_:int = CellUtil.getPixelXFromMapPoint(param2) - CellUtil.getPixelXFromMapPoint(param1);
         var _loc4_:int = CellUtil.getPixelYFromMapPoint(param1) - CellUtil.getPixelYFromMapPoint(param2);
         return Math.acos(_loc3_ / Math.sqrt(Math.pow(_loc3_,2) + Math.pow(_loc4_,2))) * 180 / Math.PI * (CellUtil.getPixelYFromMapPoint(param2) > CellUtil.getPixelYFromMapPoint(param1)?1:-1);
      }
      
      public static function SetGfxRotation(param1:DisplayObject, param2:Number) : void {
         param1.rotation = param2;
      }
      
      public static function GetEntityCell(param1:IEntity) : MapPoint {
         return param1.position;
      }
      
      public static function IsPositionsEquals(param1:MapPoint, param2:MapPoint) : Boolean {
         if(!param1 || !param2)
         {
            return false;
         }
         return param1.cellId == param2.cellId;
      }
      
      public static function GetEntityOnCell(param1:MapPoint) : IEntity {
         return Atouin.getInstance().getEntityOnCell(param1.cellId);
      }
      
      public static function GetEntityId(param1:IEntity) : int {
         return param1.id;
      }
      
      public static function GetEntityPosition(param1:IEntity) : MapPoint {
         return param1.position;
      }
      
      public static function CreateGfxEntity(param1:uint, param2:MapPoint, param3:Number=0, param4:Number=0, param5:Boolean=false, param6:Boolean=true) : IEntity {
         var _loc7_:* = -10000;
         while(DofusEntities.getEntity(_loc7_))
         {
            _loc7_ = -10000 + Math.random() * 10000;
         }
         var _loc8_:Projectile = new Projectile(_loc7_,TiphonEntityLook.fromString("{" + param1 + "}"),false);
         _loc8_.position = param2;
         _loc8_.rotation = Math.random() * (param4 - param3) + param3;
         if((param5) && Math.random() < 0.5)
         {
            _loc8_.scaleX = -1;
         }
         return _loc8_;
      }
      
      public static function CreateTailEntity() : TailEntity {
         return new TailEntity();
      }
      
      public static function SetEntityAnimation(param1:TiphonSprite, param2:String) : void {
         param1.setAnimation(param2);
      }
      
      public static function SetSubEntity(param1:TiphonSprite, param2:DisplayObject, param3:uint, param4:uint) : void {
         if(param1)
         {
            param1.addSubEntity(param2,param3,param4);
         }
      }
      
      public static function CreateParticlesEntity(param1:uint) : ParticuleEmitterEntity {
         var _loc2_:* = -10000;
         while(DofusEntities.getEntity(_loc2_))
         {
            _loc2_ = -10000 + Math.random() * 10000;
         }
         return new ParticuleEmitterEntity(_loc2_,param1);
      }
   }
}
