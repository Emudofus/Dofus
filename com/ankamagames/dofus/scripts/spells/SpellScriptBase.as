package com.ankamagames.dofus.scripts.spells
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.sequencer.ISequencable;
    import com.ankamagames.dofus.scripts.SpellFxRunner;
    import com.ankamagames.dofus.logic.game.fight.types.CastingSpell;
    import com.ankamagames.dofus.types.entities.AnimatedCharacter;
    import com.ankamagames.dofus.scripts.api.SpellFxApi;
    import com.ankamagames.dofus.scripts.api.FxApi;
    import com.ankamagames.tiphon.sequence.SetDirectionStep;
    import com.ankamagames.jerakine.types.positions.MapPoint;
    import com.ankamagames.dofus.scripts.api.SequenceApi;
    import com.ankamagames.jerakine.enum.AddGfxModeEnum;
    import com.ankamagames.dofus.logic.game.fight.steps.FightLifeVariationStep;
    import com.ankamagames.dofus.logic.game.fight.steps.IFightStep;
    import __AS3__.vec.Vector;
    import com.ankamagames.tiphon.display.TiphonSprite;
    import com.ankamagames.dofus.types.entities.Glyph;
    import com.ankamagames.dofus.types.enums.PortalAnimationEnum;
    import com.ankamagames.tiphon.sequence.PlayAnimationStep;
    import com.ankamagames.tiphon.events.TiphonEvent;
    import __AS3__.vec.*;

    public class SpellScriptBase 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SpellScriptBase));
        protected static const PREFIX_CASTER:String = "caster";
        protected static const PREFIX_TARGET:String = "target";

        protected var latestStep:ISequencable;
        protected var runner:SpellFxRunner;
        protected var spell:CastingSpell;
        protected var caster:AnimatedCharacter;

        public function SpellScriptBase(spellFxRunner:SpellFxRunner)
        {
            this.runner = spellFxRunner;
            this.spell = SpellFxApi.GetCastingSpell(this.runner);
            this.caster = (FxApi.GetCurrentCaster(this.runner) as AnimatedCharacter);
        }

        protected function addCasterSetDirectionStep(target:MapPoint):void
        {
            var orientation:uint;
            var orientationStep:SetDirectionStep;
            if (((((((this.caster) && (this.caster.position))) && (target))) && (!(FxApi.IsPositionsEquals(this.caster.position, target)))))
            {
                orientation = this.caster.position.advancedOrientationTo(target);
                orientationStep = new SetDirectionStep(this.caster, orientation);
                SpellFxApi.AddFrontStep(this.runner, orientationStep);
                this.latestStep = orientationStep;
            };
        }

        protected function addCasterAnimationStep():void
        {
            var animationStep:ISequencable;
            if (((this.caster) && (SpellFxApi.HasSpellParam(this.spell, "animId"))))
            {
                animationStep = SequenceApi.CreatePlayAnimationStep(this.caster, ("AnimAttaque" + SpellFxApi.GetSpellParam(this.spell, "animId")), true, true, "SHOT");
                if (!(this.latestStep))
                {
                    SpellFxApi.AddFrontStep(this.runner, animationStep);
                }
                else
                {
                    SpellFxApi.AddStepAfter(this.runner, this.latestStep, animationStep);
                };
                this.latestStep = animationStep;
            };
        }

        protected function addGfxEntityStep(originCell:MapPoint, casterCell:MapPoint, targetCell:MapPoint, stringPrefix:String, stringSuffix:String=""):void
        {
            var startCell:MapPoint;
            var endCell:MapPoint;
            if (((((!(originCell)) || (!(casterCell)))) || (!(targetCell))))
            {
                return;
            };
            var gfxAngle:int;
            if (SpellFxApi.HasSpellParam(this.spell, ((stringPrefix + "GfxOriented") + stringSuffix)))
            {
                if (SpellFxApi.GetSpellParam(this.spell, ((stringPrefix + "GfxOriented") + stringSuffix)))
                {
                    gfxAngle = FxApi.GetAngleTo(casterCell, targetCell);
                };
            };
            var spellGfxEntityYOffset:int;
            if (SpellFxApi.HasSpellParam(this.spell, ((stringPrefix + "GfxYOffset") + stringSuffix)))
            {
                spellGfxEntityYOffset = SpellFxApi.GetSpellParam(this.spell, ((stringPrefix + "GfxYOffset") + stringSuffix));
            };
            var spellGfxEntityShowUnder:Boolean;
            if (SpellFxApi.HasSpellParam(this.spell, ((stringPrefix + "GfxShowUnder") + stringSuffix)))
            {
                spellGfxEntityShowUnder = SpellFxApi.GetSpellParam(this.spell, ((stringPrefix + "GfxShowUnder") + stringSuffix));
            };
            var gfxDisplayMode:uint = SpellFxApi.GetSpellParam(this.spell, ((stringPrefix + "GfxDisplayType") + stringSuffix));
            if (gfxDisplayMode == AddGfxModeEnum.ORIENTED)
            {
                startCell = casterCell;
                endCell = targetCell;
                if (((((casterCell) && (endCell))) && ((casterCell.cellId == endCell.cellId))))
                {
                    endCell = endCell.getNearestCellInDirection(this.caster.getDirection());
                    if (endCell == null)
                    {
                        endCell = targetCell;
                    };
                };
                if (!(endCell))
                {
                    _log.debug("Failed to add a GfxEntityStep, expecting it to be oriented, but found no endCell!");
                    return;
                };
            };
            var gfxEntityStep:ISequencable = SequenceApi.CreateAddGfxEntityStep(this.runner, SpellFxApi.GetSpellParam(this.spell, ((stringPrefix + "GfxId") + stringSuffix)), originCell, gfxAngle, spellGfxEntityYOffset, gfxDisplayMode, startCell, endCell, spellGfxEntityShowUnder);
            if (!(this.latestStep))
            {
                if ((((((stringPrefix == PREFIX_TARGET)) && (SpellFxApi.HasSpellParam(this.spell, "playTargetGfxFirst")))) && (SpellFxApi.GetSpellParam(this.spell, "playTargetGfxFirst"))))
                {
                    SpellFxApi.AddStepBefore(this.runner, this.latestStep, gfxEntityStep);
                }
                else
                {
                    SpellFxApi.AddStepAfter(this.runner, this.latestStep, gfxEntityStep);
                };
            }
            else
            {
                SpellFxApi.AddStepAfter(this.runner, this.latestStep, gfxEntityStep);
            };
            this.latestStep = gfxEntityStep;
        }

        protected function addAnimHitSteps():void
        {
            var lifeVariationStep:FightLifeVariationStep;
            var _local_3:String;
            var lifeVariationSteps:Vector.<IFightStep> = Vector.<IFightStep>(SpellFxApi.GetStepsFromType(this.runner, "lifeVariation"));
            for each (lifeVariationStep in lifeVariationSteps)
            {
                if (lifeVariationStep.value >= 0)
                {
                }
                else
                {
                    _local_3 = "AnimHit";
                    if (SpellFxApi.HasSpellParam(this.spell, "customHitAnim"))
                    {
                        _local_3 = SpellFxApi.GetSpellParam(this.spell, "customHitAnim");
                    };
                    SpellFxApi.AddStepBefore(this.runner, lifeVariationStep, SequenceApi.CreatePlayAnimationStep((lifeVariationStep.target as TiphonSprite), _local_3, true, false));
                };
            };
        }

        protected function addPortalAnimationSteps(portalIds:Vector.<int>):void
        {
            var glyphAnimationStep:ISequencable;
            if (this.spell.spellRank.canThrowPlayer)
            {
                return;
            };
            var glyph:Glyph = SpellFxApi.GetPortalEntity(this.runner, portalIds[0]);
            if (glyph)
            {
                if (glyph.getAnimation() != PortalAnimationEnum.STATE_NORMAL)
                {
                    glyphAnimationStep = new PlayAnimationStep(glyph, PortalAnimationEnum.STATE_NORMAL, false, false);
                    if (!(this.latestStep))
                    {
                        SpellFxApi.AddFrontStep(this.runner, glyphAnimationStep);
                    }
                    else
                    {
                        SpellFxApi.AddStepAfter(this.runner, this.latestStep, glyphAnimationStep);
                    };
                    this.latestStep = glyphAnimationStep;
                };
                glyphAnimationStep = new PlayAnimationStep(glyph, PortalAnimationEnum.STATE_ENTRY_SPELL, false, true, TiphonEvent.ANIMATION_SHOT);
                if (!(this.latestStep))
                {
                    SpellFxApi.AddFrontStep(this.runner, glyphAnimationStep);
                }
                else
                {
                    SpellFxApi.AddStepAfter(this.runner, this.latestStep, glyphAnimationStep);
                };
                this.latestStep = glyphAnimationStep;
            };
            var i:int = 1;
            while (i < (portalIds.length - 1))
            {
                glyph = SpellFxApi.GetPortalEntity(this.runner, portalIds[i]);
                if (glyph)
                {
                    if (glyph.getAnimation() != PortalAnimationEnum.STATE_NORMAL)
                    {
                        glyphAnimationStep = new PlayAnimationStep(glyph, PortalAnimationEnum.STATE_NORMAL, false, false);
                        if (!(this.latestStep))
                        {
                            SpellFxApi.AddFrontStep(this.runner, glyphAnimationStep);
                        }
                        else
                        {
                            SpellFxApi.AddStepAfter(this.runner, this.latestStep, glyphAnimationStep);
                        };
                        this.latestStep = glyphAnimationStep;
                    };
                    glyphAnimationStep = new PlayAnimationStep(glyph, PortalAnimationEnum.STATE_ENTRY_SPELL, false, true, TiphonEvent.ANIMATION_SHOT);
                    SpellFxApi.AddStepAfter(this.runner, this.latestStep, glyphAnimationStep);
                    this.latestStep = glyphAnimationStep;
                };
                i++;
            };
            glyph = SpellFxApi.GetPortalEntity(this.runner, portalIds[(portalIds.length - 1)]);
            if (glyph)
            {
                if (glyph.getAnimation() != PortalAnimationEnum.STATE_NORMAL)
                {
                    glyphAnimationStep = new PlayAnimationStep(glyph, PortalAnimationEnum.STATE_NORMAL, false, false);
                    if (!(this.latestStep))
                    {
                        SpellFxApi.AddFrontStep(this.runner, glyphAnimationStep);
                    }
                    else
                    {
                        SpellFxApi.AddStepAfter(this.runner, this.latestStep, glyphAnimationStep);
                    };
                    this.latestStep = glyphAnimationStep;
                };
                glyphAnimationStep = new PlayAnimationStep(glyph, PortalAnimationEnum.STATE_EXIT_SPELL, false, false);
                SpellFxApi.AddStepAfter(this.runner, this.latestStep, glyphAnimationStep);
                this.latestStep = glyphAnimationStep;
            };
        }

        protected function destroy():void
        {
            this.latestStep = null;
            this.spell = null;
            this.caster = null;
        }


    }
}//package com.ankamagames.dofus.scripts.spells

