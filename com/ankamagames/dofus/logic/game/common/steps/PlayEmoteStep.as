package com.ankamagames.dofus.logic.game.common.steps
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.dofus.datacenter.communication.Emoticon;
   import com.ankamagames.tiphon.events.TiphonEvent;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.roleplay.messages.GameRolePlaySetAnimationMessage;
   
   public class PlayEmoteStep extends AbstractSequencable
   {
      
      public function PlayEmoteStep(param1:AnimatedCharacter, param2:int, param3:Boolean) {
         super();
         this._entity = param1;
         this._emoteId = param2;
         this._waitForEnd = param3;
         timeout = 10000;
      }
      
      private var _entity:AnimatedCharacter;
      
      private var _emoteId:int;
      
      private var _waitForEnd:Boolean;
      
      override public function start() : void {
         var _loc2_:String = null;
         var _loc3_:RoleplayEntitiesFrame = null;
         var _loc1_:Emoticon = Emoticon.getEmoticonById(this._emoteId);
         if(_loc1_)
         {
            if(this._waitForEnd)
            {
               this._entity.addEventListener(TiphonEvent.ANIMATION_END,this.onAnimationEnd);
            }
            _loc2_ = _loc1_.getAnimName(this._entity.look);
            _loc3_ = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
            _loc3_.currentEmoticon = this._emoteId;
            _loc3_.process(new GameRolePlaySetAnimationMessage(_loc3_.getEntityInfos(this._entity.id),_loc2_,0,!_loc1_.persistancy,_loc1_.eight_directions));
         }
         if(!_loc1_ || !this._waitForEnd)
         {
            executeCallbacks();
         }
      }
      
      private function onAnimationEnd(param1:TiphonEvent) : void {
         param1.currentTarget.removeEventListener(TiphonEvent.ANIMATION_END,this.onAnimationEnd);
         executeCallbacks();
      }
   }
}
