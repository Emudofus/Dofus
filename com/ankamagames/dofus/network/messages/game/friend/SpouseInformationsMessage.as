package com.ankamagames.dofus.network.messages.game.friend
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.friend.FriendSpouseInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class SpouseInformationsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function SpouseInformationsMessage() {
         this.spouse = new FriendSpouseInformations();
         super();
      }
      
      public static const protocolId:uint = 6356;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var spouse:FriendSpouseInformations;
      
      override public function getMessageId() : uint {
         return 6356;
      }
      
      public function initSpouseInformationsMessage(spouse:FriendSpouseInformations = null) : SpouseInformationsMessage {
         this.spouse = spouse;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.spouse = new FriendSpouseInformations();
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
         this.serializeAs_SpouseInformationsMessage(output);
      }
      
      public function serializeAs_SpouseInformationsMessage(output:IDataOutput) : void {
         output.writeShort(this.spouse.getTypeId());
         this.spouse.serialize(output);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_SpouseInformationsMessage(input);
      }
      
      public function deserializeAs_SpouseInformationsMessage(input:IDataInput) : void {
         var _id1:uint = input.readUnsignedShort();
         this.spouse = ProtocolTypeManager.getInstance(FriendSpouseInformations,_id1);
         this.spouse.deserialize(input);
      }
   }
}
