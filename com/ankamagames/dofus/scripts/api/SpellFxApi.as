package com.ankamagames.dofus.scripts.api
{
   import com.ankamagames.dofus.logic.game.fight.types.CastingSpell;
   import com.ankamagames.dofus.scripts.SpellFxRunner;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.jerakine.sequencer.ISequencable;
   import com.ankamagames.dofus.logic.game.fight.steps.IFightStep;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.types.entities.ExplosionEntity;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.tiphon.TiphonConstants;
   
   public class SpellFxApi extends FxApi
   {
      
      public function SpellFxApi() {
         super();
      }
      
      public static function GetCastingSpell(param1:SpellFxRunner) : CastingSpell {
         return param1.castingSpell;
      }
      
      public static function GetUsedWeaponType(param1:CastingSpell) : uint {
         if(param1.weaponId > 0)
         {
            return Item.getItemById(param1.weaponId).typeId;
         }
         return 0;
      }
      
      public static function IsCriticalHit(param1:CastingSpell) : Boolean {
         return param1.isCriticalHit;
      }
      
      public static function IsCriticalFail(param1:CastingSpell) : Boolean {
         return param1.isCriticalFail;
      }
      
      public static function GetSpellParam(param1:CastingSpell, param2:String) : * {
         var _loc3_:* = param1.spell.getParamByName(param2,IsCriticalHit(param1));
         if(_loc3_ is String)
         {
            return _loc3_;
         }
         return isNaN(_loc3_)?0:_loc3_;
      }
      
      public static function HasSpellParam(param1:CastingSpell, param2:String) : Boolean {
         var _loc3_:* = param1.spell.getParamByName(param2,IsCriticalHit(param1));
         return !isNaN(_loc3_) || !(_loc3_ == null);
      }
      
      public static function GetStepType(param1:ISequencable) : String {
         if(param1 is IFightStep)
         {
            return (param1 as IFightStep).stepType;
         }
         return "other";
      }
      
      public static function GetStepsFromType(param1:SpellFxRunner, param2:String) : Vector.<IFightStep> {
         var _loc4_:ISequencable = null;
         var _loc5_:IFightStep = null;
         var _loc3_:Vector.<IFightStep> = new Vector.<IFightStep>(0,false);
         for each (_loc4_ in param1.stepsBuffer)
         {
            if(_loc4_ is IFightStep)
            {
               _loc5_ = _loc4_ as IFightStep;
               if(_loc5_.stepType == param2)
               {
                  _loc3_.push(_loc5_);
               }
            }
         }
         return _loc3_;
      }
      
      public static function AddFrontStep(param1:SpellFxRunner, param2:ISequencable) : void {
         param1.stepsBuffer.splice(0,0,param2);
      }
      
      public static function AddBackStep(param1:SpellFxRunner, param2:ISequencable) : void {
         param1.stepsBuffer.push(param2);
      }
      
      public static function AddStepBefore(param1:SpellFxRunner, param2:ISequencable, param3:ISequencable) : void {
         var _loc6_:ISequencable = null;
         var _loc4_:* = -1;
         var _loc5_:uint = 0;
         for each (_loc6_ in param1.stepsBuffer)
         {
            if(_loc6_ == param2)
            {
               _loc4_ = _loc5_;
               break;
            }
            _loc5_++;
         }
         if(_loc4_ < 0)
         {
            _log.warn("Cannot add a step before " + param2 + "; step not found.");
            return;
         }
         param1.stepsBuffer.splice(_loc4_,0,param3);
      }
      
      public static function AddStepAfter(param1:SpellFxRunner, param2:ISequencable, param3:ISequencable) : void {
         var _loc6_:ISequencable = null;
         var _loc4_:* = -1;
         var _loc5_:uint = 0;
         for each (_loc6_ in param1.stepsBuffer)
         {
            if(_loc6_ == param2)
            {
               _loc4_ = _loc5_;
               break;
            }
            _loc5_++;
         }
         if(_loc4_ < 0)
         {
            _log.warn("Cannot add a step after " + param2 + "; step not found.");
            return;
         }
         param1.stepsBuffer.splice(_loc4_ + 1,0,param3);
      }
      
      public static function CreateExplosionEntity(param1:SpellFxRunner, param2:uint, param3:String, param4:uint, param5:Boolean, param6:Boolean, param7:uint) : ExplosionEntity {
         var _loc9_:Array = null;
         var _loc10_:uint = 0;
         var _loc11_:* = 0;
         var _loc8_:Uri = new Uri(TiphonConstants.SWF_SKULL_PATH + "/" + param2 + ".swl");
         if(param3)
         {
            _loc9_ = param3.split(";");
            while(_loc10_ < _loc9_.length)
            {
               _loc9_[_loc10_] = parseInt(_loc9_[_loc10_],16);
               _loc10_++;
            }
         }
         if(param5)
         {
            _loc11_ = param1.castingSpell.spellRank.spell.spellLevels.indexOf(param1.castingSpell.spellRank.id);
            if(_loc11_ != -1)
            {
               param4 = param4 * param1.castingSpell.spellRank.spell.spellLevels.length / 10 + param4 * (_loc11_ + 1) / 10;
            }
         }
         return new ExplosionEntity(_loc8_,_loc9_,param4,param6,param7);
      }
   }
}
