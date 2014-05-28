package com.ankamagames.dofus.logic.game.common.steps
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.tiphon.types.look.EntityLookParser;
   
   public class DisplayEntityStep extends AbstractSequencable
   {
      
      public function DisplayEntityStep(pEntityId:int, pLook:String, pCellId:uint, pDirection:int) {
         super();
         this._id = pEntityId;
         this._look = pLook;
         this._cellId = pCellId;
         this._direction = pDirection;
      }
      
      private var _id:int;
      
      private var _look:String;
      
      private var _cellId:uint;
      
      private var _direction:int;
      
      override public function start() : void {
         var rpef:RoleplayEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
         var gci:GameContextActorInformations = new GameContextActorInformations();
         var disposition:EntityDispositionInformations = new EntityDispositionInformations();
         disposition.initEntityDispositionInformations(this._cellId,this._direction);
         gci.initGameContextActorInformations(this._id,EntityLookAdapter.toNetwork(EntityLookParser.fromString(this._look)),disposition);
         rpef.addOrUpdateActor(gci);
         executeCallbacks();
      }
   }
}
