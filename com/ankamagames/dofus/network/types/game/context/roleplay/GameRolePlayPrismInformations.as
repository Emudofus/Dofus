package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.character.alignment.ActorAlignmentInformations;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;


   public class GameRolePlayPrismInformations extends GameRolePlayActorInformations implements INetworkType
   {
         

      public function GameRolePlayPrismInformations() {
         this.alignInfos=new ActorAlignmentInformations();
         super();
      }

      public static const protocolId:uint = 161;

      public var alignInfos:ActorAlignmentInformations;

      override public function getTypeId() : uint {
         return 161;
      }

      public function initGameRolePlayPrismInformations(contextualId:int=0, look:EntityLook=null, disposition:EntityDispositionInformations=null, alignInfos:ActorAlignmentInformations=null) : GameRolePlayPrismInformations {
         super.initGameRolePlayActorInformations(contextualId,look,disposition);
         this.alignInfos=alignInfos;
         return this;
      }

      override public function reset() : void {
         super.reset();
         this.alignInfos=new ActorAlignmentInformations();
      }

      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_GameRolePlayPrismInformations(output);
      }

      public function serializeAs_GameRolePlayPrismInformations(output:IDataOutput) : void {
         super.serializeAs_GameRolePlayActorInformations(output);
         this.alignInfos.serializeAs_ActorAlignmentInformations(output);
      }

      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameRolePlayPrismInformations(input);
      }

      public function deserializeAs_GameRolePlayPrismInformations(input:IDataInput) : void {
         super.deserialize(input);
         this.alignInfos=new ActorAlignmentInformations();
         this.alignInfos.deserialize(input);
      }
   }

}