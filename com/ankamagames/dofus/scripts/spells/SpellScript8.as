package com.ankamagames.dofus.scripts.spells
{
   import com.ankamagames.dofus.scripts.SpellFxRunner;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.dofus.scripts.api.FxApi;
   import com.ankamagames.dofus.scripts.api.SpellFxApi;
   
   public class SpellScript8 extends SpellScriptBase
   {
      
      public function SpellScript8(param1:SpellFxRunner)
      {
         var _loc7_:MapPoint = null;
         var _loc8_:MapPoint = null;
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
            if((_loc7_) && _loc5_ == _loc7_)
            {
               addPortalAnimationSteps(SpellFxApi.GetPortalIds(runner));
               addGfxEntityStep(_loc8_,_loc8_,_loc2_,PREFIX_CASTER);
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
