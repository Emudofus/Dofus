package com.ankamagames.dofus.network.messages.game.context.roleplay.paddock
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.paddock.PaddockInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class PaddockPropertiesMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function PaddockPropertiesMessage() {
         this.properties = new PaddockInformations();
         super();
      }
      
      public static const protocolId:uint = 5824;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var properties:PaddockInformations;
      
      override public function getMessageId() : uint {
         return 5824;
      }
      
      public function initPaddockPropertiesMessage(properties:PaddockInformations = null) : PaddockPropertiesMessage {
         this.properties = properties;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.properties = new PaddockInformations();
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
         this.serializeAs_PaddockPropertiesMessage(output);
      }
      
      public function serializeAs_PaddockPropertiesMessage(output:IDataOutput) : void {
         output.writeShort(this.properties.getTypeId());
         this.properties.serialize(output);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PaddockPropertiesMessage(input);
      }
      
      public function deserializeAs_PaddockPropertiesMessage(input:IDataInput) : void {
         var _id1:uint = input.readUnsignedShort();
         this.properties = ProtocolTypeManager.getInstance(PaddockInformations,_id1);
         this.properties.deserialize(input);
      }
   }
}
