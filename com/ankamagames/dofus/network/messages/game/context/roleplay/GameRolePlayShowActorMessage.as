package com.ankamagames.dofus.network.messages.game.context.roleplay
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayActorInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class GameRolePlayShowActorMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameRolePlayShowActorMessage() {
         this.informations = new GameRolePlayActorInformations();
         super();
      }
      
      public static const protocolId:uint = 5632;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var informations:GameRolePlayActorInformations;
      
      override public function getMessageId() : uint {
         return 5632;
      }
      
      public function initGameRolePlayShowActorMessage(informations:GameRolePlayActorInformations = null) : GameRolePlayShowActorMessage {
         this.informations = informations;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.informations = new GameRolePlayActorInformations();
         this._isInitialized = false;
      }
      
      override public function pack(output:IDataOutput) : void {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:IDataInput, length:uint) : void {
         this.deserialize(input);
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_GameRolePlayShowActorMessage(output);
      }
      
      public function serializeAs_GameRolePlayShowActorMessage(output:IDataOutput) : void {
         output.writeShort(this.informations.getTypeId());
         this.informations.serialize(output);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameRolePlayShowActorMessage(input);
      }
      
      public function deserializeAs_GameRolePlayShowActorMessage(input:IDataInput) : void {
         var _id1:uint = input.readUnsignedShort();
         this.informations = ProtocolTypeManager.getInstance(GameRolePlayActorInformations,_id1);
         this.informations.deserialize(input);
      }
   }
}
