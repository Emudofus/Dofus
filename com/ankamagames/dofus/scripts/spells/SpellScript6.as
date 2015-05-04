package com.ankamagames.dofus.scripts.spells
{
   import com.ankamagames.dofus.scripts.SpellFxRunner;
   import com.ankamagames.jerakine.sequencer.ISequencable;
   import com.ankamagames.dofus.types.entities.Projectile;
   import com.ankamagames.dofus.types.entities.ExplosionEntity;
   import com.ankamagames.dofus.scripts.api.FxApi;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.dofus.scripts.api.SequenceApi;
   import com.ankamagames.dofus.scripts.api.SpellFxApi;
   
   public class SpellScript6 extends SpellScriptBase
   {
      
      public function SpellScript6(param1:SpellFxRunner)
      {
         var _loc4_:uint = 0;
         var _loc5_:ISequencable = null;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:* = false;
         var _loc9_:ISequencable = null;
         var _loc10_:* = 0;
         var _loc11_:* = 0;
         var _loc12_:* = false;
         var _loc13_:ISequencable = null;
         var _loc14_:Projectile = null;
         var _loc15_:* = false;
         var _loc16_:* = false;
         var _loc17_:ExplosionEntity = null;
         super(param1);
         var _loc2_:MapPoint = FxApi.GetCurrentTargetedCell(runner);
         if(!caster)
         {
            return;
         }
         addCasterSetDirectionStep(_loc2_);
         if(!FxApi.IsPositionsEquals(FxApi.GetEntityCell(caster),_loc2_))
         {
            _loc4_ = FxApi.GetOrientationTo(FxApi.GetEntityCell(caster),_loc2_);
            _loc5_ = SequenceApi.CreateSetDirectionStep(caster,_loc4_);
            SpellFxApi.AddFrontStep(runner,_loc5_);
            latestStep = _loc5_;
         }
         var _loc3_:ISequencable = SequenceApi.CreatePlayAnimationStep(caster,"AnimAttaque403",true,true,"SHOT");
         if(!latestStep)
         {
            SpellFxApi.AddFrontStep(runner,_loc3_);
         }
         else
         {
            SpellFxApi.AddStepAfter(runner,latestStep,_loc3_);
         }
         latestStep = _loc3_;
         if(SpellFxApi.HasSpellParam(spell,"casterGfxId"))
         {
            _loc6_ = 0;
            if(SpellFxApi.HasSpellParam(spell,"casterGfxOriented"))
            {
               if(SpellFxApi.GetSpellParam(spell,"casterGfxOriented"))
               {
                  _loc6_ = FxApi.GetAngleTo(FxApi.GetEntityCell(caster),FxApi.GetCurrentTargetedCell(runner));
               }
            }
            _loc7_ = 0;
            if(SpellFxApi.HasSpellParam(spell,"casterGfxYOffset"))
            {
               _loc7_ = SpellFxApi.GetSpellParam(spell,"casterGfxYOffset");
            }
            _loc8_ = false;
            if(SpellFxApi.HasSpellParam(spell,"casterGfxShowUnder"))
            {
               _loc8_ = SpellFxApi.GetSpellParam(spell,"casterGfxShowUnder");
            }
            _loc9_ = SequenceApi.CreateAddGfxEntityStep(runner,SpellFxApi.GetSpellParam(spell,"casterGfxId"),FxApi.GetEntityCell(caster),_loc6_,_loc7_,SpellFxApi.GetSpellParam(spell,"casterGfxDisplayType"),FxApi.GetEntityCell(caster),FxApi.GetCurrentTargetedCell(runner),_loc8_);
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
         if(SpellFxApi.HasSpellParam(spell,"targetGfxId"))
         {
            _loc10_ = 0;
            if(SpellFxApi.HasSpellParam(spell,"targetGfxOriented"))
            {
               if(SpellFxApi.GetSpellParam(spell,"targetGfxOriented"))
               {
                  _loc10_ = FxApi.GetAngleTo(FxApi.GetEntityCell(caster),FxApi.GetCurrentTargetedCell(runner));
               }
            }
            _loc11_ = 0;
            if(SpellFxApi.HasSpellParam(spell,"targetGfxYOffset"))
            {
               _loc11_ = SpellFxApi.GetSpellParam(spell,"targetGfxYOffset");
            }
            _loc12_ = false;
            if(SpellFxApi.HasSpellParam(spell,"targetGfxShowUnder"))
            {
               _loc12_ = SpellFxApi.GetSpellParam(spell,"targetGfxShowUnder");
            }
            _loc13_ = SequenceApi.CreateAddGfxEntityStep(runner,SpellFxApi.GetSpellParam(spell,"targetGfxId"),_loc2_,_loc10_,_loc11_,SpellFxApi.GetSpellParam(spell,"targetGfxDisplayType"),FxApi.GetEntityCell(caster),FxApi.GetCurrentTargetedCell(runner),_loc12_);
            if(!latestStep)
            {
               SpellFxApi.AddFrontStep(runner,_loc13_);
            }
            else if((SpellFxApi.HasSpellParam(spell,"playTargetGfxFirst")) && (SpellFxApi.GetSpellParam(spell,"playTargetGfxFirst")))
            {
               SpellFxApi.AddStepBefore(runner,latestStep,_loc13_);
            }
            else
            {
               SpellFxApi.AddStepAfter(runner,latestStep,_loc13_);
            }
            
            latestStep = _loc13_;
         }
         if(SpellFxApi.HasSpellParam(spell,"animId"))
         {
            _loc14_ = FxApi.CreateGfxEntity(SpellFxApi.GetSpellParam(spell,"animId"),FxApi.GetCurrentTargetedCell(runner),-10,10,true) as Projectile;
            _loc15_ = false;
            if(SpellFxApi.HasSpellParam(spell,"levelChange"))
            {
               _loc15_ = SpellFxApi.GetSpellParam(spell,"levelChange");
            }
            _loc16_ = false;
            if(SpellFxApi.HasSpellParam(spell,"subExplo"))
            {
               _loc16_ = SpellFxApi.GetSpellParam(spell,"subExplo");
            }
            _loc5_ = SequenceApi.CreateSetDirectionStep(_loc14_,1);
            SpellFxApi.AddStepAfter(runner,latestStep,_loc5_);
            latestStep = _loc5_;
            _loc17_ = SpellFxApi.CreateExplosionEntity(runner,SpellFxApi.GetSpellParam(spell,"particleGfxId"),SpellFxApi.GetSpellParam(spell,"particleColor"),SpellFxApi.GetSpellParam(spell,"particleCount"),_loc15_,_loc16_,SpellFxApi.GetSpellParam(spell,"explosionType"));
            FxApi.SetSubEntity(_loc14_,_loc17_,2,1);
            _loc13_ = SequenceApi.CreateAddWorldEntityStep(_loc14_);
            if(!latestStep)
            {
               SpellFxApi.AddFrontStep(runner,_loc13_);
            }
            else if((SpellFxApi.HasSpellParam(spell,"playTargetGfxFirst2")) && (SpellFxApi.GetSpellParam(spell,"playTargetGfxFirst2")))
            {
               SpellFxApi.AddStepBefore(runner,latestStep,_loc13_);
            }
            else
            {
               SpellFxApi.AddStepAfter(runner,latestStep,_loc13_);
            }
            
            latestStep = _loc13_;
         }
         destroy();
      }
   }
}
