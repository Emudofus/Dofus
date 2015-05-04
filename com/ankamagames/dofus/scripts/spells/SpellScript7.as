package com.ankamagames.dofus.scripts.spells
{
   import com.ankamagames.dofus.scripts.SpellFxRunner;
   import com.ankamagames.dofus.scripts.api.FxApi;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.dofus.scripts.api.SpellFxApi;
   import com.ankamagames.dofus.scripts.api.SequenceApi;
   import com.ankamagames.jerakine.sequencer.ISequencable;
   
   public class SpellScript7 extends SpellScriptBase
   {
      
      public function SpellScript7(param1:SpellFxRunner)
      {
         super(param1);
         var _loc2_:MapPoint = FxApi.GetCurrentTargetedCell(runner);
         addCasterSetDirectionStep(_loc2_);
         var _loc3_:* = "AnimArme";
         if(SpellFxApi.IsCriticalFail(spell))
         {
            _loc3_ = "AnimArmeEC";
         }
         var _loc4_:ISequencable = SequenceApi.CreatePlayAnimationStep(caster,_loc3_ + SpellFxApi.GetUsedWeaponType(spell),true,true,"SHOT");
         if(!latestStep)
         {
            SpellFxApi.AddFrontStep(runner,_loc4_);
         }
         else
         {
            SpellFxApi.AddStepAfter(runner,latestStep,_loc4_);
         }
         latestStep = _loc4_;
         addAnimHitSteps();
         destroy();
      }
   }
}
