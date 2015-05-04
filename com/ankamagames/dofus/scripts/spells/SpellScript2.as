package com.ankamagames.dofus.scripts.spells
{
   import com.ankamagames.dofus.scripts.SpellFxRunner;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.dofus.types.entities.Projectile;
   import com.ankamagames.atouin.types.sequences.AddWorldEntityStep;
   import com.ankamagames.atouin.types.sequences.ParableGfxMovementStep;
   import com.ankamagames.atouin.types.sequences.DestroyEntityStep;
   import com.ankamagames.dofus.scripts.api.FxApi;
   import com.ankamagames.dofus.scripts.api.SpellFxApi;
   import com.ankamagames.dofus.scripts.api.SequenceApi;
   
   public class SpellScript2 extends SpellScriptBase
   {
      
      public function SpellScript2(param1:SpellFxRunner)
      {
         var _loc7_:MapPoint = null;
         var _loc8_:MapPoint = null;
         var _loc9_:Projectile = null;
         var _loc10_:AddWorldEntityStep = null;
         var _loc11_:* = NaN;
         var _loc12_:* = NaN;
         var _loc13_:* = false;
         var _loc14_:* = NaN;
         var _loc15_:ParableGfxMovementStep = null;
         var _loc16_:DestroyEntityStep = null;
         var _loc17_:Projectile = null;
         var _loc18_:AddWorldEntityStep = null;
         var _loc19_:ParableGfxMovementStep = null;
         var _loc20_:DestroyEntityStep = null;
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
            addGfxEntityStep(_loc3_,_loc3_,_loc5_,PREFIX_CASTER);
         }
         if((SpellFxApi.HasSpellParam(spell,"missileGfxId")) && (_loc5_))
         {
            _loc9_ = FxApi.CreateGfxEntity(SpellFxApi.GetSpellParam(spell,"missileGfxId"),_loc3_) as Projectile;
            _loc10_ = SequenceApi.CreateAddWorldEntityStep(_loc9_);
            _loc11_ = 100;
            if(SpellFxApi.HasSpellParam(spell,"missileSpeed"))
            {
               _loc11_ = (SpellFxApi.GetSpellParam(spell,"missileSpeed") + 10) * 10;
            }
            _loc12_ = 0.5;
            if(SpellFxApi.HasSpellParam(spell,"missileCurvature"))
            {
               _loc12_ = SpellFxApi.GetSpellParam(spell,"missileCurvature") / 10;
            }
            _loc13_ = true;
            if(SpellFxApi.HasSpellParam(spell,"missileOrientedToCurve"))
            {
               _loc13_ = SpellFxApi.GetSpellParam(spell,"missileOrientedToCurve");
            }
            _loc14_ = 0;
            if(SpellFxApi.HasSpellParam(spell,"missileGfxYOffset"))
            {
               _loc14_ = SpellFxApi.GetSpellParam(spell,"missileGfxYOffset");
            }
            _loc15_ = SequenceApi.CreateParableGfxMovementStep(runner,_loc9_,_loc5_,_loc11_,_loc12_,_loc14_,_loc13_);
            _loc16_ = SequenceApi.CreateDestroyEntityStep(_loc9_);
            if((_loc7_) && _loc5_ == _loc7_)
            {
               _loc17_ = FxApi.CreateGfxEntity(SpellFxApi.GetSpellParam(spell,"missileGfxId"),_loc8_) as Projectile;
               _loc18_ = SequenceApi.CreateAddWorldEntityStep(_loc17_);
               _loc19_ = SequenceApi.CreateParableGfxMovementStep(runner,_loc17_,_loc2_,_loc11_,_loc12_,_loc14_,_loc13_);
               _loc20_ = SequenceApi.CreateDestroyEntityStep(_loc17_);
            }
            if(!latestStep)
            {
               SpellFxApi.AddFrontStep(runner,_loc10_);
               SpellFxApi.AddStepAfter(runner,_loc10_,_loc15_);
               SpellFxApi.AddStepAfter(runner,_loc15_,_loc16_);
            }
            else
            {
               SpellFxApi.AddStepAfter(runner,latestStep,_loc10_);
               SpellFxApi.AddStepAfter(runner,_loc10_,_loc15_);
               SpellFxApi.AddStepAfter(runner,_loc15_,_loc16_);
            }
            latestStep = _loc15_;
            if(_loc17_)
            {
               latestStep = _loc16_;
               addPortalAnimationSteps(SpellFxApi.GetPortalIds(runner));
               SpellFxApi.AddStepAfter(runner,latestStep,_loc18_);
               SpellFxApi.AddStepAfter(runner,_loc18_,_loc19_);
               SpellFxApi.AddStepAfter(runner,_loc19_,_loc20_);
               latestStep = _loc19_;
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
