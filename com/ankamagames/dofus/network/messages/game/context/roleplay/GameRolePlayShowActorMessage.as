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
      
      public function initGameRolePlayShowActorMessage(param1:GameRolePlayActorInformations=null) : GameRolePlayShowActorMessage {
         this.informations = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.informations = new GameRolePlayActorInformations();
         this._isInitialized = false;
      }
      
      override public function pack(param1:IDataOutput) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(_loc2_);
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:IDataInput, param2:uint) : void {
         this.deserialize(param1);
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_GameRolePlayShowActorMessage(param1);
      }
      
      public function serializeAs_GameRolePlayShowActorMessage(param1:IDataOutput) : void {
         param1.writeShort(this.informations.getTypeId());
         this.informations.serialize(param1);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameRolePlayShowActorMessage(param1);
      }
      
      public function deserializeAs_GameRolePlayShowActorMessage(param1:IDataInput) : void {
         var _loc2_:uint = param1.readUnsignedShort();
         this.informations = ProtocolTypeManager.getInstance(GameRolePlayActorInformations,_loc2_);
         this.informations.deserialize(param1);
      }
   }
}
