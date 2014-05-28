package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class GameRolePlayNamedActorInformations extends GameRolePlayActorInformations implements INetworkType
   {
      
      public function GameRolePlayNamedActorInformations() {
         super();
      }
      
      public static const protocolId:uint = 154;
      
      public var name:String = "";
      
      override public function getTypeId() : uint {
         return 154;
      }
      
      public function initGameRolePlayNamedActorInformations(contextualId:int = 0, look:EntityLook = null, disposition:EntityDispositionInformations = null, name:String = "") : GameRolePlayNamedActorInformations {
         super.initGameRolePlayActorInformations(contextualId,look,disposition);
         this.name = name;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.name = "";
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_GameRolePlayNamedActorInformations(output);
      }
      
      public function serializeAs_GameRolePlayNamedActorInformations(output:IDataOutput) : void {
         super.serializeAs_GameRolePlayActorInformations(output);
         output.writeUTF(this.name);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameRolePlayNamedActorInformations(input);
      }
      
      public function deserializeAs_GameRolePlayNamedActorInformations(input:IDataInput) : void {
         super.deserialize(input);
         this.name = input.readUTF();
      }
   }
}
