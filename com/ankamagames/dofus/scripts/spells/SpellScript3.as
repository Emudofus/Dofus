package com.ankamagames.dofus.scripts.spells
{
   import com.ankamagames.dofus.scripts.SpellFxRunner;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.sequencer.ISequencable;
   import com.ankamagames.dofus.scripts.api.FxApi;
   import com.ankamagames.dofus.scripts.api.SpellFxApi;
   import com.ankamagames.dofus.scripts.api.SequenceApi;
   
   public class SpellScript3 extends SpellScriptBase
   {
      
      public function SpellScript3(param1:SpellFxRunner)
      {
         var _loc7_:MapPoint = null;
         var _loc8_:MapPoint = null;
         var _loc9_:* = false;
         var _loc10_:* = false;
         var _loc11_:* = false;
         var _loc12_:ISequencable = null;
         var _loc13_:ISequencable = null;
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
         if(SpellFxApi.HasSpellParam(spell,"casterGfxId"))
         {
            addGfxEntityStep(_loc3_,_loc3_,_loc2_,PREFIX_CASTER);
         }
         if((SpellFxApi.HasSpellParam(spell,"trailGfxId")) && (_loc5_))
         {
            _loc9_ = false;
            if(SpellFxApi.HasSpellParam(spell,"trailGfxShowUnder"))
            {
               _loc9_ = SpellFxApi.GetSpellParam(spell,"trailGfxShowUnder");
            }
            _loc10_ = false;
            if(SpellFxApi.HasSpellParam(spell,"useSpellZone"))
            {
               _loc10_ = SpellFxApi.GetSpellParam(spell,"useSpellZone");
            }
            _loc11_ = false;
            if(SpellFxApi.HasSpellParam(spell,"useOnlySpellZone"))
            {
               _loc11_ = SpellFxApi.GetSpellParam(spell,"useOnlySpellZone");
            }
            _loc12_ = SequenceApi.CreateAddGfxInLineStep(runner,SpellFxApi.GetSpellParam(spell,"trailGfxId"),_loc3_,_loc5_,SpellFxApi.GetSpellParam(spell,"trailGfxYOffset"),SpellFxApi.GetSpellParam(spell,"trailDisplayType"),SpellFxApi.GetSpellParam(spell,"trailGfxMinScale"),SpellFxApi.GetSpellParam(spell,"trailGfxMaxScale"),SpellFxApi.GetSpellParam(spell,"startTrailOnCaster"),SpellFxApi.GetSpellParam(spell,"endTrailOnTarget"),_loc9_,_loc10_,_loc11_);
            if((_loc7_) && _loc5_ == _loc7_)
            {
               _loc13_ = SequenceApi.CreateAddGfxInLineStep(runner,SpellFxApi.GetSpellParam(spell,"trailGfxId"),_loc6_,_loc2_,SpellFxApi.GetSpellParam(spell,"trailGfxYOffset"),SpellFxApi.GetSpellParam(spell,"trailDisplayType"),SpellFxApi.GetSpellParam(spell,"trailGfxMinScale"),SpellFxApi.GetSpellParam(spell,"trailGfxMaxScale"),SpellFxApi.GetSpellParam(spell,"startTrailOnCaster"),SpellFxApi.GetSpellParam(spell,"endTrailOnTarget"),_loc9_,_loc10_,_loc11_);
            }
            if(!latestStep)
            {
               SpellFxApi.AddFrontStep(runner,_loc12_);
            }
            else
            {
               SpellFxApi.AddStepAfter(runner,latestStep,_loc12_);
            }
            latestStep = _loc12_;
            if(_loc13_)
            {
               addPortalAnimationSteps(SpellFxApi.GetPortalIds(runner));
               SpellFxApi.AddStepAfter(runner,latestStep,_loc13_);
               latestStep = _loc13_;
            }
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
