package com.ankamagames.dofus.scripts.api
{
   import com.ankamagames.dofus.logic.game.fight.types.CastingSpell;
   import com.ankamagames.dofus.scripts.SpellFxRunner;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.jerakine.sequencer.ISequencable;
   import com.ankamagames.dofus.logic.game.fight.steps.IFightStep;
   import com.ankamagames.dofus.types.entities.ExplosionEntity;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.tiphon.TiphonConstants;
   
   public class SpellFxApi extends FxApi
   {
      
      public function SpellFxApi() {
         super();
      }
      
      public static function GetCastingSpell(runner:SpellFxRunner) : CastingSpell {
         return runner.castingSpell;
      }
      
      public static function GetUsedWeaponType(spell:CastingSpell) : uint {
         if(spell.weaponId > 0)
         {
            return Item.getItemById(spell.weaponId).typeId;
         }
         return 0;
      }
      
      public static function IsCriticalHit(spell:CastingSpell) : Boolean {
         return spell.isCriticalHit;
      }
      
      public static function IsCriticalFail(spell:CastingSpell) : Boolean {
         return spell.isCriticalFail;
      }
      
      public static function GetSpellParam(spell:CastingSpell, name:String) : * {
         var r:* = spell.spell.getParamByName(name,IsCriticalHit(spell));
         if(r is String)
         {
            return r;
         }
         return isNaN(r)?0:r;
      }
      
      public static function HasSpellParam(spell:CastingSpell, name:String) : Boolean {
         if((!spell) || (!spell.spell))
         {
            return false;
         }
         var v:* = spell.spell.getParamByName(name,IsCriticalHit(spell));
         return (!isNaN(v)) || (!(v == null));
      }
      
      public static function GetStepType(step:ISequencable) : String {
         if(step is IFightStep)
         {
            return (step as IFightStep).stepType;
         }
         return "other";
      }
      
      public static function GetStepsFromType(runner:SpellFxRunner, type:String) : Vector.<IFightStep> {
         var stepInside:ISequencable = null;
         var fightStepInside:IFightStep = null;
         var steps:Vector.<IFightStep> = new Vector.<IFightStep>(0,false);
         for each(stepInside in runner.stepsBuffer)
         {
            if(stepInside is IFightStep)
            {
               fightStepInside = stepInside as IFightStep;
               if(fightStepInside.stepType == type)
               {
                  steps.push(fightStepInside);
               }
            }
         }
         return steps;
      }
      
      public static function AddFrontStep(runner:SpellFxRunner, step:ISequencable) : void {
         runner.stepsBuffer.splice(0,0,step);
      }
      
      public static function AddBackStep(runner:SpellFxRunner, step:ISequencable) : void {
         runner.stepsBuffer.push(step);
      }
      
      public static function AddStepBefore(runner:SpellFxRunner, referenceStep:ISequencable, stepToAdd:ISequencable) : void {
         var stepInside:ISequencable = null;
         var index:int = -1;
         var currentIndex:uint = 0;
         for each(stepInside in runner.stepsBuffer)
         {
            if(stepInside == referenceStep)
            {
               index = currentIndex;
               break;
            }
            currentIndex++;
         }
         if(index < 0)
         {
            _log.warn("Cannot add a step before " + referenceStep + "; step not found.");
            return;
         }
         runner.stepsBuffer.splice(index,0,stepToAdd);
      }
      
      public static function AddStepAfter(runner:SpellFxRunner, referenceStep:ISequencable, stepToAdd:ISequencable) : void {
         var stepInside:ISequencable = null;
         var index:int = -1;
         var currentIndex:uint = 0;
         for each(stepInside in runner.stepsBuffer)
         {
            if(stepInside == referenceStep)
            {
               index = currentIndex;
               break;
            }
            currentIndex++;
         }
         if(index < 0)
         {
            _log.warn("Cannot add a step after " + referenceStep + "; step not found.");
            return;
         }
         runner.stepsBuffer.splice(index + 1,0,stepToAdd);
      }
      
      public static function CreateExplosionEntity(runner:SpellFxRunner, gfxId:uint, startColors:String, particleCount:uint, levelChange:Boolean, subExplo:Boolean, exploType:uint) : ExplosionEntity {
         var tmp:Array = null;
         var i:uint = 0;
         var spellRank:* = 0;
         var uri:Uri = new Uri(TiphonConstants.SWF_SKULL_PATH + "/" + gfxId + ".swl");
         if(startColors)
         {
            tmp = startColors.split(";");
            while(i < tmp.length)
            {
               tmp[i] = parseInt(tmp[i],16);
               i++;
            }
         }
         if(levelChange)
         {
            spellRank = runner.castingSpell.spellRank.spell.spellLevels.indexOf(runner.castingSpell.spellRank.id);
            if(spellRank != -1)
            {
               particleCount = particleCount * runner.castingSpell.spellRank.spell.spellLevels.length / 10 + particleCount * (spellRank + 1) / 10;
            }
         }
         return new ExplosionEntity(uri,tmp,particleCount,subExplo,exploType);
      }
   }
}
