package com.ankamagames.dofus.scripts.spells
{
    import com.ankamagames.jerakine.types.positions.MapPoint;
    import com.ankamagames.jerakine.sequencer.ISequencable;
    import com.ankamagames.dofus.scripts.api.FxApi;
    import com.ankamagames.dofus.scripts.api.SpellFxApi;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.scripts.api.SequenceApi;
    import com.ankamagames.dofus.scripts.SpellFxRunner;

    public class SpellScript3 extends SpellScriptBase 
    {

        public function SpellScript3(spellFxRunner:SpellFxRunner)
        {
            var entryPortalCell:MapPoint;
            var exitPortalCell:MapPoint;
            var trailGfxShowUnder:Boolean;
            var useSpellZone:Boolean;
            var useOnlySpellZone:Boolean;
            var trailStep:ISequencable;
            var trailStep2:ISequencable;
            super(spellFxRunner);
            var targetCell:MapPoint = FxApi.GetCurrentTargetedCell(runner);
            var casterCell:MapPoint = FxApi.GetEntityCell(caster);
            var portalsCells:Vector.<MapPoint> = SpellFxApi.GetPortalCells(runner);
            if (((portalsCells) && ((portalsCells.length > 1))))
            {
                entryPortalCell = portalsCells[0];
                exitPortalCell = portalsCells[(portalsCells.length - 1)];
            };
            var tmpTargetCell:MapPoint = ((entryPortalCell) ? entryPortalCell : targetCell);
            var tmpCasterCell:MapPoint = ((exitPortalCell) ? exitPortalCell : casterCell);
            addCasterSetDirectionStep(tmpTargetCell);
            addCasterAnimationStep();
            if (SpellFxApi.HasSpellParam(spell, "casterGfxId"))
            {
                addGfxEntityStep(casterCell, casterCell, targetCell, PREFIX_CASTER);
            };
            if (SpellFxApi.HasSpellParam(spell, "trailGfxId"))
            {
                trailGfxShowUnder = false;
                if (SpellFxApi.HasSpellParam(spell, "trailGfxShowUnder"))
                {
                    trailGfxShowUnder = SpellFxApi.GetSpellParam(spell, "trailGfxShowUnder");
                };
                useSpellZone = false;
                if (SpellFxApi.HasSpellParam(spell, "useSpellZone"))
                {
                    useSpellZone = SpellFxApi.GetSpellParam(spell, "useSpellZone");
                };
                useOnlySpellZone = false;
                if (SpellFxApi.HasSpellParam(spell, "useOnlySpellZone"))
                {
                    useOnlySpellZone = SpellFxApi.GetSpellParam(spell, "useOnlySpellZone");
                };
                trailStep = SequenceApi.CreateAddGfxInLineStep(runner, SpellFxApi.GetSpellParam(spell, "trailGfxId"), casterCell, tmpTargetCell, SpellFxApi.GetSpellParam(spell, "trailGfxYOffset"), SpellFxApi.GetSpellParam(spell, "trailDisplayType"), SpellFxApi.GetSpellParam(spell, "trailGfxMinScale"), SpellFxApi.GetSpellParam(spell, "trailGfxMaxScale"), SpellFxApi.GetSpellParam(spell, "startTrailOnCaster"), SpellFxApi.GetSpellParam(spell, "endTrailOnTarget"), trailGfxShowUnder, useSpellZone, useOnlySpellZone);
                if (tmpTargetCell == entryPortalCell)
                {
                    trailStep2 = SequenceApi.CreateAddGfxInLineStep(runner, SpellFxApi.GetSpellParam(spell, "trailGfxId"), tmpCasterCell, targetCell, SpellFxApi.GetSpellParam(spell, "trailGfxYOffset"), SpellFxApi.GetSpellParam(spell, "trailDisplayType"), SpellFxApi.GetSpellParam(spell, "trailGfxMinScale"), SpellFxApi.GetSpellParam(spell, "trailGfxMaxScale"), SpellFxApi.GetSpellParam(spell, "startTrailOnCaster"), SpellFxApi.GetSpellParam(spell, "endTrailOnTarget"), trailGfxShowUnder, useSpellZone, useOnlySpellZone);
                };
                if (!(latestStep))
                {
                    SpellFxApi.AddFrontStep(runner, trailStep);
                }
                else
                {
                    SpellFxApi.AddStepAfter(runner, latestStep, trailStep);
                };
                latestStep = trailStep;
                if (trailStep2)
                {
                    addPortalAnimationSteps(SpellFxApi.GetPortalIds(runner));
                    SpellFxApi.AddStepAfter(runner, latestStep, trailStep2);
                    latestStep = trailStep2;
                };
            };
            if (SpellFxApi.HasSpellParam(spell, "targetGfxId"))
            {
                addGfxEntityStep(targetCell, tmpCasterCell, targetCell, PREFIX_TARGET);
            };
            addAnimHitSteps();
            destroy();
        }

    }
}//package com.ankamagames.dofus.scripts.spells

