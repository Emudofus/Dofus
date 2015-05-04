package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.dofus.datacenter.spells.SpellLevel;
   import com.ankamagames.dofus.network.types.game.actions.fight.GameActionMarkedCell;
   import com.ankamagames.dofus.types.sequences.AddGlyphGfxStep;
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.dofus.network.enums.GameActionMarkTypeEnum;
   import com.ankamagames.dofus.logic.game.fight.managers.MarkedCellsManager;
   import com.ankamagames.dofus.logic.game.fight.types.MarkInstance;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   
   public class FightMarkCellsStep extends AbstractSequencable implements IFightStep
   {
      
      public function FightMarkCellsStep(param1:int, param2:int, param3:Vector.<GameActionMarkedCell>, param4:int, param5:SpellLevel, param6:int, param7:int, param8:Boolean = true)
      {
         super();
         this._markId = param1;
         this._markType = param2;
         this._cells = param3;
         this._markSpellId = param4;
         this._markSpellLevel = param5;
         this._markTeamId = param6;
         this._markImpactCell = param7;
         this._markActive = param8;
      }
      
      private var _markId:int;
      
      private var _markType:int;
      
      private var _markSpellLevel:SpellLevel;
      
      private var _cells:Vector.<GameActionMarkedCell>;
      
      private var _markSpellId:int;
      
      private var _markTeamId:int;
      
      private var _markImpactCell:int;
      
      private var _markActive:Boolean;
      
      public function get stepType() : String
      {
         return "markCells";
      }
      
      override public function start() : void
      {
         var _loc3_:GameActionMarkedCell = null;
         var _loc4_:AddGlyphGfxStep = null;
         var _loc5_:String = null;
         var _loc1_:Spell = Spell.getSpellById(this._markSpellId);
         if(this._markType == GameActionMarkTypeEnum.WALL)
         {
            if((_loc1_.getParamByName("glyphGfxId")) || true)
            {
               for each(_loc3_ in this._cells)
               {
                  _loc4_ = new AddGlyphGfxStep(_loc1_.getParamByName("glyphGfxId"),_loc3_.cellId,this._markId,this._markType,this._markTeamId);
                  _loc4_.start();
               }
            }
         }
         else if((_loc1_.getParamByName("glyphGfxId")) && (!MarkedCellsManager.getInstance().getGlyph(this._markId)) && !(this._markImpactCell == -1))
         {
            _loc4_ = new AddGlyphGfxStep(_loc1_.getParamByName("glyphGfxId"),this._markImpactCell,this._markId,this._markType,this._markTeamId);
            _loc4_.start();
         }
         
         MarkedCellsManager.getInstance().addMark(this._markId,this._markType,_loc1_,this._markSpellLevel,this._cells,this._markTeamId,this._markActive,this._markImpactCell);
         var _loc2_:MarkInstance = MarkedCellsManager.getInstance().getMarkDatas(this._markId);
         if(_loc2_)
         {
            _loc5_ = FightEventEnum.UNKNOWN_FIGHT_EVENT;
            switch(_loc2_.markType)
            {
               case GameActionMarkTypeEnum.GLYPH:
                  _loc5_ = FightEventEnum.GLYPH_APPEARED;
                  break;
               case GameActionMarkTypeEnum.TRAP:
                  _loc5_ = FightEventEnum.TRAP_APPEARED;
                  break;
               case GameActionMarkTypeEnum.PORTAL:
                  _loc5_ = FightEventEnum.PORTAL_APPEARED;
                  break;
               default:
                  _log.warn("Unknown mark type (" + _loc2_.markType + ").");
            }
            FightEventsHelper.sendFightEvent(_loc5_,[_loc2_.associatedSpell.id],0,castingSpellId);
         }
         executeCallbacks();
      }
   }
}
