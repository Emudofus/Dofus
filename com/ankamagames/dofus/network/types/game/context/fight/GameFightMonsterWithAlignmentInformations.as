package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.character.alignment.ActorAlignmentInformations;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class GameFightMonsterWithAlignmentInformations extends GameFightMonsterInformations implements INetworkType
   {
      
      public function GameFightMonsterWithAlignmentInformations()
      {
         this.alignmentInfos = new ActorAlignmentInformations();
         super();
      }
      
      public static const protocolId:uint = 203;
      
      public var alignmentInfos:ActorAlignmentInformations;
      
      override public function getTypeId() : uint
      {
         return 203;
      }
      
      public function initGameFightMonsterWithAlignmentInformations(param1:int = 0, param2:EntityLook = null, param3:EntityDispositionInformations = null, param4:uint = 2, param5:uint = 0, param6:Boolean = false, param7:GameFightMinimalStats = null, param8:Vector.<uint> = null, param9:uint = 0, param10:uint = 0, param11:ActorAlignmentInformations = null) : GameFightMonsterWithAlignmentInformations
      {
         super.initGameFightMonsterInformations(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10);
         this.alignmentInfos = param11;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.alignmentInfos = new ActorAlignmentInformations();
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_GameFightMonsterWithAlignmentInformations(param1);
      }
      
      public function serializeAs_GameFightMonsterWithAlignmentInformations(param1:ICustomDataOutput) : void
      {
         super.serializeAs_GameFightMonsterInformations(param1);
         this.alignmentInfos.serializeAs_ActorAlignmentInformations(param1);
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightMonsterWithAlignmentInformations(param1);
      }
      
      public function deserializeAs_GameFightMonsterWithAlignmentInformations(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.alignmentInfos = new ActorAlignmentInformations();
         this.alignmentInfos.deserialize(param1);
      }
   }
}
