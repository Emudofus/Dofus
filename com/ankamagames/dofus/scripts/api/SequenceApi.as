package com.ankamagames.dofus.scripts.api
{
   import com.ankamagames.jerakine.sequencer.ISequencer;
   import com.ankamagames.jerakine.sequencer.SerialSequencer;
   import com.ankamagames.jerakine.sequencer.ISequencable;
   import com.ankamagames.jerakine.sequencer.ParallelStartSequenceStep;
   import com.ankamagames.jerakine.sequencer.StartSequenceStep;
   import com.ankamagames.dofus.scripts.FxRunner;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.dofus.types.sequences.AddGfxEntityStep;
   import flash.display.DisplayObject;
   import com.ankamagames.dofus.scripts.SpellFxRunner;
   import com.ankamagames.dofus.types.sequences.AddGlyphGfxStep;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.tiphon.sequence.PlayAnimationStep;
   import com.ankamagames.tiphon.sequence.SetDirectionStep;
   import com.ankamagames.atouin.types.sequences.ParableGfxMovementStep;
   import com.ankamagames.jerakine.entities.interfaces.IMovable;
   import com.ankamagames.tiphon.types.CarriedSprite;
   import com.ankamagames.dofus.types.sequences.AddGfxInLineStep;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.jerakine.types.zones.IZone;
   import com.ankamagames.jerakine.types.zones.Cross;
   import com.ankamagames.jerakine.utils.display.spellZone.SpellShapeEnum;
   import com.ankamagames.atouin.utils.DataMapProvider;
   import com.ankamagames.jerakine.types.zones.Line;
   import com.ankamagames.jerakine.types.zones.Lozenge;
   import com.ankamagames.atouin.types.sequences.AddWorldEntityStep;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.atouin.types.sequences.DestroyEntityStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightDestroyEntityStep;
   import com.ankamagames.jerakine.sequencer.DebugStep;
   
   public class SequenceApi extends Object
   {
      
      public function SequenceApi() {
         super();
      }
      
      public static function CreateSerialSequencer() : ISequencer {
         return new SerialSequencer();
      }
      
      public static function CreateParallelStartSequenceStep(aSequence:Array, waitAllSequenceEnd:Boolean=true, waitFirstEndSequence:Boolean=false) : ISequencable {
         return new ParallelStartSequenceStep(aSequence,waitAllSequenceEnd,waitFirstEndSequence);
      }
      
      public static function CreateStartSequenceStep(sequence:ISequencer) : ISequencable {
         return new StartSequenceStep(sequence);
      }
      
      public static function CreateAddGfxEntityStep(runner:FxRunner, gfxId:uint, cell:MapPoint, angle:Number=0, yOffset:int=0, mode:uint=0, startCell:MapPoint=null, endCell:MapPoint=null, popUnderPlayer:Boolean=false) : ISequencable {
         return new AddGfxEntityStep(gfxId,cell.cellId,angle,-DisplayObject(runner.caster).height * yOffset / 10,mode,startCell,endCell,popUnderPlayer);
      }
      
      public static function CreateAddGlyphGfxStep(runner:SpellFxRunner, gfxId:uint, cell:MapPoint, markId:int) : ISequencable {
         return new AddGlyphGfxStep(gfxId,cell.cellId,markId,runner.castingSpell.markType);
      }
      
      public static function CreatePlayAnimationStep(target:TiphonSprite, animationName:String, backToLastAnimationAtEnd:Boolean, waitForEvent:Boolean, eventEnd:String="animation_event_end", loop:int=1) : ISequencable {
         return new PlayAnimationStep(target,animationName,backToLastAnimationAtEnd,waitForEvent,eventEnd,loop);
      }
      
      public static function CreateSetDirectionStep(target:TiphonSprite, nDirection:uint) : ISequencable {
         return new SetDirectionStep(target,nDirection);
      }
      
      public static function CreateParableGfxMovementStep(runner:FxRunner, gfxEntity:IMovable, targetPoint:MapPoint, speed:Number=100, curvePrc:Number=0.5, yOffset:int=0, waitEnd:Boolean=true) : ParableGfxMovementStep {
         var subEntityOffset:int = 0;
         var p:DisplayObject = TiphonSprite(runner.caster).parent;
         while(p)
         {
            if(p is CarriedSprite)
            {
               subEntityOffset = subEntityOffset + p.y;
            }
            p = p.parent;
         }
         return new ParableGfxMovementStep(gfxEntity,targetPoint,speed,curvePrc,-DisplayObject(runner.caster).height * yOffset / 10 + subEntityOffset,waitEnd);
      }
      
      public static function CreateAddGfxInLineStep(runner:SpellFxRunner, gfxId:uint, startCell:MapPoint, endCell:MapPoint, yOffset:Number=0, mode:uint=0, minScale:Number=0, maxScale:Number=0, addOnStartCell:Boolean=false, addOnEndCell:Boolean=false, showUnder:Boolean=false, useSpellZone:Boolean=false, useOnlySpellZone:Boolean=false) : AddGfxInLineStep {
         var cells:Vector.<uint> = null;
         var shape:uint = 0;
         var ray:uint = 0;
         var i:EffectInstance = null;
         var zone:IZone = null;
         var shapeT:Cross = null;
         var level:uint = runner.castingSpell.spell.spellLevels.indexOf(runner.castingSpell.spellRank.id);
         var scale:Number = 1 + (minScale + (maxScale - minScale) * level / 6) / 10;
         if(useSpellZone)
         {
            shape = 88;
            ray = 0;
            for each (i in runner.castingSpell.spellRank.effects)
            {
               if((!(i.zoneShape == 0)) && (i.zoneSize < 63) && ((i.zoneSize > ray) || (i.zoneSize == ray) && (shape == SpellShapeEnum.P)))
               {
                  ray = uint(i.zoneSize);
                  shape = i.zoneShape;
               }
            }
            switch(shape)
            {
               case SpellShapeEnum.X:
                  zone = new Cross(0,ray,DataMapProvider.getInstance());
                  break;
               case SpellShapeEnum.L:
                  zone = new Line(ray,DataMapProvider.getInstance());
                  break;
               case SpellShapeEnum.T:
                  shapeT = new Cross(0,ray,DataMapProvider.getInstance());
                  shapeT.onlyPerpendicular = true;
                  zone = shapeT;
                  break;
               case SpellShapeEnum.D:
                  zone = new Cross(0,ray,DataMapProvider.getInstance());
                  break;
               case SpellShapeEnum.C:
                  zone = new Lozenge(0,ray,DataMapProvider.getInstance());
                  break;
               case SpellShapeEnum.O:
                  zone = new Cross(ray - 1,ray,DataMapProvider.getInstance());
                  break;
               case SpellShapeEnum.P:
                  zone = new Cross(0,0,DataMapProvider.getInstance());
                  break;
            }
            zone.direction = startCell.advancedOrientationTo(runner.castingSpell.targetedCell);
            cells = zone.getCells(runner.castingSpell.targetedCell.cellId);
         }
         return new AddGfxInLineStep(gfxId,startCell,endCell,-DisplayObject(runner.caster).height * yOffset / 10,mode,scale,addOnStartCell,addOnEndCell,cells,useOnlySpellZone,showUnder);
      }
      
      public static function CreateAddWorldEntityStep(entity:IEntity) : AddWorldEntityStep {
         return new AddWorldEntityStep(entity);
      }
      
      public static function CreateDestroyEntityStep(entity:IEntity) : DestroyEntityStep {
         return new FightDestroyEntityStep(entity);
      }
      
      public static function CreateDebugStep(text:String) : DebugStep {
         return new DebugStep(text);
      }
   }
}
