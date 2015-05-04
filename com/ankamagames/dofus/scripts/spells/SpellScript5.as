package com.ankamagames.dofus.scripts.spells
{
   import com.ankamagames.dofus.scripts.SpellFxRunner;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.sequencer.ISequencable;
   import com.ankamagames.dofus.scripts.api.FxApi;
   import com.ankamagames.dofus.scripts.api.SpellFxApi;
   import com.ankamagames.dofus.scripts.api.SequenceApi;
   
   public class SpellScript5 extends SpellScriptBase
   {
      
      public function SpellScript5(param1:SpellFxRunner)
      {
         var _loc7_:MapPoint = null;
         var _loc8_:MapPoint = null;
         var _loc9_:ISequencable = null;
         super(param1);
         var _loc2_:MapPoint = FxApi.GetCurrentTargetedCell(runner);
         var _loc3_:MapPoint = FxApi.GetEntityCell(caster);
         var _loc4_:Vector.<MapPoint> = SpellFxApi.GetPortalCells(runner);
         if((_loc4_) && _loc4_.length > 1)
         {
            _loc7_ = _loc4_[0];
            _loc8_ = _loc4_[_loc4_.length - 1];
         }
         var _loc5_:MapPoint = _loc7_?_loc7_:_loc2_;
         var _loc6_:MapPoint = _loc8_?_loc8_:_loc3_;
         addCasterSetDirectionStep(_loc5_);
         addCasterAnimationStep();
         if(_loc7_)
         {
            addPortalAnimationSteps(SpellFxApi.GetPortalIds(runner));
         }
         if((SpellFxApi.HasSpellParam(spell,"glyphGfxId")) && spell.silentCast == false && (_loc2_))
         {
            _loc9_ = SequenceApi.CreateAddGlyphGfxStep(runner,SpellFxApi.GetSpellParam(spell,"glyphGfxId"),_loc2_,spell.markId);
            if(!latestStep)
            {
               SpellFxApi.AddFrontStep(runner,_loc9_);
            }
            else
            {
               SpellFxApi.AddStepAfter(runner,latestStep,_loc9_);
            }
            latestStep = _loc9_;
         }
         if(SpellFxApi.HasSpellParam(spell,"casterGfxId"))
         {
            addGfxEntityStep(_loc3_,_loc6_,_loc2_,PREFIX_CASTER);
         }
         if(SpellFxApi.HasSpellParam(spell,"targetGfxId"))
         {
            addGfxEntityStep(_loc2_,_loc6_,_loc2_,PREFIX_TARGET);
         }
         addAnimHitSteps();
         destroy();
      }
   }
}
