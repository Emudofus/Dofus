package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.dofus.logic.game.fight.steps.abstract.AbstractStatContextualStep;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.tiphon.events.TiphonEvent;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightCharacterInformations;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.dofus.network.enums.GameContextEnum;
   
   public class FightShieldPointsVariationStep extends AbstractStatContextualStep implements IFightStep
   {
      
      public function FightShieldPointsVariationStep(param1:int, param2:int, param3:int)
      {
         super(COLOR,param2.toString(),param1,GameContextEnum.FIGHT,BLOCKING);
         this._intValue = param2;
         this._actionId = param3;
         _virtual = false;
      }
      
      public static const COLOR:uint = 10053324;
      
      private static const BLOCKING:Boolean = false;
      
      private var _intValue:int;
      
      private var _actionId:int;
      
      public function get stepType() : String
      {
         return "shieldPointsVariation";
      }
      
      public function get value() : int
      {
         return this._intValue;
      }
      
      public function set virtual(param1:Boolean) : void
      {
         _virtual = param1;
      }
      
      override public function start() : void
      {
         var _loc4_:String = null;
         var _loc1_:AnimatedCharacter = DofusEntities.getEntity(_targetId) as AnimatedCharacter;
         if((_loc1_) && (_loc1_.isPlayingAnimation()))
         {
            _loc1_.addEventListener(TiphonEvent.ANIMATION_END,this.onAnimationEnd);
            return;
         }
         var _loc2_:GameFightFighterInformations = FightEntitiesFrame.getCurrentInstance().getEntityInfos(_targetId) as GameFightFighterInformations;
         if(!_loc2_)
         {
            super.executeCallbacks();
            return;
         }
         var _loc3_:uint = _loc2_.stats.shieldPoints;
         _loc2_.stats.shieldPoints = Math.max(0,_loc2_.stats.shieldPoints + this._intValue);
         var _loc5_:String = "tooltipOverEntity_" + _loc2_.contextualId;
         if(_loc2_ is GameFightCharacterInformations)
         {
            _loc4_ = "PlayerShortInfos" + _loc2_.contextualId;
         }
         else
         {
            _loc4_ = "EntityShortInfos" + _loc2_.contextualId;
         }
         TooltipManager.updateContent(_loc4_,_loc5_,_loc2_);
         _loc2_.stats.shieldPoints = _loc3_;
         TooltipManager.updatePosition(_loc4_,_loc5_,_loc1_.absoluteBounds,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,0,true,true,_loc1_.position.cellId);
         if(this._intValue < 0)
         {
            FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_SHIELD_LOSS,[_targetId,Math.abs(this._intValue),this._actionId],_targetId,castingSpellId);
         }
         else if(this._intValue == 0)
         {
            FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_NO_CHANGE,[_targetId],_targetId,castingSpellId);
         }
         
         super.start();
      }
      
      private function onAnimationEnd(param1:TiphonEvent) : void
      {
         var _loc2_:TiphonSprite = param1.currentTarget as TiphonSprite;
         _loc2_.removeEventListener(TiphonEvent.ANIMATION_END,this.onAnimationEnd);
         this.start();
      }
   }
}
